`include"../param.v"

module sdram_ctrl(       //实现sdram读写控制
    input                   clk         ,
    input                   clk_in      ,
    input                   clk_out     ,

    input                   rst_n       ,
    input                   rd_en       ,
    input       [15:0]      din         ,
    input                   din_vld     ,
    input                   din_sop     ,
    input                   din_eop     ,
    output      [15:0]      dout        ,    
    output                  dout_vld    , 

    //sdram_intf接口
    output                  wr_req      ,
    output      [15:0]      wr_data     ,
    output                  rd_req      ,
    output      [24:0]      rw_addr     ,
    input       [15:0]      rd_data     ,
    input                   rd_data_vld ,
    input                   ack         
    );

//参数定义

    localparam  IDLE    = 4'b0001,
                BURST_W = 4'b0010,//发起突发写请求
                BURST_R = 4'b0100,//发起突发读
                DONE    = 4'b1000;

//信号定义
    reg     [3:0]       state_c     ;
    reg     [3:0]       state_n     ;

    reg                 rd_flag     ;//读请求标志
    reg                 wr_flag     ;//写请求标志
    reg                 flag_sel    ;//标记上一次操作
    reg                 prior_flag  ;//优先级标志 0：写优先级高 1：读优先级高 

    reg                 ack_r       ;
    wire                ack_nedge   ;
    reg     [15:0]      tx_data     ;//
    reg                 tx_data_vld ;

    reg     [12:0]      wr_addr     ;//写地址计数器
    wire                add_wr_addr ;
    wire                end_wr_addr ;
    reg     [12:0]      rd_addr     ;//读地址计数器
    wire                add_rd_addr ;
    wire                end_rd_addr ;
    reg     [24:0]      addr        ;//读、写地址

    reg                 get_data_flag   ;
    reg     [1:0]       wr_bank         ;//写bank地址
    reg     [1:0]       rd_bank         ;//读bank地址
    reg                 change_bank     ;//切换bank标志
    reg     [1:0]       change_bank_f   ;
    reg     [2:0]       cnt_change      ;
    wire                add_cnt_change  ;
    wire                end_cnt_change  ;
    reg                 wr_frame_end    ;//一帧数据写完
    reg                 wr_frame_end_f  ;
    reg                 rdfifo_flag     ;//rdfifo可读标志

    wire                wrfifo_eop   ;
    wire    [15:0]      wrfifo_data  ;      //wr_fifo    
    wire                wrfifo_rd    ;      
    wire                wrfifo_wr    ;  
    wire    [15:0]      wrfifo_qout  ;  
    wire                wrfoifo_empty;  
    wire    [11:0]      wrfifo_usedw ;  
    wire                wrfifo_full  ;  

    wire    [15:0]      rdfifo_data  ;
    wire                rdfifo_rd    ;
    wire                rdfifo_wr    ;
    wire    [15:0]      rdfifo_qout  ;
    wire                rdfifo_empty ;
    wire                rdfifo_full  ;
    wire 	[11:0]      rdfifo_used  ;

    wire                idle2write   ;
    wire                idle2read    ;
    wire                write2done   ;
    wire                read2done    ;

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
        case (state_c)
            IDLE   :begin 
                if(idle2write)
                    state_n = BURST_W;
                else if(idle2read)
                    state_n = BURST_R;
                else 
                    state_n = state_c;
            end 
            BURST_W:begin 
                if(write2done)
                    state_n = DONE;
                else 
                    state_n = state_c;
            end 
            BURST_R:begin 
                if(read2done)
                    state_n = DONE;
                else 
                    state_n = state_c;
            end 
            DONE   :begin state_n = IDLE;end 
            default: state_n = IDLE;
        endcase
    end

    assign idle2write = state_c == IDLE    && (~prior_flag & wr_flag);
    assign idle2read  = state_c == IDLE    && (prior_flag & rd_flag);
    assign write2done = state_c == BURST_W && (ack_nedge);
    assign read2done  = state_c == BURST_R && (ack_nedge);

//ack_r
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            ack_r <= 0;
        end 
        else begin 
            ack_r <= ack;
        end 
    end

    assign ack_nedge = ~ack & ack_r;

/************************读写优先级仲裁*****************************/
//rd_flag     ;//读请求标志
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rd_flag <= 0;
        end 
        else if(rdfifo_used < `RD_TH_L)begin 
            rd_flag <= 1'b1;
        end 
        else if(rdfifo_used > `RD_TH_U)begin 
            rd_flag <= 1'b0;
        end 
    end

//wr_flag     ;//写请求标志
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            wr_flag <= 0;
        end 
        else if(wrfifo_usedw >= `WR_TH)begin 
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
        else if(state_c == DONE)begin 
            flag_sel <= prior_flag;
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

