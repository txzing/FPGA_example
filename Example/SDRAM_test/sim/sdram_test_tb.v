`timescale 1ns/1ps

module sdram_test_tb;

    parameter CLK_FREQ = 100000000;
    parameter UART_RATE = 1000000;
	parameter PARITY_ODD_EVEN = 1;        //0:odd, 1:even
	
reg				clk;
reg				clk_50M;
reg				rst_n;

wire				uart_rxd;
wire				uart_txd;
	 
wire[12:0]		sdram_addr;
wire[1:0]		sdram_ba;
wire			sdram_cas_n;
wire			sdram_cke;
wire			sdram_cs_n;
wire	[15:0]	sdram_dq;
wire[1:0]		sdram_dqm;
wire			sdram_ras_n;
wire			sdram_we_n;
wire 			sdram_clk;

reg [7:0] 		data_i;
reg 			start_i;
wire			ready_o;

initial 		
	clk = 1'b0;		
	
always #5 clk = ~clk;  

initial 		
	clk_50M = 1'b0;		
	
always #10 clk_50M = ~clk_50M;  

initial  begin						       		
   rst_n = 1'b0;
	#300
	rst_n = 1'b1;
end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			start_i <= 0;
			data_i <= 8'h51;
		end else begin
			if(ready_o) begin
				start_i <= 1'b1;
				data_i <= data_i + 3;
			end else begin
				start_i <= 1'b0;
			end
		end
	end

 sdram_test sdram_test_u0
(
    .clk(clk_50M),
    .rst_n(rst_n),
	
	.uart_rxd(uart_rxd),
	.uart_txd(uart_txd),
	 
	.sdram_addr(sdram_addr),
	.sdram_ba(sdram_ba),
	.sdram_cas_n(sdram_cas_n),
	.sdram_cke(sdram_cke),
	.sdram_cs_n(sdram_cs_n),
	.sdram_dq(sdram_dq),
	.sdram_dqm(sdram_dqm),
	.sdram_ras_n(sdram_ras_n),
	.sdram_we_n(sdram_we_n),
	.sdram_clk(sdram_clk)
);

uart_tx  
#(
  .CLK_FREQ			( CLK_FREQ			),
  .UART_RATE		( UART_RATE			),
  .PARITY_ODD_EVEN 	( PARITY_ODD_EVEN	)        //0:odd, 1:even
)
	uart_tx_u0(
    .clk		(clk), 
    .rst_n		(rst_n),
    .data_i		(data_i),
    .start_i	(start_i),
    .uart_txd	(uart_rxd),
    .ready_o	(ready_o)
	);

endmodule
