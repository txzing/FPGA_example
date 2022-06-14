/*注释1*/
///*
module mult_shift_add
(
   input 				clk,
   input 				rst_n,
	 
	input [31:0]		a,
	input [31:0]		b,
	output reg [63:0]	p
);
parameter DATA_SIZE = 32;

//输入数据打一个时钟节拍
reg  [DATA_SIZE - 1 : 0] a_r;
reg  [DATA_SIZE - 1 : 0] b_r;

//输入数据移位
wire [2*DATA_SIZE - 1 : 0] a_shift0;
wire [2*DATA_SIZE - 1 : 0] a_shift1;
wire [2*DATA_SIZE - 1 : 0] a_shift2;
wire [2*DATA_SIZE - 1 : 0] a_shift3;
wire [2*DATA_SIZE - 1 : 0] a_shift4;
wire [2*DATA_SIZE - 1 : 0] a_shift5;
wire [2*DATA_SIZE - 1 : 0] a_shift6;
wire [2*DATA_SIZE - 1 : 0] a_shift7;
wire [2*DATA_SIZE - 1 : 0] a_shift8;
wire [2*DATA_SIZE - 1 : 0] a_shift9;
wire [2*DATA_SIZE - 1 : 0] a_shift10;
wire [2*DATA_SIZE - 1 : 0] a_shift11;
wire [2*DATA_SIZE - 1 : 0] a_shift12;
wire [2*DATA_SIZE - 1 : 0] a_shift13;
wire [2*DATA_SIZE - 1 : 0] a_shift14;
wire [2*DATA_SIZE - 1 : 0] a_shift15;
wire [2*DATA_SIZE - 1 : 0] a_shift16;
wire [2*DATA_SIZE - 1 : 0] a_shift17;
wire [2*DATA_SIZE - 1 : 0] a_shift18;
wire [2*DATA_SIZE - 1 : 0] a_shift19;
wire [2*DATA_SIZE - 1 : 0] a_shift20;
wire [2*DATA_SIZE - 1 : 0] a_shift21;
wire [2*DATA_SIZE - 1 : 0] a_shift22;
wire [2*DATA_SIZE - 1 : 0] a_shift23;
wire [2*DATA_SIZE - 1 : 0] a_shift24;
wire [2*DATA_SIZE - 1 : 0] a_shift25;
wire [2*DATA_SIZE - 1 : 0] a_shift26;
wire [2*DATA_SIZE - 1 : 0] a_shift27;
wire [2*DATA_SIZE - 1 : 0] a_shift28;
wire [2*DATA_SIZE - 1 : 0] a_shift29;
wire [2*DATA_SIZE - 1 : 0] a_shift30;
wire [2*DATA_SIZE - 1 : 0] a_shift31;


//输出数据打一个时钟节拍
wire [2*DATA_SIZE - 1 : 0] p_tmp;
reg  [2*DATA_SIZE - 1 : 0] p_median; 

//输入数据打一个时钟节拍
always@(posedge clk)
    if(!rst_n)
        begin
            a_r <= 32'd0;
            b_r <= 32'd0;
        end
    else
        begin
            a_r <= a;
            b_r <= b;
        end

