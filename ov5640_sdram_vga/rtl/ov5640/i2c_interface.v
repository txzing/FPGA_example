`include "../param.v"

module i2c_interface( 
    input				clk		        ,
    input				rst_n	        ,
    input               trans_req       ,//传输请求  
    input         [3:0] trans_cmd       ,//命令码、操作码  
    input         [7:0] wr_din          ,//待发送给从机的数据     
    output  reg   [7:0] rd_dout         ,//从eeprom读取的一字节数据   
    output  reg         rd_dout_vld     ,
    output  reg         trans_done      ,//i2c_interface 传输一字节完成
    input               i2c_sda_in      ,
    output  reg         i2c_scl         ,
    output  reg         i2c_sda_out     ,
    output  reg         i2c_sda_out_en  ,
    output  reg         i2c_wr_faile
);			

//i2c_interface 状态机参数
    localparam  IDLE  = 7'b000_0001;		//idle
    localparam  START = 7'b000_0010;		//发起始位
    localparam  WRITE = 7'b000_0100;		//主机发数据给从机 并串转换
    localparam  RACK  = 7'b000_1000;		//主机接收从机应答
    localparam  READ  = 7'b001_0000;		//主机读取从机数据 串并转换
    localparam  SACK  = 7'b010_0000;		//主机发应答给从机  非应答时主机可以释放sda总线，或者直接发1也是等效的
    localparam  STOP  = 7'b100_0000;		//主机发停止位

//中间信号定义		 
    reg		[6:0]	state_c     ;
    reg		[6:0]	state_n     ;

    reg     [7:0]   cnt_scl     ;//产生串行时钟的计数器
    wire	    	add_cnt_scl ;
    wire	        end_cnt_scl ;

    reg     [3:0]   cnt_bit     ;//bit计数器
    wire	    	add_cnt_bit ;
    wire	        end_cnt_bit ;

    reg             slave_ack   ;//从机应答位   或0或1

    wire            idle2start  ;//状态转移条件
    wire            idle2write  ;
    wire            idle2read   ;
    wire            start2write ;
    wire            start2read  ;
    wire            write2rack  ;
    wire            rack2stop   ;
    wire            rack2idle   ;
    wire            read2sack   ;
    wire            sack2stop   ;
    wire            sack2idle   ;
    wire            stop2idle   ;

//状态机设计

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            state_c <= IDLE;
        end 
        else begin 
            state_c <= state_n;
        end 
    end

    always @(*)begin 
        case(state_c)
            IDLE :begin
                if(idle2start)
                    state_n = START;
                else if(idle2write)
                    state_n = WRITE;
                else if(idle2read)
                    state_n = READ;
                else 
                    state_n = state_c;
            end
            START:begin
                if(start2write)
                    state_n = WRITE;
                else if(start2read)
                    state_n = READ;
                else 
                    state_n = state_c;
            end
            WRITE:begin
                if(write2rack)
                    state_n = RACK;
                else 
                    state_n = state_c;
            end
            RACK :begin
                if(rack2stop)
                    state_n = STOP;
                else if(rack2idle)
                    state_n = IDLE;
                else 
                    state_n = state_c;
            end
            READ :begin
                if(read2sack)
                    state_n = SACK;
                else 
                    state_n = state_c;
            end
            SACK :begin
                if(sack2stop)
                    state_n = STOP;
                else if(sack2idle)
                    state_n = IDLE;
                else 
                    state_n = state_c;
            end
            STOP :begin
                if(stop2idle)
                    state_n = IDLE;
                else 
                    state_n = state_c;
            end
            default:state_n = IDLE;
        endcase 
    end

    assign idle2start  = state_c == IDLE  && (trans_req   && trans_cmd[0]);
    assign idle2write  = state_c == IDLE  && (trans_req   && trans_cmd[1]);
    assign idle2read   = state_c == IDLE  && (trans_req   && trans_cmd[2]);
    assign start2write = state_c == START && (end_cnt_scl && trans_cmd[1]);
    assign start2read  = state_c == START && (end_cnt_scl && trans_cmd[2]);
    assign write2rack  = state_c == WRITE && (end_cnt_bit);
    assign rack2stop   = state_c == RACK  && (end_cnt_scl && trans_cmd[3]);
    assign rack2idle   = state_c == RACK  && (end_cnt_scl && trans_cmd[3] == 0);
    assign read2sack   = state_c == READ  && (end_cnt_bit);
    assign sack2stop   = state_c == SACK  && (end_cnt_scl && trans_cmd[3]);
    assign sack2idle   = state_c == SACK  && (end_cnt_scl && trans_cmd[3] == 0);
    assign stop2idle   = state_c == STOP  && (end_cnt_scl);

//计数器
    //cnt_scl
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            cnt_scl <= 0;
        end 
        else if(add_cnt_scl)begin 
            if(end_cnt_scl)begin 
                cnt_scl <= 0;
            end
            else begin 
                cnt_scl <= cnt_scl + 1;
            end 
        end
    end 
    assign add_cnt_scl = state_c != IDLE;
    assign end_cnt_scl = add_cnt_scl && cnt_scl == `SCL_MAX-1;

    //cnt_bit
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            cnt_bit <= 0;
        end 
        else if(add_cnt_bit)begin 
            if(end_cnt_bit)begin 
                cnt_bit <= 0;
            end
            else begin 
                cnt_bit <= cnt_bit + 1;
            end 
        end
    end 
    assign add_cnt_bit = (state_c == WRITE || state_c == READ) && end_cnt_scl;
    assign end_cnt_bit = add_cnt_bit && cnt_bit == 8-1;

