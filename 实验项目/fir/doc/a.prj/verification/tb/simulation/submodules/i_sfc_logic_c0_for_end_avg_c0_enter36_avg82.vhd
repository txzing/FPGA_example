-- ------------------------------------------------------------------------- 
-- High Level Design Compiler for Intel(R) FPGAs Version 18.1 (Release Build #625)
-- 
-- Legal Notice: Copyright 2018 Intel Corporation.  All rights reserved.
-- Your use of  Intel Corporation's design tools,  logic functions and other
-- software and  tools, and its AMPP partner logic functions, and any output
-- files any  of the foregoing (including  device programming  or simulation
-- files), and  any associated  documentation  or information  are expressly
-- subject  to the terms and  conditions of the  Intel FPGA Software License
-- Agreement, Intel MegaCore Function License Agreement, or other applicable
-- license agreement,  including,  without limitation,  that your use is for
-- the  sole  purpose of  programming  logic devices  manufactured by  Intel
-- and  sold by Intel  or its authorized  distributors. Please refer  to the
-- applicable agreement for further details.
-- ---------------------------------------------------------------------------

-- VHDL created from i_sfc_logic_c0_for_end_avg_c0_enter36_avg82
-- VHDL created on Tue Jul 13 15:48:11 2021


library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.all;
use IEEE.MATH_REAL.all;
use std.TextIO.all;
use work.dspba_library_package.all;

LIBRARY altera_mf;
USE altera_mf.altera_mf_components.all;
LIBRARY altera_lnsim;
USE altera_lnsim.altera_lnsim_components.altera_syncram;
LIBRARY lpm;
USE lpm.lpm_components.all;

entity i_sfc_logic_c0_for_end_avg_c0_enter36_avg82 is
    port (
        in_c0_eni135_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_eni135_1 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_i_valid : in std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exi138_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exi138_1 : out std_logic_vector(31 downto 0);  -- float32_m23
        out_o_valid : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end i_sfc_logic_c0_for_end_avg_c0_enter36_avg82;

architecture normal of i_sfc_logic_c0_for_end_avg_c0_enter36_avg82 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component floatComponent_i_sfc_logic_c0_for_end_avg_c0_enter36_avg82_constMultBlock_typeSFA0Z06of03p06o303d0jzj0u is
        port (
            in_0 : in std_logic_vector(31 downto 0);  -- Floating Point
            out_primWireOut : out std_logic_vector(31 downto 0);  -- Floating Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component floatComponent_i_sfc_logic_c0_for_end_avg_c0_enter36_avg82_multBlock_typeSFloatIA0Zp06o303d06o00rf01pzc is
        port (
            in_0 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_1 : in std_logic_vector(31 downto 0);  -- Floating Point
            out_primWireOut : out std_logic_vector(31 downto 0);  -- Floating Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal c_float_5_100000e_01_q : STD_LOGIC_VECTOR (31 downto 0);
    signal constMult_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal i_mul_avg_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal redist0_i_mul_avg_out_primWireOut_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist1_sync_in_aunroll_x_in_i_valid_11_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist1_sync_in_aunroll_x_in_i_valid_11(DELAY,9)
    redist1_sync_in_aunroll_x_in_i_valid_11 : dspba_delay
    GENERIC MAP ( width => 1, depth => 11, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_i_valid, xout => redist1_sync_in_aunroll_x_in_i_valid_11_q, clk => clock, aclr => resetn );

    -- c_float_5_100000e_01(FLOATCONSTANT,4)
    c_float_5_100000e_01_q <= "01000010010011000000000000000000";

    -- i_mul_avg(BLACKBOX,7)@0
    -- out out_primWireOut@7
    thei_mul_avg : floatComponent_i_sfc_logic_c0_for_end_avg_c0_enter36_avg82_multBlock_typeSFloatIA0Zp06o303d06o00rf01pzc
    PORT MAP (
        in_0 => in_c0_eni135_1,
        in_1 => c_float_5_100000e_01_q,
        out_primWireOut => i_mul_avg_out_primWireOut,
        clock => clock,
        resetn => resetn
    );

    -- redist0_i_mul_avg_out_primWireOut_1(DELAY,8)
    redist0_i_mul_avg_out_primWireOut_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => i_mul_avg_out_primWireOut, xout => redist0_i_mul_avg_out_primWireOut_1_q, clk => clock, aclr => resetn );

    -- constMult(BLACKBOX,6)@8
    -- out out_primWireOut@11
    theconstMult : floatComponent_i_sfc_logic_c0_for_end_avg_c0_enter36_avg82_constMultBlock_typeSFA0Z06of03p06o303d0jzj0u
    PORT MAP (
        in_0 => redist0_i_mul_avg_out_primWireOut_1_q,
        out_primWireOut => constMult_out_primWireOut,
        clock => clock,
        resetn => resetn
    );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- sync_out_aunroll_x(GPOUT,3)@11
    out_c0_exi138_0 <= GND_q;
    out_c0_exi138_1 <= constMult_out_primWireOut;
    out_o_valid <= redist1_sync_in_aunroll_x_in_i_valid_11_q;

END normal;
