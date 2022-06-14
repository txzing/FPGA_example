module ds18b20_driver(
//module clock
input              clk        ,         // 时钟信号（50MHz）
input              rst_n      ,         // 复位信号
//user interface
input              enable     ,         //使能信号
inout              dq         ,         // DS18B20的DQ引脚数据
output reg [20:0]  temp_data  ,         // 转换后得到的温度值
output reg         sign       ,         // 符号位
output reg         temp_data_vld        // 指示输出有效
);

//parameter define
parameter   CLK_1us      = 5'd25;
parameter   DELAY_TIME   = 20'd500000;//500ms
localparam  ROM_SKIP_CMD = 8'hcc;           // 跳过 ROM 命令
localparam  CONVERT_CMD  = 8'h44;           // 温度转换命令
localparam  READ_TEMP    = 8'hbe;           // 读 DS1820 温度暂存器命令
//state define，状态机状态编码
localparam  init         = 7'b0000001;           // 初始化状态
localparam  rom_skip     = 7'b0000010;           // 加载跳过ROM命令
localparam  wr_byte      = 7'b0000100;           // 写字节状态
localparam  temp_convert = 7'b0001000;           // 加载温度转换命令
localparam  delay        = 7'b0010000;           // 延时等待温度转换结束
localparam  rd_temp      = 7'b0100000;           // 加载读温度命令
localparam  rd_byte      = 7'b1000000;           // 读字节状态
/*
DS18B20的典型温度，读取过程为：初始化?发跳过ROM命令（ CCH） ?发开始转换命令（ 44H） ?延时(500ms)?初始化?
发送跳过ROM命令（ CCH） ?发读存储器命令（ BEH） ?连续读出两个字节数据(即温度)?结束或开始下一循环。
*/
//reg define
reg     [ 4:0]         cnt         ;        // 分频计数器
reg                    clk_1us     ;        // 1MHz时钟
reg     [19:0]         cnt_1us     ;        // 微秒计数
reg     [ 7:0]         state_c   ;        // 当前状态
reg     [ 7:0]         state_n  ;        // 下一状态
reg     [ 3:0]         flow_cnt    ;        // 流转计数
reg     [ 3:0]         wr_cnt      ;        // 写计数
reg     [ 4:0]         rd_cnt      ;        // 读计数
reg     [ 7:0]         wr_data     ;        // 装载写入DS18B20的数据
reg     [ 4:0]         bit_width   ;        // 读取的数据的位宽
reg     [15:0]         rd_data     ;        // 采集到的数据
reg     [15:0]         org_data    ;        // 读取到的原始温度数据
reg     [10:0]         data_r       ;        // 对原理温度进行符号处理后的数据
reg     [ 3:0]         cmd_cnt     ;        // 发送命令计数
reg                    init_done   ;        // 初始化完成信号
reg                    st_done     ;        // 完成信号
reg                    cnt_1us_en  ;        // 使能计时
reg                    dq_out      ;        // DS18B20的dq输出

//wire define
wire                   add_cnt;
wire                   end_cnt;
//*****************************************************
//**                    main code
//*****************************************************

assign dq = dq_out;

//分频生成1MHz的时钟信号,1MHz对应1us
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 5'b0;
        clk_1us <= 1'b0;
    end
    else if(add_cnt)begin 
            if(end_cnt)begin 
                cnt <= 5'b0;
                clk_1us <= ~clk_1us;
            end
            else begin
                cnt <= cnt + 1'b1;
                clk_1us <= clk_1us;
            end
    end
    else  begin
        cnt <= 5'b0;
        clk_1us <= clk_1us;
    end
end

assign add_cnt = enable;
assign end_cnt = add_cnt && cnt == CLK_1us - 1'b1;

//微秒计时,在使能信号下，统一进行us计数,使能信号由状态机约束
always @ (posedge clk_1us or negedge rst_n) begin
    if (!rst_n)
        cnt_1us <= 20'b0;
    else if (cnt_1us_en)
        cnt_1us <= cnt_1us + 1'b1;
    else
        cnt_1us <= 20'b0;
end

//状态跳转
always @ (posedge clk_1us or negedge rst_n) begin
    if(!rst_n)
        state_c <= init;
    else 
        state_c <= state_n;
end