//对每一个bit都需扩展
assign a_shift0  = b_r[0]  ? {32'b0,a_r      } : 0;
assign a_shift1  = b_r[1]  ? {31'b0,a_r, 1'b0} : 0;
assign a_shift2  = b_r[2]  ? {30'b0,a_r, 2'b0} : 0;
assign a_shift3  = b_r[3]  ? {29'b0,a_r, 3'b0} : 0;
assign a_shift4  = b_r[4]  ? {28'b0,a_r, 4'b0} : 0;
assign a_shift5  = b_r[5]  ? {27'b0,a_r, 5'b0} : 0;
assign a_shift6  = b_r[6]  ? {26'b0,a_r, 6'b0} : 0;
assign a_shift7  = b_r[7]  ? {25'b0,a_r, 7'b0} : 0;
assign a_shift8  = b_r[8]  ? {24'b0,a_r, 8'b0} : 0;
assign a_shift9  = b_r[9]  ? {23'b0,a_r, 9'b0} : 0;
assign a_shift10 = b_r[10] ? {22'b0,a_r,10'b0} : 0;
assign a_shift11 = b_r[11] ? {21'b0,a_r,11'b0} : 0;
assign a_shift12 = b_r[12] ? {20'b0,a_r,12'b0} : 0;
assign a_shift13 = b_r[13] ? {19'b0,a_r,13'b0} : 0;
assign a_shift14 = b_r[14] ? {18'b0,a_r,14'b0} : 0;
assign a_shift15 = b_r[15] ? {17'b0,a_r,15'b0} : 0;
assign a_shift16 = b_r[16] ? {16'b0,a_r,16'b0} : 0;
assign a_shift17 = b_r[17] ? {15'b0,a_r,17'b0} : 0;
assign a_shift18 = b_r[18] ? {14'b0,a_r,18'b0} : 0;
assign a_shift19 = b_r[19] ? {13'b0,a_r,19'b0} : 0;
assign a_shift20 = b_r[20] ? {12'b0,a_r,20'b0} : 0;
assign a_shift21 = b_r[21] ? {11'b0,a_r,21'b0} : 0;
assign a_shift22 = b_r[22] ? {10'b0,a_r,22'b0} : 0;
assign a_shift23 = b_r[23] ? { 9'b0,a_r,23'b0} : 0;
assign a_shift24 = b_r[24] ? { 8'b0,a_r,24'b0} : 0;
assign a_shift25 = b_r[25] ? { 7'b0,a_r,25'b0} : 0;
assign a_shift26 = b_r[26] ? { 6'b0,a_r,26'b0} : 0;
assign a_shift27 = b_r[27] ? { 5'b0,a_r,27'b0} : 0;
assign a_shift28 = b_r[28] ? { 4'b0,a_r,28'b0} : 0;
assign a_shift29 = b_r[29] ? { 3'b0,a_r,29'b0} : 0;
assign a_shift30 = b_r[30] ? { 2'b0,a_r,30'b0} : 0;
assign a_shift31 = b_r[31] ? { 1'b0,a_r,31'b0} : 0;

assign p_tmp = a_shift0 + a_shift1 + a_shift2 + a_shift3 + a_shift4 + a_shift5 + a_shift6 + a_shift7 +
				   a_shift8 + a_shift9 + a_shift10 + a_shift11 + a_shift12 + a_shift13 + a_shift14 + a_shift15 +
					a_shift16 + a_shift17 + a_shift18 + a_shift19 + a_shift20 + a_shift21 + a_shift22 + a_shift23 +
					a_shift24 + a_shift25 + a_shift26 + a_shift27 + a_shift28 + a_shift29 + a_shift30 + a_shift31;

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        begin
            p <= 64'd0;
        end
    else
        begin
            p <= p_tmp[63:0];
        end

endmodule
//*/
///*注释1结束*/

/*注释2*/
/*
module mult_shift_add
(
   input 				clk,
   input 				rst_n,
	 
	input [31:0]		a,
	input [31:0]		b,
	output reg [63:0]	p
);
parameter DATA_SIZE = 32;

//输入数据打一个时钟节拍
reg  [DATA_SIZE - 1 : 0] a_r;
reg  [DATA_SIZE - 1 : 0] b_r;

//输入数据移位
reg [2*DATA_SIZE - 1 : 0] a_shift[31:0];

//输出数据打一个时钟节拍
wire  [2*DATA_SIZE - 1 : 0] p_tmp;
reg  [2*DATA_SIZE - 1 : 0] p_round_1[7:0];
reg  [2*DATA_SIZE - 1 : 0] p_round_2[1:0];

//输入数据打一个时钟节拍
always@(posedge clk)
    if(!rst_n)
        begin
            a_r <= 32'd0;
            b_r <= 32'd0;
        end
    else
        begin
            a_r <= a;
            b_r <= b;
        end

//对每一个bit都需扩展
always@(posedge clk or negedge rst_n)
    if(!rst_n)
        begin
				a_shift[ 0] <= 0;
				a_shift[ 1] <= 0;
				a_shift[ 2] <= 0;
				a_shift[ 3] <= 0;
				a_shift[ 4] <= 0;
				a_shift[ 5] <= 0;
				a_shift[ 6] <= 0;
				a_shift[ 7] <= 0;
				a_shift[ 8] <= 0;
				a_shift[ 9] <= 0;
				a_shift[10] <= 0;
				a_shift[11] <= 0;
				a_shift[12] <= 0;
				a_shift[13] <= 0;
				a_shift[14] <= 0;
				a_shift[15] <= 0;
				a_shift[16] <= 0;
				a_shift[17] <= 0;
				a_shift[18] <= 0;
				a_shift[19] <= 0;
				a_shift[20] <= 0;
				a_shift[21] <= 0;
				a_shift[22] <= 0;
				a_shift[23] <= 0;
				a_shift[24] <= 0;
				a_shift[25] <= 0;
				a_shift[26] <= 0;
				a_shift[27] <= 0;
				a_shift[28] <= 0;
				a_shift[29] <= 0;
				a_shift[30] <= 0;
				a_shift[31] <= 0;		  
		  end
	 else
	     begin
				a_shift[ 0] <= b_r[0]  ? {32'b0,a_r      } : 0;
				a_shift[ 1] <= b_r[1]  ? {31'b0,a_r, 1'b0} : 0;
				a_shift[ 2] <= b_r[2]  ? {30'b0,a_r, 2'b0} : 0;
				a_shift[ 3] <= b_r[3]  ? {29'b0,a_r, 3'b0} : 0;
				a_shift[ 4] <= b_r[4]  ? {28'b0,a_r, 4'b0} : 0;
				a_shift[ 5] <= b_r[5]  ? {27'b0,a_r, 5'b0} : 0;
				a_shift[ 6] <= b_r[6]  ? {26'b0,a_r, 6'b0} : 0;
				a_shift[ 7] <= b_r[7]  ? {25'b0,a_r, 7'b0} : 0;
				a_shift[ 8] <= b_r[8]  ? {24'b0,a_r, 8'b0} : 0;
				a_shift[ 9] <= b_r[9]  ? {23'b0,a_r, 9'b0} : 0;
				a_shift[10] <= b_r[10] ? {22'b0,a_r,10'b0} : 0;
				a_shift[11] <= b_r[11] ? {21'b0,a_r,11'b0} : 0;
				a_shift[12] <= b_r[12] ? {20'b0,a_r,12'b0} : 0;
				a_shift[13] <= b_r[13] ? {19'b0,a_r,13'b0} : 0;
				a_shift[14] <= b_r[14] ? {18'b0,a_r,14'b0} : 0;
				a_shift[15] <= b_r[15] ? {17'b0,a_r,15'b0} : 0;
				a_shift[16] <= b_r[16] ? {16'b0,a_r,16'b0} : 0;
				a_shift[17] <= b_r[17] ? {15'b0,a_r,17'b0} : 0;
				a_shift[18] <= b_r[18] ? {14'b0,a_r,18'b0} : 0;
				a_shift[19] <= b_r[19] ? {13'b0,a_r,19'b0} : 0;
				a_shift[20] <= b_r[20] ? {12'b0,a_r,20'b0} : 0;
				a_shift[21] <= b_r[21] ? {11'b0,a_r,21'b0} : 0;
				a_shift[22] <= b_r[22] ? {10'b0,a_r,22'b0} : 0;
				a_shift[23] <= b_r[23] ? { 9'b0,a_r,23'b0} : 0;
				a_shift[24] <= b_r[24] ? { 8'b0,a_r,24'b0} : 0;
				a_shift[25] <= b_r[25] ? { 7'b0,a_r,25'b0} : 0;
				a_shift[26] <= b_r[26] ? { 6'b0,a_r,26'b0} : 0;
				a_shift[27] <= b_r[27] ? { 5'b0,a_r,27'b0} : 0;
				a_shift[28] <= b_r[28] ? { 4'b0,a_r,28'b0} : 0;
				a_shift[29] <= b_r[29] ? { 3'b0,a_r,29'b0} : 0;
				a_shift[30] <= b_r[30] ? { 2'b0,a_r,30'b0} : 0;
				a_shift[31] <= b_r[31] ? { 1'b0,a_r,31'b0} : 0;
		   end	

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        begin
				p_round_2[0] <= 0;
				p_round_2[1] <= 0;
		  end
	 else
		  begin
				p_round_2[0] <= a_shift[0] + a_shift[8] + a_shift[16] + a_shift[24]
								+ a_shift[1] + a_shift[9] + a_shift[17] + a_shift[25]
								+ a_shift[2] + a_shift[10] + a_shift[18] + a_shift[26]
								+ a_shift[3] + a_shift[11] + a_shift[19] + a_shift[27];
				p_round_2[1] <= a_shift[4] + a_shift[12] + a_shift[20] + a_shift[28]
								+ a_shift[5] + a_shift[13] + a_shift[21] + a_shift[29]
								+ a_shift[6] + a_shift[14] + a_shift[22] + a_shift[30]
								+ a_shift[7] + a_shift[15] + a_shift[23] + a_shift[31];
		  end

assign p_tmp = p_round_2[0] + p_round_2[1];

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        begin
            p <= 64'd0;
        end
    else
        begin
            p <= p_tmp[63:0];
        end

endmodule
*/
/*注释2结束*/

/*注释3*/
/*
module mult_shift_add
(
   input 				clk,
   input 				rst_n,
	 
	input [31:0]		a,
	input [31:0]		b,
	output reg [63:0]	p
);
parameter DATA_SIZE = 32;

//输入数据打一个时钟节拍
reg  [DATA_SIZE - 1 : 0] a_r;
reg  [DATA_SIZE - 1 : 0] b_r;

//输出数据打一个时钟节拍
wire  [2*DATA_SIZE - 1 : 0] p_tmp;
wire  [2*DATA_SIZE - 1 : 0] p_round_1[7:0];
wire  [2*DATA_SIZE - 1 : 0] p_round_2[1:0];

//输入数据移位
wire [2*DATA_SIZE - 1 : 0] a_shift0;
wire [2*DATA_SIZE - 1 : 0] a_shift1;
wire [2*DATA_SIZE - 1 : 0] a_shift2;
wire [2*DATA_SIZE - 1 : 0] a_shift3;
wire [2*DATA_SIZE - 1 : 0] a_shift4;
wire [2*DATA_SIZE - 1 : 0] a_shift5;
wire [2*DATA_SIZE - 1 : 0] a_shift6;
wire [2*DATA_SIZE - 1 : 0] a_shift7;
wire [2*DATA_SIZE - 1 : 0] a_shift8;
wire [2*DATA_SIZE - 1 : 0] a_shift9;
wire [2*DATA_SIZE - 1 : 0] a_shift10;
wire [2*DATA_SIZE - 1 : 0] a_shift11;
wire [2*DATA_SIZE - 1 : 0] a_shift12;
wire [2*DATA_SIZE - 1 : 0] a_shift13;
wire [2*DATA_SIZE - 1 : 0] a_shift14;
wire [2*DATA_SIZE - 1 : 0] a_shift15;
wire [2*DATA_SIZE - 1 : 0] a_shift16;
wire [2*DATA_SIZE - 1 : 0] a_shift17;
wire [2*DATA_SIZE - 1 : 0] a_shift18;
wire [2*DATA_SIZE - 1 : 0] a_shift19;
wire [2*DATA_SIZE - 1 : 0] a_shift20;
wire [2*DATA_SIZE - 1 : 0] a_shift21;
wire [2*DATA_SIZE - 1 : 0] a_shift22;
wire [2*DATA_SIZE - 1 : 0] a_shift23;
wire [2*DATA_SIZE - 1 : 0] a_shift24;
wire [2*DATA_SIZE - 1 : 0] a_shift25;
wire [2*DATA_SIZE - 1 : 0] a_shift26;
wire [2*DATA_SIZE - 1 : 0] a_shift27;
wire [2*DATA_SIZE - 1 : 0] a_shift28;
wire [2*DATA_SIZE - 1 : 0] a_shift29;
wire [2*DATA_SIZE - 1 : 0] a_shift30;
wire [2*DATA_SIZE - 1 : 0] a_shift31;

//输入数据打一个时钟节拍
always@(posedge clk)
    if(!rst_n)
        begin
            a_r <= 32'd0;
            b_r <= 32'd0;
        end
    else
        begin
            a_r <= a;
            b_r <= b;
        end

assign a_shift0  = b_r[0]  ? {32'b0,a_r      } : 0;
assign a_shift1  = b_r[1]  ? {31'b0,a_r, 1'b0} : 0;
assign a_shift2  = b_r[2]  ? {30'b0,a_r, 2'b0} : 0;
assign a_shift3  = b_r[3]  ? {29'b0,a_r, 3'b0} : 0;
assign a_shift4  = b_r[4]  ? {28'b0,a_r, 4'b0} : 0;
assign a_shift5  = b_r[5]  ? {27'b0,a_r, 5'b0} : 0;
assign a_shift6  = b_r[6]  ? {26'b0,a_r, 6'b0} : 0;
assign a_shift7  = b_r[7]  ? {25'b0,a_r, 7'b0} : 0;
assign a_shift8  = b_r[8]  ? {24'b0,a_r, 8'b0} : 0;
assign a_shift9  = b_r[9]  ? {23'b0,a_r, 9'b0} : 0;
assign a_shift10 = b_r[10] ? {22'b0,a_r,10'b0} : 0;
assign a_shift11 = b_r[11] ? {21'b0,a_r,11'b0} : 0;
assign a_shift12 = b_r[12] ? {20'b0,a_r,12'b0} : 0;
assign a_shift13 = b_r[13] ? {19'b0,a_r,13'b0} : 0;
assign a_shift14 = b_r[14] ? {18'b0,a_r,14'b0} : 0;
assign a_shift15 = b_r[15] ? {17'b0,a_r,15'b0} : 0;
assign a_shift16 = b_r[16] ? {16'b0,a_r,16'b0} : 0;
assign a_shift17 = b_r[17] ? {15'b0,a_r,17'b0} : 0;
assign a_shift18 = b_r[18] ? {14'b0,a_r,18'b0} : 0;
assign a_shift19 = b_r[19] ? {13'b0,a_r,19'b0} : 0;
assign a_shift20 = b_r[20] ? {12'b0,a_r,20'b0} : 0;
assign a_shift21 = b_r[21] ? {11'b0,a_r,21'b0} : 0;
assign a_shift22 = b_r[22] ? {10'b0,a_r,22'b0} : 0;
assign a_shift23 = b_r[23] ? { 9'b0,a_r,23'b0} : 0;
assign a_shift24 = b_r[24] ? { 8'b0,a_r,24'b0} : 0;
assign a_shift25 = b_r[25] ? { 7'b0,a_r,25'b0} : 0;
assign a_shift26 = b_r[26] ? { 6'b0,a_r,26'b0} : 0;
assign a_shift27 = b_r[27] ? { 5'b0,a_r,27'b0} : 0;
assign a_shift28 = b_r[28] ? { 4'b0,a_r,28'b0} : 0;
assign a_shift29 = b_r[29] ? { 3'b0,a_r,29'b0} : 0;
assign a_shift30 = b_r[30] ? { 2'b0,a_r,30'b0} : 0;
assign a_shift31 = b_r[31] ? { 1'b0,a_r,31'b0} : 0;


assign p_round_1[0] = a_shift0 + a_shift8  + a_shift16 + a_shift24;
assign p_round_1[1] = a_shift1 + a_shift9  + a_shift17 + a_shift25;
assign p_round_1[2] = a_shift2 + a_shift10 + a_shift18 + a_shift26;
assign p_round_1[3] = a_shift3 + a_shift11 + a_shift19 + a_shift27;
assign p_round_1[4] = a_shift4 + a_shift12 + a_shift20 + a_shift28;
assign p_round_1[5] = a_shift5 + a_shift13 + a_shift21 + a_shift29;
assign p_round_1[6] = a_shift6 + a_shift14 + a_shift22 + a_shift30;
assign p_round_1[7] = a_shift7 + a_shift15 + a_shift23 + a_shift31;

assign p_round_2[0] = p_round_1[0] + p_round_1[1] + p_round_1[2] + p_round_1[3];
assign p_round_2[1] = p_round_1[4] + p_round_1[5] + p_round_1[6] + p_round_1[7];

assign p_tmp = p_round_2[0] + p_round_2[1];

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        begin
            p <= 64'd0;
        end
    else
        begin
            p <= p_tmp[63:0];
        end

endmodule
*/
/*注释3结束*/

/*注释4*/
/*
module mult_shift_add
(
   input 				clk,
   input 				rst_n,
	 
	input [31:0]		a,
	input [31:0]		b,
	output reg [63:0]	p
);
parameter DATA_SIZE = 32;

//输入数据打一个时钟节拍
reg  [DATA_SIZE - 1 : 0] a_r;
reg  [DATA_SIZE - 1 : 0] b_r;

//输入数据移位
reg [2*DATA_SIZE - 1 : 0] a_shift[31:0];

//输出数据打一个时钟节拍
wire  [2*DATA_SIZE - 1 : 0] p_tmp;
reg  [2*DATA_SIZE - 1 : 0] p_round_1[7:0];
reg  [2*DATA_SIZE - 1 : 0] p_round_2[1:0];

//输入数据打一个时钟节拍
always@(posedge clk)
    if(!rst_n)
        begin
            a_r <= 32'd0;
            b_r <= 32'd0;
        end
    else
        begin
            a_r <= a;
            b_r <= b;
        end

//对每一个bit都需扩展
always@(posedge clk or negedge rst_n)
    if(!rst_n)
        begin
				a_shift[ 0] <= 0;
				a_shift[ 1] <= 0;
				a_shift[ 2] <= 0;
				a_shift[ 3] <= 0;
				a_shift[ 4] <= 0;
				a_shift[ 5] <= 0;
				a_shift[ 6] <= 0;
				a_shift[ 7] <= 0;
				a_shift[ 8] <= 0;
				a_shift[ 9] <= 0;
				a_shift[10] <= 0;
				a_shift[11] <= 0;
				a_shift[12] <= 0;
				a_shift[13] <= 0;
				a_shift[14] <= 0;
				a_shift[15] <= 0;
				a_shift[16] <= 0;
				a_shift[17] <= 0;
				a_shift[18] <= 0;
				a_shift[19] <= 0;
				a_shift[20] <= 0;
				a_shift[21] <= 0;
				a_shift[22] <= 0;
				a_shift[23] <= 0;
				a_shift[24] <= 0;
				a_shift[25] <= 0;
				a_shift[26] <= 0;
				a_shift[27] <= 0;
				a_shift[28] <= 0;
				a_shift[29] <= 0;
				a_shift[30] <= 0;
				a_shift[31] <= 0;
		  end
	 else
	     begin
				a_shift[ 0] <= b_r[0]  ? {32'b0,a_r      } : 0;
				a_shift[ 1] <= b_r[1]  ? {31'b0,a_r, 1'b0} : 0;
				a_shift[ 2] <= b_r[2]  ? {30'b0,a_r, 2'b0} : 0;
				a_shift[ 3] <= b_r[3]  ? {29'b0,a_r, 3'b0} : 0;
				a_shift[ 4] <= b_r[4]  ? {28'b0,a_r, 4'b0} : 0;
				a_shift[ 5] <= b_r[5]  ? {27'b0,a_r, 5'b0} : 0;
				a_shift[ 6] <= b_r[6]  ? {26'b0,a_r, 6'b0} : 0;
				a_shift[ 7] <= b_r[7]  ? {25'b0,a_r, 7'b0} : 0;
				a_shift[ 8] <= b_r[8]  ? {24'b0,a_r, 8'b0} : 0;
				a_shift[ 9] <= b_r[9]  ? {23'b0,a_r, 9'b0} : 0;
				a_shift[10] <= b_r[10] ? {22'b0,a_r,10'b0} : 0;
				a_shift[11] <= b_r[11] ? {21'b0,a_r,11'b0} : 0;
				a_shift[12] <= b_r[12] ? {20'b0,a_r,12'b0} : 0;
				a_shift[13] <= b_r[13] ? {19'b0,a_r,13'b0} : 0;
				a_shift[14] <= b_r[14] ? {18'b0,a_r,14'b0} : 0;
				a_shift[15] <= b_r[15] ? {17'b0,a_r,15'b0} : 0;
				a_shift[16] <= b_r[16] ? {16'b0,a_r,16'b0} : 0;
				a_shift[17] <= b_r[17] ? {15'b0,a_r,17'b0} : 0;
				a_shift[18] <= b_r[18] ? {14'b0,a_r,18'b0} : 0;
				a_shift[19] <= b_r[19] ? {13'b0,a_r,19'b0} : 0;
				a_shift[20] <= b_r[20] ? {12'b0,a_r,20'b0} : 0;
				a_shift[21] <= b_r[21] ? {11'b0,a_r,21'b0} : 0;
				a_shift[22] <= b_r[22] ? {10'b0,a_r,22'b0} : 0;
				a_shift[23] <= b_r[23] ? { 9'b0,a_r,23'b0} : 0;
				a_shift[24] <= b_r[24] ? { 8'b0,a_r,24'b0} : 0;
				a_shift[25] <= b_r[25] ? { 7'b0,a_r,25'b0} : 0;
				a_shift[26] <= b_r[26] ? { 6'b0,a_r,26'b0} : 0;
				a_shift[27] <= b_r[27] ? { 5'b0,a_r,27'b0} : 0;
				a_shift[28] <= b_r[28] ? { 4'b0,a_r,28'b0} : 0;
				a_shift[29] <= b_r[29] ? { 3'b0,a_r,29'b0} : 0;
				a_shift[30] <= b_r[30] ? { 2'b0,a_r,30'b0} : 0;
				a_shift[31] <= b_r[31] ? { 1'b0,a_r,31'b0} : 0;
		   end

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        begin
			   p_round_1[0] <= 0;
				p_round_1[1] <= 0;
				p_round_1[2] <= 0;
				p_round_1[3] <= 0;
				p_round_1[4] <= 0;
				p_round_1[5] <= 0;
				p_round_1[6] <= 0;
				p_round_1[7] <= 0;
		  end
	 else
		  begin
				p_round_1[0] <= a_shift[0] + a_shift[8] + a_shift[16] + a_shift[24];
				p_round_1[1] <= a_shift[1] + a_shift[9] + a_shift[17] + a_shift[25];
				p_round_1[2] <= a_shift[2] + a_shift[10] + a_shift[18] + a_shift[26];
				p_round_1[3] <= a_shift[3] + a_shift[11] + a_shift[19] + a_shift[27];
				p_round_1[4] <= a_shift[4] + a_shift[12] + a_shift[20] + a_shift[28];
				p_round_1[5] <= a_shift[5] + a_shift[13] + a_shift[21] + a_shift[29];
				p_round_1[6] <= a_shift[6] + a_shift[14] + a_shift[22] + a_shift[30];
				p_round_1[7] <= a_shift[7] + a_shift[15] + a_shift[23] + a_shift[31];
		  end

always@(posedge clk or negedge rst_n)
    if(!rst_n)
        begin
				p_round_2[0] <= 0;
				p_round_2[1] <= 0;
		  end
	 else
		  begin
				p_round_2[0] <= p_round_1[0] + p_round_1[1] + p_round_1[2] + p_round_1[3];
				p_round_2[1] <= p_round_1[4] + p_round_1[5] + p_round_1[6] + p_round_1[7];
		  end

assign p_tmp = p_round_2[0] + p_round_2[1];


always@(posedge clk or negedge rst_n)
    if(!rst_n)
        begin
            p <= 64'd0;
        end
    else
        begin
            p <= p_tmp[63:0];
        end

endmodule
*/
/*注释4结束*/