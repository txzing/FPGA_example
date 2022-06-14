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

-- VHDL created from bb_avg_B4
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

entity bb_avg_B4 is
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
        in_flush : in std_logic_vector(0 downto 0);  -- ufix1
        in_intel_reserved_ffwd_1_0 : in std_logic_vector(63 downto 0);  -- ufix64
        in_memdep_avm_readdata : in std_logic_vector(63 downto 0);  -- ufix64
        in_memdep_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        in_memdep_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_memdep_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_stall_in_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_stall_in_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_valid_in_0 : in std_logic_vector(0 downto 0);  -- ufix1
        out_feedback_out_10 : out std_logic_vector(7 downto 0);  -- ufix8
        in_feedback_stall_in_10 : in std_logic_vector(0 downto 0);  -- ufix1
        out_feedback_valid_out_10 : out std_logic_vector(0 downto 0);  -- ufix1
        out_lsu_memdep_o_active : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_address : out std_logic_vector(63 downto 0);  -- ufix64
        out_memdep_avm_burstcount : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_byteenable : out std_logic_vector(7 downto 0);  -- ufix8
        out_memdep_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_writedata : out std_logic_vector(63 downto 0);  -- ufix64
        out_stall_out_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_valid_out_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_valid_out_1 : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end bb_avg_B4;

