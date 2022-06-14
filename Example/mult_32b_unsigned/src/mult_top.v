module mult_top
(
    input clk,
    input rst_n
);

wire		sys_clk;

reg  [31:0]		a;
reg  [31:0]		b;	
reg  [31:0]		a_r/*synthesis noprune*/ ;
reg  [31:0]		b_r/*synthesis noprune*/ ;	
reg  [31:0]		a_r1/*synthesis noprune*/ ;
reg  [31:0]		b_r1/*synthesis noprune*/ ;	
reg  [31:0]		a_r2/*synthesis noprune*/ ;
reg  [31:0]		b_r2/*synthesis noprune*/ ;
reg  [31:0]		a_r3/*synthesis noprune*/ ;
reg  [31:0]		b_r3/*synthesis noprune*/ ;
reg  [31:0]		b_r4/*synthesis noprune*/ ;
reg  [31:0]		a_r4/*synthesis noprune*/ ;
reg  [31:0]		a_r5/*synthesis noprune*/ ;
reg  [31:0]		b_r5/*synthesis noprune*/ ;
reg  [31:0]		a_r6/*synthesis noprune*/ ;
reg  [31:0]		b_r6/*synthesis noprune*/ ;	
wire [63:0]		p;
reg  [63:0]		p_r/*synthesis noprune*/ ;

pll pll_0(
	.areset(~rst_n),
	.inclk0(clk),
	.c0(sys_clk),
	.locked()
);

always@(posedge sys_clk or negedge rst_n)
	if(!rst_n) begin
		a    <= 0;
		b    <= 0;
		a_r  <= 0;
		b_r  <= 0;
	end else begin
	   a <= a + 32'h55;
		b <= b + 32'ha7;
	   a_r <= a_r + 32'h55;
		b_r <= b_r + 32'ha7;
	end	

always@(posedge sys_clk or negedge rst_n)
	if(!rst_n) begin	
		a_r1 <= 0;
		b_r1 <= 0;
		a_r2 <= 0;
		b_r2 <= 0;
		a_r3 <= 0;
		b_r3 <= 0;
		a_r4 <= 0;
		b_r4 <= 0;
		a_r5 <= 0;
		b_r5 <= 0;
		a_r6 <= 0;
		b_r6 <= 0;
	end else begin
	   a_r1 <= a_r;
		b_r1 <= b_r;
	   a_r2 <= a_r1;
		b_r2 <= b_r1;
	   a_r3 <= a_r2;
		b_r3 <= b_r2;
	   a_r4 <= a_r3;
		b_r4 <= b_r3;
	   a_r5 <= a_r4;
		b_r5 <= b_r4;
	   a_r6 <= a_r5;
		b_r6 <= b_r5;	
	end
	
always@(posedge sys_clk or negedge rst_n)
	if(!rst_n) begin
		p_r <= 0;
	end else begin
		p_r <= p;
	end
	
mult_shift_add  mult_shift_add_u0(
	.clk	   (sys_clk),
	.rst_n	(rst_n),

	.a			(a),
	.b			(b),
	.p			(p)
);


endmodule