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

-- VHDL created from bb_avg_B3
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

entity bb_avg_B3 is
    port (
        out_c0_exit31_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exit31_1 : out std_logic_vector(31 downto 0);  -- ufix32
        out_c0_exit31_2 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exit31_3 : out std_logic_vector(63 downto 0);  -- ufix64
        out_c0_exit31_4 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exit31_5 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exit31_6 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exit31_7 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exit31_8 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exit31_9 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c1_exit_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c1_exit_1 : out std_logic_vector(31 downto 0);  -- float32_m23
        out_exiting_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        out_exiting_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out_1 : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_avg4_avm_address : out std_logic_vector(63 downto 0);  -- ufix64
        out_unnamed_avg4_avm_burstcount : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_avg4_avm_byteenable : out std_logic_vector(7 downto 0);  -- ufix8
        out_unnamed_avg4_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_avg4_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_avg4_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_avg4_avm_writedata : out std_logic_vector(63 downto 0);  -- ufix64
        out_valid_out_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_valid_out_1 : out std_logic_vector(0 downto 0);  -- ufix1
        in_exitcond18_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_exitcond18_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_flush : in std_logic_vector(0 downto 0);  -- ufix1
        in_forked16_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_forked16_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_i_03_pop917_0 : in std_logic_vector(31 downto 0);  -- ufix32
        in_i_03_pop917_1 : in std_logic_vector(31 downto 0);  -- ufix32
        in_intel_reserved_ffwd_0_0 : in std_logic_vector(63 downto 0);  -- ufix64
        in_memdep_phi_pop1020_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_memdep_phi_pop1020_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_notexit1119_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_notexit1119_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_stall_in_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_stall_in_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_avg4_avm_readdata : in std_logic_vector(63 downto 0);  -- ufix64
        in_unnamed_avg4_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_avg4_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_avg4_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_valid_in_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_valid_in_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_pipeline_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_pipeline_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end bb_avg_B3;

architecture normal of bb_avg_B3 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component avg_B3_branch is
        port (
            in_c0_exit31_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit31_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_c0_exit31_2 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit31_3 : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_c0_exit31_4 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit31_5 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit31_6 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit31_7 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit31_8 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_exit31_9 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c1_exit_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c1_exit_1 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_c0_exe6 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_c0_exit31_2 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_3 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_c0_exit31_4 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_5 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_6 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_7 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_8 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_9 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c1_exit_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c1_exit_1 : out std_logic_vector(31 downto 0);  -- Floating Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out_1 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component avg_B3_merge is
        port (
            in_exitcond18_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_exitcond18_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_forked16_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_forked16_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_03_pop917_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_03_pop917_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_memdep_phi_pop1020_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_memdep_phi_pop1020_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_notexit1119_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_notexit1119_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_exitcond18 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_forked16 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_i_03_pop917 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_memdep_phi_pop1020 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_notexit1119 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out_1 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_avg_B3_stall_region is
        port (
            in_exitcond18 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_forked16 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_03_pop917 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_intel_reserved_ffwd_0_0 : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_memdep_phi_pop1020 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_notexit1119 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_pipeline_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_avg4_avm_readdata : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_unnamed_avg4_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_avg4_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_avg4_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_c0_exit31_2 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_3 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_c0_exit31_4 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_5 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_6 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_7 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_8 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit31_9 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c1_exit_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c1_exit_1 : out std_logic_vector(31 downto 0);  -- Floating Point
            out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exe6 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_pipeline_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_avg4_avm_address : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_unnamed_avg4_avm_burstcount : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_avg4_avm_byteenable : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_unnamed_avg4_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_avg4_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_avg4_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_avg4_avm_writedata : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal avg_B3_branch_aunroll_x_out_c0_exit31_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_branch_aunroll_x_out_c0_exit31_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal avg_B3_branch_aunroll_x_out_c0_exit31_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_branch_aunroll_x_out_c0_exit31_3 : STD_LOGIC_VECTOR (63 downto 0);
    signal avg_B3_branch_aunroll_x_out_c0_exit31_4 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_branch_aunroll_x_out_c0_exit31_5 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_branch_aunroll_x_out_c0_exit31_6 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_branch_aunroll_x_out_c0_exit31_7 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_branch_aunroll_x_out_c0_exit31_8 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_branch_aunroll_x_out_c0_exit31_9 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_branch_aunroll_x_out_c1_exit_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_branch_aunroll_x_out_c1_exit_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal avg_B3_branch_aunroll_x_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_branch_aunroll_x_out_valid_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_branch_aunroll_x_out_valid_out_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_merge_out_exitcond18 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_merge_out_forked16 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_merge_out_i_03_pop917 : STD_LOGIC_VECTOR (31 downto 0);
    signal avg_B3_merge_out_memdep_phi_pop1020 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_merge_out_notexit1119 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_merge_out_stall_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_merge_out_stall_out_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_merge_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_c0_exit31_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_c0_exit31_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_avg_B3_stall_region_out_c0_exit31_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_c0_exit31_3 : STD_LOGIC_VECTOR (63 downto 0);
    signal bb_avg_B3_stall_region_out_c0_exit31_4 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_c0_exit31_5 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_c0_exit31_6 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_c0_exit31_7 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_c0_exit31_8 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_c0_exit31_9 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_c1_exit_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_c1_exit_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_avg_B3_stall_region_out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_c0_exe6 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_pipeline_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_unnamed_avg4_avm_address : STD_LOGIC_VECTOR (63 downto 0);
    signal bb_avg_B3_stall_region_out_unnamed_avg4_avm_burstcount : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_unnamed_avg4_avm_byteenable : STD_LOGIC_VECTOR (7 downto 0);
    signal bb_avg_B3_stall_region_out_unnamed_avg4_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_unnamed_avg4_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_unnamed_avg4_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_stall_region_out_unnamed_avg4_avm_writedata : STD_LOGIC_VECTOR (63 downto 0);
    signal bb_avg_B3_stall_region_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- avg_B3_merge(BLACKBOX,28)
    theavg_B3_merge : avg_B3_merge
    PORT MAP (
        in_exitcond18_0 => in_exitcond18_0,
        in_exitcond18_1 => in_exitcond18_1,
        in_forked16_0 => in_forked16_0,
        in_forked16_1 => in_forked16_1,
        in_i_03_pop917_0 => in_i_03_pop917_0,
        in_i_03_pop917_1 => in_i_03_pop917_1,
        in_memdep_phi_pop1020_0 => in_memdep_phi_pop1020_0,
        in_memdep_phi_pop1020_1 => in_memdep_phi_pop1020_1,
        in_notexit1119_0 => in_notexit1119_0,
        in_notexit1119_1 => in_notexit1119_1,
        in_stall_in => bb_avg_B3_stall_region_out_stall_out,
        in_valid_in_0 => in_valid_in_0,
        in_valid_in_1 => in_valid_in_1,
        out_exitcond18 => avg_B3_merge_out_exitcond18,
        out_forked16 => avg_B3_merge_out_forked16,
        out_i_03_pop917 => avg_B3_merge_out_i_03_pop917,
        out_memdep_phi_pop1020 => avg_B3_merge_out_memdep_phi_pop1020,
        out_notexit1119 => avg_B3_merge_out_notexit1119,
        out_stall_out_0 => avg_B3_merge_out_stall_out_0,
        out_stall_out_1 => avg_B3_merge_out_stall_out_1,
        out_valid_out => avg_B3_merge_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- bb_avg_B3_stall_region(BLACKBOX,29)
    thebb_avg_B3_stall_region : bb_avg_B3_stall_region
    PORT MAP (
        in_exitcond18 => avg_B3_merge_out_exitcond18,
        in_flush => in_flush,
        in_forked16 => avg_B3_merge_out_forked16,
        in_i_03_pop917 => avg_B3_merge_out_i_03_pop917,
        in_intel_reserved_ffwd_0_0 => in_intel_reserved_ffwd_0_0,
        in_memdep_phi_pop1020 => avg_B3_merge_out_memdep_phi_pop1020,
        in_notexit1119 => avg_B3_merge_out_notexit1119,
        in_pipeline_stall_in => in_pipeline_stall_in,
        in_stall_in => avg_B3_branch_aunroll_x_out_stall_out,
        in_unnamed_avg4_avm_readdata => in_unnamed_avg4_avm_readdata,
        in_unnamed_avg4_avm_readdatavalid => in_unnamed_avg4_avm_readdatavalid,
        in_unnamed_avg4_avm_waitrequest => in_unnamed_avg4_avm_waitrequest,
        in_unnamed_avg4_avm_writeack => in_unnamed_avg4_avm_writeack,
        in_valid_in => avg_B3_merge_out_valid_out,
        out_c0_exit31_0 => bb_avg_B3_stall_region_out_c0_exit31_0,
        out_c0_exit31_1 => bb_avg_B3_stall_region_out_c0_exit31_1,
        out_c0_exit31_2 => bb_avg_B3_stall_region_out_c0_exit31_2,
        out_c0_exit31_3 => bb_avg_B3_stall_region_out_c0_exit31_3,
        out_c0_exit31_4 => bb_avg_B3_stall_region_out_c0_exit31_4,
        out_c0_exit31_5 => bb_avg_B3_stall_region_out_c0_exit31_5,
        out_c0_exit31_6 => bb_avg_B3_stall_region_out_c0_exit31_6,
        out_c0_exit31_7 => bb_avg_B3_stall_region_out_c0_exit31_7,
        out_c0_exit31_8 => bb_avg_B3_stall_region_out_c0_exit31_8,
        out_c0_exit31_9 => bb_avg_B3_stall_region_out_c0_exit31_9,
        out_c1_exit_0 => bb_avg_B3_stall_region_out_c1_exit_0,
        out_c1_exit_1 => bb_avg_B3_stall_region_out_c1_exit_1,
        out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_stall_out => bb_avg_B3_stall_region_out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_stall_out,
        out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_valid_out => bb_avg_B3_stall_region_out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_valid_out,
        out_c0_exe6 => bb_avg_B3_stall_region_out_c0_exe6,
        out_pipeline_valid_out => bb_avg_B3_stall_region_out_pipeline_valid_out,
        out_stall_out => bb_avg_B3_stall_region_out_stall_out,
        out_unnamed_avg4_avm_address => bb_avg_B3_stall_region_out_unnamed_avg4_avm_address,
        out_unnamed_avg4_avm_burstcount => bb_avg_B3_stall_region_out_unnamed_avg4_avm_burstcount,
        out_unnamed_avg4_avm_byteenable => bb_avg_B3_stall_region_out_unnamed_avg4_avm_byteenable,
        out_unnamed_avg4_avm_enable => bb_avg_B3_stall_region_out_unnamed_avg4_avm_enable,
        out_unnamed_avg4_avm_read => bb_avg_B3_stall_region_out_unnamed_avg4_avm_read,
        out_unnamed_avg4_avm_write => bb_avg_B3_stall_region_out_unnamed_avg4_avm_write,
        out_unnamed_avg4_avm_writedata => bb_avg_B3_stall_region_out_unnamed_avg4_avm_writedata,
        out_valid_out => bb_avg_B3_stall_region_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- avg_B3_branch_aunroll_x(BLACKBOX,2)
    theavg_B3_branch_aunroll_x : avg_B3_branch
    PORT MAP (
        in_c0_exit31_0 => bb_avg_B3_stall_region_out_c0_exit31_0,
        in_c0_exit31_1 => bb_avg_B3_stall_region_out_c0_exit31_1,
        in_c0_exit31_2 => bb_avg_B3_stall_region_out_c0_exit31_2,
        in_c0_exit31_3 => bb_avg_B3_stall_region_out_c0_exit31_3,
        in_c0_exit31_4 => bb_avg_B3_stall_region_out_c0_exit31_4,
        in_c0_exit31_5 => bb_avg_B3_stall_region_out_c0_exit31_5,
        in_c0_exit31_6 => bb_avg_B3_stall_region_out_c0_exit31_6,
        in_c0_exit31_7 => bb_avg_B3_stall_region_out_c0_exit31_7,
        in_c0_exit31_8 => bb_avg_B3_stall_region_out_c0_exit31_8,
        in_c0_exit31_9 => bb_avg_B3_stall_region_out_c0_exit31_9,
        in_c1_exit_0 => bb_avg_B3_stall_region_out_c1_exit_0,
        in_c1_exit_1 => bb_avg_B3_stall_region_out_c1_exit_1,
        in_c0_exe6 => bb_avg_B3_stall_region_out_c0_exe6,
        in_stall_in_0 => in_stall_in_0,
        in_stall_in_1 => in_stall_in_1,
        in_valid_in => bb_avg_B3_stall_region_out_valid_out,
        out_c0_exit31_0 => avg_B3_branch_aunroll_x_out_c0_exit31_0,
        out_c0_exit31_1 => avg_B3_branch_aunroll_x_out_c0_exit31_1,
        out_c0_exit31_2 => avg_B3_branch_aunroll_x_out_c0_exit31_2,
        out_c0_exit31_3 => avg_B3_branch_aunroll_x_out_c0_exit31_3,
        out_c0_exit31_4 => avg_B3_branch_aunroll_x_out_c0_exit31_4,
        out_c0_exit31_5 => avg_B3_branch_aunroll_x_out_c0_exit31_5,
        out_c0_exit31_6 => avg_B3_branch_aunroll_x_out_c0_exit31_6,
        out_c0_exit31_7 => avg_B3_branch_aunroll_x_out_c0_exit31_7,
        out_c0_exit31_8 => avg_B3_branch_aunroll_x_out_c0_exit31_8,
        out_c0_exit31_9 => avg_B3_branch_aunroll_x_out_c0_exit31_9,
        out_c1_exit_0 => avg_B3_branch_aunroll_x_out_c1_exit_0,
        out_c1_exit_1 => avg_B3_branch_aunroll_x_out_c1_exit_1,
        out_stall_out => avg_B3_branch_aunroll_x_out_stall_out,
        out_valid_out_0 => avg_B3_branch_aunroll_x_out_valid_out_0,
        out_valid_out_1 => avg_B3_branch_aunroll_x_out_valid_out_1,
        clock => clock,
        resetn => resetn
    );

    -- out_c0_exit31_0(GPOUT,3)
    out_c0_exit31_0 <= avg_B3_branch_aunroll_x_out_c0_exit31_0;

    -- out_c0_exit31_1(GPOUT,4)
    out_c0_exit31_1 <= avg_B3_branch_aunroll_x_out_c0_exit31_1;

    -- out_c0_exit31_2(GPOUT,5)
    out_c0_exit31_2 <= avg_B3_branch_aunroll_x_out_c0_exit31_2;

    -- out_c0_exit31_3(GPOUT,6)
    out_c0_exit31_3 <= avg_B3_branch_aunroll_x_out_c0_exit31_3;

    -- out_c0_exit31_4(GPOUT,7)
    out_c0_exit31_4 <= avg_B3_branch_aunroll_x_out_c0_exit31_4;

    -- out_c0_exit31_5(GPOUT,8)
    out_c0_exit31_5 <= avg_B3_branch_aunroll_x_out_c0_exit31_5;

    -- out_c0_exit31_6(GPOUT,9)
    out_c0_exit31_6 <= avg_B3_branch_aunroll_x_out_c0_exit31_6;

    -- out_c0_exit31_7(GPOUT,10)
    out_c0_exit31_7 <= avg_B3_branch_aunroll_x_out_c0_exit31_7;

    -- out_c0_exit31_8(GPOUT,11)
    out_c0_exit31_8 <= avg_B3_branch_aunroll_x_out_c0_exit31_8;

    -- out_c0_exit31_9(GPOUT,12)
    out_c0_exit31_9 <= avg_B3_branch_aunroll_x_out_c0_exit31_9;

    -- out_c1_exit_0(GPOUT,13)
    out_c1_exit_0 <= avg_B3_branch_aunroll_x_out_c1_exit_0;

    -- out_c1_exit_1(GPOUT,14)
    out_c1_exit_1 <= avg_B3_branch_aunroll_x_out_c1_exit_1;

    -- out_exiting_stall_out(GPOUT,15)
    out_exiting_stall_out <= bb_avg_B3_stall_region_out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_stall_out;

    -- out_exiting_valid_out(GPOUT,16)
    out_exiting_valid_out <= bb_avg_B3_stall_region_out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_valid_out;

    -- out_stall_out_0(GPOUT,17)
    out_stall_out_0 <= avg_B3_merge_out_stall_out_0;

    -- out_stall_out_1(GPOUT,18)
    out_stall_out_1 <= avg_B3_merge_out_stall_out_1;

    -- out_unnamed_avg4_avm_address(GPOUT,19)
    out_unnamed_avg4_avm_address <= bb_avg_B3_stall_region_out_unnamed_avg4_avm_address;

    -- out_unnamed_avg4_avm_burstcount(GPOUT,20)
    out_unnamed_avg4_avm_burstcount <= bb_avg_B3_stall_region_out_unnamed_avg4_avm_burstcount;

    -- out_unnamed_avg4_avm_byteenable(GPOUT,21)
    out_unnamed_avg4_avm_byteenable <= bb_avg_B3_stall_region_out_unnamed_avg4_avm_byteenable;

    -- out_unnamed_avg4_avm_enable(GPOUT,22)
    out_unnamed_avg4_avm_enable <= bb_avg_B3_stall_region_out_unnamed_avg4_avm_enable;

    -- out_unnamed_avg4_avm_read(GPOUT,23)
    out_unnamed_avg4_avm_read <= bb_avg_B3_stall_region_out_unnamed_avg4_avm_read;

    -- out_unnamed_avg4_avm_write(GPOUT,24)
    out_unnamed_avg4_avm_write <= bb_avg_B3_stall_region_out_unnamed_avg4_avm_write;

    -- out_unnamed_avg4_avm_writedata(GPOUT,25)
    out_unnamed_avg4_avm_writedata <= bb_avg_B3_stall_region_out_unnamed_avg4_avm_writedata;

    -- out_valid_out_0(GPOUT,26)
    out_valid_out_0 <= avg_B3_branch_aunroll_x_out_valid_out_0;

    -- out_valid_out_1(GPOUT,27)
    out_valid_out_1 <= avg_B3_branch_aunroll_x_out_valid_out_1;

    -- pipeline_valid_out_sync(GPOUT,51)
    out_pipeline_valid_out <= bb_avg_B3_stall_region_out_pipeline_valid_out;

END normal;
