`include "param.v"

module sdram_rw_ctrl( 
    input				clk_100m        ,
    input				clk_50m         ,
    input				clk_65m         ,
    input				rst_n	        ,

    //capture interface       
    input       [15:0]  din		        ,//输入capture捕获数据
    input               din_vld         ,//输入capture捕获数据数据有效指示
    input		        din_sop	        ,//start of packet 
    input               din_eop         ,//end of packet 

    //sdram_driver interface
    input   	     	busy	        ,//忙标志信号
    input              	ack  	        ,//应答信号
    input       [15:0]  rd_din          ,//读取的数据
    input               rd_din_vld      ,//数据有效标志信号
    output  reg     	wr_req       	,//写请求
    output	reg	    	rd_req      	,//读请求
    output  reg [15:0]  wr_dout         ,//数据
    output  reg         wr_dout_vld     ,//数据有效标志信号
    output  reg [23:0]	rw_addr	        ,//读、写地址 bank/行/列

    //vga interface
    input               vga_rd_req      ,//vga读数据请求
    output	reg	[15:0]	vga_dout    	,
    output  reg         vga_dout_vld    
       
);								 
      
    //中间信号定义		 
    reg		[4:0]	state_c         ;
    reg		[4:0]	state_n         ;

    reg     [9:0]   cnt             ;
    wire	    	add_cnt         ;
    wire	    	end_cnt         ;

    reg             wr_sdram_flag   ;//写标志
    reg             rd_sdram_flag   ;//读标志
    reg             rw_flag         ;//读写选择标志  1：读 0：写
    reg             flag_sel        ;//读写标志

    reg     [21:0]  wr_addr         ;//写数据地址
    wire            add_wr_addr     ;
    wire            end_wr_addr     ;
    reg     [21:0]  rd_addr         ;//读数据地址
    wire            add_rd_addr     ;
    wire            end_rd_addr     ;

    reg     [3:0]   change_cnt      ;
    wire            add_change_cnt  ;
    wire            end_change_cnt  ;

    reg             wr_frame_end    ;
    reg     [1:0]   wr_bank         ;//写bank
    reg     [1:0]   rd_bank         ;//读bank
    reg             change_bank     ;//bank切换标志
    reg             change_bank_flag;
    reg             change_bank_ff0 ;
    reg             change_bank_ff1 ;
    reg             change_bank_ff2 ;

    reg             wr_fifo_flag    ;//写FIFO标志信号
    wire            get_data_flag   ;
    
    //wr_fifo
    wire            wr_fifo_wrreq   ;
    wire    [17:0]  wr_fifo_din     ;
    wire            wr_fifo_rdreq   ;
    wire    [17:0]  wr_fifo_dout    ;
    wire            wr_fifo_empty   ;
    wire    [10:0]  wr_fifo_usedw   ;
    wire            wr_fifo_full    ;

    //rd_fifo
    wire    [15:0]  rd_fifo_din     ;    
    wire            rd_fifo_rdreq   ;    
    wire            rd_fifo_wrreq   ;
    wire    [15:0]  rd_fifo_dout    ;
    wire            rd_fifo_empty   ;
    wire            rd_fifo_full    ;
    wire    [11:0]  rd_fifo_usedw   ;

//状态转移条件
    wire            c_idle2wr_req   ;
    wire            c_idle2rd_req   ;
    wire            wr_req2send_data;
    wire            send_data2c_idle;
    wire            rd_req2read_data;
    wire            read_data2c_idle;

//状态机
    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            state_c <= `C_IDLE;
        end 
        else begin 
            state_c <= state_n;
        end 
    end    

    always @(*)begin 
        case (state_c)
            `C_IDLE:begin 
                if(c_idle2wr_req)
                    state_n = `WR_REQ;
                else if(c_idle2rd_req)
                    state_n = `RD_REQ;
                else 
                    state_n = state_c;
            end 
            `WR_REQ:begin 
                if(wr_req2send_data)
                    state_n = `SEND_DATA;
                else 
                    state_n = state_c;
            end 
            `SEND_DATA:begin 
                if(send_data2c_idle)
                    state_n = `C_IDLE;
                else 
                    state_n = state_c;
            end 
            `RD_REQ:begin 
                if(rd_req2read_data)
                    state_n = `READ_DATA;
                else 
                    state_n = state_c;
            end 
            `READ_DATA:begin 
                if(read_data2c_idle)
                    state_n = `C_IDLE;
                else 
                    state_n = state_c;
            end 
            default:state_n = `C_IDLE;
        endcase
    end

    assign  c_idle2wr_req    = state_c == `C_IDLE    && (rw_flag == 1'b0 && wr_fifo_usedw >= `WR_FIFO_MIN);
    assign  c_idle2rd_req    = state_c == `C_IDLE    && (rw_flag && rd_fifo_usedw <= `RD_FIFO_MAX);
    assign  wr_req2send_data = state_c == `WR_REQ    && (ack);
    assign  send_data2c_idle = state_c == `SEND_DATA && (end_cnt);
    assign  rd_req2read_data = state_c == `RD_REQ    && (ack);
    assign  read_data2c_idle = state_c == `READ_DATA && (end_cnt);