//组合逻辑状态判断转换条件，状态切换
always @( * ) begin
    case(state_c)
        init: begin                             // 初始化状态
            if (init_done)
                state_n = rom_skip;
            else
                state_n = init;
        end
        rom_skip: begin                         // 加载跳过ROM命令
            if(st_done)
                state_n = wr_byte;
            else
                state_n = rom_skip;
        end
        wr_byte: begin                          // 发送命令
            if(st_done)
                case(cmd_cnt)                   // 根据命令序号，判断下个状态
                    4'b1: state_n = temp_convert;
                    4'd2: state_n = delay;
                    4'd3: state_n = rd_temp;
                    4'd4: state_n = rd_byte;
                    default: 
					      state_n = temp_convert;
                endcase
            else
                state_n = wr_byte;
        end
        temp_convert: begin                     // 加载温度转换命令
            if(st_done)
                state_n = wr_byte;
            else
                state_n = temp_convert;
        end
        delay: begin                            // 延时等待温度转换结束
            if(st_done)
                state_n = init;
            else
                state_n = delay;
        end
        rd_temp: begin                          // 加载读温度命令
            if(st_done)
                state_n = wr_byte;
            else
                state_n = rd_temp;
        end
        rd_byte: begin                          // 读数据线上的数据
            if(st_done)
                state_n = init;
            else
                state_n = rd_byte;
        end
        default: state_n = init;
    endcase
end

//整个操作步骤为初始化、发送跳过ROM操作命令、发送温度转换指令、
//再初始化、再发送跳过ROM操作指令、发送读数据指令。

