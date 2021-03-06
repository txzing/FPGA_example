`include "../param.v"

module i2c_intf(
    input               clk              ,
    input               rst_n            ,
    //eeprom_ctrl接口
    input               req              ,
    input       [3:0]   cmd              ,
    input               cmd_vld          ,
    input       [7:0]   wr_din           ,
    input               wr_din_vld       ,
    output  reg         slave_busy       ,
    output  reg         fail             ,

    //eeprom接口
    input               sda_in           ,
    output  reg         sda_out          ,
    output  reg         sda_out_en       ,
    output  reg         scl              ,
    output  reg [7:0]   rd_dout          ,
    output  reg         rd_dout_vld      
    );
					 
//状态机参数
    localparam  IDLE     = 7'b000_0001,
                START    = 7'b000_0010,
                WRITE    = 7'b000_0100,
                READ     = 7'b000_1000,
                RECV_ACK = 7'b001_0000,
                SEND_ACK = 7'b010_0000,
                STOP     = 7'b100_0000;

//定义信号
    reg     [6:0]       state_c         ;
    reg     [6:0]       state_n         ;

    reg     [7:0]       cnt_scl         ;//产生I2C scl
    wire                add_cnt_scl     ;
    wire                end_cnt_scl     ;

    reg     [3:0]       cnt_bit         ;//传输数据的bit计数器
    wire                add_cnt_bit     ;
    wire                end_cnt_bit     ;
    reg     [3:0]       bit_num         ;

    reg                 slave_ack       ;//从机应答位
    reg                 req_r           ;//寄存 检测下降沿
    wire                req_pedge       ;
    reg     [3:0]       opcode          ;
    reg     [7:0]       tx_data         ;//从数据队列读出的数据

    wire                idle2start      ;
    wire                idle2write      ;
    wire                idle2read       ;
    wire                start2write     ;
    wire                start2read      ;
    wire                write2recv_ack  ;
    wire                read2send_ack   ;
    wire                recv_ack2idle   ;
    wire                recv_ack2stop   ;
    wire                send_ack2idle   ;
    wire                send_ack2stop   ;
    wire                stop2idle       ;

    wire    [3:0]       cmdbuf_din      ;
    wire                cmdbuf_rden     ;
    wire                cmdbuf_wren     ;
    wire                cmdbuf_empty    ;
    wire                cmdbuf_full     ;
    wire    [3:0]       cmdbuf_q        ;

    wire    [7:0]       databuf_din     ;
    wire                databuf_rden    ;
    wire                databuf_wren    ;
    wire                databuf_empty   ;
    wire                databuf_full    ;
    wire    [7:0]       databuf_q       ;

    

//状态机
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
            IDLE    :begin 
                if(idle2start)
                    state_n = START;
                else if(idle2write)
                    state_n = WRITE;
                else if(idle2read)
                    state_n = READ;
                else 
                    state_n = state_c;
            end 
            START   :begin 
                if(start2write)
                    state_n = WRITE;
                else if(start2read)
                    state_n = READ;
                else 
                    state_n = state_c;
            end 
            WRITE   :begin 
                if(write2recv_ack)
                    state_n = RECV_ACK;
                else 
                    state_n = state_c;
            end 
            READ    :begin 
                if(read2send_ack)
                    state_n = SEND_ACK;
                else 
                    state_n = state_c;
            end 
            RECV_ACK:begin 
                if(recv_ack2idle)
                    state_n = IDLE;
                else if(recv_ack2stop)
                    state_n = STOP;
                else 
                    state_n = state_c;
            end 
            SEND_ACK:begin
                if(send_ack2idle)
                    state_n = IDLE; 
                else if(send_ack2stop)
                    state_n = STOP;
                else 
                    state_n = state_c;
            end 
            STOP    :begin 
                if(stop2idle)
                    state_n = IDLE;
                else 
                    state_n = state_c;
            end  
            default:state_n = IDLE;
        endcase 
    end    

//注意：状态机跳转条件应该是互斥的，不能有包含关系
    assign idle2start     = state_c == IDLE  && (req_pedge || slave_busy & opcode[0]);
    assign idle2write     = state_c == IDLE  && (slave_busy & opcode[1]);
    assign idle2read      = state_c == IDLE  && (slave_busy & opcode[2]);
    assign start2write    = state_c == START && (end_cnt_bit & slave_busy & opcode[1]);
    assign start2read     = state_c == START && (end_cnt_bit & slave_busy & opcode[2]);
    assign write2recv_ack = state_c == WRITE && (end_cnt_bit);
    assign read2send_ack  = state_c == READ  && (end_cnt_bit);
    assign recv_ack2stop  = state_c == RECV_ACK && (end_cnt_bit & slave_busy & opcode[3] == 1'b1);
    assign recv_ack2idle  = state_c == RECV_ACK && (end_cnt_bit & slave_busy & opcode[3] == 1'b0);
    assign send_ack2stop  = state_c == SEND_ACK && (end_cnt_bit & slave_busy & opcode[3] == 1'b1);
    assign send_ack2idle  = state_c == SEND_ACK && (end_cnt_bit & slave_busy & opcode[3] == 1'b0);
    assign stop2idle      = state_c == STOP && (end_cnt_bit);                      

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
    assign end_cnt_scl = add_cnt_scl && cnt_scl == `SCL_MAX-1 ;

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
    assign add_cnt_bit = end_cnt_scl;
    assign end_cnt_bit = add_cnt_bit && cnt_bit == bit_num-1;

   always @(*)begin 
        if(state_c == WRITE || state_c == READ)
            bit_num = 8;
        else 
            bit_num = 1;
    end

