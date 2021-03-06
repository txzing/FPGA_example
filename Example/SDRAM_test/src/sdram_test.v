module sdram_test
(
	input 	clk,
	input 	rst_n,
	 
	//UART 两线
	input	uart_rxd,
	output	uart_txd,

	//sdram物理接口 
	output[12:0]	sdram_addr,
	output[1:0]		sdram_ba,
	output			sdram_cas_n,
	output			sdram_cke,
	output			sdram_cs_n,
	inout	[15:0]	sdram_dq,
	output[1:0]		sdram_dqm,
	output			sdram_ras_n,
	output			sdram_we_n,
	output 			sdram_clk
);

//工作时钟
parameter 	CLK_FREQ 			= 100000000;
//波特率
parameter 	UART_RATE 			= 115200;//6000000
//0:odd, 1:even
parameter 	PARITY_ODD_EVEN 	= 1'b1; //偶校验        

wire			sys_clk;

//总线
wire[23:0]	avalon_sdram_address;
wire[1:0]	avalon_sdram_byteenable_n;
wire			avalon_sdram_chipselect;
wire[15:0]	avalon_sdram_writedata;
wire			avalon_sdram_read_n;
wire			avalon_sdram_write_n;
wire[15:0]	avalon_sdram_readdata;
wire			avalon_sdram_readdatavalid;
wire			avalon_sdram_waitrequest;

pll pll_0(
	.areset(~rst_n),
	.inclk0(clk),
	.c0(sys_clk),
	.locked()
);

assign sdram_clk = sys_clk;

process #(
   .CLK_FREQ 			(CLK_FREQ),
   .UART_RATE 			(UART_RATE),
	.PARITY_ODD_EVEN 	(PARITY_ODD_EVEN)        //0:odd, 1:even
)
	process_u0(
	.clk									(sys_clk),
	.rst_n								(rst_n),
	.uart_txd							(uart_txd),
	.uart_rxd							(uart_rxd),

	.avalon_sdram_address			(avalon_sdram_address),
	.avalon_sdram_byteenable_n		(avalon_sdram_byteenable_n),
	.avalon_sdram_chipselect		(avalon_sdram_chipselect),
	.avalon_sdram_writedata			(avalon_sdram_writedata),
	.avalon_sdram_read_n				(avalon_sdram_read_n),
	.avalon_sdram_write_n			(avalon_sdram_write_n),
	.avalon_sdram_readdata			(avalon_sdram_readdata),
	.avalon_sdram_readdatavalid	(avalon_sdram_readdatavalid),
	.avalon_sdram_waitrequest		(avalon_sdram_waitrequest)
	);

		
sdram sdram_u0(
	.clk_clk							(sys_clk),
	.reset_reset_n					(rst_n),
	.avalon_sdram_address		(avalon_sdram_address),
	.avalon_sdram_byteenable_n	(avalon_sdram_byteenable_n),
	.avalon_sdram_chipselect	(avalon_sdram_chipselect),
	.avalon_sdram_writedata		(avalon_sdram_writedata),
	.avalon_sdram_read_n			(avalon_sdram_read_n),
	.avalon_sdram_write_n		(avalon_sdram_write_n),
	.avalon_sdram_readdata		(avalon_sdram_readdata),
	.avalon_sdram_readdatavalid(avalon_sdram_readdatavalid),
	.avalon_sdram_waitrequest	(avalon_sdram_waitrequest),
	.sdram_addr						(sdram_addr),
	.sdram_ba						(sdram_ba),
	.sdram_cas_n					(sdram_cas_n),
	.sdram_cke						(sdram_cke),
	.sdram_cs_n						(sdram_cs_n),
	.sdram_dq						(sdram_dq),
	.sdram_dqm						(sdram_dqm),
	.sdram_ras_n					(sdram_ras_n),
	.sdram_we_n						(sdram_we_n),
	.sdram_rst_reset_n			(rst_n)
	);


endmodule