//三段式状态机第三段，在相应状态下进行输出
always @ (posedge clk_1us or negedge rst_n) begin
    if(!rst_n) begin
        flow_cnt     <=  4'b0;
        init_done    <=  1'b0;
        cnt_1us_en   <=  1'b1;
        dq_out       <=  1'bZ;
        st_done      <=  1'b0;
        rd_data      <= 16'b0;
        rd_cnt       <=  5'd0;
        wr_cnt       <=  4'd0;
        cmd_cnt      <=  3'd0;
    end
    else begin
        st_done <= 1'b0;
        case (state_n)
            init:begin                              //初始化。发出复位脉冲
                init_done <= 1'b0;
                case(flow_cnt)
                    4'd0:
						flow_cnt <= flow_cnt + 1'b1;
					4'd1: begin					//发出500us复位脉冲
                        cnt_1us_en <= 1'b1; //开始计数        
                        if(cnt_1us < 20'd500)
                            dq_out <= 1'b0; //保持低电平       
                        else begin
                            cnt_1us_en <= 1'b0;//将cnt_1us清零
                            dq_out <= 1'bz; //释放总线
                            flow_cnt <= flow_cnt + 1'b1;//进入下一流程
                        end
                    end
                    4'd2:begin						//释放总线，等待15-60us，这里取30us
                        cnt_1us_en <= 1'b1;//开始重新计数 
                        if(cnt_1us == 20'd30)                            
                            flow_cnt <= flow_cnt + 1'b1;
                        else
                            dq_out <= 1'bz;
                    end
                    4'd3: begin	
                        if(cnt_1us <= 20'd300) begin  //从机拉低总线60-240us做出响应脉冲，以极限计算则60+240				
                            if(!dq) //如果总线出现低电平，说明又从机应答
                                flow_cnt <= flow_cnt + 1'b1;
                            else
                                flow_cnt <= flow_cnt;
                            end
                        else//没有重新开始初始化过程
                            flow_cnt <= 4'd0;                      
                    end
                    4'd4: begin						//等待初始化结束
                        if(cnt_1us == 20'd500) begin  //延时等待一段时间
                            cnt_1us_en <= 1'b0;//将cnt_1us清零
                            init_done  <= 1'b1;		//初始化完成，标志可以进入下一状态
                            flow_cnt   <= 4'd0;
                        end
                        else
                            flow_cnt <= flow_cnt;
                    end
                    default: flow_cnt <= 4'd0;
                endcase
            end
            rom_skip: begin                         //加载跳过ROM操作指令
                wr_data  <= ROM_SKIP_CMD;
                flow_cnt <= 4'd0;
                st_done  <= 1'b1;
            end
            wr_byte: begin                          //写字节状态（发送指令），根据送入的wr_data发送数据
                if(wr_cnt <= 4'd7) begin//总共发送8bit      
                    case (flow_cnt)
                        4'd0: begin
                            dq_out <= 1'b0;			//拉低数据线，开始写操作
                            cnt_1us_en <= 1'b1;		//启动计时器
                            flow_cnt <= flow_cnt + 1'b1;
                        end
                        4'd1: begin					//数据线拉低1us
                            flow_cnt <= flow_cnt + 1'b1;
                        end
                        4'd2: begin
                            if(cnt_1us < 20'd60)	//发送数据，最少持续60us
                                dq_out <= wr_data[wr_cnt];
                            else if(cnt_1us < 20'd63) 	
                                dq_out <= 1'bz;		//释放总线（发送间隔）
                            else
                                flow_cnt <= flow_cnt + 1'b1;
                        end
                        4'd3: begin					//发送1bit数据完成
                            flow_cnt <= 0;
                            cnt_1us_en <= 1'b0;
                            wr_cnt <= wr_cnt + 1'b1;//写计数器加1
                        end
                        default : flow_cnt <= 0;
                    endcase
                end
                else begin							//发送指令（1Byte）结束
                    st_done <= 1'b1;
                    wr_cnt <= 4'b0;
                    cmd_cnt <= (cmd_cnt == 3'd4) ?  //标记当前发送的指令序号
					           3'd1 : (cmd_cnt+ 1'b1);
                end
            end
            temp_convert: begin                     //加载温度转换命令
                wr_data <= CONVERT_CMD;
                st_done <= 1'b1;
            end
            delay: begin                            //延时等待温度转换结束
                cnt_1us_en <= 1'b1;
                if(cnt_1us == DELAY_TIME) begin
                    st_done <= 1'b1;
                    cnt_1us_en <= 1'b0;
                end 
            end 
            rd_temp: begin                          //加载读温度命令
                wr_data <= READ_TEMP;
                bit_width <= 5'd16;					//指定读数据个数
                st_done <= 1'b1;
            end
            rd_byte: begin                          //接收16位温度数据
                if(rd_cnt < bit_width) begin
                    case(flow_cnt)
                        4'd0: begin
                            cnt_1us_en <= 1'b1;
                            dq_out <= 1'b0;			//拉低数据线，开始读操作
                            flow_cnt <= flow_cnt + 1'b1;
                        end
                        4'd1: begin
                            dq_out <= 1'bz;			//释放总线并在15us内接收数据
                            if(cnt_1us == 20'd14) begin
                                rd_data <= {dq,rd_data[15:1]};//采样数据，数据右移，先发送最低位
                                flow_cnt <= flow_cnt + 1'b1 ;
                            end
                        end
                        4'd2: begin
                            if (cnt_1us <= 20'd64)	//读1bit数据结束
                                dq_out <= 1'bz;
                            else begin
                                flow_cnt <= 4'd0;	
                                rd_cnt <= rd_cnt + 1'b1;//读计数器加1
                                cnt_1us_en <= 1'b0;
                            end
                        end
                        default : flow_cnt <= 4'd0;
                    endcase
                end
                else begin  //16bit数据接收完
                    st_done <= 1'b1;
                    org_data  <= rd_data;
                    rd_cnt <= 5'b0;
                end
            end
            default: ;
        endcase
    end 
end

//判断符号位
always @(posedge clk_1us or negedge rst_n) begin
    if(!rst_n) begin
        sign  <=  1'b0;
        data_r <= 11'b0;
    end
    else if(org_data[15] == 1'b0) begin
        sign  <= 1'b0;
        data_r <= org_data[10:0];
    end
    else if(org_data[15] == 1'b1) begin//判断符号位，若为1，则代表为负数
        sign  <= 1'b1;
        data_r <= ~org_data[10:0] + 1'b1;//负数格式为补码，取反加1
    end
end


//温度输出
always @(posedge clk_1us or negedge rst_n) begin
    if(!rst_n)begin
        temp_data <= 21'b0;
        temp_data_vld <= 1'b0;     
    end
    else if(state_c == rd_byte & st_done)begin
        temp_data <= data_r * 11'd625;//数据放大1万倍
        temp_data_vld <= 1'b1;    
    end
    else begin
        temp_data <= temp_data;//数据放大1万倍
        temp_data_vld <= 1'b0;         
    end
end

endmodule 
