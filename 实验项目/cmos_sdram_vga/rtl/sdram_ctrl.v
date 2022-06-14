`include"param.v"
module sdram_ctrl (
    input               clk             ,//100M 控制器主时钟
    input               clk_in          ,//数据输入时钟
    input               clk_out         ,//数据输出时钟
    input               rst_n           ,
    //数据输入
    input   [15:0]      din             ,//摄像头输入像素数据
    input               din_sop         ,//第一个像素
    input               din_eop         ,//第二个像素    
    input               din_vld         ,//指示输入的像素数据有效
    //数据输出
    input               rdreq           ,//vga的读数据请求
    output  [15:0]      dout            ,//输出给vga的数据
    output              dout_vld        ,//输出给vga的数据有效标志
    //sdram_interface
    output              avm_write       ,//输出给sdram 接口 IP 的写请求
    output              avm_read        ,//输出给sdram 接口 IP 的读请求
    output  [23:0]      avm_addr        ,//输出给sdram 接口 IP 的读写地址
    output  [15:0]      avm_wrdata      ,//输出给sdram 接口 IP 的写数据
    input   [15:0]      avs_rddata      ,//sdram 接口 IP 输入的读数据
    input               avs_rddata_vld  ,
    input               avs_waitrequest    
    
);

/**
    1、读、写 请求仲裁---用于产生读写请求
    2、sdram乒乓缓存控制  双buf缓存
    实现功能：写缓冲不会溢出，读缓冲区不会空，保证输入数据正常写入sdram，
              保证vga能够正常显示图像。
**/

//参数定义
    localparam  IDLE  = 4'b0001,
                WRITE = 4'b0010,
                READ  = 4'b0100,
                DONE  = 4'b1000;

//信号定义

    reg     [3:0]       state_c     ;
    reg     [3:0]       state_n     ;

    reg     [8:0]       cnt         ;//突发读写计数器
    wire                add_cnt     ;
    wire                end_cnt     ;
    
    reg     [1:0]       wr_bank     ;//写bank
    reg     [1:0]       rd_bank     ;//读bank
    reg     [21:0]      wr_addr     ;//写地址   行地址 + 列地址
    wire                add_wr_addr ;
    wire                end_wr_addr ;
    reg     [21:0]      rd_addr     ;//读地址   行地址 + 列地址
    wire                add_rd_addr ;
    wire                end_rd_addr ;

    reg                 change_bank ;//切换bank 
    reg                 wr_finish   ;//一帧数据写完
    
    reg                 wr_data_flag;//wrfifo写数据的标志

    reg                 wr_flag     ;//突发写标志
    reg                 rd_flag     ;//突发读标志
    reg                 flag_sel    ;//突发标志 指示前次操作是 写或是读 0：写 1：读
    reg                 prior_flag  ;//读写优先级标志 0：写优先级高 1：读优先级高

    wire                idle2write  ;  
    wire                idle2read   ;
    wire                write2done  ;
    wire                read2done   ;

    reg     [15:0]      rd_data     ;//rfifo读数据输出
    reg                 rd_data_vld ;

    wire    [17:0]      wfifo_data  ; 
    wire                wfifo_rdreq ;
    wire                wfifo_wrreq ;
    wire    [17:0]      wfifo_q     ;
    wire                wfifo_empty ;
    wire    [10:0]      wfifo_usedw ;
    wire                wfifo_full  ;

    wire    [15:0]      rfifo_data  ;
    wire                rfifo_rdreq ;
    wire                rfifo_wrreq ;
    wire    [15:0]      rfifo_q     ;
    wire                rfifo_empty ;
    wire                rfifo_full  ;
    wire    [10:0]      rfifo_usedw ;

//状态机
    always  @(posedge clk or negedge rst_n)begin
        if(~rst_n)begin
            state_c <= IDLE;
        end
        else begin
            state_c <= state_n;
        end
    end

    always  @(*)begin
        case(state_c)
            IDLE  :begin 
                if(idle2write)
                    state_n = WRITE;
                else if(idle2read)
                    state_n = READ;
                else 
                    state_n = state_c;
            end 
            WRITE :begin 
                if(write2done)
                    state_n = DONE;
                else 
                    state_n = state_c;
            end     
            READ  :begin 
                if(read2done)
                    state_n = DONE;
                else 
                    state_n = state_c;
            end 
            DONE  :state_n = IDLE;
            default:state_n = IDLE;
        endcase  
    end

    assign idle2write = state_c == IDLE  && (~prior_flag && wfifo_usedw >= `USER_BL);
    assign idle2read  = state_c == IDLE  && prior_flag && rfifo_usedw <= `RD_UT;
    assign write2done = state_c == WRITE && end_cnt;
    assign read2done  = state_c == READ  && end_cnt;

//计数器
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt <= 0;
        end
        else if(add_cnt)begin
            if(end_cnt)
                cnt <= 0;
            else
                cnt <= cnt + 1;
        end
    end

    assign add_cnt = (state_c == WRITE | state_c == READ) & ~avs_waitrequest; 
    assign end_cnt = add_cnt && cnt== `USER_BL-1;//计数突发传输的数据  

/************************读写优先级仲裁*****************************/
//rd_flag     ;//读请求标志
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rd_flag <= 0;
        end 
        else if(rfifo_usedw <= `RD_LT)begin   
            rd_flag <= 1'b1;
        end 
        else if(rfifo_usedw > `RD_UT)begin 
            rd_flag <= 1'b0;
        end 
    end

