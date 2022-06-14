
module sdram (
	avalon_sdram_address,
	avalon_sdram_byteenable_n,
	avalon_sdram_chipselect,
	avalon_sdram_writedata,
	avalon_sdram_read_n,
	avalon_sdram_write_n,
	avalon_sdram_readdata,
	avalon_sdram_readdatavalid,
	avalon_sdram_waitrequest,
	clk_clk,
	reset_reset_n,
	sdram_addr,
	sdram_ba,
	sdram_cas_n,
	sdram_cke,
	sdram_cs_n,
	sdram_dq,
	sdram_dqm,
	sdram_ras_n,
	sdram_we_n,
	sdram_rst_reset_n);	

	input	[23:0]	avalon_sdram_address;
	input	[1:0]	avalon_sdram_byteenable_n;
	input		avalon_sdram_chipselect;
	input	[15:0]	avalon_sdram_writedata;
	input		avalon_sdram_read_n;
	input		avalon_sdram_write_n;
	output	[15:0]	avalon_sdram_readdata;
	output		avalon_sdram_readdatavalid;
	output		avalon_sdram_waitrequest;
	input		clk_clk;
	input		reset_reset_n;
	output	[12:0]	sdram_addr;
	output	[1:0]	sdram_ba;
	output		sdram_cas_n;
	output		sdram_cke;
	output		sdram_cs_n;
	inout	[15:0]	sdram_dq;
	output	[1:0]	sdram_dqm;
	output		sdram_ras_n;
	output		sdram_we_n;
	input		sdram_rst_reset_n;
endmodule
