`include "param.v"

module vga_interface( 
    input				clk		,
    input				rst_n	,

    //ctrl interface
    input		[15:0]	din		,
    input		        din_vld ,
    output  wire        req     ,

    //vga
    output  reg [15:0]	dout 	,
    output	reg	        h_sync	,
    output	reg	        v_sync	
);								 
     
    //中间信号定义		 
    reg		[11:0]	hsync_cnt      ;//行同步计数器
    wire            add_hsync_cnt  ;
    wire            end_hsync_cnt  ;
    reg		[10:0]	vsync_cnt      ;//场同步计数器
    wire	        add_vsync_cnt  ;
    wire	        end_vsync_cnt  ;

    reg	            h_sync_r0      ;
    reg	            v_sync_r0      ;
    reg	            h_sync_r1      ;
    reg	            v_sync_r1      ;
    wire            h_vld          ;
    wire            v_vld          ;

//计数器
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            hsync_cnt <= 0;
        end 
        else if(add_hsync_cnt)begin 
            if(end_hsync_cnt)begin 
                hsync_cnt <= 0;
            end
            else begin 
                hsync_cnt <= hsync_cnt + 1;
            end 
        end
    end 
    assign add_hsync_cnt = 1'b1;
    assign end_hsync_cnt = add_hsync_cnt && hsync_cnt == `H_TOTAL-1;
                                            
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            vsync_cnt <= 0;
        end 
        else if(add_vsync_cnt)begin 
            if(end_vsync_cnt)begin 
                vsync_cnt <= 0;
            end
            else begin 
                vsync_cnt <= vsync_cnt + 1;
            end 
        end
    end 
    assign add_vsync_cnt = end_hsync_cnt;
    assign end_vsync_cnt = add_vsync_cnt && vsync_cnt == `V_TOTAL-1;    

    assign h_vld = (hsync_cnt >= `H_SYNC + `H_BP) && (hsync_cnt < `H_TOTAL-`H_FP); 
    assign v_vld = (vsync_cnt >= `V_SYNC + `V_BP) && (vsync_cnt < `V_TOTAL-`V_FP);   

//req
    assign req = h_vld&v_vld;

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout <= 0;
        end 
        else begin 
            dout <= din;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            h_sync_r0 <= 1'b0;
        end 
        else if(hsync_cnt == `H_SYNC-1)begin 
            h_sync_r0 <= 1'b1;
        end 
        else if(end_hsync_cnt)begin 
            h_sync_r0 <= 1'b0;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            v_sync_r0 <= 1'b0;
        end 
        else if(vsync_cnt == `V_SYNC-1 && end_hsync_cnt)begin 
            v_sync_r0 <= 1'b1;
        end 
        else if(end_vsync_cnt)begin 
            v_sync_r0 <= 1'b0;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            h_sync_r1 <= 1'b0;
            h_sync    <= 1'b0;
        end 
        else begin 
            h_sync_r1 <= h_sync_r0;
            h_sync    <= h_sync_r1;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            v_sync_r1 <= 1'b0;
            v_sync    <= 1'b0;
        end 
        else begin 
            v_sync_r1 <= v_sync_r0;
            v_sync    <= v_sync_r1;
        end 
    end

endmodule

