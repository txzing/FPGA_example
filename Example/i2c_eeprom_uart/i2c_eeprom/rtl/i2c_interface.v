`include "param.v"

module i2c_interface (  //仅仅实现I2C协议时序
    input               clk         ,//50MHz
    input               rst_n       ,

    input               req         ,//传输使能
    input   [3:0]       cmd         ,//传输命令码
    input   [7:0]       wr_din      ,//需要传输的数据

    input               sda_in      ,
    output  reg         sda_out     ,
    output  reg         sda_out_en  ,
    output  reg         scl         ,

    output  reg         wr_fail     ,//从机未应答
    output  reg [7:0]   rd_dout     ,//从slave读取的1字节数据 
    output  reg         rw_done      //1个字节读写完成
);

//状态机参数,独热码
    localparam  IDLE     = 7'b000_0001,
                START    = 7'b000_0010,
                WRITE    = 7'b000_0100,
                READ     = 7'b000_1000,
                RECV_ACK = 7'b001_0000,
                SEND_ACK = 7'b010_0000,
                STOP     = 7'b100_0000;

//定义信号
    reg     [6:0]       state_c     ;
    reg     [6:0]       state_n     ;

    reg     [7:0]       cnt_scl     ;//产生I2C scl
    wire                add_cnt_scl ;
    wire                end_cnt_scl ;

    reg     [3:0]       cnt_bit     ;//传输数据的bit计数器
    wire                add_cnt_bit ;
    wire                end_cnt_bit ;
    reg     [3:0]       bit_num     ;

    reg                 slave_ack   ;//从机应答位

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
                if(recv_ack2stop)
                    state_n = STOP;
                else if(recv_ack2idle)
                    state_n = IDLE;
                else 
                    state_n = state_c;
            end 
            SEND_ACK:begin
                if(send_ack2stop)
                    state_n = STOP; 
                else if(send_ack2idle)
                    state_n = IDLE;
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
    assign idle2start     = state_c == IDLE  && (req && (cmd & `CMD_START));
    assign idle2write     = state_c == IDLE  && (req && (cmd & `CMD_WRITE));
    assign idle2read      = state_c == IDLE  && (req && (cmd & `CMD_READ ));
    assign start2write    = state_c == START && (end_cnt_bit && (cmd & `CMD_WRITE));
    assign start2read     = state_c == START && (end_cnt_bit && (cmd & `CMD_READ ));
    assign write2recv_ack = state_c == WRITE && (end_cnt_bit);
    assign read2send_ack  = state_c == READ  && (end_cnt_bit);
    assign recv_ack2stop  = state_c == RECV_ACK && (end_cnt_bit && ((cmd & `CMD_STOP) || slave_ack));
    assign recv_ack2idle  = state_c == RECV_ACK && (end_cnt_bit && ((cmd & `CMD_STOP) == 'd0));
    assign send_ack2stop  = state_c == SEND_ACK && (end_cnt_bit && (cmd & `CMD_STOP));
    assign send_ack2idle  = state_c == SEND_ACK && (end_cnt_bit && (cmd & `CMD_STOP) == 'd0);
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
    
    //assign end_cnt_bit = add_cnt_bit && cnt_bit == ((state_c == `WRITE || state_c == `READ)?8-1:1-1);

    always @(*)begin 
        if(state_c == WRITE || state_c == READ)     //在写和读状态下是8个IIC时钟周期
            bit_num = 8;
        else 
            bit_num = 1;        //发送起始位，发送应答，发送停止位是1个时钟周期
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

//i2c scl 
/*
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            scl <= 1'b1;
        end 
        else if(add_cnt_scl && cnt_scl < `SCL_HALF-1)begin 
            scl <= 1'b0;
        end 
        else begin   //传输数据时，cnt_scl大于SCL_HALF scl拉高；不传输数据时，scl也拉高
            scl <= 1'b1;
        end 
    end
*/

/*
    always @(*)begin 
        if(add_cnt_scl && cnt_scl < `SCL_HALF)begin
            scl = 1'b0;
        end 
        else begin 
            scl = 1'b1;
        end 
    end
*/
//产生IIC时钟
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            scl <= 1'b1;
        end
        else if(idle2start | idle2write | idle2read)begin   //当从空闲状态到写数据状态或者从空闲状态到读数据状态时，先把scl拉低
            scl <= 1'b0;    
        end 
        else if(end_cnt_scl && stop2idle == 1'b0)begin    //当计数器计完且不是处于发送停止位状态时
            scl <= 1'b0;              
        end                                    
        else if(add_cnt_scl && cnt_scl == `SCL_HALF)begin     //当计数器计到一半时，将scl拉高
            scl <= 1'b1;
        end 
    end

//sda_out_en 
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            sda_out_en <= 1'b0;
        end 
        else if(state_c == START | state_c == WRITE | state_c == SEND_ACK | state_c == STOP)begin 
            sda_out_en <= 1'b1;//这些状态下处于发送使能
        end 
        else begin 
            sda_out_en <= 1'b0;
        end 
    end

//i2c sda_out  
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
            sda_out <= wr_din[7-cnt_bit];//先发送最高位
        end
        else if(state_c == SEND_ACK && cnt_scl == `SEND)begin 
            sda_out <= (cmd & `CMD_STOP)?1'b1:1'b0;   //在读数据的时候，FPGA发送应答，当有发送停止位命令即结束读取数据时，则送出非应答1,即
        end                                           //若连续读取数据，则主机发送应答位0
        else if(state_c == STOP)begin 
            if(cnt_scl == `SEND)    //时钟scl低电平时 拉低sda
                sda_out <= 1'b0;
            else if(cnt_scl == `SAMPLE)
                sda_out <= 1'b1;    //时钟scl高电平时 拉高sda
        end 
    end
/*    
如果接收端是主控端，则在它收到最后一个字节后，发送一个 NACK 信号，
以通知被控发送端结束数据发送，并释放 SDA 线，以便主控接收器发送停止信号。
*/


//wr_fail
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            wr_fail <= 1'b0;
        end 
        else if(slave_ack && stop2idle)begin //主机进行写时,接收到的应答为低电平
            wr_fail <= 1'b1;//未接收到应答
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

//rw_done
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rw_done <= 0;
        end 
        else begin 
            rw_done <= recv_ack2idle | send_ack2idle | stop2idle;
        end 
    end

endmodule