//cnt
    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            cnt <= 0;
        end 
        else if(add_cnt)begin 
            if(end_cnt)begin 
                cnt <= 0;
            end
            else begin 
                cnt <= cnt + 1;
            end 
        end
    end 
    assign add_cnt = state_c == `SEND_DATA || state_c == `READ_DATA;
    assign end_cnt = add_cnt && cnt == `SDRAM_BL-1;

/*********************读写请求仲裁机制***************************/

    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            wr_sdram_flag <= 1'b0;
        end 
        else if(wr_fifo_usedw >= `WR_FIFO_MIN)begin 
            wr_sdram_flag <= 1'b1;  //可以发起一次SDRAM写操作
        end 
        else begin 
            wr_sdram_flag <= 1'b0;
        end 
    end

    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            rd_sdram_flag <= 0;
        end 
        else if(rd_fifo_usedw <= `RD_FIFO_MIN)begin 
            rd_sdram_flag <= 1'b1;
        end 
        else begin 
            rd_sdram_flag <= 1'b0;
        end 
    end

    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            rw_flag <= 1'b0;
        end 
        else if(wr_sdram_flag && (flag_sel || flag_sel == 1'b0 && rd_sdram_flag != 1'b1))begin 
            rw_flag <= 1'b0;
        end 
        else if(rd_sdram_flag && (flag_sel == 1'b0 || flag_sel && wr_sdram_flag != 1'b1))begin 
            rw_flag <= 1'b1;
        end 
    end

    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            flag_sel <= 0;
        end 
        else if(send_data2c_idle || read_data2c_idle)begin 
            flag_sel <= rw_flag;
        end 
    end

/*************************************************************/

//wr_addr         ;//写数据地址

    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            wr_addr <= 0;
        end 
        else if(add_wr_addr)begin 
            if(end_wr_addr)begin 
                wr_addr <= 0;
            end
            else begin 
                wr_addr <= wr_addr + `SDRAM_BL;
            end 
        end
    end 
    assign add_wr_addr = send_data2c_idle;
    assign end_wr_addr = add_wr_addr && wr_addr == `RESOLUTION-`SDRAM_BL;

    
//rd_addr         ;//读数据地址
    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            rd_addr <= 0;
        end 
        else if(add_rd_addr)begin 
            if(end_rd_addr)begin 
                rd_addr <= 0;
            end
            else begin 
                rd_addr <= rd_addr + `SDRAM_BL;
            end 
        end
    end 
    assign add_rd_addr = read_data2c_idle;
    assign end_rd_addr = add_rd_addr && rd_addr == `RESOLUTION-`SDRAM_BL;

//wr_bank
    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            wr_bank <= 2'b00;
        end 
        else if(change_bank)begin 
            wr_bank <= ~wr_bank;
        end 
    end    

//rd_bank
    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            rd_bank <= 2'b11;
        end 
        else if(change_bank)begin 
            rd_bank <= ~rd_bank;
        end 
    end

//change_bank

    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            change_bank <= 0;
        end 
        else if(wr_frame_end && end_rd_addr)begin 
            change_bank <= 1'b1;
        end 
        else begin 
            change_bank <= 1'b0;
        end 
    end
    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            change_bank_flag <= 0;
        end 
        else if(wr_frame_end && end_rd_addr)begin 
            change_bank_flag <= 1'b1;
        end 
        else if(end_change_cnt)begin 
            change_bank_flag <= 1'b0;
        end 
    end

    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            change_cnt <= 0;
        end 
        else if(add_change_cnt)begin 
            if(end_change_cnt)begin 
                change_cnt <= 0;
            end
            else begin 
                change_cnt <= change_cnt + 1;
            end 
        end
    end 
    assign add_change_cnt = change_bank_flag;
    assign end_change_cnt = add_change_cnt && change_cnt == 5-1;

//将 change_bank 从100M时钟域下同步到50M时钟域下，再在50M时钟域下检测change_bank上升沿时，切换bank
    always @(posedge clk_50m or negedge rst_n)begin     
        if(!rst_n)begin
            change_bank_ff0 <= 0;
            change_bank_ff1 <= 0;
            change_bank_ff2 <= 0;
        end 
        else begin 
            change_bank_ff0 <= change_bank_flag;
            change_bank_ff1 <= change_bank_ff0;
            change_bank_ff2 <= change_bank_ff1;
        end 
    end
//wr_frame_end
    always @(posedge clk_50m or negedge rst_n)begin 
        if(!rst_n)begin
            wr_frame_end <= 0;
        end 
        else if(wr_fifo_flag && din_eop)begin //eop  
            wr_frame_end <= 1'b1;
        end 
        else if(change_bank_ff1 && change_bank_ff2 == 1'b0)begin    //在50M时钟域下出现上升沿时，切换bank
            wr_frame_end <= 1'b0;
        end 
    end

//wr_fifo_flag
    always @(posedge clk_50m or negedge rst_n)begin 
        if(!rst_n)begin
            wr_fifo_flag <= 0;
        end 
        else if(wr_frame_end == 1'b0 && din_sop)begin   //新的一帧开始时，写入FIFO
            wr_fifo_flag <= 1'b1;
        end 
        else if(get_data_flag && din_eop)begin      //一帧写完后，停止写FIFO，在读完一帧之前，后面的一帧丢弃
            wr_fifo_flag <= 0;
        end 
    end

    assign get_data_flag = wr_fifo_flag || wr_frame_end == 1'b0 && din_sop;

//rw_addr
    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            rw_addr <= 0;
        end 
        else if(state_c == `WR_REQ)begin 
            rw_addr <= {wr_bank,wr_addr};
        end 
        else if(state_c == `RD_REQ)begin 
            rw_addr <= {rd_bank,rd_addr};
        end 
    end    

//wr_req
    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            wr_req <= 0;
        end 
        else begin 
            wr_req <= state_c == `WR_REQ && busy == 1'b0;
        end 
    end

//rd_req
    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            rd_req <= 0;
        end 
        else begin 
            rd_req <= state_c == `RD_REQ && busy == 1'b0;
        end 
    end

//wr_dout
    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            wr_dout <= 0;
        end 
        else begin 
            wr_dout <= wr_fifo_dout[15:0];
        end 
    end

//wr_dout_vld       //wr_dout_vld <= state_n == `SEND_DATA;
    always @(posedge clk_100m or negedge rst_n)begin 
        if(!rst_n)begin
            wr_dout_vld <= 0;
        end 
        else if(wr_req2send_data)begin 
            wr_dout_vld <= 1'b1;
        end 
        else if(send_data2c_idle)begin 
            wr_dout_vld <= 0;
        end 
    end

//vga_dout    	,

    always @(posedge clk_65m or negedge rst_n)begin 
        if(!rst_n)begin
            vga_dout <= 0;
        end 
        else begin 
            vga_dout <= rd_fifo_dout;
        end 
    end

//vga_dout_vld            
    always @(posedge clk_65m or negedge rst_n)begin 
        if(!rst_n)begin
            vga_dout_vld <= 0;
        end 
        else begin 
            vga_dout_vld <= !rd_fifo_empty && vga_rd_req;
        end 
    end


//fifo 例化

wr_fifo	u_wr_fifo (
	.aclr    (~rst_n        ),
	.data    (wr_fifo_din   ),
	.rdclk   (clk_100m      ),
	.rdreq   (wr_fifo_rdreq ),
	.wrclk   (clk_50m       ),
	.wrreq   (wr_fifo_wrreq ),
	.q       (wr_fifo_dout  ),
	.rdempty (wr_fifo_empty ),
	.rdusedw (wr_fifo_usedw ),
	.wrfull  (wr_fifo_full  )
);

    assign wr_fifo_din   = {din_sop,din_eop,din};
    assign wr_fifo_wrreq = din_vld && get_data_flag && !wr_fifo_full;
    assign wr_fifo_rdreq = !wr_fifo_empty && state_c == `SEND_DATA;


rd_fifo	u_rd_fifo (
    .aclr    (~rst_n        ),
	.data    (rd_fifo_din   ),
	.rdclk   (clk_65m       ),
	.rdreq   (rd_fifo_rdreq ),
	.wrclk   (clk_100m      ),
	.wrreq   (rd_fifo_wrreq ),
	.q       (rd_fifo_dout  ),
	.rdempty (rd_fifo_empty ),
	.wrfull  (rd_fifo_full  ),
	.wrusedw (rd_fifo_usedw )
);

    //assign rd_fifo_rdreq = rd_rdfifo_flag;
    assign rd_fifo_rdreq = !rd_fifo_empty && vga_rd_req;
    assign rd_fifo_din   = rd_din;
    assign rd_fifo_wrreq = !rd_fifo_full && rd_din_vld;

endmodule
