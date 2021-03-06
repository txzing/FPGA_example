`include "../param.v"

module sdram_intf(      //实现sdram接口时序
    input               clk             ,
    input               rst_n           ,

    //sdram_ctrl接口
    input                wr_req         ,
    input       [15:0]   wr_data        ,
    input                rd_req         ,
    input       [24:0]   rw_addr        ,
    output      [15:0]   rd_data        ,
    output               rd_data_vld    ,
    output               ack            ,
    //sdram存储器接口
    output               mem_cke        ,
    output               mem_csn        ,
    output               mem_rasn       ,
    output               mem_casn       ,
    output               mem_wen        ,
    output  [1:0]        mem_bank       ,
    output  [12:0]       mem_addr       ,
    input   [15:0]       mem_dq_in      ,
    output  [15:0]       mem_dq_out     ,
    output               mem_dq_oe      ,
    output  [1:0]        mem_dqm        
    ); 

//参数定义
    localparam  WAIT  = 8'b0000_0001,//上电等待200us
                PRECH = 8'b0000_0010,
                AREF  = 8'b0000_0100,
                MRS   = 8'b0000_1000,
                IDLE  = 8'b0001_0000,
                ACTI  = 8'b0010_0000,
                WRITE = 8'b0100_0000,
                READ  = 8'b1000_0000;
            

//信号定义

    reg     [7:0]       state_c     ;
    reg     [7:0]       state_n     ;
    reg     [12:0]      cnt_ref     ;//刷新计数器
    wire                add_cnt_ref ;
    wire                end_cnt_ref ;
    reg     [14:0]      cnt0        ;//状态计数器
    wire                add_cnt0    ;
    wire                end_cnt0    ;
    reg     [14:0]      XX          ;
    reg     [2:0]       cnt1        ;
    wire                add_cnt1    ;
    wire                end_cnt1    ;
    reg                 intf_ack    ;
    reg                 init_flag   ;//初始化标志
    reg                 ref_req     ;//刷新请求
    reg     [3:0]       command     ;//命令寄存器
    reg     [12:0]      addr        ;//行地址、bank地址 + 列地址
	reg		[1:0]		bank		;////bank地址
    reg                 dq_out_en   ;
    reg     [1:0]       dq_mask     ;
    reg     [15:0]      rd_din      ;
    reg                 rd_din_vld0 ;
    reg                 rd_din_vld1 ;
    reg                 rd_din_vld2 ;   
    reg                 mem_rdy     ;

    wire                wait2prech  ;
    wire                prech2aref  ;
    wire                prech2idle  ;
    wire                aref2mrs    ;
    wire                aref2idle   ;
    wire                mrs2idle    ;
    wire                idle2aref   ;
    wire                idle2acti   ;
    wire                acti2write  ;
    wire                acti2read   ;
    wire                write2prech ;
    wire                read2prech  ;

//状态机
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            state_c <= WAIT;
        end 
        else begin 
            state_c <= state_n;
        end 
    end

    always @(*)begin 
        case (state_c)
            WAIT :begin 
                if(wait2prech)
                    state_n = PRECH;
                else 
                    state_n = state_c;
            end 
            PRECH:begin 
                if(prech2aref)
                    state_n = AREF;
                else if(prech2idle)
                    state_n = IDLE;
                else 
                    state_n = state_c;
            end 
            AREF :begin 
                if(aref2mrs)
                    state_n = MRS;
                else if(aref2idle)
                    state_n = IDLE;
                else 
                    state_n = state_c;
            end 
            MRS  :begin 
                if(mrs2idle)
                    state_n = IDLE;
                else 
                    state_n = state_c;
            end 
            IDLE :begin 
                if(idle2aref)
                    state_n = AREF;
                else if(idle2acti)
                    state_n = ACTI;
                else 
                    state_n = state_c;
            end 
            ACTI :begin 
                if(acti2write)
                    state_n = WRITE;
                else if(acti2read)
                    state_n = READ;
                else 
                    state_n = state_c;
            end 
            WRITE:begin 
                if(write2prech)
                    state_n = PRECH;
                else 
                    state_n = state_c;
            end 
            READ :begin 
                if(read2prech)
                    state_n = PRECH;
                else 
                    state_n = state_c;
            end 
            default: state_n = IDLE;
        endcase
    end

    assign wait2prech  = state_c == WAIT  && (end_cnt0);     
    assign prech2aref  = state_c == PRECH && (end_cnt0 & init_flag);     
    assign prech2idle  = state_c == PRECH && (end_cnt0 & init_flag == 1'b0);     
    assign aref2mrs    = state_c == AREF  && (end_cnt1 & init_flag); 
    assign aref2idle   = state_c == AREF  && (end_cnt0 & init_flag == 1'b0);     
    assign mrs2idle    = state_c == MRS   && (end_cnt0); 
    assign idle2aref   = state_c == IDLE  && (ref_req | end_cnt_ref);     
    assign idle2acti   = state_c == IDLE  && (wr_req | rd_req);     
    assign acti2write  = state_c == ACTI  && (end_cnt0 & wr_req);     
    assign acti2read   = state_c == ACTI  && (end_cnt0 & rd_req);     
    assign write2prech = state_c == WRITE && (end_cnt0);     
    assign read2prech  = state_c == READ  && (end_cnt0);     
//计数器

    //cnt_ref
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            cnt_ref <= 0;
        end 
        else if(add_cnt_ref)begin 
            if(end_cnt_ref)begin 
                cnt_ref <= 0;
            end
            else begin 
                cnt_ref <= cnt_ref + 1;
            end 
        end
    end 
    assign add_cnt_ref = init_flag == 1'b0;
    assign end_cnt_ref = add_cnt_ref && cnt_ref == `TREF-1;

    //cnt0 
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            cnt0 <= 0;
        end 
        else if(add_cnt0)begin 
            if(end_cnt0)begin 
                cnt0 <= 0;
            end
            else begin 
                cnt0 <= cnt0 + 1;
            end 
        end
    end 
    assign add_cnt0 = state_c != IDLE;
    assign end_cnt0 = add_cnt0 && cnt0 == XX-1;

    always @(*)begin 
        if(state_c == WAIT)
            XX = `TWAIT;
        else if(state_c == PRECH)begin
            XX = `TRP;
        end 
        else if(state_c == AREF)begin 
            XX = `TRRC;
        end 
        else if(state_c == MRS) begin 
            XX = `TMRS;
        end 
        else if(state_c == ACTI) begin 
            XX = `TRCD;
        end 
        else if(state_c == WRITE) begin 
            XX = `BURST_LEN+2;
        end 
        else if(state_c == READ) begin 
            XX = `BURST_LEN;
        end
        else begin 
            XX = 0;
        end 
    end

//cnt1                   初始化过程中自动刷新次数计数器               
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            cnt1 <= 0;
        end 
        else if(add_cnt1)begin 
            if(end_cnt1)begin 
                cnt1 <= 0;
            end
            else begin 
                cnt1 <= cnt1 + 1;
            end 
        end
    end 
    assign add_cnt1 = init_flag & state_c == AREF & end_cnt0;
    assign end_cnt1 = add_cnt1 && cnt1 == 8-1;

//init_flag
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            init_flag <= 1'b1;
        end 
        else if(mrs2idle)begin 
            init_flag <= 1'b0;
        end 
    end

//ref_req
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            ref_req <= 0;
        end 
        else if(ref_req == 1'b0 &  end_cnt_ref)begin //刷新时间到 拉高
            ref_req <= 1'b1;
        end 
        else if(ref_req & idle2aref)begin       //开始刷新拉低
            ref_req <= 1'b0;
        end 
    end

//command 
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            command <= 0;
        end 
        else if(wait2prech | write2prech | read2prech)begin     //预充电
            command <= `CMD_PRECH;
        end 
        else if(prech2aref | idle2aref)begin        //自动刷新
            command <= `CMD_AREF;
        end 
        else if(aref2mrs)begin      //模式寄存器设计
            command <= `CMD_MRS;
        end 
        else if(idle2acti)begin     //激活命令
            command <= `CMD_ACTI;
        end 
        else if(acti2write)begin    //写命令
            command <= `CMD_WRITE;
        end 
        else if(acti2read)begin         //读命令
            command <= `CMD_READ;
        end 
        else begin 
            command <= `CMD_NOP;
        end 
    end