//opcode
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            opcode <= 0;
        end 
        else begin 
            opcode <= cmdbuf_q;
        end
    end

//req_r 对req打拍 检测上升沿  启动状态机发送起始位、数据。。。
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            req_r <= 0;
        end 
        else begin 
            req_r <= req;
        end 
    end
    assign req_pedge = ~req_r & req;

//tx_data   从数据队列中读取数据
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            tx_data <= 0;
        end 
        else begin 
            tx_data <= databuf_q;
        end 
    end
    
//slave_ack  采样从机应答位
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            slave_ack <= 1'b1;
        end 
        else if(state_c == RECV_ACK && cnt_scl == `SAMPLE)begin 
            slave_ack <= sda_in;
        end 
    end

//产生串行时钟
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            scl <= 1'b1;
        end
        else if(idle2start | idle2write | idle2read)begin   //当从空闲状态到写数据状态或者从空闲状态到读数据状态时，先把scl拉低
            scl <= 1'b0;    
        end 
        else if(end_cnt_scl && stop2idle == 1'b0)begin    //当计数器计完且不是处于发送停止位状态时，将scl拉低
            scl <= 1'b0;              
        end                                    
        else if(add_cnt_scl && cnt_scl == `SCL_HALF)begin     //当计数器计到一半时，将scl拉高
            scl <= 1'b1;
        end 
    end

//i2c sda_out  产生串行数据输出
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            sda_out <= 1'b1;
        end 
        else if(state_c == START)begin  //发起始位
            if(cnt_scl == `SEND)    //先在时钟低电平时 sda拉高
                sda_out <= 1'b1;
            else if(cnt_scl == `SAMPLE)
                sda_out <= 1'b0;    //再在时钟高电平时 sda拉低
        end 
        else if(state_c == WRITE && cnt_scl == `SEND)begin 
            sda_out <= tx_data[7-cnt_bit];
        end
        else if(state_c == SEND_ACK && cnt_scl == `SEND)begin 
            sda_out <= opcode[3]?1'b1:1'b0;
        end  
        else if(state_c == STOP)begin 
            if(cnt_scl == `SEND)    //时钟scl低电平时 拉低sda
                sda_out <= 1'b0;
            else if(cnt_scl == `SAMPLE)
                sda_out <= 1'b1;    //时钟scl高电平时 拉高sda
        end 
    end

//sda_out_en 
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            sda_out_en <= 1'b0;
        end 
        else if(idle2start | idle2write | read2send_ack | recv_ack2stop)begin 
            sda_out_en <= 1'b1;
        end 
        else if(write2recv_ack | stop2idle | send_ack2idle)begin 
            sda_out_en <= 1'b0;
        end 
    end
	
//rd_dout
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rd_dout <= 0;
        end 
        else if(state_c == READ && cnt_scl == `SAMPLE)begin 
            rd_dout[7-cnt_bit] <= sda_in;  //MSB
            //rd_dout <= {rd_dout[6:0],sda_in};
        end 
    end

//rd_dout_vld
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rd_dout_vld <= 0;
        end 
        else begin 
            rd_dout_vld <= read2send_ack;
        end 
    end


//fail
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            fail <= 1'b0;
        end 
        else if(slave_ack && stop2idle)begin 
            fail <= 1'b1;
        end 
    end

//slave_busy
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            slave_busy <= 0;
        end 
        else if(slave_busy == 1'b0 & idle2start)begin 
            slave_busy <= 1'b1;
        end 
        else if(slave_busy & stop2idle)begin 
            slave_busy <= 1'b0;
        end 
    end


//fifo例化
    cmd_buf u_cmd_buf(      //命令队列
	.aclr       (~rst_n         ),
	.clock      (clk            ),
	.data       (cmdbuf_din     ),
	.rdreq      (cmdbuf_rden    ),
	.wrreq      (cmdbuf_wren    ),
	.empty      (cmdbuf_empty   ),
	.full       (cmdbuf_full    ),      
	.q          (cmdbuf_q       )
    );


    assign cmdbuf_din   = cmd   ;
    assign cmdbuf_wren  = cmd_vld & ~cmdbuf_full;
    assign cmdbuf_rden = ~cmdbuf_empty & (write2recv_ack | read2send_ack | stop2idle);
    
    data_buf u_data_buf(      //数据队列
	.aclr       (~rst_n         ),
	.clock      (clk            ),
	.data       (databuf_din    ),
	.rdreq      (databuf_rden   ),
	.wrreq      (databuf_wren   ),
	.empty      (databuf_empty  ),
	.full       (databuf_full   ),      
	.q          (databuf_q      )
    );

    assign databuf_din   = wr_din;
    assign databuf_wren  = wr_din_vld & ~databuf_full;
    assign databuf_rden  = ~databuf_empty & (write2recv_ack | read2send_ack | stop2idle);  

endmodule
