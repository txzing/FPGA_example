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

-- VHDL created from avg_B3_merge
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

entity avg_B3_merge is
    port (
        in_exitcond18_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_exitcond18_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_forked16_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_forked16_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_i_03_pop917_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_i_03_pop917_1 : in std_logic_vector(31 downto 0);  -- ufix32
        in_memdep_phi_pop1020_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_memdep_phi_pop1020_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_notexit1119_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_notexit1119_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        in_valid_in_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_valid_in_1 : in std_logic_vector(0 downto 0);  -- ufix1
        out_exitcond18 : out std_logic_vector(0 downto 0);  -- ufix1
        out_forked16 : out std_logic_vector(0 downto 0);  -- ufix1
        out_i_03_pop917 : out std_logic_vector(31 downto 0);  -- ufix32
        out_memdep_phi_pop1020 : out std_logic_vector(0 downto 0);  -- ufix1
        out_notexit1119 : out std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out_1 : out std_logic_vector(0 downto 0);  -- ufix1
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end avg_B3_merge;

architecture normal of avg_B3_merge is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal exitcond18_mux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal exitcond18_mux_q : STD_LOGIC_VECTOR (0 downto 0);
    signal forked16_mux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal forked16_mux_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_03_pop917_mux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal i_03_pop917_mux_q : STD_LOGIC_VECTOR (31 downto 0);
    signal memdep_phi_pop1020_mux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal memdep_phi_pop1020_mux_q : STD_LOGIC_VECTOR (0 downto 0);
    signal notexit1119_mux_s : STD_LOGIC_VECTOR (0 downto 0);
    signal notexit1119_mux_q : STD_LOGIC_VECTOR (0 downto 0);
    signal stall_out_q : STD_LOGIC_VECTOR (0 downto 0);
    signal stall_out_1_specific_q : STD_LOGIC_VECTOR (0 downto 0);
    signal valid_or_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- exitcond18_mux(MUX,2)
    exitcond18_mux_s <= in_valid_in_0;
    exitcond18_mux_combproc: PROCESS (exitcond18_mux_s, in_exitcond18_1, in_exitcond18_0)
    BEGIN
        CASE (exitcond18_mux_s) IS
            WHEN "0" => exitcond18_mux_q <= in_exitcond18_1;
            WHEN "1" => exitcond18_mux_q <= in_exitcond18_0;
            WHEN OTHERS => exitcond18_mux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- out_exitcond18(GPOUT,20)
    out_exitcond18 <= exitcond18_mux_q;

    -- forked16_mux(MUX,3)
    forked16_mux_s <= in_valid_in_0;
    forked16_mux_combproc: PROCESS (forked16_mux_s, in_forked16_1, in_forked16_0)
    BEGIN
        CASE (forked16_mux_s) IS
            WHEN "0" => forked16_mux_q <= in_forked16_1;
            WHEN "1" => forked16_mux_q <= in_forked16_0;
            WHEN OTHERS => forked16_mux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- out_forked16(GPOUT,21)
    out_forked16 <= forked16_mux_q;

    -- i_03_pop917_mux(MUX,4)
    i_03_pop917_mux_s <= in_valid_in_0;
    i_03_pop917_mux_combproc: PROCESS (i_03_pop917_mux_s, in_i_03_pop917_1, in_i_03_pop917_0)
    BEGIN
        CASE (i_03_pop917_mux_s) IS
            WHEN "0" => i_03_pop917_mux_q <= in_i_03_pop917_1;
            WHEN "1" => i_03_pop917_mux_q <= in_i_03_pop917_0;
            WHEN OTHERS => i_03_pop917_mux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- out_i_03_pop917(GPOUT,22)
    out_i_03_pop917 <= i_03_pop917_mux_q;

    -- memdep_phi_pop1020_mux(MUX,18)
    memdep_phi_pop1020_mux_s <= in_valid_in_0;
    memdep_phi_pop1020_mux_combproc: PROCESS (memdep_phi_pop1020_mux_s, in_memdep_phi_pop1020_1, in_memdep_phi_pop1020_0)
    BEGIN
        CASE (memdep_phi_pop1020_mux_s) IS
            WHEN "0" => memdep_phi_pop1020_mux_q <= in_memdep_phi_pop1020_1;
            WHEN "1" => memdep_phi_pop1020_mux_q <= in_memdep_phi_pop1020_0;
            WHEN OTHERS => memdep_phi_pop1020_mux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- out_memdep_phi_pop1020(GPOUT,23)
    out_memdep_phi_pop1020 <= memdep_phi_pop1020_mux_q;

    -- notexit1119_mux(MUX,19)
    notexit1119_mux_s <= in_valid_in_0;
    notexit1119_mux_combproc: PROCESS (notexit1119_mux_s, in_notexit1119_1, in_notexit1119_0)
    BEGIN
        CASE (notexit1119_mux_s) IS
            WHEN "0" => notexit1119_mux_q <= in_notexit1119_1;
            WHEN "1" => notexit1119_mux_q <= in_notexit1119_0;
            WHEN OTHERS => notexit1119_mux_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- out_notexit1119(GPOUT,24)
    out_notexit1119 <= notexit1119_mux_q;

    -- valid_or(LOGICAL,30)
    valid_or_q <= in_valid_in_0 or in_valid_in_1;

    -- stall_out(LOGICAL,28)
    stall_out_q <= valid_or_q and in_stall_in;

    -- out_stall_out_0(GPOUT,25)
    out_stall_out_0 <= stall_out_q;

    -- stall_out_1_specific(LOGICAL,29)
    stall_out_1_specific_q <= in_valid_in_0 or stall_out_q;

    -- out_stall_out_1(GPOUT,26)
    out_stall_out_1 <= stall_out_1_specific_q;

    -- out_valid_out(GPOUT,27)
    out_valid_out <= valid_or_q;

END normal;
