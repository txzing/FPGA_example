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

-- VHDL created from avg_function
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

entity avg_function is
    port (
        in_arg_do : in std_logic_vector(63 downto 0);  -- ufix64
        in_arg_return : in std_logic_vector(63 downto 0);  -- ufix64
        in_arg_x : in std_logic_vector(63 downto 0);  -- ufix64
        in_arg_y : in std_logic_vector(63 downto 0);  -- ufix64
        in_iord_bl_do_i_fifodata : in std_logic_vector(127 downto 0);  -- ufix128
        in_iord_bl_do_i_fifovalid : in std_logic_vector(0 downto 0);  -- ufix1
        in_iowr_bl_return_i_fifoready : in std_logic_vector(0 downto 0);  -- ufix1
        in_memdep_avm_readdata : in std_logic_vector(63 downto 0);  -- ufix64
        in_memdep_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        in_memdep_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_memdep_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        in_start : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_avg4_avm_readdata : in std_logic_vector(63 downto 0);  -- ufix64
        in_unnamed_avg4_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_avg4_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_unnamed_avg4_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_iord_bl_do_o_fifoready : out std_logic_vector(0 downto 0);  -- ufix1
        out_iowr_bl_return_o_fifodata : out std_logic_vector(0 downto 0);  -- ufix1
        out_iowr_bl_return_o_fifovalid : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_address : out std_logic_vector(63 downto 0);  -- ufix64
        out_memdep_avm_burstcount : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_byteenable : out std_logic_vector(7 downto 0);  -- ufix8
        out_memdep_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_writedata : out std_logic_vector(63 downto 0);  -- ufix64
        out_o_active_memdep : out std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_avg4_avm_address : out std_logic_vector(63 downto 0);  -- ufix64
        out_unnamed_avg4_avm_burstcount : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_avg4_avm_byteenable : out std_logic_vector(7 downto 0);  -- ufix8
        out_unnamed_avg4_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_avg4_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_avg4_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_unnamed_avg4_avm_writedata : out std_logic_vector(63 downto 0);  -- ufix64
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end avg_function;

architecture normal of avg_function is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component bb_avg_B2_sr_1 is
        port (
            in_i_data_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_avg_B3 is
        port (
            in_exitcond18_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_exitcond18_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_forked16_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_forked16_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_03_pop917_0 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_03_pop917_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_intel_reserved_ffwd_0_0 : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_memdep_phi_pop1020_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_memdep_phi_pop1020_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_notexit1119_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_notexit1119_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_pipeline_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_avg4_avm_readdata : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_unnamed_avg4_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_avg4_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_avg4_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
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
            out_exiting_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_exiting_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_pipeline_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out_1 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_avg4_avm_address : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_unnamed_avg4_avm_burstcount : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_avg4_avm_byteenable : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_unnamed_avg4_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_avg4_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_avg4_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_unnamed_avg4_avm_writedata : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_valid_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out_1 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_avg_B3_sr_1 is
        port (
            in_i_data_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_data_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_data_2 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_data_3 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_data_4 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_o_data_2 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_3 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_4 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_avg_B4 is
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
            in_feedback_stall_in_10 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_intel_reserved_ffwd_1_0 : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_memdep_avm_readdata : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_memdep_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_memdep_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_memdep_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
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
            out_stall_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out_1 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_avg_B4_sr_0 is
        port (
            in_i_data_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_data_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_i_data_2 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_data_3 : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_i_data_4 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_data_5 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_data_6 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_data_7 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_data_8 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_data_9 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_data_10 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_data_11 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_o_data_2 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_3 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_o_data_4 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_5 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_6 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_7 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_8 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_9 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_10 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_11 : out std_logic_vector(31 downto 0);  -- Floating Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_avg_B5_sr_0 is
        port (
            in_i_data_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_avg_B0_runOnce is
        port (
            in_stall_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_avg_B1_start is
        port (
            in_feedback_in_1 : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_feedback_valid_in_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_iord_bl_do_i_fifodata : in std_logic_vector(127 downto 0);  -- Fixed Point
            in_iord_bl_do_i_fifovalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_pipeline_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_exiting_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_exiting_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_feedback_stall_out_1 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_intel_reserved_ffwd_0_0 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_intel_reserved_ffwd_1_0 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_iord_bl_do_o_fifoready : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_pipeline_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out_1 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_avg_B2 is
        port (
            in_feedback_in_10 : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_feedback_valid_in_10 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_forked15_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_forked15_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_pipeline_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exe124 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_c0_exe2 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exe3 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_exiting_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_exiting_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_feedback_stall_out_10 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_phi_pop10 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_pipeline_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out_1 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component bb_avg_B5 is
        port (
            in_feedback_stall_in_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_iowr_bl_return_i_fifoready : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_feedback_out_1 : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_feedback_valid_out_1 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_iowr_bl_return_o_fifodata : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_iowr_bl_return_o_fifovalid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_pipeline_keep_going13_avg_sr is
        port (
            in_i_data : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_pipeline_keep_going13_avg_valid_fifo is
        port (
            in_data_in : in std_logic_vector(1 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(1 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_pipeline_keep_going9_avg_sr is
        port (
            in_i_data : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_pipeline_keep_going9_avg_valid_fifo is
        port (
            in_data_in : in std_logic_vector(1 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(1 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_pipeline_keep_going_avg_sr is
        port (
            in_i_data : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_pipeline_keep_going_avg_valid_fifo is
        port (
            in_data_in : in std_logic_vector(1 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(1 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component loop_limiter_avg0 is
        port (
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall_exit : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid_exit : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component loop_limiter_avg1 is
        port (
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall_exit : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid_exit : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B2_sr_1_aunroll_x_out_o_data_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B2_sr_1_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B2_sr_1_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_c0_exit31_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_c0_exit31_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_avg_B3_aunroll_x_out_c0_exit31_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_c0_exit31_3 : STD_LOGIC_VECTOR (63 downto 0);
    signal bb_avg_B3_aunroll_x_out_c0_exit31_4 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_c0_exit31_5 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_c0_exit31_6 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_c0_exit31_7 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_c0_exit31_8 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_c0_exit31_9 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_c1_exit_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_c1_exit_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_avg_B3_aunroll_x_out_exiting_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_exiting_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_pipeline_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_stall_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_stall_out_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_address : STD_LOGIC_VECTOR (63 downto 0);
    signal bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_burstcount : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_byteenable : STD_LOGIC_VECTOR (7 downto 0);
    signal bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_writedata : STD_LOGIC_VECTOR (63 downto 0);
    signal bb_avg_B3_aunroll_x_out_valid_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_sr_1_aunroll_x_out_o_data_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_sr_1_aunroll_x_out_o_data_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_avg_B3_sr_1_aunroll_x_out_o_data_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_sr_1_aunroll_x_out_o_data_3 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_sr_1_aunroll_x_out_o_data_4 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_sr_1_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B3_sr_1_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_aunroll_x_out_feedback_out_10 : STD_LOGIC_VECTOR (7 downto 0);
    signal bb_avg_B4_aunroll_x_out_feedback_valid_out_10 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_aunroll_x_out_lsu_memdep_o_active : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_aunroll_x_out_memdep_avm_address : STD_LOGIC_VECTOR (63 downto 0);
    signal bb_avg_B4_aunroll_x_out_memdep_avm_burstcount : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_aunroll_x_out_memdep_avm_byteenable : STD_LOGIC_VECTOR (7 downto 0);
    signal bb_avg_B4_aunroll_x_out_memdep_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_aunroll_x_out_memdep_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_aunroll_x_out_memdep_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_aunroll_x_out_memdep_avm_writedata : STD_LOGIC_VECTOR (63 downto 0);
    signal bb_avg_B4_aunroll_x_out_stall_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_aunroll_x_out_valid_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_sr_0_aunroll_x_out_o_data_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_sr_0_aunroll_x_out_o_data_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_avg_B4_sr_0_aunroll_x_out_o_data_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_sr_0_aunroll_x_out_o_data_3 : STD_LOGIC_VECTOR (63 downto 0);
    signal bb_avg_B4_sr_0_aunroll_x_out_o_data_4 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_sr_0_aunroll_x_out_o_data_5 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_sr_0_aunroll_x_out_o_data_6 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_sr_0_aunroll_x_out_o_data_7 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_sr_0_aunroll_x_out_o_data_8 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_sr_0_aunroll_x_out_o_data_9 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_sr_0_aunroll_x_out_o_data_10 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_sr_0_aunroll_x_out_o_data_11 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_avg_B4_sr_0_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B4_sr_0_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B5_sr_0_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B5_sr_0_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_0_c_i2_0gr_x_q : STD_LOGIC_VECTOR (1 downto 0);
    signal bb_avg_B0_runOnce_out_stall_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B1_start_out_feedback_stall_out_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B1_start_out_intel_reserved_ffwd_0_0 : STD_LOGIC_VECTOR (63 downto 0);
    signal bb_avg_B1_start_out_intel_reserved_ffwd_1_0 : STD_LOGIC_VECTOR (63 downto 0);
    signal bb_avg_B1_start_out_iord_bl_do_o_fifoready : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B1_start_out_pipeline_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B1_start_out_stall_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B1_start_out_valid_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B2_out_c0_exe124 : STD_LOGIC_VECTOR (31 downto 0);
    signal bb_avg_B2_out_c0_exe2 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B2_out_c0_exe3 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B2_out_exiting_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B2_out_exiting_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B2_out_feedback_stall_out_10 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B2_out_memdep_phi_pop10 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B2_out_pipeline_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B2_out_stall_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B2_out_stall_out_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B2_out_valid_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B5_out_feedback_out_1 : STD_LOGIC_VECTOR (7 downto 0);
    signal bb_avg_B5_out_feedback_valid_out_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B5_out_iowr_bl_return_o_fifodata : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B5_out_iowr_bl_return_o_fifovalid : STD_LOGIC_VECTOR (0 downto 0);
    signal bb_avg_B5_out_stall_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal c_i32_undef_q : STD_LOGIC_VECTOR (31 downto 0);
    signal i_acl_pipeline_keep_going13_avg_sr_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pipeline_keep_going13_avg_sr_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pipeline_keep_going13_avg_valid_fifo_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pipeline_keep_going13_avg_valid_fifo_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pipeline_keep_going9_avg_sr_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pipeline_keep_going9_avg_sr_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pipeline_keep_going9_avg_valid_fifo_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pipeline_keep_going9_avg_valid_fifo_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pipeline_keep_going_avg_sr_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pipeline_keep_going_avg_sr_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pipeline_keep_going_avg_valid_fifo_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pipeline_keep_going_avg_valid_fifo_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal loop_limiter_avg0_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal loop_limiter_avg0_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal loop_limiter_avg1_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal loop_limiter_avg1_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- dupName_0_c_i2_0gr_x(CONSTANT,11)
    dupName_0_c_i2_0gr_x_q <= "00";

    -- i_acl_pipeline_keep_going13_avg_valid_fifo(BLACKBOX,34)
    thei_acl_pipeline_keep_going13_avg_valid_fifo : i_acl_pipeline_keep_going13_avg_valid_fifo
    PORT MAP (
        in_data_in => dupName_0_c_i2_0gr_x_q,
        in_stall_in => bb_avg_B1_start_out_stall_out_0,
        in_valid_in => i_acl_pipeline_keep_going13_avg_sr_out_o_valid,
        out_stall_out => i_acl_pipeline_keep_going13_avg_valid_fifo_out_stall_out,
        out_valid_out => i_acl_pipeline_keep_going13_avg_valid_fifo_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- i_acl_pipeline_keep_going9_avg_valid_fifo(BLACKBOX,36)
    thei_acl_pipeline_keep_going9_avg_valid_fifo : i_acl_pipeline_keep_going9_avg_valid_fifo
    PORT MAP (
        in_data_in => dupName_0_c_i2_0gr_x_q,
        in_stall_in => bb_avg_B2_out_stall_out_0,
        in_valid_in => i_acl_pipeline_keep_going9_avg_sr_out_o_valid,
        out_stall_out => i_acl_pipeline_keep_going9_avg_valid_fifo_out_stall_out,
        out_valid_out => i_acl_pipeline_keep_going9_avg_valid_fifo_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- i_acl_pipeline_keep_going_avg_valid_fifo(BLACKBOX,38)
    thei_acl_pipeline_keep_going_avg_valid_fifo : i_acl_pipeline_keep_going_avg_valid_fifo
    PORT MAP (
        in_data_in => dupName_0_c_i2_0gr_x_q,
        in_stall_in => bb_avg_B3_aunroll_x_out_stall_out_0,
        in_valid_in => i_acl_pipeline_keep_going_avg_sr_out_o_valid,
        out_stall_out => i_acl_pipeline_keep_going_avg_valid_fifo_out_stall_out,
        out_valid_out => i_acl_pipeline_keep_going_avg_valid_fifo_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- bb_avg_B4_sr_0_aunroll_x(BLACKBOX,6)
    thebb_avg_B4_sr_0_aunroll_x : bb_avg_B4_sr_0
    PORT MAP (
        in_i_data_0 => bb_avg_B3_aunroll_x_out_c0_exit31_0,
        in_i_data_1 => bb_avg_B3_aunroll_x_out_c0_exit31_1,
        in_i_data_2 => bb_avg_B3_aunroll_x_out_c0_exit31_2,
        in_i_data_3 => bb_avg_B3_aunroll_x_out_c0_exit31_3,
        in_i_data_4 => bb_avg_B3_aunroll_x_out_c0_exit31_4,
        in_i_data_5 => bb_avg_B3_aunroll_x_out_c0_exit31_5,
        in_i_data_6 => bb_avg_B3_aunroll_x_out_c0_exit31_6,
        in_i_data_7 => bb_avg_B3_aunroll_x_out_c0_exit31_7,
        in_i_data_8 => bb_avg_B3_aunroll_x_out_c0_exit31_8,
        in_i_data_9 => bb_avg_B3_aunroll_x_out_c0_exit31_9,
        in_i_data_10 => bb_avg_B3_aunroll_x_out_c1_exit_0,
        in_i_data_11 => bb_avg_B3_aunroll_x_out_c1_exit_1,
        in_i_stall => bb_avg_B4_aunroll_x_out_stall_out_0,
        in_i_valid => bb_avg_B3_aunroll_x_out_valid_out_0,
        out_o_data_0 => bb_avg_B4_sr_0_aunroll_x_out_o_data_0,
        out_o_data_1 => bb_avg_B4_sr_0_aunroll_x_out_o_data_1,
        out_o_data_2 => bb_avg_B4_sr_0_aunroll_x_out_o_data_2,
        out_o_data_3 => bb_avg_B4_sr_0_aunroll_x_out_o_data_3,
        out_o_data_4 => bb_avg_B4_sr_0_aunroll_x_out_o_data_4,
        out_o_data_5 => bb_avg_B4_sr_0_aunroll_x_out_o_data_5,
        out_o_data_6 => bb_avg_B4_sr_0_aunroll_x_out_o_data_6,
        out_o_data_7 => bb_avg_B4_sr_0_aunroll_x_out_o_data_7,
        out_o_data_8 => bb_avg_B4_sr_0_aunroll_x_out_o_data_8,
        out_o_data_9 => bb_avg_B4_sr_0_aunroll_x_out_o_data_9,
        out_o_data_10 => bb_avg_B4_sr_0_aunroll_x_out_o_data_10,
        out_o_data_11 => bb_avg_B4_sr_0_aunroll_x_out_o_data_11,
        out_o_stall => bb_avg_B4_sr_0_aunroll_x_out_o_stall,
        out_o_valid => bb_avg_B4_sr_0_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- i_acl_pipeline_keep_going_avg_sr(BLACKBOX,37)
    thei_acl_pipeline_keep_going_avg_sr : i_acl_pipeline_keep_going_avg_sr
    PORT MAP (
        in_i_data => GND_q,
        in_i_stall => i_acl_pipeline_keep_going_avg_valid_fifo_out_stall_out,
        in_i_valid => bb_avg_B3_aunroll_x_out_pipeline_valid_out,
        out_o_stall => i_acl_pipeline_keep_going_avg_sr_out_o_stall,
        out_o_valid => i_acl_pipeline_keep_going_avg_sr_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- c_i32_undef(CONSTANT,31)
    c_i32_undef_q <= "00000000000000000000000000000000";

    -- bb_avg_B3_aunroll_x(BLACKBOX,3)
    thebb_avg_B3_aunroll_x : bb_avg_B3
    PORT MAP (
        in_exitcond18_0 => GND_q,
        in_exitcond18_1 => bb_avg_B3_sr_1_aunroll_x_out_o_data_2,
        in_flush => in_start,
        in_forked16_0 => GND_q,
        in_forked16_1 => bb_avg_B3_sr_1_aunroll_x_out_o_data_0,
        in_i_03_pop917_0 => c_i32_undef_q,
        in_i_03_pop917_1 => bb_avg_B3_sr_1_aunroll_x_out_o_data_1,
        in_intel_reserved_ffwd_0_0 => bb_avg_B1_start_out_intel_reserved_ffwd_0_0,
        in_memdep_phi_pop1020_0 => GND_q,
        in_memdep_phi_pop1020_1 => bb_avg_B3_sr_1_aunroll_x_out_o_data_4,
        in_notexit1119_0 => GND_q,
        in_notexit1119_1 => bb_avg_B3_sr_1_aunroll_x_out_o_data_3,
        in_pipeline_stall_in => i_acl_pipeline_keep_going_avg_sr_out_o_stall,
        in_stall_in_0 => bb_avg_B4_sr_0_aunroll_x_out_o_stall,
        in_stall_in_1 => GND_q,
        in_unnamed_avg4_avm_readdata => in_unnamed_avg4_avm_readdata,
        in_unnamed_avg4_avm_readdatavalid => in_unnamed_avg4_avm_readdatavalid,
        in_unnamed_avg4_avm_waitrequest => in_unnamed_avg4_avm_waitrequest,
        in_unnamed_avg4_avm_writeack => in_unnamed_avg4_avm_writeack,
        in_valid_in_0 => i_acl_pipeline_keep_going_avg_valid_fifo_out_valid_out,
        in_valid_in_1 => bb_avg_B3_sr_1_aunroll_x_out_o_valid,
        out_c0_exit31_0 => bb_avg_B3_aunroll_x_out_c0_exit31_0,
        out_c0_exit31_1 => bb_avg_B3_aunroll_x_out_c0_exit31_1,
        out_c0_exit31_2 => bb_avg_B3_aunroll_x_out_c0_exit31_2,
        out_c0_exit31_3 => bb_avg_B3_aunroll_x_out_c0_exit31_3,
        out_c0_exit31_4 => bb_avg_B3_aunroll_x_out_c0_exit31_4,
        out_c0_exit31_5 => bb_avg_B3_aunroll_x_out_c0_exit31_5,
        out_c0_exit31_6 => bb_avg_B3_aunroll_x_out_c0_exit31_6,
        out_c0_exit31_7 => bb_avg_B3_aunroll_x_out_c0_exit31_7,
        out_c0_exit31_8 => bb_avg_B3_aunroll_x_out_c0_exit31_8,
        out_c0_exit31_9 => bb_avg_B3_aunroll_x_out_c0_exit31_9,
        out_c1_exit_0 => bb_avg_B3_aunroll_x_out_c1_exit_0,
        out_c1_exit_1 => bb_avg_B3_aunroll_x_out_c1_exit_1,
        out_exiting_stall_out => bb_avg_B3_aunroll_x_out_exiting_stall_out,
        out_exiting_valid_out => bb_avg_B3_aunroll_x_out_exiting_valid_out,
        out_pipeline_valid_out => bb_avg_B3_aunroll_x_out_pipeline_valid_out,
        out_stall_out_0 => bb_avg_B3_aunroll_x_out_stall_out_0,
        out_stall_out_1 => bb_avg_B3_aunroll_x_out_stall_out_1,
        out_unnamed_avg4_avm_address => bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_address,
        out_unnamed_avg4_avm_burstcount => bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_burstcount,
        out_unnamed_avg4_avm_byteenable => bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_byteenable,
        out_unnamed_avg4_avm_enable => bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_enable,
        out_unnamed_avg4_avm_read => bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_read,
        out_unnamed_avg4_avm_write => bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_write,
        out_unnamed_avg4_avm_writedata => bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_writedata,
        out_valid_out_0 => bb_avg_B3_aunroll_x_out_valid_out_0,
        clock => clock,
        resetn => resetn
    );

    -- bb_avg_B3_sr_1_aunroll_x(BLACKBOX,4)
    thebb_avg_B3_sr_1_aunroll_x : bb_avg_B3_sr_1
    PORT MAP (
        in_i_data_0 => VCC_q,
        in_i_data_1 => bb_avg_B2_out_c0_exe124,
        in_i_data_2 => bb_avg_B2_out_c0_exe2,
        in_i_data_3 => bb_avg_B2_out_c0_exe3,
        in_i_data_4 => bb_avg_B2_out_memdep_phi_pop10,
        in_i_stall => bb_avg_B3_aunroll_x_out_stall_out_1,
        in_i_valid => loop_limiter_avg1_out_o_valid,
        out_o_data_0 => bb_avg_B3_sr_1_aunroll_x_out_o_data_0,
        out_o_data_1 => bb_avg_B3_sr_1_aunroll_x_out_o_data_1,
        out_o_data_2 => bb_avg_B3_sr_1_aunroll_x_out_o_data_2,
        out_o_data_3 => bb_avg_B3_sr_1_aunroll_x_out_o_data_3,
        out_o_data_4 => bb_avg_B3_sr_1_aunroll_x_out_o_data_4,
        out_o_stall => bb_avg_B3_sr_1_aunroll_x_out_o_stall,
        out_o_valid => bb_avg_B3_sr_1_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- loop_limiter_avg1(BLACKBOX,58)
    theloop_limiter_avg1 : loop_limiter_avg1
    PORT MAP (
        in_i_stall => bb_avg_B3_sr_1_aunroll_x_out_o_stall,
        in_i_stall_exit => bb_avg_B3_aunroll_x_out_exiting_stall_out,
        in_i_valid => bb_avg_B2_out_valid_out_0,
        in_i_valid_exit => bb_avg_B3_aunroll_x_out_exiting_valid_out,
        out_o_stall => loop_limiter_avg1_out_o_stall,
        out_o_valid => loop_limiter_avg1_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- i_acl_pipeline_keep_going9_avg_sr(BLACKBOX,35)
    thei_acl_pipeline_keep_going9_avg_sr : i_acl_pipeline_keep_going9_avg_sr
    PORT MAP (
        in_i_data => GND_q,
        in_i_stall => i_acl_pipeline_keep_going9_avg_valid_fifo_out_stall_out,
        in_i_valid => bb_avg_B2_out_pipeline_valid_out,
        out_o_stall => i_acl_pipeline_keep_going9_avg_sr_out_o_stall,
        out_o_valid => i_acl_pipeline_keep_going9_avg_sr_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- bb_avg_B5_sr_0_aunroll_x(BLACKBOX,7)
    thebb_avg_B5_sr_0_aunroll_x : bb_avg_B5_sr_0
    PORT MAP (
        in_i_data_0 => GND_q,
        in_i_stall => bb_avg_B5_out_stall_out_0,
        in_i_valid => bb_avg_B4_aunroll_x_out_valid_out_0,
        out_o_stall => bb_avg_B5_sr_0_aunroll_x_out_o_stall,
        out_o_valid => bb_avg_B5_sr_0_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- bb_avg_B4_aunroll_x(BLACKBOX,5)
    thebb_avg_B4_aunroll_x : bb_avg_B4
    PORT MAP (
        in_c0_exit311_0_0 => bb_avg_B4_sr_0_aunroll_x_out_o_data_0,
        in_c0_exit311_0_1 => bb_avg_B4_sr_0_aunroll_x_out_o_data_1,
        in_c0_exit311_0_2 => bb_avg_B4_sr_0_aunroll_x_out_o_data_2,
        in_c0_exit311_0_3 => bb_avg_B4_sr_0_aunroll_x_out_o_data_3,
        in_c0_exit311_0_4 => bb_avg_B4_sr_0_aunroll_x_out_o_data_4,
        in_c0_exit311_0_5 => bb_avg_B4_sr_0_aunroll_x_out_o_data_5,
        in_c0_exit311_0_6 => bb_avg_B4_sr_0_aunroll_x_out_o_data_6,
        in_c0_exit311_0_7 => bb_avg_B4_sr_0_aunroll_x_out_o_data_7,
        in_c0_exit311_0_8 => bb_avg_B4_sr_0_aunroll_x_out_o_data_8,
        in_c0_exit311_0_9 => bb_avg_B4_sr_0_aunroll_x_out_o_data_9,
        in_c1_exit2_0_0 => bb_avg_B4_sr_0_aunroll_x_out_o_data_10,
        in_c1_exit2_0_1 => bb_avg_B4_sr_0_aunroll_x_out_o_data_11,
        in_feedback_stall_in_10 => bb_avg_B2_out_feedback_stall_out_10,
        in_flush => in_start,
        in_intel_reserved_ffwd_1_0 => bb_avg_B1_start_out_intel_reserved_ffwd_1_0,
        in_memdep_avm_readdata => in_memdep_avm_readdata,
        in_memdep_avm_readdatavalid => in_memdep_avm_readdatavalid,
        in_memdep_avm_waitrequest => in_memdep_avm_waitrequest,
        in_memdep_avm_writeack => in_memdep_avm_writeack,
        in_stall_in_0 => bb_avg_B5_sr_0_aunroll_x_out_o_stall,
        in_stall_in_1 => GND_q,
        in_valid_in_0 => bb_avg_B4_sr_0_aunroll_x_out_o_valid,
        out_feedback_out_10 => bb_avg_B4_aunroll_x_out_feedback_out_10,
        out_feedback_valid_out_10 => bb_avg_B4_aunroll_x_out_feedback_valid_out_10,
        out_lsu_memdep_o_active => bb_avg_B4_aunroll_x_out_lsu_memdep_o_active,
        out_memdep_avm_address => bb_avg_B4_aunroll_x_out_memdep_avm_address,
        out_memdep_avm_burstcount => bb_avg_B4_aunroll_x_out_memdep_avm_burstcount,
        out_memdep_avm_byteenable => bb_avg_B4_aunroll_x_out_memdep_avm_byteenable,
        out_memdep_avm_enable => bb_avg_B4_aunroll_x_out_memdep_avm_enable,
        out_memdep_avm_read => bb_avg_B4_aunroll_x_out_memdep_avm_read,
        out_memdep_avm_write => bb_avg_B4_aunroll_x_out_memdep_avm_write,
        out_memdep_avm_writedata => bb_avg_B4_aunroll_x_out_memdep_avm_writedata,
        out_stall_out_0 => bb_avg_B4_aunroll_x_out_stall_out_0,
        out_valid_out_0 => bb_avg_B4_aunroll_x_out_valid_out_0,
        clock => clock,
        resetn => resetn
    );

    -- bb_avg_B2(BLACKBOX,25)
    thebb_avg_B2 : bb_avg_B2
    PORT MAP (
        in_feedback_in_10 => bb_avg_B4_aunroll_x_out_feedback_out_10,
        in_feedback_valid_in_10 => bb_avg_B4_aunroll_x_out_feedback_valid_out_10,
        in_forked15_0 => GND_q,
        in_forked15_1 => bb_avg_B2_sr_1_aunroll_x_out_o_data_0,
        in_pipeline_stall_in => i_acl_pipeline_keep_going9_avg_sr_out_o_stall,
        in_stall_in_0 => loop_limiter_avg1_out_o_stall,
        in_valid_in_0 => i_acl_pipeline_keep_going9_avg_valid_fifo_out_valid_out,
        in_valid_in_1 => bb_avg_B2_sr_1_aunroll_x_out_o_valid,
        out_c0_exe124 => bb_avg_B2_out_c0_exe124,
        out_c0_exe2 => bb_avg_B2_out_c0_exe2,
        out_c0_exe3 => bb_avg_B2_out_c0_exe3,
        out_exiting_stall_out => bb_avg_B2_out_exiting_stall_out,
        out_exiting_valid_out => bb_avg_B2_out_exiting_valid_out,
        out_feedback_stall_out_10 => bb_avg_B2_out_feedback_stall_out_10,
        out_memdep_phi_pop10 => bb_avg_B2_out_memdep_phi_pop10,
        out_pipeline_valid_out => bb_avg_B2_out_pipeline_valid_out,
        out_stall_out_0 => bb_avg_B2_out_stall_out_0,
        out_stall_out_1 => bb_avg_B2_out_stall_out_1,
        out_valid_out_0 => bb_avg_B2_out_valid_out_0,
        clock => clock,
        resetn => resetn
    );

    -- bb_avg_B2_sr_1_aunroll_x(BLACKBOX,2)
    thebb_avg_B2_sr_1_aunroll_x : bb_avg_B2_sr_1
    PORT MAP (
        in_i_data_0 => VCC_q,
        in_i_stall => bb_avg_B2_out_stall_out_1,
        in_i_valid => loop_limiter_avg0_out_o_valid,
        out_o_data_0 => bb_avg_B2_sr_1_aunroll_x_out_o_data_0,
        out_o_stall => bb_avg_B2_sr_1_aunroll_x_out_o_stall,
        out_o_valid => bb_avg_B2_sr_1_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- loop_limiter_avg0(BLACKBOX,57)
    theloop_limiter_avg0 : loop_limiter_avg0
    PORT MAP (
        in_i_stall => bb_avg_B2_sr_1_aunroll_x_out_o_stall,
        in_i_stall_exit => bb_avg_B2_out_exiting_stall_out,
        in_i_valid => bb_avg_B1_start_out_valid_out_0,
        in_i_valid_exit => bb_avg_B2_out_exiting_valid_out,
        out_o_stall => loop_limiter_avg0_out_o_stall,
        out_o_valid => loop_limiter_avg0_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- i_acl_pipeline_keep_going13_avg_sr(BLACKBOX,33)
    thei_acl_pipeline_keep_going13_avg_sr : i_acl_pipeline_keep_going13_avg_sr
    PORT MAP (
        in_i_data => GND_q,
        in_i_stall => i_acl_pipeline_keep_going13_avg_valid_fifo_out_stall_out,
        in_i_valid => bb_avg_B1_start_out_pipeline_valid_out,
        out_o_stall => i_acl_pipeline_keep_going13_avg_sr_out_o_stall,
        out_o_valid => i_acl_pipeline_keep_going13_avg_sr_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- bb_avg_B5(BLACKBOX,26)
    thebb_avg_B5 : bb_avg_B5
    PORT MAP (
        in_feedback_stall_in_1 => bb_avg_B1_start_out_feedback_stall_out_1,
        in_iowr_bl_return_i_fifoready => in_iowr_bl_return_i_fifoready,
        in_stall_in_0 => GND_q,
        in_valid_in_0 => bb_avg_B5_sr_0_aunroll_x_out_o_valid,
        out_feedback_out_1 => bb_avg_B5_out_feedback_out_1,
        out_feedback_valid_out_1 => bb_avg_B5_out_feedback_valid_out_1,
        out_iowr_bl_return_o_fifodata => bb_avg_B5_out_iowr_bl_return_o_fifodata,
        out_iowr_bl_return_o_fifovalid => bb_avg_B5_out_iowr_bl_return_o_fifovalid,
        out_stall_out_0 => bb_avg_B5_out_stall_out_0,
        clock => clock,
        resetn => resetn
    );

    -- bb_avg_B1_start(BLACKBOX,24)
    thebb_avg_B1_start : bb_avg_B1_start
    PORT MAP (
        in_feedback_in_1 => bb_avg_B5_out_feedback_out_1,
        in_feedback_valid_in_1 => bb_avg_B5_out_feedback_valid_out_1,
        in_iord_bl_do_i_fifodata => in_iord_bl_do_i_fifodata,
        in_iord_bl_do_i_fifovalid => in_iord_bl_do_i_fifovalid,
        in_pipeline_stall_in => i_acl_pipeline_keep_going13_avg_sr_out_o_stall,
        in_stall_in_0 => loop_limiter_avg0_out_o_stall,
        in_valid_in_0 => i_acl_pipeline_keep_going13_avg_valid_fifo_out_valid_out,
        in_valid_in_1 => VCC_q,
        out_feedback_stall_out_1 => bb_avg_B1_start_out_feedback_stall_out_1,
        out_intel_reserved_ffwd_0_0 => bb_avg_B1_start_out_intel_reserved_ffwd_0_0,
        out_intel_reserved_ffwd_1_0 => bb_avg_B1_start_out_intel_reserved_ffwd_1_0,
        out_iord_bl_do_o_fifoready => bb_avg_B1_start_out_iord_bl_do_o_fifoready,
        out_pipeline_valid_out => bb_avg_B1_start_out_pipeline_valid_out,
        out_stall_out_0 => bb_avg_B1_start_out_stall_out_0,
        out_valid_out_0 => bb_avg_B1_start_out_valid_out_0,
        clock => clock,
        resetn => resetn
    );

    -- out_iord_bl_do_o_fifoready(GPOUT,59)
    out_iord_bl_do_o_fifoready <= bb_avg_B1_start_out_iord_bl_do_o_fifoready;

    -- out_iowr_bl_return_o_fifodata(GPOUT,60)
    out_iowr_bl_return_o_fifodata <= bb_avg_B5_out_iowr_bl_return_o_fifodata;

    -- out_iowr_bl_return_o_fifovalid(GPOUT,61)
    out_iowr_bl_return_o_fifovalid <= bb_avg_B5_out_iowr_bl_return_o_fifovalid;

    -- out_memdep_avm_address(GPOUT,62)
    out_memdep_avm_address <= bb_avg_B4_aunroll_x_out_memdep_avm_address;

    -- out_memdep_avm_burstcount(GPOUT,63)
    out_memdep_avm_burstcount <= bb_avg_B4_aunroll_x_out_memdep_avm_burstcount;

    -- out_memdep_avm_byteenable(GPOUT,64)
    out_memdep_avm_byteenable <= bb_avg_B4_aunroll_x_out_memdep_avm_byteenable;

    -- out_memdep_avm_enable(GPOUT,65)
    out_memdep_avm_enable <= bb_avg_B4_aunroll_x_out_memdep_avm_enable;

    -- out_memdep_avm_read(GPOUT,66)
    out_memdep_avm_read <= bb_avg_B4_aunroll_x_out_memdep_avm_read;

    -- out_memdep_avm_write(GPOUT,67)
    out_memdep_avm_write <= bb_avg_B4_aunroll_x_out_memdep_avm_write;

    -- out_memdep_avm_writedata(GPOUT,68)
    out_memdep_avm_writedata <= bb_avg_B4_aunroll_x_out_memdep_avm_writedata;

    -- out_o_active_memdep(GPOUT,69)
    out_o_active_memdep <= bb_avg_B4_aunroll_x_out_lsu_memdep_o_active;

    -- bb_avg_B0_runOnce(BLACKBOX,23)
    thebb_avg_B0_runOnce : bb_avg_B0_runOnce
    PORT MAP (
        in_stall_in_0 => GND_q,
        in_valid_in_0 => in_valid_in,
        out_stall_out_0 => bb_avg_B0_runOnce_out_stall_out_0,
        clock => clock,
        resetn => resetn
    );

    -- out_stall_out(GPOUT,70)
    out_stall_out <= bb_avg_B0_runOnce_out_stall_out_0;

    -- out_unnamed_avg4_avm_address(GPOUT,71)
    out_unnamed_avg4_avm_address <= bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_address;

    -- out_unnamed_avg4_avm_burstcount(GPOUT,72)
    out_unnamed_avg4_avm_burstcount <= bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_burstcount;

    -- out_unnamed_avg4_avm_byteenable(GPOUT,73)
    out_unnamed_avg4_avm_byteenable <= bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_byteenable;

    -- out_unnamed_avg4_avm_enable(GPOUT,74)
    out_unnamed_avg4_avm_enable <= bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_enable;

    -- out_unnamed_avg4_avm_read(GPOUT,75)
    out_unnamed_avg4_avm_read <= bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_read;

    -- out_unnamed_avg4_avm_write(GPOUT,76)
    out_unnamed_avg4_avm_write <= bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_write;

    -- out_unnamed_avg4_avm_writedata(GPOUT,77)
    out_unnamed_avg4_avm_writedata <= bb_avg_B3_aunroll_x_out_unnamed_avg4_avm_writedata;

    -- out_valid_out(GPOUT,78)
    out_valid_out <= GND_q;

END normal;
