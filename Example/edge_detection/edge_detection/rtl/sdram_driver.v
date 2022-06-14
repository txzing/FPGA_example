`include "param.v"

module sdram_driver( 
    input				clk		        ,//100MHz
    input				rst_n	        ,
    //控制模块接口信号      
    input				wr_req	        ,//写请求
    input               rd_req          ,//读请求
    input		[15:0]  wr_din          ,//数据
    input               wr_din_vld      ,//数据有效标志信号
    input		[23:0]	rw_addr	        ,//[23:22]：bank地址 [21:9]：行地址  [8:0]：列地址
    output	reg	     	busy	        ,//忙标志信号
    output	wire    	ack  	        ,//应答信号
    output  reg [15:0]  rd_dout         ,//读取的数据
    output  reg         rd_dout_vld     ,//数据有效标志信号
    //sdram芯片接口信号
    output  wire        sdram_clk       ,
    output  wire        sdram_cke       ,
    output  wire        sdram_cs_n      ,
    output  wire        sdram_ras_n     ,
    output  wire        sdram_cas_n     ,
    output  wire        sdram_we_n      ,
    output  reg [1:0]   sdram_bank      ,
    output  reg [12:0]  sdram_addr      ,
    output  reg [15:0]  sdram_dq_out    ,
    output  reg         sdram_dq_out_en ,
    input       [15:0]  sdram_dq_in     ,
    output  reg [1:0]   sdram_dqm       ,
    output  reg         initial_done        
);								 
       
    //中间信号定义		 
    reg		[7:0]	state_c             ;//状态机
    reg		[7:0]	state_n             ;

    reg     [14:0]  cnt0                ;//延时计数器
    wire	    	add_cnt0            ;
    wire	    	end_cnt0            ;
    reg     [14:0]  x                   ;

    reg     [9:0]   cnt_ref             ;//刷新定时计数器
    wire            add_cnt_ref         ;   
    wire            end_cnt_ref         ;     

    reg     [3:0]   command             ;//命令控制
    reg             refresh_flag        ;//刷新标志信号

    reg             wr_falg             ;//写标志信号  
    reg             rd_falg             ;//读标志信号
    reg             rd_dout_vld_ff0     ;
    reg             rd_dout_vld_ff1     ;

    wire            wait2precharge      ;//状态机转移条件
    wire            precharge2refresh   ;
    wire            precharge2idle      ;
    wire            refresh2modeset     ;
    wire            refresh2idle        ;
    wire            modeset2idle        ;
    wire            idle2refresh        ;
    wire            idle2active         ;
    wire            active2read         ;
    wire            active2write        ;
    wire            read2precharge      ;
    wire            write2precharge     ;

//状态机
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            state_c <= `WAIT;
        end 
        else begin 
            state_c <= state_n;
        end 
    end

    always @(*)begin 
        case(state_c)
            `WAIT:begin 
                if(wait2precharge)
                    state_n = `PRECHARGE;
                else 
                    state_n = state_c;
            end 
            `PRECHARGE:begin 
                if(precharge2refresh)
                    state_n = `REFRESH;
                else if(precharge2idle)
                    state_n = `IDLE;
                else 
                    state_n = state_c;
            end 
            `REFRESH:begin 
                if(refresh2modeset)
                    state_n = `MODESET;
                else if(refresh2idle)
                    state_n = `IDLE;
                else 
                    state_n = state_c;
            end 
            `MODESET:begin 
                if(modeset2idle)
                    state_n = `IDLE;
                else 
                    state_n = state_c;
            end 
            `IDLE:begin 
                if(idle2refresh)
                    state_n = `REFRESH;
                else if(idle2active)
                    state_n = `ACTIVE;
                else 
                    state_n = state_c;
            end 
            `ACTIVE:begin 
                if(active2read)
                    state_n = `READ;
                else if(active2write)
                    state_n = `WRITE;
                else 
                    state_n = state_c;
            end 
            `READ:begin 
                if(read2precharge)
                    state_n = `PRECHARGE;
                else 
                    state_n = state_c;
            end 
            `WRITE:begin 
                if(write2precharge)
                    state_n = `PRECHARGE;
                else    
                    state_n = state_c;
            end 
            default:state_n = `WAIT;
        endcase 
    end

    assign wait2precharge    = state_c == `WAIT      && (end_cnt0);
    assign precharge2refresh = state_c == `PRECHARGE && (end_cnt0 && !initial_done);
    assign precharge2idle    = state_c == `PRECHARGE && (end_cnt0 && initial_done);
    assign refresh2modeset   = state_c == `REFRESH   && (end_cnt0 && !initial_done);
    assign refresh2idle      = state_c == `REFRESH   && (end_cnt0 && initial_done);
    assign modeset2idle      = state_c == `MODESET   && (end_cnt0);
    assign idle2refresh      = state_c == `IDLE      && (refresh_flag);
    assign idle2active       = state_c == `IDLE      && (wr_req || rd_req);
    assign active2read       = state_c == `ACTIVE    && (rd_falg && end_cnt0);
    assign active2write      = state_c == `ACTIVE    && (wr_falg && end_cnt0);
    assign read2precharge    = state_c == `READ      && (end_cnt0);
    assign write2precharge   = state_c == `WRITE     && (end_cnt0);

//cnt0  延时计数器
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
    assign add_cnt0 = state_c != `IDLE;
    assign end_cnt0 = add_cnt0 && cnt0 == x-1;

    always @(*)begin 
        if(state_c == `WAIT)begin
            x = `TIME_200US;
        end 
        else if(state_c == `PRECHARGE)begin 
            x = `TIME_RP;
        end 
        else if(state_c == `REFRESH)begin 
            x= `TIME_RRC;
        end 
        else if(state_c == `MODESET)begin 
            x = `TIME_MRD;
        end 
        else if(state_c == `ACTIVE)begin 
            x = `TIME_RCD;
        end 
        else if(state_c == `READ)begin 
            x = `TIME_RD;//是否少了CL延时
        end 
        else if(state_c == `WRITE)begin 
            x = `TIME_WR;
        end 
        else begin 
            x = 1;
        end 
    end

//cnt_ref   定时刷新计数器
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
    assign add_cnt_ref = initial_done;
    assign end_cnt_ref = add_cnt_ref && cnt_ref == `TIME_REF-1;

//initial_done
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            initial_done <= 1'b0;
        end 
        else if(modeset2idle)begin 
            initial_done <= 1'b1;
        end 
    end

//refresh_flag
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            refresh_flag <= 1'b0;
        end 
        else if(refresh_flag == 1'b0 && end_cnt_ref)begin 
            refresh_flag <= 1'b1;
        end 
        else if(refresh_flag && idle2refresh)begin 
            refresh_flag <= 1'b0;
        end 
    end

//rd_falg       读标志信号
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rd_falg <= 1'b0;
        end 
        else if(rd_falg == 1'b0 && rd_req)begin 
            rd_falg <= 1'b1;
        end 
        else if(rd_falg && read2precharge)begin 
            rd_falg <= 1'b0;
        end 
    end

//wr_falg   写标志信号
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            wr_falg <= 1'b0;
        end 
        else if(wr_falg == 1'b0 && wr_req)begin 
            wr_falg <= 1'b1;
        end 
        else if(wr_falg && write2precharge)begin 
            wr_falg <= 1'b0;
        end 
    end

//busy
    always @(*)begin 
        if(idle2refresh || idle2active || state_c != `IDLE)begin
            busy = 1'b1;
        end 
        else begin 
            busy = 1'b0;
        end 
    end

//ack   应答控制模块的写请求 与 读请求

    assign ack = active2write || active2read;

//rd_dout
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rd_dout <= 0;
        end 
        else begin 
            rd_dout <= sdram_dq_in;
        end 
    end

//rd_dout_vld
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rd_dout_vld_ff0 <= 1'b0;
        end 
        else if(state_c == `READ)begin 
            rd_dout_vld_ff0 <= 1'b1;
        end 
        else begin 
            rd_dout_vld_ff0 <= 1'b0;
        end 
    end
//打三拍,同步读取数据时的CAS延时,CAS延时在模式寄存器中设置为3
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rd_dout_vld_ff1 <= 1'b0;
            rd_dout_vld     <= 1'b0;
        end 
        else begin 
            rd_dout_vld_ff1 <= rd_dout_vld_ff0;
            rd_dout_vld     <= rd_dout_vld_ff1;
        end 
    end

//command
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            command <= 0;
        end 
        else if(wait2precharge || read2precharge || write2precharge)begin 
            command <= `CMD_PR;
        end 
        else if(precharge2refresh || idle2refresh)begin 
            command <= `CMD_REF;
        end 
        else if(refresh2modeset)begin 
            command <= `CMD_MRS;
        end 
        else if(idle2active)begin 
            command <= `CMD_ACT;
        end
        else if(active2read)begin 
            command <= `CMD_RD;
        end
        else if(active2write)begin 
            command <= `CMD_WR;
        end 
        else begin 
            command <= `CMD_NOP;
        end 
    end

//sdram_bank
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            sdram_bank <= 0;
        end 
        else begin 
            sdram_bank <= rw_addr[23:22];
        end 
    end

//sdram_addr
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            sdram_addr <= 0;
        end 
        else if(idle2active)begin 
            sdram_addr <= rw_addr[21:9];
        end 
        else if(active2read || active2write)begin 
            sdram_addr <= rw_addr[8:0];
        end 
        else if(read2precharge || write2precharge || wait2precharge)begin 
            sdram_addr <= {2'd0,1'b1,10'd0};//1'b1<<10;
        end 
        else if(refresh2modeset)begin 
            sdram_addr <= {3'b000,`OP_CODE,2'b00,`CASL,`BT,`BL};
        end 
        else if(precharge2idle)begin 
            sdram_addr <= 0;
        end 
    end

//sdram_dq_out
   always @(posedge clk or negedge rst_n)begin 
       if(!rst_n)begin
            sdram_dq_out <= 0;
       end 
       else begin 
            sdram_dq_out <= wr_din;
       end 
   end
  
//sdram_dq_out_en
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            sdram_dq_out_en <= 0;
        end 
        else if(active2write)begin 
            sdram_dq_out_en <= 1'b1;
        end 
        else if(state_c == `WRITE && cnt0 == `SDRAM_BL-1)begin 
            sdram_dq_out_en <= 1'b0;
        end 
    end
     
//sdram_dqm
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            sdram_dqm <= 0;
        end 
        else if(state_c == `WRITE && cnt0 >= `TIME_WR-3)begin 
            sdram_dqm <= 2'b11;
        end 
        else begin 
            sdram_dqm <= 0;
        end 
    end       

    assign sdram_clk = clk;
    assign sdram_cke = 1'b1;
    assign {sdram_cs_n,sdram_ras_n,sdram_cas_n,sdram_we_n} = command;

endmodule
