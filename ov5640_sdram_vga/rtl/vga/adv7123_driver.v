`include"../param.v"
module adv7123_driver (
    input               clk         ,
    input               rst_n       ,
    
    input       [15:0]  din         ,
    input               din_vld     ,
    output              req         ,

    //output to ADV7123
    output      [7:0]   vga_r       ,//r g b 数据输出给 da芯片
    output      [7:0]   vga_g       ,
    output      [7:0]   vga_b       ,
    output              vga_blank   ,
    output              vga_sync    ,
    output              vga_clk     ,
    //output to vga 
    output              vsync       ,
    output              hsync           
);			
	             
    //中间信号定义		 
    reg		[12:0]	    cnt_h       ;//行同步计数器
    wire                add_cnt_h   ;
    wire                end_cnt_h   ;
    reg     [9:0]       cnt_v       ;//场同步计数器
    wire                add_cnt_v   ;
    wire                end_cnt_v   ;

    reg         	    h_vld       ;//行有效
    reg                 v_vld       ;//场有效
    reg                 vga_req     ;//读FIFO读数据请求
    wire                empty       ;
    wire                full        ;
    wire    [15:0]      q_out       ;
    wire    [3:0]       usedw       ;
    wire                rdreq       ;

//计数器

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            cnt_h <= 0;
        end 
        else if(add_cnt_h)begin 
            if(end_cnt_h)begin 
                cnt_h <= 0;
            end
            else begin 
                cnt_h <= cnt_h + 1;
            end 
        end
    end 
    assign add_cnt_h = 1'b1;
    assign end_cnt_h = add_cnt_h && cnt_h == `H_TOTAL-1;
                                            
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            cnt_v <= 0;
        end 
        else if(add_cnt_v)begin 
            if(end_cnt_v)begin 
                cnt_v <= 0;
            end
            else begin 
                cnt_v <= cnt_v + 1;
            end 
        end
    end 
    assign add_cnt_v = end_cnt_h;
    assign end_cnt_v = add_cnt_v && cnt_v == `V_TOTAL-1;

//行有效
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            h_vld <= 0;
        end 
        else if(cnt_h == `H_SYNC + `H_BP - 1)begin 
            h_vld <= 1'b1;
        end 
        else if(cnt_h == `H_TOTAL - `H_FP - 1)begin 
            h_vld <= 1'b0;
        end 
    end
//场有效
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            v_vld <= 0;
        end 
        else if(cnt_v == `V_SYNC + `V_BP - 1)begin 
            v_vld <= 1;
        end 
        else if(cnt_v == `V_TOTAL - `V_FP - 1)begin 
            v_vld <= 0;
        end 
    end

    //vga_req   
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            vga_req <= 0;
        end 
        else if(usedw <= 4)begin 
            vga_req <= 1'b1;
        end 
        else if(usedw >= 12)begin 
            vga_req <= 1'b0;
        end 
    end

//缓存例化
    vga_fifo	vga_fifo_inst (
	.aclr   (~rst_n     ),
	.clock  (clk        ),
	.data   (din        ),
	.rdreq  (rdreq      ),
	.wrreq  (din_vld    ),
	.empty  (empty      ),
	.full   (full       ),
	.q      (q_out      ),
	.usedw  (usedw      )
	);

    assign rdreq = h_vld & v_vld & ~empty;

//输出

    assign req       = vga_req;
/*
    assign vga_r     = (h_vld & v_vld)?{q_out[15:11],3'd0}:8'd0;    //r 5
    assign vga_g     = (h_vld & v_vld)?{q_out[10:5],2'd0}:8'd0;     //g 5
    assign vga_b     = (h_vld & v_vld)?{q_out[4:0],3'd0}:8'd0;      //b 5 
*/
/*
16bit RGB565  R4 R3 R2 R1 R0 G5 G4 G3 G2 G1 G0 B4 B3 B2 B1 B0
转为
24ibt RGB888  R4 R3 R2 R1 R0 R2 R1 R0 G5 G4 G3 G2 G1 G0 G1 G0 B4 B3 B2 B1 B0 B2 B1 B0
*/

    assign vga_r     = (h_vld & v_vld)?{q_out[15:11],q_out[13:11]}:8'd0;    //r 8
    assign vga_g     = (h_vld & v_vld)?{q_out[10: 6],q_out[ 7: 6]}:8'd0;    //g 8
    assign vga_b     = (h_vld & v_vld)?{q_out[ 4: 0],q_out[ 2: 0]}:8'd0;    //b 8 

    assign vga_blank = h_vld && v_vld;  //有效显示区域 拉高，无效显示区域拉低
    assign vga_sync  = 1'b0;        //无效 

    assign vga_clk   = ~clk;
    assign hsync     = (cnt_h >= `H_SYNC)?1'b1:1'b0;
    assign vsync     = (cnt_v >= `V_SYNC)?1'b1:1'b0;

endmodule