//slave_ack  采样slave应答位
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            slave_ack <= 1'b0;
        end 
        else if(state_c == RACK && cnt_scl == `SAMPLE)begin 
            slave_ack <= i2c_sda_in;
        end 
    end

//i2c_scl
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            i2c_scl <= 1'b1;
        end
        else if(idle2start | idle2write | idle2read)begin   //当从空闲状态到写数据状态或者从空闲状态到读数据状态时，先把scl拉低
            i2c_scl <= 1'b0;    
        end 
        else if(end_cnt_scl && stop2idle == 1'b0)begin    //当计数器计完且不是处于发送停止位状态时，将scl拉低
            i2c_scl <= 1'b0;              
        end                                    
        else if(add_cnt_scl && cnt_scl == `SCL_HALF-1)begin     //当计数器计到一半时，将scl拉高
            i2c_scl <= 1'b1;
        end 
    end

//i2c_sda_out
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            i2c_sda_out <= 1'b1;
        end 
        else if(state_c == START)begin   //起始位
            if(cnt_scl == `SEND)begin   //scl时钟低电平时，将sda拉高
                i2c_sda_out <= 1'b1;
            end 
            else if(cnt_scl == `SAMPLE)begin  //scl时钟高电平时，将sda拉低
                i2c_sda_out <= 1'b0;
            end 
        end 
        else if(state_c == WRITE && cnt_scl == `SEND)begin 
            i2c_sda_out <= wr_din[7-cnt_bit];
        end 
        else if(state_c == SACK && cnt_scl == `SEND)begin 
            i2c_sda_out <= ((trans_cmd[3]) == 0)?1'b1:1'b0;  
        end 
        else if(state_c == STOP)begin    //停止位
            if(cnt_scl == `SEND)begin   //scl时钟低电平时，将sda拉低
                i2c_sda_out <= 1'b0;
            end     
            else if(cnt_scl == `SAMPLE)begin  //scl时钟高电平时，将sda拉高
                i2c_sda_out <= 1'b1;
            end 
        end 
    end

//i2c_sda_out_en
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            i2c_sda_out_en <= 1'b0;
        end 
        else if(state_n == START || state_n == WRITE || state_n == SACK || state_n == STOP)begin 
            i2c_sda_out_en <= 1'b1;
        end 
        else begin 
            i2c_sda_out_en <= 1'b0;
        end 
    end

//rd_dout
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rd_dout <= 0;
        end 
        else if(state_n == READ && cnt_scl == `SAMPLE)begin 
            rd_dout[7-cnt_bit] <= i2c_sda_in;
        end 
    end

//rd_dout_vld
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rd_dout_vld <= 0;
        end 
        else begin 
            rd_dout_vld <= read2sack;
        end 
    end

//trans_done  接收完ack、发送完ack、发送完stop
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            trans_done <= 1'b0;
        end 
        else if(rack2idle || sack2idle || stop2idle )begin 
            trans_done <= 1'b1;
        end 
        else begin 
            trans_done <= 1'b0;
        end 
    end

//i2c_wr_faile
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            i2c_wr_faile <= 0;
        end 
        else begin 
            i2c_wr_faile <= slave_ack && stop2idle;
        end 
    end

endmodule
