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

-- VHDL created from avg_B4_merge
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

entity avg_B4_merge is
    port (
        in_c0_exit311_0_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit311_0_1 : in std_logic_vector(31 downto 0);  -- ufix32
        in_c0_exit311_0_2 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit311_0_3 : in std_logic_vector(63 downto 0);  -- ufix64
        in_c0_exit311_0_4 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit311_0_5 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit311_0_6 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit311_0_7 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit311_0_8 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit311_0_9 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c1_exit2_0_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c1_exit2_0_1 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        in_valid_in_0 : in std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exit311_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exit311_1 : out std_logic_vector(31 downto 0);  -- ufix32
        out_c0_exit311_2 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exit311_3 : out std_logic_vector(63 downto 0);  -- ufix64
        out_c0_exit311_4 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exit311_5 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exit311_6 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exit311_7 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exit311_8 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exit311_9 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c1_exit2_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c1_exit2_1 : out std_logic_vector(31 downto 0);  -- float32_m23
        out_stall_out_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end avg_B4_merge;

architecture normal of avg_B4_merge is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal stall_out_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- out_c0_exit311_0(GPOUT,16)
    out_c0_exit311_0 <= in_c0_exit311_0_0;

    -- out_c0_exit311_1(GPOUT,17)
    out_c0_exit311_1 <= in_c0_exit311_0_1;

    -- out_c0_exit311_2(GPOUT,18)
    out_c0_exit311_2 <= in_c0_exit311_0_2;

    -- out_c0_exit311_3(GPOUT,19)
    out_c0_exit311_3 <= in_c0_exit311_0_3;

    -- out_c0_exit311_4(GPOUT,20)
    out_c0_exit311_4 <= in_c0_exit311_0_4;

    -- out_c0_exit311_5(GPOUT,21)
    out_c0_exit311_5 <= in_c0_exit311_0_5;

    -- out_c0_exit311_6(GPOUT,22)
    out_c0_exit311_6 <= in_c0_exit311_0_6;

    -- out_c0_exit311_7(GPOUT,23)
    out_c0_exit311_7 <= in_c0_exit311_0_7;

    -- out_c0_exit311_8(GPOUT,24)
    out_c0_exit311_8 <= in_c0_exit311_0_8;

    -- out_c0_exit311_9(GPOUT,25)
    out_c0_exit311_9 <= in_c0_exit311_0_9;

    -- out_c1_exit2_0(GPOUT,26)
    out_c1_exit2_0 <= in_c1_exit2_0_0;

    -- out_c1_exit2_1(GPOUT,27)
    out_c1_exit2_1 <= in_c1_exit2_0_1;

    -- stall_out(LOGICAL,30)
    stall_out_q <= in_valid_in_0 and in_stall_in;

    -- out_stall_out_0(GPOUT,28)
    out_stall_out_0 <= stall_out_q;

    -- out_valid_out(GPOUT,29)
    out_valid_out <= in_valid_in_0;

END normal;