/********************** 产生读、写SDRAM的地址 **********************/
//地址计数器        对读写次数计数，因为突发长度是2的整数次幂，所以给地址时，只需要对次数移位即可
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            wr_addr <= 0;
        end 
        else if(add_wr_addr)begin 
            if(end_wr_addr)begin 
                wr_addr <= 0;
            end
            else begin 
                wr_addr <= wr_addr + 1;
            end 
        end
    end 
    assign add_wr_addr = write2done;
    assign end_wr_addr = add_wr_addr && wr_addr == (`BURST_MAX>>10)-1;  //一帧数据写900行

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rd_addr <= 0;
        end 
        else if(add_rd_addr)begin 
            if(end_rd_addr)begin 
                rd_addr <= 0;
            end
            else begin 
                rd_addr <= rd_addr + 1;
            end 
        end
    end 
    assign add_rd_addr = read2done;
    assign end_rd_addr = add_rd_addr && rd_addr == (`BURST_MAX>>10)-1;
            
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            addr <= 0;
        end 
        else if(idle2write)begin 
            addr <= {wr_bank,wr_addr,10'd0}; //发起写请求时，给写bank、写地址
        end 
        else if(idle2read)begin 
            addr <= {rd_bank,rd_addr,10'd0}; //发起读请求时，给读bank、读地址
        end 
    end

/******************************************************************/   

/******************** 切换读、写SDRAM的bank地址 ********************/
//wr_bank  rd_bank      //切换bank
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            wr_bank <= 2'b00;
            rd_bank <= 2'b11;
        end 
        else if(wr_frame_end_f & end_rd_addr)begin //写完、读完时，切换bank
            wr_bank <= ~wr_bank;
            rd_bank <= ~rd_bank;
        end 
    end

//change_bank  在sdram时钟域下
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            change_bank <= 0;
        end 
        else if(wr_frame_end_f & end_rd_addr)begin    //一帧数据写完，并且一帧数据读完
            change_bank <= 1'b1;
        end 
        else if(end_cnt_change)begin 
            change_bank <= 1'b0;
        end 
    end

//wr_frame_end_f
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            wr_frame_end_f <= 0;
        end 
        else begin 
            wr_frame_end_f <= wr_frame_end;
        end 
    end

//cnt_change 延时
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            cnt_change <= 0;
        end 
        else if(add_cnt_change)begin 
            if(end_cnt_change)begin 
                cnt_change <= 0;
            end
            else begin 
                cnt_change <= cnt_change + 1;
            end 
        end
    end 
    assign add_cnt_change = change_bank;
    assign end_cnt_change = add_cnt_change && cnt_change == 5-1;

//wr_frame_end      一帧数据写完  应该在数据输入时钟域clk_in下判断 
    always @(posedge clk_in or negedge rst_n)begin 
        if(!rst_n)begin
            wr_frame_end <= 0;
        end 
        else if(get_data_flag & din_eop)begin    //eop，表示一帧数据写完
            wr_frame_end <= 1;
        end 
        else if(~change_bank_f[1] & change_bank_f[0])begin  //change_bank出现上升沿时切换bank，拉低wr_frame_end 使能新的一帧数据写入wrfifo
            wr_frame_end <= 0;
        end 
    end

//change_bank_f 将change_bank从clk时钟域下同步到clk_in时钟域
    always @(posedge clk_in or negedge rst_n)begin 
        if(!rst_n)begin
            change_bank_f <= 0;
        end 
        else begin 
            change_bank_f <= {change_bank_f[0],change_bank};
        end 
    end

//get_data_flag     控制向wrfifo写数据 允许丢弃数据
    always @(posedge clk_in or negedge rst_n)begin 
        if(!rst_n)begin
            get_data_flag <= 0;
        end 
        else if(~wr_frame_end & ~get_data_flag & din_sop)begin 
            get_data_flag <= 1'b1;
        end 
        else if(get_data_flag & din_eop)begin 
            get_data_flag <= 1'b0;
        end 
    end

/******************************************************************/ 

//rdfifo_flag       从rdfifo读数据给 vga接口显示
    always @(posedge clk_out or negedge rst_n)begin 
        if(!rst_n)begin
            rdfifo_flag <= 0;
        end 
        else if(~rdfifo_empty & ~rdfifo_flag)begin 
            rdfifo_flag <= 1'b1;
        end 
        else if(rdfifo_empty)begin 
            rdfifo_flag <= 1'b0;
        end 
    end

    always @(posedge clk_out or negedge rst_n)begin 
        if(!rst_n)begin
            tx_data     <= 0;
            tx_data_vld <= 0;
        end 
        else begin 
            tx_data     <= rdfifo_qout;
            tx_data_vld <= rdfifo_rd;
        end 
    end


//fifo例化
    wrfifo	wrfifo_inst (
	.aclr       (~rst_n         ),
	.data       (wrfifo_data    ),
	.rdclk      (clk            ),
	.rdreq      (wrfifo_rd      ),
	.wrclk      (clk_in         ),
	.wrreq      (wrfifo_wr      ),
	.q          (wrfifo_qout    ),
	.rdempty    (wrfoifo_empty  ),
	.rdusedw    (wrfifo_usedw   ),
	.wrfull     (wrfifo_full    )
	);

    assign wrfifo_data = din;
    assign wrfifo_wr = din_vld & ~wrfifo_full & (~wr_frame_end_f && din_sop || get_data_flag); 
    assign wrfifo_rd = ack & state_c == BURST_W & ~wrfoifo_empty;
   

    rdfifo	rdfifo_inst (
    .aclr       (~rst_n         ),
	.data       (rdfifo_data    ),
	.rdclk      (clk_out        ),
	.rdreq      (rdfifo_rd      ),
	.wrclk      (clk            ),
	.wrreq      (rdfifo_wr      ),
	.q          (rdfifo_qout    ),
	.rdempty    (rdfifo_empty   ),
	.wrfull     (rdfifo_full    ),
    .wrusedw    (rdfifo_used    )
	);

    assign rdfifo_data = rd_data;                 
    assign rdfifo_wr = rd_data_vld & ~rdfifo_full;
    assign rdfifo_rd = rd_en & rdfifo_flag;


//输出

    assign wr_req = state_c == BURST_W;
    assign rd_req = state_c == BURST_R;
    assign rw_addr = addr;
    assign wr_data = wrfifo_qout[15:0];
    assign dout     = tx_data;    
    assign dout_vld = tx_data_vld; 



endmodule 

