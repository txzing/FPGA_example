module hist#(parameter ROW = 5,COL = 1024,SCALE = 256)(
      input                         clk         ,//时钟
      input                         rst_n       ,//复位
      input                         start       ,//开始统计的使能信号
      input                 [7:0]   din         ,//输入的待统计的数据
      input                         din_vld     ,//输入数据有效指示信号
//输出信号定义
      output        reg             dout_vld    ,
      output        wire    [19:0]  dout        ,//输出的统计结果
      output        reg             cal_row_done,//统计一行结束标志信号 可以不用
      output        reg             init_done    //ram清零完成（即初始化完成），告诉上游模块可以送数据来了

);

/************************************ 注释开始 ************************************
模块功能：1、对输入的1M字节数据统计每个数据出现的次数；
         2、本模块仅作为基本功能测试，设置输入数据行数为5行，每行1024个数据，每个数据的大小范围为0--255；
         3、以输入数据作为双口ram的地址值，每次接收到一个数据就读出该地址中对应的数据，加1之后再写入该地址；
         4、采用相邻数判断的方法，相邻数判断主要通过判断前一个数据与当前输入的数据是否相同来改变RAM写入的数据
             若相同则统计完相同的相邻数的个数之后，将其与ram中读出的数据相加后写入ram;若相邻数据不同则直接读出
             ram中原有数据加1之后写回ram；

************************************ 注释结束 ************************************/

//状态机参数定义
    localparam  IDLE    =   4'b0001,//空闲状态
                CLEAR   =   4'b0010,//将ram所有地址清零
                CALCU   =   4'b0100,//计算各个数据出现的次数
                OUTPUT  =   4'b1000;//输出结果
					 
					 

//信号定义
    reg     [3:0]   state_c     ;
    reg     [3:0]   state_n     ;

    reg     [7:0]   din_r       ;//输入数据寄存
    reg             din_vld_r   ;
    reg     [7:0]   din_ff0     ;//输入数据打拍
    reg     [7:0]   din_ff1     ;
    reg             din_vld_ff0 ;
    reg             din_vld_ff1 ;

    reg     [19:0]  cal_data    ;//相同的数据统计值
    reg     [19:0]  cal_value   ;//写入ram的统计值
    reg             cal_value_vld;//写入ram数据有效指示信号

    wire    [7:0]   cal_wr_addr ;//统计状态下，写ram的地址

    wire    [7:0]   cal_rd_addr ;//统计状态下，读ram的地址

    reg     [10:0]  cnt_clear   ;//清零计数器        
    wire            add_cnt_clear;
    wire            end_cnt_clear;

    reg     [7:0]   cnt_output    ;//输出数据计数器
    wire            add_cnt_output;
    wire            end_cnt_output;

    reg     [10:0]  cnt_row     ;//计算行数
    wire            add_cnt_row ;
    wire            end_cnt_row ;

    reg             wr_ram_en   ;//写ram使能信号
    reg     [ 7:0]  wr_ram_addr ;//写ram地址
    reg     [19:0]  wr_ram_din  ;//写ram数据
    reg     [ 7:0]  rd_ram_addr ;//读ram地址
    wire    [19:0]  rd_ram_dout ;//读ram数据    

//状态机转移条件定义

    wire            idle2clear_start    ;
    wire            clear2calcu_start   ;
    wire            calcu2output_start  ;
    wire            output2idle_start   ;  

//状态机
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            state_c <= IDLE;                
        end
        else begin
            state_c <= state_n;
        end
    end

    always  @(*)begin
        case(state_c)
            IDLE:   begin 
                        if(idle2clear_start)
                            state_n = CLEAR;
                        else 
                            state_n = state_c;
                    end 
            CLEAR:  begin 
                        if(clear2calcu_start)
                            state_n = CALCU;
                        else 
                            state_n = state_c;
                    end 
            CALCU:  begin 
                        if(calcu2output_start)
                            state_n = OUTPUT;
                        else 
                            state_n = state_c;
                    end 
            OUTPUT: begin 
                        if(output2idle_start)
                            state_n = IDLE;
                        else 
                            state_n =state_c;
                    end 
            default:begin 
                        state_n = IDLE;
                    end 
        endcase
    end

    assign  idle2clear_start   = state_c == IDLE   && start;
    assign  clear2calcu_start  = state_c == CLEAR  && end_cnt_clear;
    assign  calcu2output_start = state_c == CALCU  && end_cnt_row;
    assign  output2idle_start  = state_c == OUTPUT && end_cnt_output ;  

//cnt_clear,初始化，将RAM数据清零
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_clear <= 0;
        end
        else if(add_cnt_clear)begin
            if(end_cnt_clear)
                cnt_clear <= 0;
            else
                cnt_clear <= cnt_clear + 1;
        end
    end
    
    assign add_cnt_clear = state_c == CLEAR && wr_ram_en;
    assign end_cnt_clear = add_cnt_clear && cnt_clear == SCALE-1;

//cnt_output,统计完后，将RAM中的数据输出
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_output <= 0;
        end
        else if(add_cnt_output)begin
            if(end_cnt_output)
                cnt_output <= 0;
            else
                cnt_output <= cnt_output + 1;
        end
    end

    assign add_cnt_output = state_c == OUTPUT;       
    assign end_cnt_output = add_cnt_output && cnt_output == SCALE-1;   

