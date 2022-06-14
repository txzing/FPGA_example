	sdram u0 (
		.avalon_sdram_address       (<connected-to-avalon_sdram_address>),       // avalon_sdram.address
		.avalon_sdram_byteenable_n  (<connected-to-avalon_sdram_byteenable_n>),  //             .byteenable_n
		.avalon_sdram_chipselect    (<connected-to-avalon_sdram_chipselect>),    //             .chipselect
		.avalon_sdram_writedata     (<connected-to-avalon_sdram_writedata>),     //             .writedata
		.avalon_sdram_read_n        (<connected-to-avalon_sdram_read_n>),        //             .read_n
		.avalon_sdram_write_n       (<connected-to-avalon_sdram_write_n>),       //             .write_n
		.avalon_sdram_readdata      (<connected-to-avalon_sdram_readdata>),      //             .readdata
		.avalon_sdram_readdatavalid (<connected-to-avalon_sdram_readdatavalid>), //             .readdatavalid
		.avalon_sdram_waitrequest   (<connected-to-avalon_sdram_waitrequest>),   //             .waitrequest
		.clk_clk                    (<connected-to-clk_clk>),                    //          clk.clk
		.reset_reset_n              (<connected-to-reset_reset_n>),              //        reset.reset_n
		.sdram_addr                 (<connected-to-sdram_addr>),                 //        sdram.addr
		.sdram_ba                   (<connected-to-sdram_ba>),                   //             .ba
		.sdram_cas_n                (<connected-to-sdram_cas_n>),                //             .cas_n
		.sdram_cke                  (<connected-to-sdram_cke>),                  //             .cke
		.sdram_cs_n                 (<connected-to-sdram_cs_n>),                 //             .cs_n
		.sdram_dq                   (<connected-to-sdram_dq>),                   //             .dq
		.sdram_dqm                  (<connected-to-sdram_dqm>),                  //             .dqm
		.sdram_ras_n                (<connected-to-sdram_ras_n>),                //             .ras_n
		.sdram_we_n                 (<connected-to-sdram_we_n>),                 //             .we_n
		.sdram_rst_reset_n          (<connected-to-sdram_rst_reset_n>)           //    sdram_rst.reset_n
	);

