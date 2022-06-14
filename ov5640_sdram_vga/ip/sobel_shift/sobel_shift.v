// megafunction wizard: %Shift register (RAM-based)%
// GENERATION: STANDARD
// VERSION: WM1.0
// MODULE: ALTSHIFT_TAPS 

// ============================================================
// File Name: sobel_shift.v
// Megafunction Name(s):
// 			ALTSHIFT_TAPS
//
// Simulation Library Files(s):
// 			altera_mf
// ============================================================
// ************************************************************
// THIS IS A WIZARD-GENERATED FILE. DO NOT EDIT THIS FILE!
//
// 18.1.0 Build 625 09/12/2018 SJ Standard Edition
// ************************************************************


//Copyright (C) 2018  Intel Corporation. All rights reserved.
//Your use of Intel Corporation's design tools, logic functions 
//and other software and tools, and its AMPP partner logic 
//functions, and any output files from any of the foregoing 
//(including device programming or simulation files), and any 
//associated documentation or information are expressly subject 
//to the terms and conditions of the Intel Program License 
//Subscription Agreement, the Intel Quartus Prime License Agreement,
//the Intel FPGA IP License Agreement, or other applicable license
//agreement, including, without limitation, that your use is for
//the sole purpose of programming logic devices manufactured by
//Intel and sold by Intel or its authorized distributors.  Please
//refer to the applicable agreement for further details.


// synopsys translate_off
`timescale 1 ps / 1 ps
// synopsys translate_on
module sobel_shift (
	aclr,
	clken,
	clock,
	shiftin,
	shiftout,
	taps0x,
	taps1x,
	taps2x);

	input	  aclr;
	input	  clken;
	input	  clock;
	input	[0:0]  shiftin;
	output	[0:0]  shiftout;
	output	[0:0]  taps0x;
	output	[0:0]  taps1x;
	output	[0:0]  taps2x;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_off
`endif
	tri1	  aclr;
	tri1	  clken;
`ifndef ALTERA_RESERVED_QIS
// synopsys translate_on
`endif

	wire [0:0] sub_wire0;
	wire [2:0] sub_wire1;
	wire [0:0] shiftout = sub_wire0[0:0];
	wire [2:2] sub_wire5 = sub_wire1[2:2];
	wire [1:1] sub_wire4 = sub_wire1[1:1];
	wire [1:1] sub_wire3 = sub_wire4[1:1];
	wire [0:0] sub_wire2 = sub_wire1[0:0];
	wire [0:0] taps0x = sub_wire2[0:0];
	wire [0:0] taps1x = sub_wire3[1:1];
	wire [0:0] taps2x = sub_wire5[2:2];

	altshift_taps	ALTSHIFT_TAPS_component (
				.aclr (aclr),
				.clken (clken),
				.clock (clock),
				.shiftin (shiftin),
				.shiftout (sub_wire0),
				.taps (sub_wire1)
				// synopsys translate_off
				//,
				//.sclr ()
				// synopsys translate_on
				);
	defparam
		ALTSHIFT_TAPS_component.intended_device_family = "Cyclone IV E",
		ALTSHIFT_TAPS_component.lpm_hint = "RAM_BLOCK_TYPE=M9K",
		ALTSHIFT_TAPS_component.lpm_type = "altshift_taps",
		ALTSHIFT_TAPS_component.number_of_taps = 3,
		ALTSHIFT_TAPS_component.tap_distance = 1280,
		ALTSHIFT_TAPS_component.width = 1;


endmodule

// ============================================================
// CNX file retrieval info
// ============================================================
// Retrieval info: PRIVATE: ACLR NUMERIC "1"
// Retrieval info: PRIVATE: CLKEN NUMERIC "1"
// Retrieval info: PRIVATE: GROUP_TAPS NUMERIC "1"
// Retrieval info: PRIVATE: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: PRIVATE: NUMBER_OF_TAPS NUMERIC "3"
// Retrieval info: PRIVATE: RAM_BLOCK_TYPE NUMERIC "1"
// Retrieval info: PRIVATE: SYNTH_WRAPPER_GEN_POSTFIX STRING "0"
// Retrieval info: PRIVATE: TAP_DISTANCE NUMERIC "1280"
// Retrieval info: PRIVATE: WIDTH NUMERIC "1"
// Retrieval info: LIBRARY: altera_mf altera_mf.altera_mf_components.all
// Retrieval info: CONSTANT: INTENDED_DEVICE_FAMILY STRING "Cyclone IV E"
// Retrieval info: CONSTANT: LPM_HINT STRING "RAM_BLOCK_TYPE=M9K"
// Retrieval info: CONSTANT: LPM_TYPE STRING "altshift_taps"
// Retrieval info: CONSTANT: NUMBER_OF_TAPS NUMERIC "3"
// Retrieval info: CONSTANT: TAP_DISTANCE NUMERIC "1280"
// Retrieval info: CONSTANT: WIDTH NUMERIC "1"
// Retrieval info: USED_PORT: aclr 0 0 0 0 INPUT VCC "aclr"
// Retrieval info: USED_PORT: clken 0 0 0 0 INPUT VCC "clken"
// Retrieval info: USED_PORT: clock 0 0 0 0 INPUT NODEFVAL "clock"
// Retrieval info: USED_PORT: shiftin 0 0 1 0 INPUT NODEFVAL "shiftin[0..0]"
// Retrieval info: USED_PORT: shiftout 0 0 1 0 OUTPUT NODEFVAL "shiftout[0..0]"
// Retrieval info: USED_PORT: taps0x 0 0 1 0 OUTPUT NODEFVAL "taps0x[0..0]"
// Retrieval info: USED_PORT: taps1x 0 0 1 0 OUTPUT NODEFVAL "taps1x[0..0]"
// Retrieval info: USED_PORT: taps2x 0 0 1 0 OUTPUT NODEFVAL "taps2x[0..0]"
// Retrieval info: CONNECT: @aclr 0 0 0 0 aclr 0 0 0 0
// Retrieval info: CONNECT: @clken 0 0 0 0 clken 0 0 0 0
// Retrieval info: CONNECT: @clock 0 0 0 0 clock 0 0 0 0
// Retrieval info: CONNECT: @shiftin 0 0 1 0 shiftin 0 0 1 0
// Retrieval info: CONNECT: shiftout 0 0 1 0 @shiftout 0 0 1 0
// Retrieval info: CONNECT: taps0x 0 0 1 0 @taps 0 0 1 0
// Retrieval info: CONNECT: taps1x 0 0 1 0 @taps 0 0 1 1
// Retrieval info: CONNECT: taps2x 0 0 1 0 @taps 0 0 1 2
// Retrieval info: GEN_FILE: TYPE_NORMAL sobel_shift.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL sobel_shift.inc FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL sobel_shift.cmp FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL sobel_shift.bsf FALSE
// Retrieval info: GEN_FILE: TYPE_NORMAL sobel_shift_inst.v TRUE
// Retrieval info: GEN_FILE: TYPE_NORMAL sobel_shift_bb.v TRUE
// Retrieval info: LIB_FILE: altera_mf