//输入数据打拍
    always  @(posedge clk or negedge rst_n)begin    //同步输入数据
        if(!rst_n)begin
            din_r <= 0;
				din_ff0 <= 0;
            din_ff1 <= 0;           
        end
        else begin
            din_r     <= din;
				din_ff0     <= din_r;
            din_ff1     <= din_ff0;
            
        end
    end

    always  @(posedge clk or negedge rst_n)begin    //打两拍
        if(!rst_n)begin
				din_vld_r <= 0;
            din_vld_ff0 <= 1'b0;
            din_vld_ff1 <= 1'b0;
        end
        else begin
            din_vld_r <= din_vld;
            din_vld_ff0 <= din_vld_r;
            din_vld_ff1 <= din_vld_ff0;
        end
    end	 
	 
//cnt_row   记录统计了多少行数据
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_row <= 0;
        end
        else if(add_cnt_row)begin
            if(end_cnt_row)
                cnt_row <= 0;
            else
                cnt_row <= cnt_row + 1;
        end
    end
                                            //下降沿
    assign add_cnt_row = state_c == CALCU && din_vld_ff0 == 1'b0 && din_vld_ff1;       
    assign end_cnt_row = add_cnt_row && cnt_row == ROW-1;   


//cal_data
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cal_data <= 0;
        end
        else if(state_c == CALCU && din_vld_ff0)begin
            if(din_ff0 != din_r)begin     //相邻两个数据不同则不加1
                cal_data <= 1;
            end 
            else begin
                cal_data <= cal_data + 1'b1;    //相邻两个数据相同则加1
            end 
        end
        else begin
            cal_data <= 1'b1;   //其余情况则保持初值为1
        end
    end

//写入ram的当前统计结果 cal_value   cal_value_vld：写入ram数据有效标志信号，同时也作为ram的写使能信号
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cal_value     <= 0;
            cal_value_vld <= 1'b0;
        end
        else if(state_c == CALCU)begin
            if(din_ff0 != din_r && din_vld_ff0)begin   //若相邻两个数值不同，则将当前的统计结果写入ram
                cal_value     <= rd_ram_dout + cal_data;
                cal_value_vld <= 1'b1;
            end 
            else begin 
                cal_value     <= cal_value; //若相邻两个数相同则不写进ram
                cal_value_vld <= 1'b0;
            end 
        end
        else if(din_vld_ff0 && din_vld == 1'b0)begin    //1024个数据结束则把最后一个结果写入
            cal_value     <= rd_ram_dout + cal_data;
            cal_value_vld <= 1'b1;
        end
        else begin 
            cal_value     <= 0;
            cal_value_vld <= 1'b0;
        end 
    end
    
    assign  cal_wr_addr = din_ff1;  //数据写入ram的地址
    assign  cal_rd_addr = din_r;    //数据读出ram的地址

//dout_vld  输出数据有效指示信号    
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            dout_vld <= 1'b0;
        end
        else begin
            dout_vld <= state_c == OUTPUT;
        end
    end

    assign  dout =  dout_vld?rd_ram_dout:0;  

	 
//cal_row_done  一行数据统计完毕
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cal_row_done <= 1'b0;
        end
        else begin                                 //下降沿
            cal_row_done <= state_c == CALCU && din_vld_ff0 == 1'b0 && din_vld_ff1;  
        end
    end

//init_done 初始化ram完成标志信号
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            init_done <= 1'b0;
        end
        else begin
            init_done <= clear2calcu_start;
        end
    end

    
//ram写 
    always  @(*)begin
        if(state_c == CLEAR)begin
            wr_ram_en   = 1'b1;     //清零的时候，向ram里写0
            wr_ram_addr = cnt_clear;//写地址就是清零计数器的值    
            wr_ram_din  = 0;        //所有256个地址全部写入0
        end
        else if(state_c == CALCU)begin
            wr_ram_en   = cal_value_vld;    //当前后两个数不同时，才将数据写入ram
            wr_ram_addr = din_ff1;
            wr_ram_din  = cal_value;
        end
        else begin 
            wr_ram_en   = 0;
            wr_ram_addr = 0;
            wr_ram_din  = 0;
        end 
    end

//ram读
    always  @(*)begin
        if(state_c == CALCU)begin 
            rd_ram_addr = cal_rd_addr;
        end 
        else if(state_c == OUTPUT)begin 
            rd_ram_addr = cnt_output;
        end 
        else begin 
            rd_ram_addr = 0;
        end 
    end

    
//ram例化       ram的深度为256，宽度为20    简单双口ram，可以同时读、写不同地址，但是不能同时对同一地址读写
    ram ram(
	 .data      (wr_ram_din ),
	 .rd_aclr   (~rst_n     ),
	 .rdaddress (rd_ram_addr),
	 .rdclock   (clk        ),
	 .wraddress (wr_ram_addr),
	 .wrclock   (clk        ),
	 .wren      (wr_ram_en  ),
	 .q         (rd_ram_dout)
 );

endmodule