architecture normal of bb_avg_B4 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component avg_B4_merge is
        port (
            in_c0_exit311_0_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit311_0_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_c0_exit311_0_2 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit311_0_3 : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_c0_exit311_0_4 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit311_0_5 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit311_0_6 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit311_0_7 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit311_0_8 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit311_0_9 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c1_exit2_0_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c1_exit2_0_1 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit311_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit311_1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_c0_exit311_2 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit311_3 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_c0_exit311_4 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit311_5 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit311_6 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit311_7 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit311_8 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit311_9 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c1_exit2_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c1_exit2_1 : out std_logic_vector(31 downto 0);  -- Floating Point
            out_stall_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component avg_B4_branch is
        port (
            in_c0_exe8 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out_1 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_avg_B4_stall_region is
        port (
            in_c0_exit311_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit311_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_c0_exit311_2 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit311_3 : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_c0_exit311_4 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit311_5 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit311_6 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit311_7 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit311_8 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit311_9 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c1_exit2_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c1_exit2_1 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_feedback_stall_in_10 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_intel_reserved_ffwd_1_0 : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_memdep_avm_readdata : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_memdep_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_memdep_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_memdep_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exe8 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_feedback_out_10 : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_feedback_valid_out_10 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_lsu_memdep_o_active : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_avm_address : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_memdep_avm_burstcount : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_avm_byteenable : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_memdep_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_avm_writedata : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal avg_B4_merge_aunroll_x_out_c0_exit311_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B4_merge_aunroll_x_out_c0_exit311_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal avg_B4_merge_aunroll_x_out_c0_exit311_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B4_merge_aunroll_x_out_c0_exit311_3 : STD_LOGIC_VECTOR (63 downto 0);
    signal avg_B4_merge_aunroll_x_out_c0_exit311_4 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B4_merge_aunroll_x_out_c0_exit311_5 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B4_merge_aunroll_x_out_c0_exit311_6 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B4_merge_aunroll_x_out_c0_exit311_7 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B4_merge_aunroll_x_out_c0_exit311_8 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B4_merge_aunroll_x_out_c0_exit311_9 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B4_merge_aunroll_x_out_c1_exit2_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B4_merge_aunroll_x_out_c1_exit2_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal avg_B4_merge_aunroll_x_out_stall_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B4_merge_aunroll_x_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B4_branch_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B4_branch_out_valid_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B4_branch_out_valid_out_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_stall_region_out_c0_exe8 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_stall_region_out_feedback_out_10 : STD_LOGIC_VECTOR (7 downto 0);
    signal bb_avg_B4_stall_region_out_feedback_valid_out_10 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_stall_region_out_lsu_memdep_o_active : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_stall_region_out_memdep_avm_address : STD_LOGIC_VECTOR (63 downto 0);
    signal bb_avg_B4_stall_region_out_memdep_avm_burstcount : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_stall_region_out_memdep_avm_byteenable : STD_LOGIC_VECTOR (7 downto 0);
    signal bb_avg_B4_stall_region_out_memdep_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_stall_region_out_memdep_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_stall_region_out_memdep_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_stall_region_out_memdep_avm_writedata : STD_LOGIC_VECTOR (63 downto 0);
    signal bb_avg_B4_stall_region_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_stall_region_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- avg_B4_branch(BLACKBOX,24)
    theavg_B4_branch : avg_B4_branch
    PORT MAP (
        in_c0_exe8 => bb_avg_B4_stall_region_out_c0_exe8,
        in_stall_in_0 => in_stall_in_0,
        in_stall_in_1 => in_stall_in_1,
        in_valid_in => bb_avg_B4_stall_region_out_valid_out,
        out_stall_out => avg_B4_branch_out_stall_out,
        out_valid_out_0 => avg_B4_branch_out_valid_out_0,
        out_valid_out_1 => avg_B4_branch_out_valid_out_1,
        clock => clock,
        resetn => resetn
    );

    -- avg_B4_merge_aunroll_x(BLACKBOX,2)
    theavg_B4_merge_aunroll_x : avg_B4_merge
    PORT MAP (
        in_c0_exit311_0_0 => in_c0_exit311_0_0,
        in_c0_exit311_0_1 => in_c0_exit311_0_1,
        in_c0_exit311_0_2 => in_c0_exit311_0_2,
        in_c0_exit311_0_3 => in_c0_exit311_0_3,
        in_c0_exit311_0_4 => in_c0_exit311_0_4,
        in_c0_exit311_0_5 => in_c0_exit311_0_5,
        in_c0_exit311_0_6 => in_c0_exit311_0_6,
        in_c0_exit311_0_7 => in_c0_exit311_0_7,
        in_c0_exit311_0_8 => in_c0_exit311_0_8,
        in_c0_exit311_0_9 => in_c0_exit311_0_9,
        in_c1_exit2_0_0 => in_c1_exit2_0_0,
        in_c1_exit2_0_1 => in_c1_exit2_0_1,
        in_stall_in => bb_avg_B4_stall_region_out_stall_out,
        in_valid_in_0 => in_valid_in_0,
        out_c0_exit311_0 => avg_B4_merge_aunroll_x_out_c0_exit311_0,
        out_c0_exit311_1 => avg_B4_merge_aunroll_x_out_c0_exit311_1,
        out_c0_exit311_2 => avg_B4_merge_aunroll_x_out_c0_exit311_2,
        out_c0_exit311_3 => avg_B4_merge_aunroll_x_out_c0_exit311_3,
        out_c0_exit311_4 => avg_B4_merge_aunroll_x_out_c0_exit311_4,
        out_c0_exit311_5 => avg_B4_merge_aunroll_x_out_c0_exit311_5,
        out_c0_exit311_6 => avg_B4_merge_aunroll_x_out_c0_exit311_6,
        out_c0_exit311_7 => avg_B4_merge_aunroll_x_out_c0_exit311_7,
        out_c0_exit311_8 => avg_B4_merge_aunroll_x_out_c0_exit311_8,
        out_c0_exit311_9 => avg_B4_merge_aunroll_x_out_c0_exit311_9,
        out_c1_exit2_0 => avg_B4_merge_aunroll_x_out_c1_exit2_0,
        out_c1_exit2_1 => avg_B4_merge_aunroll_x_out_c1_exit2_1,
        out_stall_out_0 => avg_B4_merge_aunroll_x_out_stall_out_0,
        out_valid_out => avg_B4_merge_aunroll_x_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- bb_avg_B4_stall_region(BLACKBOX,25)
    thebb_avg_B4_stall_region : bb_avg_B4_stall_region
    PORT MAP (
        in_c0_exit311_0 => avg_B4_merge_aunroll_x_out_c0_exit311_0,
        in_c0_exit311_1 => avg_B4_merge_aunroll_x_out_c0_exit311_1,
        in_c0_exit311_2 => avg_B4_merge_aunroll_x_out_c0_exit311_2,
        in_c0_exit311_3 => avg_B4_merge_aunroll_x_out_c0_exit311_3,
        in_c0_exit311_4 => avg_B4_merge_aunroll_x_out_c0_exit311_4,
        in_c0_exit311_5 => avg_B4_merge_aunroll_x_out_c0_exit311_5,
        in_c0_exit311_6 => avg_B4_merge_aunroll_x_out_c0_exit311_6,
        in_c0_exit311_7 => avg_B4_merge_aunroll_x_out_c0_exit311_7,
        in_c0_exit311_8 => avg_B4_merge_aunroll_x_out_c0_exit311_8,
        in_c0_exit311_9 => avg_B4_merge_aunroll_x_out_c0_exit311_9,
        in_c1_exit2_0 => avg_B4_merge_aunroll_x_out_c1_exit2_0,
        in_c1_exit2_1 => avg_B4_merge_aunroll_x_out_c1_exit2_1,
        in_feedback_stall_in_10 => in_feedback_stall_in_10,
        in_flush => in_flush,
        in_intel_reserved_ffwd_1_0 => in_intel_reserved_ffwd_1_0,
        in_memdep_avm_readdata => in_memdep_avm_readdata,
        in_memdep_avm_readdatavalid => in_memdep_avm_readdatavalid,
        in_memdep_avm_waitrequest => in_memdep_avm_waitrequest,
        in_memdep_avm_writeack => in_memdep_avm_writeack,
        in_stall_in => avg_B4_branch_out_stall_out,
        in_valid_in => avg_B4_merge_aunroll_x_out_valid_out,
        out_c0_exe8 => bb_avg_B4_stall_region_out_c0_exe8,
        out_feedback_out_10 => bb_avg_B4_stall_region_out_feedback_out_10,
        out_feedback_valid_out_10 => bb_avg_B4_stall_region_out_feedback_valid_out_10,
        out_lsu_memdep_o_active => bb_avg_B4_stall_region_out_lsu_memdep_o_active,
        out_memdep_avm_address => bb_avg_B4_stall_region_out_memdep_avm_address,
        out_memdep_avm_burstcount => bb_avg_B4_stall_region_out_memdep_avm_burstcount,
        out_memdep_avm_byteenable => bb_avg_B4_stall_region_out_memdep_avm_byteenable,
        out_memdep_avm_enable => bb_avg_B4_stall_region_out_memdep_avm_enable,
        out_memdep_avm_read => bb_avg_B4_stall_region_out_memdep_avm_read,
        out_memdep_avm_write => bb_avg_B4_stall_region_out_memdep_avm_write,
        out_memdep_avm_writedata => bb_avg_B4_stall_region_out_memdep_avm_writedata,
        out_stall_out => bb_avg_B4_stall_region_out_stall_out,
        out_valid_out => bb_avg_B4_stall_region_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- feedback_out_10_sync(GPOUT,26)
    out_feedback_out_10 <= bb_avg_B4_stall_region_out_feedback_out_10;

    -- feedback_valid_out_10_sync(GPOUT,28)
    out_feedback_valid_out_10 <= bb_avg_B4_stall_region_out_feedback_valid_out_10;

    -- out_lsu_memdep_o_active(GPOUT,29)
    out_lsu_memdep_o_active <= bb_avg_B4_stall_region_out_lsu_memdep_o_active;

    -- out_memdep_avm_address(GPOUT,30)
    out_memdep_avm_address <= bb_avg_B4_stall_region_out_memdep_avm_address;

    -- out_memdep_avm_burstcount(GPOUT,31)
    out_memdep_avm_burstcount <= bb_avg_B4_stall_region_out_memdep_avm_burstcount;

    -- out_memdep_avm_byteenable(GPOUT,32)
    out_memdep_avm_byteenable <= bb_avg_B4_stall_region_out_memdep_avm_byteenable;

    -- out_memdep_avm_enable(GPOUT,33)
    out_memdep_avm_enable <= bb_avg_B4_stall_region_out_memdep_avm_enable;

    -- out_memdep_avm_read(GPOUT,34)
    out_memdep_avm_read <= bb_avg_B4_stall_region_out_memdep_avm_read;

    -- out_memdep_avm_write(GPOUT,35)
    out_memdep_avm_write <= bb_avg_B4_stall_region_out_memdep_avm_write;

    -- out_memdep_avm_writedata(GPOUT,36)
    out_memdep_avm_writedata <= bb_avg_B4_stall_region_out_memdep_avm_writedata;

    -- out_stall_out_0(GPOUT,37)
    out_stall_out_0 <= avg_B4_merge_aunroll_x_out_stall_out_0;

    -- out_valid_out_0(GPOUT,38)
    out_valid_out_0 <= avg_B4_branch_out_valid_out_0;

    -- out_valid_out_1(GPOUT,39)
    out_valid_out_1 <= avg_B4_branch_out_valid_out_1;

END normal;