//addr bank
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            addr <= 0;
			bank <= 0;
        end 
        else if(aref2mrs)begin 
            addr <= {3'b000,`WB_MODE,`OP_MODE,`CASL,`BT,`BL};
			bank <= 0;
        end 
        else if(idle2acti)begin 
            addr <= rw_addr[22:10];//行地址
			bank <= rw_addr[24:23];	 //bank地址
        end 
        else if(acti2write | acti2read)begin 
            addr <= {3'd0,rw_addr[9:0]};//列地址
			bank <= rw_addr[24:23];	 //bank地址
        end 
        else if(wait2prech | write2prech | read2prech)begin 
            addr <= 1'b1 << 10;     //全BANK预充电
				//bank <= bank;	 //bank地址
        end 
    end
 
//dq_out_en

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dq_out_en <= 0;
        end 
        else if(acti2write)begin 
            dq_out_en <= 1'b1;
        end 
        else if(state_c == WRITE && cnt0 >= `BURST_LEN-1)begin 
            dq_out_en <= 1'b0;
        end 
    end

//dq_mask
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dq_mask <= 0;
        end 
        else if(state_c == WRITE && cnt0 == `BURST_LEN-1)begin 
            dq_mask <= 2'b11;
        end 
        else if(write2prech)begin 
            dq_mask <= 2'b00;
        end 
    end

//    rd_din   rd_din_vld0 rd_din_vld1
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rd_din <= 0;
        end 
        else begin 
            rd_din <= mem_dq_in;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rd_din_vld0 <= 0;
            rd_din_vld1 <= 0;
            rd_din_vld2 <= 0;
        end 
        else begin 
            rd_din_vld0 <= state_c == READ;
            rd_din_vld1 <= rd_din_vld0;
            rd_din_vld2 <= rd_din_vld1;
        end 
    end

//intf_ack
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            intf_ack <= 0;
        end 
        else if(acti2read | acti2write)begin 
            intf_ack <= 1'b1;
        end 
        else if((state_c == WRITE && cnt0 == `BURST_LEN-1) | read2prech)begin 
            intf_ack <= 1'b0;
        end 
    end

//输出

    //mem_cke        
    assign mem_cke = 1'b1;

    //mem_csn mem_rasn mem_casn mem_wen
    assign {mem_csn,mem_rasn,mem_casn,mem_wen} = command;

    //mem_bank
    assign mem_bank = bank;

    //mem_addr
    assign mem_addr = addr;

    //mem_dq_out mem_dq_oe
    assign mem_dq_out = wr_data;
    assign mem_dq_oe  = dq_out_en;

    //mem_dqm
    assign mem_dqm = dq_mask;   

    //rd_data        ,
    assign rd_data = rd_din;

    //rd_data_vld    ,
    assign rd_data_vld = rd_din_vld2;

    // ack            ,
    assign ack = intf_ack;

endmodule    