//wr_flag     ;//写请求标志
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            wr_flag <= 0;
        end 
        else if(wfifo_usedw >= `USER_BL)begin//wfifo的数据够一次突发写 ，表示可以进行一次突发写 
            wr_flag <= 1'b1;
        end 
        else begin 
            wr_flag <= 1'b0;
        end 
    end

//flag_sel    ;//标记上一次操作
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            flag_sel <= 0;
        end 
        else if(read2done)begin 
            flag_sel <= 1;//读
        end 
        else if(write2done)begin 
            flag_sel <= 0;//写
        end 
    end

//prior_flag  ;//优先级标志 0：写优先级高   1：读优先级高     仲裁读、写的优先级
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            prior_flag <= 0;
        end      
        else if(wr_flag && (flag_sel || (~flag_sel && ~rd_flag)))begin   //突发写优先级高
            prior_flag <= 1'b0;
        end 
        else if(rd_flag && (~flag_sel || (flag_sel && ~wr_flag)))begin   //突发读优先级高
            prior_flag <= 1'b1;
        end 
    end

/******************************************************************/    

/********************      地址设计    ****************************/    

//wr_bank  rd_bank
    always  @(posedge clk or negedge rst_n)begin
        if(~rst_n)begin
            wr_bank <= 2'b00;
            rd_bank <= 2'b11;
        end
        else if(change_bank)begin
            wr_bank <= ~wr_bank;
            rd_bank <= ~rd_bank;
        end
    end

// wr_addr   rd_addr
    always @(posedge clk or negedge rst_n) begin 
        if (rst_n==0) begin
            wr_addr <= 0; 
        end
        else if(add_wr_addr) begin
            if(end_wr_addr)
                wr_addr <= 0; 
            else
                wr_addr <= wr_addr+1 ;
       end
    end
    assign add_wr_addr = (state_c == WRITE) && ~avs_waitrequest;
    assign end_wr_addr = add_wr_addr  && wr_addr == `BURST_MAX-1 ;
    
    always @(posedge clk or negedge rst_n) begin 
        if (rst_n==0) begin
            rd_addr <= 0; 
        end
        else if(add_rd_addr) begin
            if(end_rd_addr)
                rd_addr <= 0; 
            else
                rd_addr <= rd_addr+1 ;
       end
    end
    assign add_rd_addr = (state_c == READ) && ~avs_waitrequest;
    assign end_rd_addr = add_rd_addr  && rd_addr == `BURST_MAX-1;

//wr_finish
    always  @(posedge clk or negedge rst_n)begin
        if(~rst_n)begin
            wr_finish <= 1'b0;
        end
        else if(~wr_finish & wfifo_q[17])begin  //在一个bank中一幅图像写完
            wr_finish <= 1'b1;
        end
        else if(wr_finish && end_rd_addr)begin
            wr_finish <= 1'b0;
        end
    end

//change_bank ;//切换bank 
    always  @(posedge clk or negedge rst_n)begin
        if(~rst_n)begin
            change_bank <= 1'b0;
        end
        else begin
            change_bank <= wr_finish && end_rd_addr;//在另一个bank中一幅图像读完
        end
    end

/****************************************************************/

/*********************** wrfifo 写数据   ************************/
//控制像素数据帧 写入 或 丢帧

    always  @(posedge clk_in or negedge rst_n)begin
        if(~rst_n)begin
            wr_data_flag <= 1'b0;
        end 
        else if(~wr_data_flag & ~wr_finish & din_sop)begin//可以向wrfifo写数据
            wr_data_flag <= 1'b1;
        end
        else if(wr_data_flag & din_eop)begin      //不可以向wrfifo写入数据
            wr_data_flag <= 1'b0;
        end
    end

/****************************************************************/

    always  @(posedge clk_out or negedge rst_n)begin
        if(~rst_n)begin
            rd_data <= 0;
            rd_data_vld <= 1'b0;
        end
        else begin
            rd_data <= rfifo_q;
            rd_data_vld <= rfifo_rdreq;
        end
    end

wrfifo	wrfifo_inst (
	.aclr   (~rst_n     ),
	.data   (wfifo_data ),
	.rdclk  (clk        ),
	.rdreq  (wfifo_rdreq),
	.wrclk  (clk_in     ),
	.wrreq  (wfifo_wrreq),
	.q      (wfifo_q    ),
	.rdempty(wfifo_empty),
	.rdusedw(wfifo_usedw),
	.wrfull (wfifo_full )
	);

    assign wfifo_data = {din_eop,din_sop,din};
    assign wfifo_wrreq = ~wfifo_full & din_vld & ((~wr_finish & din_sop) ||wr_data_flag);
    assign wfifo_rdreq = state_c == WRITE && ~avs_waitrequest;

rdfifo u_rdfifo(
	.aclr       (~rst_n     ),
	.data       (rfifo_data ),
	.rdclk      (clk_out    ),
	.rdreq      (rfifo_rdreq),
	.wrclk      (clk        ),
	.wrreq      (rfifo_wrreq),
	.q          (rfifo_q    ), 
	.rdempty    (rfifo_empty),
	.wrfull     (rfifo_full ),
	.wrusedw    (rfifo_usedw)
);

    assign rfifo_data = avs_rddata;
    assign rfifo_wrreq = ~rfifo_full & avs_rddata_vld;
    assign rfifo_rdreq = ~rfifo_empty & rdreq;

//输出
    assign dout       = rd_data;
    assign dout_vld   = rd_data_vld;
    assign avm_wrdata = wfifo_q[15:0];
    assign avm_write = ~(state_c == WRITE && ~avs_waitrequest);
    assign avm_read = ~(state_c == READ && ~avs_waitrequest);
    assign avm_addr = (state_c == WRITE)?{wr_bank,wr_addr}:((state_c == READ)?{rd_bank,rd_addr}:0);

endmodule 


