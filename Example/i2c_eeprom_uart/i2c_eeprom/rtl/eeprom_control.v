`include "param.v"

module eeprom_control (
    input                   clk         ,
    input                   rst_n       ,
    
    //user interface
    input                   wr_req      ,
    input                   rd_req      ,
    input           [7:0]   wr_din      ,
    input                   wr_din_vld  ,
    input           [8:0]   rw_addr     ,
    input                   rdy         ,//指示串口发送模块是否可以发数据
    output      reg [7:0]   tx_data     ,
    output      reg         tx_data_vld ,

    //i2c interface
    output      reg         req         ,
    output      reg [3:0]   cmd         ,
    output      reg [7:0]   data        ,
    input                   wr_fail     ,
    input           [7:0]   rd_din      ,
    input                   rw_done     
);

//状态机参数定义

    localparam  IDLE        = 6'b00_0001,
                WR_REQ      = 6'b00_0010,
                WAIT_WDONE  = 6'b00_0100,
                RD_REQ      = 6'b00_1000,
                WAIT_RDONE  = 6'b01_0000,
                DONE        = 6'b10_0000;

//信号定义   

    reg     [5:0]       state_c         ;
    reg     [5:0]       state_n         ;

    reg     [7:0]       cnt_byte        ;
    wire                add_cnt_byte    ;
    wire                end_cnt_byte    ;
    reg     [7:0]       x               ;//记录读写操作的总Byte数，比如单次写操作，则需写器件地址，写地址，写数据，总发送3Byte数据

    wire                idle2wr_req         ;
    wire                idle2rd_req         ;
    wire                wait_wdone2wr_req   ;
    wire                wait_wdone2done     ;
    wire                wait_rdone2rd_req   ;
    wire                wait_rdone2done     ;

    reg                 wfifo_rdreq     ;
    wire                wfifo_wrreq     ;
    wire                wfifo_empty     ;
    wire                wfifo_full      ;
    wire    [7:0]       wfifo_qout      ;
    wire    [5:0]       wfifo_usedw     ;

    reg                 rfifo_rdreq     ;
    reg                 rfifo_wrreq     ;
    wire                rfifo_empty     ;
    wire                rfifo_full      ;
    wire    [7:0]       rfifo_qout      ;
    wire    [5:0]       rfifo_usedw     ;


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
        case (state_c)
            IDLE      :begin 
                if(idle2wr_req)
                    state_n = WR_REQ;
                else if(idle2rd_req)
                    state_n = RD_REQ;
                else 
                    state_n = state_c;
            end     
            WR_REQ    :begin 
                state_n = WAIT_WDONE;
            end 
            WAIT_WDONE:begin 
                if(wait_wdone2wr_req)
                    state_n = WR_REQ;
                else if(wait_wdone2done)
                    state_n = DONE;
                else 
                    state_n = state_c;
            end 
            RD_REQ    :begin 
                state_n = WAIT_RDONE;
            end 
            WAIT_RDONE:begin 
                if(wait_rdone2rd_req)
                    state_n = RD_REQ;
                else if(wait_rdone2done)
                    state_n = DONE;
                else 
                    state_n = state_c;
            end 
            DONE      :begin 
                state_n = IDLE;
            end  
            default:state_n = IDLE;
        endcase
    end

    assign idle2wr_req       = state_c == IDLE && (wr_req && wfifo_usedw >= `WR_BYTE-2);    
    assign idle2rd_req       = state_c == IDLE && (rd_req);    
    assign wait_wdone2wr_req = state_c == WAIT_WDONE && (rw_done && end_cnt_byte == 1'b0);        
    assign wait_wdone2done   = state_c == WAIT_WDONE && (rw_done && end_cnt_byte == 1'b1);    
    assign wait_rdone2rd_req = state_c == WAIT_RDONE && (rw_done && end_cnt_byte == 1'b0);        
    assign wait_rdone2done   = state_c == WAIT_RDONE && (rw_done && end_cnt_byte == 1'b1);    

//计数器
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            cnt_byte <= 0;
        end 
        else if(add_cnt_byte)begin 
            if(end_cnt_byte)begin 
                cnt_byte <= 0;
            end
            else begin 
                cnt_byte <= cnt_byte + 1;
            end 
        end
    end 
    assign add_cnt_byte = (state_c == WAIT_WDONE | state_c == WAIT_RDONE) && rw_done;
    assign end_cnt_byte  = add_cnt_byte && cnt_byte == x-1;

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            x <= 0;
        end 
        else if(idle2wr_req)begin 
            x <= `WR_BYTE;
        end 
        else if(idle2rd_req)begin 
            x <= `RD_BYTE;
        end 
    end

//req         cmd         data        
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            req  <= 0;
            cmd  <= 0;
            data <= 0;
        end 
        else if(state_c == WR_REQ)begin 
            case(cnt_byte)
            0:begin 
                req  <= 1;
                cmd  <= {`CMD_START | `CMD_WRITE};
                data <= {`SLAVE_CODE,2'b00,rw_addr[8],`WR_BIT};
            end  
            1:begin 
                req  <= 1;
                cmd  <= `CMD_WRITE;
                data <= rw_addr[7:0];
            end 
            `WR_BYTE-1:begin 
                req  <= 1;
                cmd  <= {`CMD_WRITE | `CMD_STOP};
                data <= wfifo_qout;
            end 
            default:begin
                req  <= 1;
                cmd  <= `CMD_WRITE;
                data <= wfifo_qout;
            end 
            endcase 
        end 
        else if(state_c == RD_REQ)begin 
            case(cnt_byte)
            0:begin 
                req  <= 1;
                cmd  <= {`CMD_START | `CMD_WRITE};
                data <= {`SLAVE_CODE,2'b00,rw_addr[8],`WR_BIT};
            end  
            1:begin 
                req  <= 1;
                cmd  <= `CMD_WRITE;
                data <= rw_addr[7:0];
            end 
            2:begin 
                req  <= 1;
                cmd  <= {`CMD_START | `CMD_WRITE};
                data <= {`SLAVE_CODE,2'b00,rw_addr[8],`RD_BIT};
            end 
            `RD_BYTE-1:begin 
                req  <= 1;
                cmd  <= {`CMD_READ | `CMD_STOP};
                data <= 0;
            end 
            default:begin
                req  <= 1;
                cmd  <= `CMD_READ;
                data <= 0;
            end 
            endcase 
        end 
        else begin 
            req  <= 0;
        end 
    end

// tx_data      tx_data_vld 
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            tx_data <= 0;
        end 
        else begin 
            tx_data <= rfifo_qout;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            tx_data_vld <= 0;
        end 
        else begin 
            tx_data_vld <= rfifo_rdreq;
        end 
    end

//rfifo_rdreq
//当读FIFO不为空，且串口发送模块处于空闲时，将读FIFO中的数据读出且发送至上位机
    always @(*)begin 
        if(rfifo_empty == 1'b0 && rdy)begin
            rfifo_rdreq  = 1'b1;
        end 
        else begin 
            rfifo_rdreq  = 1'b0;
        end 
    end

//wfifo_rdreq
//从写FIFO中读出数据发送到EEPROM
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            wfifo_rdreq <= 0;
        end 
        else if(wfifo_empty == 1'b0 && state_c == WAIT_WDONE && req && cnt_byte > 1)begin 
            wfifo_rdreq <= 1'b1;
        end 
        else begin 
            wfifo_rdreq <= 1'b0;
        end 
    end

//rfifo_wrreq
//将从EEPROM芯片读出的数据写入读FIFO中
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rfifo_wrreq <= 0;
        end 
        else if(rfifo_full == 1'b0 && rw_done && state_c == WAIT_RDONE && cnt_byte > 2)begin 
            rfifo_wrreq <= 1'b1;
        end 
        else begin 
            rfifo_wrreq <= 1'b0;
        end 
    end

//将串口接收模块传来的数据写入写FIFO中
assign wfifo_wrreq = wr_din_vld && wfifo_full == 1'b0;


//fifo例化
//将从串口发送来的有效数据存入FIFO中，然后在写入EEPROM芯片
wrfifo	wrfifo_inst (
	.aclr   (~rst_n     ),
	.clock  (clk        ),
	.data   (wr_din     ),
	.rdreq  (wfifo_rdreq),
	.wrreq  (wfifo_wrreq),
	.empty  (wfifo_empty),
	.full   (wfifo_full ),
	.q      (wfifo_qout ),
	.usedw  (wfifo_usedw)
);

//将EEPROM芯片中读出的数据存放在FIFO中然后再通过串口发送出去
rdfifo	rdfifo_inst (
	.aclr   (~rst_n     ),
	.clock  (clk        ),
	.data   (rd_din     ),
	.rdreq  (rfifo_rdreq),
	.wrreq  (rfifo_wrreq),
	.empty  (rfifo_empty),
	.full   (rfifo_full ),
	.q      (rfifo_qout ),
	.usedw  (rfifo_usedw)
);

   
endmodule

