
module sdram_interface (
	clk_clk,
	reset_reset_n,
	avs_address,
	avs_byteenable_n,
	avs_chipselect,
	avs_writedata,
	avs_read_n,
	avs_write_n,
	avs_readdata,
	avs_readdatavalid,
	avs_waitrequest,
	mem_pin_addr,
	mem_pin_ba,
	mem_pin_cas_n,
	mem_pin_cke,
	mem_pin_cs_n,
	mem_pin_dq,
	mem_pin_dqm,
	mem_pin_ras_n,
	mem_pin_we_n);	

	input		clk_clk;
	input		reset_reset_n;
	input	[23:0]	avs_address;
	input	[1:0]	avs_byteenable_n;
	input		avs_chipselect;
	input	[15:0]	avs_writedata;
	input		avs_read_n;
	input		avs_write_n;
	output	[15:0]	avs_readdata;
	output		avs_readdatavalid;
	output		avs_waitrequest;
	output	[12:0]	mem_pin_addr;
	output	[1:0]	mem_pin_ba;
	output		mem_pin_cas_n;
	output		mem_pin_cke;
	output		mem_pin_cs_n;
	inout	[15:0]	mem_pin_dq;
	output	[1:0]	mem_pin_dqm;
	output		mem_pin_ras_n;
	output		mem_pin_we_n;
endmodule
