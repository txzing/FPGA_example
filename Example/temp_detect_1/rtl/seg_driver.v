module seg_driver (
input           	clk     ,
input           	rst_n   ,
input           	din_sign,
input   [31:0]  	din     ,
input           	din_vld ,
input      [7:0]  seg_point,//数码管小数点
output reg [7:0]  seg_sel,//数码管位选，8个数码管
output reg [7:0]  seg_dig //数码管段选
);
    
parameter TIME_SCAN = 5_000;//扫描间隔 1ms

localparam  NONE= 7'b111_1111,
			ZER = 7'b100_0000,
            ONE = 7'b111_1001,
            TWO = 7'b010_0100,
            THR = 7'b011_0000,
            FOU = 7'b001_1001,
            FIV = 7'b001_0010,
            SIX = 7'b000_0010,
            SEV = 7'b111_1000,
            EIG = 7'b000_0000,
            NIN = 7'b001_0000,
				 P   = 7'b000_1100,//+
            N   = 7'b001_1011;//-
                

reg     [12:0]  cnt_scan    ;//数码管扫描计数器
wire            add_cnt_scan;
wire            end_cnt_scan;

reg     [3:0]   disp_num    ;
reg             dot         ;


//1ms计数器
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        cnt_scan <= 0;
    end 
    else if(add_cnt_scan)begin 
            if(end_cnt_scan)begin 
                cnt_scan <= 0;
            end
            else begin 
                cnt_scan <= cnt_scan + 1;
            end 
    end
end 
assign add_cnt_scan = 1'b1;
assign end_cnt_scan = add_cnt_scan && cnt_scan == TIME_SCAN-1;

//位选切换
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        seg_sel <= 8'b11111110;
    end 
    else if(end_cnt_scan)begin 
        seg_sel <= {seg_sel[6:0],seg_sel[7]};
    end 
end

//disp_num
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        disp_num <= 0;
    end 
    else begin 
        case (seg_sel)
            8'b11111110:begin disp_num <= din[7:4]  ;dot = 1'b1;end 
            8'b11111101:begin disp_num <= din[11:8] ;dot = 1'b1;end 
            8'b11111011:begin disp_num <= din[15:12];dot = 1'b1;end 
            8'b11110111:begin disp_num <= din[19:16];dot = 1'b0;end 
            8'b11101111:begin disp_num <= din[23:20];dot = 1'b1;end 
            8'b11011111:begin disp_num <= din_sign?4'hA:4'hB;dot = 1'b1;end
            default  	:begin disp_num <= 4'hF;end 
        endcase
    end 
end

    //seg_dig
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        seg_dig <= 8'hff;
    end 
    else begin 
        case (disp_num)
            4'h0:seg_dig <= {dot,ZER};
            4'h1:seg_dig <= {dot,ONE};
            4'h2:seg_dig <= {dot,TWO};
            4'h3:seg_dig <= {dot,THR};
            4'h4:seg_dig <= {dot,FOU};
            4'h5:seg_dig <= {dot,FIV};
            4'h6:seg_dig <= {dot,SIX};
            4'h7:seg_dig <= {dot,SEV};
            4'h8:seg_dig <= {dot,EIG};
            4'h9:seg_dig <= {dot,NIN}; 
            4'hA:seg_dig <= {dot,N};
            4'hB:seg_dig <= {dot,P};
            default:seg_dig <= 8'hff;
        endcase
    end 
end

endmodule

