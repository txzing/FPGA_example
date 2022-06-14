`timescale 1ns/1ps

module uart_top_tb;

    parameter CLK_FREQ = 100000000;
    parameter UART_RATE = 1000000;
	parameter PARITY_ODD_EVEN = 1;        //0:odd, 1:even

reg				clk;
reg				rst_n;
reg [7:0] 		data_i;
reg 			start_i;
wire			ready_o;
wire [7:0]		data_o;
wire 			data_vild_o;
wire 			parity_error_o;
wire			uart_txd;
wire			uart_rxd;

initial 		
	clk = 1'b0;		
	
always #10 clk = ~clk;  

initial  begin						       		
   rst_n = 1'b0;
	#300
	rst_n = 1'b1;
end

initial  begin
	data_i <= 0;
	start_i <= 0;
	#500
	data_i <= 8'h35;
	start_i <= 1'b1;
	#15
	start_i <= 1'b0;	
end

	uart_tx  
#(
  .CLK_FREQ				( CLK_FREQ			),
  .UART_RATE			( UART_RATE			),
  .PARITY_ODD_EVEN 	( PARITY_ODD_EVEN	)        //0:odd, 1:even
)
	uart_tx_u0(
    .clk		(clk), 
	.rst_n		(rst_n),
    .data_i		(data_i),
    .start_i	(start_i),
    .uart_txd	(uart_txd),
    .ready_o	(ready_o)
	);

	uart_rx 
#(
  .CLK_FREQ				( CLK_FREQ			),
  .UART_RATE			( UART_RATE			),
  .PARITY_ODD_EVEN 	( PARITY_ODD_EVEN	)        //0:odd, 1:even
)
	uart_rx_u0(
    .clk			(clk), 
    .rst_n			(rst_n), 
    .uart_rxd		(uart_txd),	 
    .data_o			(data_o), 
    .data_vild_o	(data_vild_o), 
    .parity_error_o	(parity_error_o)
);


endmodule
