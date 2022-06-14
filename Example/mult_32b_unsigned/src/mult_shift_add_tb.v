`timescale 1 ps/ 1 ps

module mult_shift_add_tb;

	reg 				clk;
	reg 				rst_n;
	reg  [31:0]			a;
	reg  [31:0]			b;
	wire [63:0]			p;

initial
begin
    clk = 1'b0;
	rst_n = 1'b0;
    #1000 rst_n = 1'b1;
end 

always 
begin
    clk = #10 ~clk;
end

initial
begin
	a = 32'h0;
	b = 32'h0;
	#2000
	a = 32'hffffffff;
	b = 32'hffffffff;	
end 

mult_shift_add  mult_shift_add_u0(
	.clk	(clk),
	.rst_n	(rst_n),

	.a		(a),
	.b		(b),
	.p		(p)
);


endmodule
