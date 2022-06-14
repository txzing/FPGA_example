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

-- VHDL created from i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37
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

entity i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37 is
    port (
        in_c0_eni5_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_eni5_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_eni5_2 : in std_logic_vector(31 downto 0);  -- ufix32
        in_c0_eni5_3 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_eni5_4 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_eni5_5 : in std_logic_vector(0 downto 0);  -- ufix1
        in_i_valid : in std_logic_vector(0 downto 0);  -- ufix1
        in_intel_reserved_ffwd_0_0 : in std_logic_vector(63 downto 0);  -- ufix64
        out_c0_exi9_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exi9_1 : out std_logic_vector(31 downto 0);  -- ufix32
        out_c0_exi9_2 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exi9_3 : out std_logic_vector(63 downto 0);  -- ufix64
        out_c0_exi9_4 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exi9_5 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exi9_6 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exi9_7 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exi9_8 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exi9_9 : out std_logic_vector(0 downto 0);  -- ufix1
        out_o_valid : out std_logic_vector(0 downto 0);  -- ufix1
        out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_pipeline_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_pipeline_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37;

architecture normal of i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component i_acl_pipeline_keep_going_avg39 is
        port (
            in_data_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_initeration_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_initeration_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_not_exitcond_in : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_not_exitcond_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_pipeline_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_exiting_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_exiting_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_initeration_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_not_exitcond_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_pipeline_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_pop_i1_exitcond18_pop15_avg64 is
        port (
            in_data_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_dir : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_feedback_in_15 : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_feedback_valid_in_15 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_feedback_stall_out_15 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_pop_i1_memdep_phi_pop1020_pop17_avg49 is
        port (
            in_data_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_dir : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_feedback_in_17 : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_feedback_valid_in_17 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_feedback_stall_out_17 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_pop_i1_notexit1119_pop16_avg68 is
        port (
            in_data_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_dir : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_feedback_in_16 : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_feedback_valid_in_16 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_feedback_stall_out_16 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_pop_i32_i_03_pop917_pop14_avg43 is
        port (
            in_data_in : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_dir : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_feedback_in_14 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_feedback_valid_in_14 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_feedback_stall_out_14 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_pop_i32_j_11_pop13_avg41 is
        port (
            in_data_in : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_dir : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_feedback_in_13 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_feedback_valid_in_13 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_feedback_stall_out_13 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_pop_i4_fpgaindvars_iv_pop11_avg51 is
        port (
            in_data_in : in std_logic_vector(3 downto 0);  -- Fixed Point
            in_dir : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_feedback_in_11 : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_feedback_valid_in_11 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(3 downto 0);  -- Fixed Point
            out_feedback_stall_out_11 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_push_i1_exitcond18_push15_avg66 is
        port (
            in_data_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_feedback_stall_in_15 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_notexit : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_feedback_out_15 : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_feedback_valid_out_15 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_push_i1_memdep_phi_pop1020_push17_avg54 is
        port (
            in_data_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_feedback_stall_in_17 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_notexit : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_feedback_out_17 : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_feedback_valid_out_17 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_push_i1_notexit1119_push16_avg70 is
        port (
            in_data_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_feedback_stall_in_16 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_notexit : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_feedback_out_16 : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_feedback_valid_out_16 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_push_i1_notexitcond_avg60 is
        port (
            in_data_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_feedback_stall_in_3 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_feedback_out_3 : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_feedback_valid_out_3 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_push_i32_i_03_pop917_push14_avg56 is
        port (
            in_data_in : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_feedback_stall_in_14 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_notexit : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_feedback_out_14 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_feedback_valid_out_14 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_push_i32_j_11_push13_avg58 is
        port (
            in_data_in : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_feedback_stall_in_13 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_notexit : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_feedback_out_13 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_feedback_valid_out_13 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_push_i4_fpgaindvars_iv_push11_avg62 is
        port (
            in_data_in : in std_logic_vector(3 downto 0);  -- Fixed Point
            in_feedback_stall_in_11 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_notexit : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(3 downto 0);  -- Fixed Point
            out_feedback_out_11 : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_feedback_valid_out_11 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_ffwd_dst_x56_avg46 is
        port (
            in_intel_reserved_ffwd_0_0 : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_dest_data_out_0_0 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bgTrunc_i_add_avg_sel_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bgTrunc_i_fpgaindvars_iv_next_avg_sel_x_b : STD_LOGIC_VECTOR (3 downto 0);
    signal bgTrunc_i_inc_avg_sel_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal i_arrayidx_avg_avg48_dupName_0_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx_avg_avg48_mult_extender_x_q : STD_LOGIC_VECTOR (127 downto 0);
    signal i_arrayidx_avg_avg48_mult_multconst_x_q : STD_LOGIC_VECTOR (60 downto 0);
    signal i_arrayidx_avg_avg48_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx_avg_avg48_add_x_a : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx_avg_avg48_add_x_b : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx_avg_avg48_add_x_o : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx_avg_avg48_add_x_q : STD_LOGIC_VECTOR (64 downto 0);
    signal i_idxprom_avg_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal c_i32_1gr_q : STD_LOGIC_VECTOR (31 downto 0);
    signal c_i32_2gr_q : STD_LOGIC_VECTOR (31 downto 0);
    signal c_i32_32_q : STD_LOGIC_VECTOR (31 downto 0);
    signal c_i4_1gr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal c_i4_3gr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal i_acl_pipeline_keep_going_avg_out_exiting_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pipeline_keep_going_avg_out_exiting_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pipeline_keep_going_avg_out_not_exitcond_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pipeline_keep_going_avg_out_pipeline_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i1_exitcond18_pop15_avg_out_data_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i1_exitcond18_pop15_avg_out_feedback_stall_out_15 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i1_memdep_phi_pop1020_pop17_avg_out_data_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i1_memdep_phi_pop1020_pop17_avg_out_feedback_stall_out_17 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i1_notexit1119_pop16_avg_out_data_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i1_notexit1119_pop16_avg_out_feedback_stall_out_16 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_acl_pop_i32_i_03_pop917_pop14_avg_out_feedback_stall_out_14 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i32_j_11_pop13_avg_out_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_acl_pop_i32_j_11_pop13_avg_out_feedback_stall_out_13 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i4_fpgaindvars_iv_pop11_avg_out_data_out : STD_LOGIC_VECTOR (3 downto 0);
    signal i_acl_pop_i4_fpgaindvars_iv_pop11_avg_out_feedback_stall_out_11 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_push_i1_exitcond18_push15_avg_out_feedback_out_15 : STD_LOGIC_VECTOR (7 downto 0);
    signal i_acl_push_i1_exitcond18_push15_avg_out_feedback_valid_out_15 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_push_i1_memdep_phi_pop1020_push17_avg_out_feedback_out_17 : STD_LOGIC_VECTOR (7 downto 0);
    signal i_acl_push_i1_memdep_phi_pop1020_push17_avg_out_feedback_valid_out_17 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_push_i1_notexit1119_push16_avg_out_feedback_out_16 : STD_LOGIC_VECTOR (7 downto 0);
    signal i_acl_push_i1_notexit1119_push16_avg_out_feedback_valid_out_16 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_push_i1_notexitcond_avg_out_feedback_out_3 : STD_LOGIC_VECTOR (7 downto 0);
    signal i_acl_push_i1_notexitcond_avg_out_feedback_valid_out_3 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_push_i32_i_03_pop917_push14_avg_out_feedback_out_14 : STD_LOGIC_VECTOR (31 downto 0);
    signal i_acl_push_i32_i_03_pop917_push14_avg_out_feedback_valid_out_14 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_push_i32_j_11_push13_avg_out_feedback_out_13 : STD_LOGIC_VECTOR (31 downto 0);
    signal i_acl_push_i32_j_11_push13_avg_out_feedback_valid_out_13 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_push_i4_fpgaindvars_iv_push11_avg_out_feedback_out_11 : STD_LOGIC_VECTOR (7 downto 0);
    signal i_acl_push_i4_fpgaindvars_iv_push11_avg_out_feedback_valid_out_11 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_add_avg_a : STD_LOGIC_VECTOR (32 downto 0);
    signal i_add_avg_b : STD_LOGIC_VECTOR (32 downto 0);
    signal i_add_avg_o : STD_LOGIC_VECTOR (32 downto 0);
    signal i_add_avg_q : STD_LOGIC_VECTOR (32 downto 0);
    signal i_ffwd_dst_x56_avg_out_dest_data_out_0_0 : STD_LOGIC_VECTOR (63 downto 0);
    signal i_fpgaindvars_iv_next_avg_a : STD_LOGIC_VECTOR (4 downto 0);
    signal i_fpgaindvars_iv_next_avg_b : STD_LOGIC_VECTOR (4 downto 0);
    signal i_fpgaindvars_iv_next_avg_o : STD_LOGIC_VECTOR (4 downto 0);
    signal i_fpgaindvars_iv_next_avg_q : STD_LOGIC_VECTOR (4 downto 0);
    signal i_inc_avg_a : STD_LOGIC_VECTOR (32 downto 0);
    signal i_inc_avg_b : STD_LOGIC_VECTOR (32 downto 0);
    signal i_inc_avg_o : STD_LOGIC_VECTOR (32 downto 0);
    signal i_inc_avg_q : STD_LOGIC_VECTOR (32 downto 0);
    signal i_notexit_avg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_unnamed_avg45_a : STD_LOGIC_VECTOR (33 downto 0);
    signal i_unnamed_avg45_b : STD_LOGIC_VECTOR (33 downto 0);
    signal i_unnamed_avg45_o : STD_LOGIC_VECTOR (33 downto 0);
    signal i_unnamed_avg45_c : STD_LOGIC_VECTOR (0 downto 0);
    signal i_xor_avg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_align_12_q : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_align_12_qint : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_join_13_q : STD_LOGIC_VECTOR (56 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_align_14_q : STD_LOGIC_VECTOR (38 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_align_14_qint : STD_LOGIC_VECTOR (38 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_align_15_q : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_align_15_qint : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_join_16_q : STD_LOGIC_VECTOR (66 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_result_add_0_0_a : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_result_add_0_0_b : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_result_add_0_0_o : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_result_add_0_0_q : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_im0_shift0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_im0_shift0_qint : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_im3_shift0_q : STD_LOGIC_VECTOR (11 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_im3_shift0_qint : STD_LOGIC_VECTOR (11 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_im6_shift0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_im6_shift0_qint : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_im9_shift0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_im9_shift0_qint : STD_LOGIC_VECTOR (19 downto 0);
    signal i_exitcond3_avg_cmp_sign_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_bs1_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_bs1_merged_bit_select_c : STD_LOGIC_VECTOR (9 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_bs1_merged_bit_select_d : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx_avg_avg48_mult_x_bs1_merged_bit_select_e : STD_LOGIC_VECTOR (17 downto 0);
    signal redist0_i_exitcond3_avg_cmp_sign_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_i_notexit_avg_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_i_acl_pop_i32_j_11_pop13_avg_out_data_out_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist4_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_15_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist5_i_acl_pop_i1_notexit1119_pop16_avg_out_data_out_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist6_i_acl_pop_i1_memdep_phi_pop1020_pop17_avg_out_data_out_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_i_acl_pop_i1_exitcond18_pop15_avg_out_data_out_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_sync_in_aunroll_x_in_c0_eni5_1_12_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist9_sync_in_aunroll_x_in_c0_eni5_1_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_sync_in_aunroll_x_in_c0_eni5_3_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist11_sync_in_aunroll_x_in_c0_eni5_4_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_sync_in_aunroll_x_in_c0_eni5_5_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_sync_in_aunroll_x_in_i_valid_12_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist14_sync_in_aunroll_x_in_i_valid_13_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist15_sync_in_aunroll_x_in_i_valid_15_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist16_i_arrayidx_avg_avg48_trunc_sel_x_b_1_q : STD_LOGIC_VECTOR (63 downto 0);
    signal redist17_bgTrunc_i_add_avg_sel_x_b_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_outputreg_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_reset0 : std_logic;
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_ia : STD_LOGIC_VECTOR (31 downto 0);
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_aa : STD_LOGIC_VECTOR (3 downto 0);
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_ab : STD_LOGIC_VECTOR (3 downto 0);
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_iq : STD_LOGIC_VECTOR (31 downto 0);
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_i : UNSIGNED (3 downto 0);
    attribute preserve : boolean;
    attribute preserve of redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_i : signal is true;
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_eq : std_logic;
    attribute preserve of redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_eq : signal is true;
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_wraddr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_last_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_cmp_b : STD_LOGIC_VECTOR (4 downto 0);
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge : boolean;
    attribute dont_merge of redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_sticky_ena_q : signal is true;
    signal redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist13_sync_in_aunroll_x_in_i_valid_12(DELAY,117)
    redist13_sync_in_aunroll_x_in_i_valid_12 : dspba_delay
    GENERIC MAP ( width => 1, depth => 12, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_i_valid, xout => redist13_sync_in_aunroll_x_in_i_valid_12_q, clk => clock, aclr => resetn );

    -- redist14_sync_in_aunroll_x_in_i_valid_13(DELAY,118)
    redist14_sync_in_aunroll_x_in_i_valid_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist13_sync_in_aunroll_x_in_i_valid_12_q, xout => redist14_sync_in_aunroll_x_in_i_valid_13_q, clk => clock, aclr => resetn );

    -- redist15_sync_in_aunroll_x_in_i_valid_15(DELAY,119)
    redist15_sync_in_aunroll_x_in_i_valid_15 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist14_sync_in_aunroll_x_in_i_valid_13_q, xout => redist15_sync_in_aunroll_x_in_i_valid_15_q, clk => clock, aclr => resetn );

    -- i_acl_push_i1_notexit1119_push16_avg(BLACKBOX,55)@16
    -- out out_feedback_out_16@20000000
    -- out out_feedback_valid_out_16@20000000
    thei_acl_push_i1_notexit1119_push16_avg : i_acl_push_i1_notexit1119_push16_avg70
    PORT MAP (
        in_data_in => redist5_i_acl_pop_i1_notexit1119_pop16_avg_out_data_out_2_q,
        in_feedback_stall_in_16 => i_acl_pop_i1_notexit1119_pop16_avg_out_feedback_stall_out_16,
        in_notexit => redist1_i_notexit_avg_q_2_q,
        in_stall_in => GND_q,
        in_valid_in => redist15_sync_in_aunroll_x_in_i_valid_15_q,
        out_feedback_out_16 => i_acl_push_i1_notexit1119_push16_avg_out_feedback_out_16,
        out_feedback_valid_out_16 => i_acl_push_i1_notexit1119_push16_avg_out_feedback_valid_out_16,
        clock => clock,
        resetn => resetn
    );

    -- redist8_sync_in_aunroll_x_in_c0_eni5_1_12(DELAY,112)
    redist8_sync_in_aunroll_x_in_c0_eni5_1_12 : dspba_delay
    GENERIC MAP ( width => 1, depth => 12, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_c0_eni5_1, xout => redist8_sync_in_aunroll_x_in_c0_eni5_1_12_q, clk => clock, aclr => resetn );

    -- redist9_sync_in_aunroll_x_in_c0_eni5_1_13(DELAY,113)
    redist9_sync_in_aunroll_x_in_c0_eni5_1_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist8_sync_in_aunroll_x_in_c0_eni5_1_12_q, xout => redist9_sync_in_aunroll_x_in_c0_eni5_1_13_q, clk => clock, aclr => resetn );

    -- redist12_sync_in_aunroll_x_in_c0_eni5_5_13(DELAY,116)
    redist12_sync_in_aunroll_x_in_c0_eni5_5_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 13, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_c0_eni5_5, xout => redist12_sync_in_aunroll_x_in_c0_eni5_5_13_q, clk => clock, aclr => resetn );

    -- i_acl_pop_i1_notexit1119_pop16_avg(BLACKBOX,49)@14
    -- out out_feedback_stall_out_16@20000000
    thei_acl_pop_i1_notexit1119_pop16_avg : i_acl_pop_i1_notexit1119_pop16_avg68
    PORT MAP (
        in_data_in => redist12_sync_in_aunroll_x_in_c0_eni5_5_13_q,
        in_dir => redist9_sync_in_aunroll_x_in_c0_eni5_1_13_q,
        in_feedback_in_16 => i_acl_push_i1_notexit1119_push16_avg_out_feedback_out_16,
        in_feedback_valid_in_16 => i_acl_push_i1_notexit1119_push16_avg_out_feedback_valid_out_16,
        in_predicate => GND_q,
        in_stall_in => GND_q,
        in_valid_in => redist14_sync_in_aunroll_x_in_i_valid_13_q,
        out_data_out => i_acl_pop_i1_notexit1119_pop16_avg_out_data_out,
        out_feedback_stall_out_16 => i_acl_pop_i1_notexit1119_pop16_avg_out_feedback_stall_out_16,
        clock => clock,
        resetn => resetn
    );

    -- redist5_i_acl_pop_i1_notexit1119_pop16_avg_out_data_out_2(DELAY,109)
    redist5_i_acl_pop_i1_notexit1119_pop16_avg_out_data_out_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => i_acl_pop_i1_notexit1119_pop16_avg_out_data_out, xout => redist5_i_acl_pop_i1_notexit1119_pop16_avg_out_data_out_2_q, clk => clock, aclr => resetn );

    -- i_acl_push_i1_exitcond18_push15_avg(BLACKBOX,53)@16
    -- out out_feedback_out_15@20000000
    -- out out_feedback_valid_out_15@20000000
    thei_acl_push_i1_exitcond18_push15_avg : i_acl_push_i1_exitcond18_push15_avg66
    PORT MAP (
        in_data_in => redist7_i_acl_pop_i1_exitcond18_pop15_avg_out_data_out_2_q,
        in_feedback_stall_in_15 => i_acl_pop_i1_exitcond18_pop15_avg_out_feedback_stall_out_15,
        in_notexit => redist1_i_notexit_avg_q_2_q,
        in_stall_in => GND_q,
        in_valid_in => redist15_sync_in_aunroll_x_in_i_valid_15_q,
        out_feedback_out_15 => i_acl_push_i1_exitcond18_push15_avg_out_feedback_out_15,
        out_feedback_valid_out_15 => i_acl_push_i1_exitcond18_push15_avg_out_feedback_valid_out_15,
        clock => clock,
        resetn => resetn
    );

    -- redist11_sync_in_aunroll_x_in_c0_eni5_4_13(DELAY,115)
    redist11_sync_in_aunroll_x_in_c0_eni5_4_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 13, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_c0_eni5_4, xout => redist11_sync_in_aunroll_x_in_c0_eni5_4_13_q, clk => clock, aclr => resetn );

    -- i_acl_pop_i1_exitcond18_pop15_avg(BLACKBOX,47)@14
    -- out out_feedback_stall_out_15@20000000
    thei_acl_pop_i1_exitcond18_pop15_avg : i_acl_pop_i1_exitcond18_pop15_avg64
    PORT MAP (
        in_data_in => redist11_sync_in_aunroll_x_in_c0_eni5_4_13_q,
        in_dir => redist9_sync_in_aunroll_x_in_c0_eni5_1_13_q,
        in_feedback_in_15 => i_acl_push_i1_exitcond18_push15_avg_out_feedback_out_15,
        in_feedback_valid_in_15 => i_acl_push_i1_exitcond18_push15_avg_out_feedback_valid_out_15,
        in_predicate => GND_q,
        in_stall_in => GND_q,
        in_valid_in => redist14_sync_in_aunroll_x_in_i_valid_13_q,
        out_data_out => i_acl_pop_i1_exitcond18_pop15_avg_out_data_out,
        out_feedback_stall_out_15 => i_acl_pop_i1_exitcond18_pop15_avg_out_feedback_stall_out_15,
        clock => clock,
        resetn => resetn
    );

    -- redist7_i_acl_pop_i1_exitcond18_pop15_avg_out_data_out_2(DELAY,111)
    redist7_i_acl_pop_i1_exitcond18_pop15_avg_out_data_out_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => i_acl_pop_i1_exitcond18_pop15_avg_out_data_out, xout => redist7_i_acl_pop_i1_exitcond18_pop15_avg_out_data_out_2_q, clk => clock, aclr => resetn );

    -- c_i4_1gr(CONSTANT,43)
    c_i4_1gr_q <= "1111";

    -- i_fpgaindvars_iv_next_avg(ADD,63)@14
    i_fpgaindvars_iv_next_avg_a <= STD_LOGIC_VECTOR("0" & i_acl_pop_i4_fpgaindvars_iv_pop11_avg_out_data_out);
    i_fpgaindvars_iv_next_avg_b <= STD_LOGIC_VECTOR("0" & c_i4_1gr_q);
    i_fpgaindvars_iv_next_avg_o <= STD_LOGIC_VECTOR(UNSIGNED(i_fpgaindvars_iv_next_avg_a) + UNSIGNED(i_fpgaindvars_iv_next_avg_b));
    i_fpgaindvars_iv_next_avg_q <= i_fpgaindvars_iv_next_avg_o(4 downto 0);

    -- bgTrunc_i_fpgaindvars_iv_next_avg_sel_x(BITSELECT,3)@14
    bgTrunc_i_fpgaindvars_iv_next_avg_sel_x_b <= i_fpgaindvars_iv_next_avg_q(3 downto 0);

    -- i_acl_push_i4_fpgaindvars_iv_push11_avg(BLACKBOX,59)@14
    -- out out_feedback_out_11@20000000
    -- out out_feedback_valid_out_11@20000000
    thei_acl_push_i4_fpgaindvars_iv_push11_avg : i_acl_push_i4_fpgaindvars_iv_push11_avg62
    PORT MAP (
        in_data_in => bgTrunc_i_fpgaindvars_iv_next_avg_sel_x_b,
        in_feedback_stall_in_11 => i_acl_pop_i4_fpgaindvars_iv_pop11_avg_out_feedback_stall_out_11,
        in_notexit => i_notexit_avg_q,
        in_stall_in => GND_q,
        in_valid_in => redist14_sync_in_aunroll_x_in_i_valid_13_q,
        out_feedback_out_11 => i_acl_push_i4_fpgaindvars_iv_push11_avg_out_feedback_out_11,
        out_feedback_valid_out_11 => i_acl_push_i4_fpgaindvars_iv_push11_avg_out_feedback_valid_out_11,
        clock => clock,
        resetn => resetn
    );

    -- c_i4_3gr(CONSTANT,44)
    c_i4_3gr_q <= "0011";

    -- i_acl_pop_i4_fpgaindvars_iv_pop11_avg(BLACKBOX,52)@14
    -- out out_feedback_stall_out_11@20000000
    thei_acl_pop_i4_fpgaindvars_iv_pop11_avg : i_acl_pop_i4_fpgaindvars_iv_pop11_avg51
    PORT MAP (
        in_data_in => c_i4_3gr_q,
        in_dir => redist9_sync_in_aunroll_x_in_c0_eni5_1_13_q,
        in_feedback_in_11 => i_acl_push_i4_fpgaindvars_iv_push11_avg_out_feedback_out_11,
        in_feedback_valid_in_11 => i_acl_push_i4_fpgaindvars_iv_push11_avg_out_feedback_valid_out_11,
        in_predicate => GND_q,
        in_stall_in => GND_q,
        in_valid_in => redist14_sync_in_aunroll_x_in_i_valid_13_q,
        out_data_out => i_acl_pop_i4_fpgaindvars_iv_pop11_avg_out_data_out,
        out_feedback_stall_out_11 => i_acl_pop_i4_fpgaindvars_iv_pop11_avg_out_feedback_stall_out_11,
        clock => clock,
        resetn => resetn
    );

    -- i_exitcond3_avg_cmp_sign(LOGICAL,101)@14
    i_exitcond3_avg_cmp_sign_q <= STD_LOGIC_VECTOR(i_acl_pop_i4_fpgaindvars_iv_pop11_avg_out_data_out(3 downto 3));

    -- i_notexit_avg(LOGICAL,67)@14
    i_notexit_avg_q <= i_exitcond3_avg_cmp_sign_q xor VCC_q;

    -- redist1_i_notexit_avg_q_2(DELAY,105)
    redist1_i_notexit_avg_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => i_notexit_avg_q, xout => redist1_i_notexit_avg_q_2_q, clk => clock, aclr => resetn );

    -- redist0_i_exitcond3_avg_cmp_sign_q_2(DELAY,104)
    redist0_i_exitcond3_avg_cmp_sign_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => i_exitcond3_avg_cmp_sign_q, xout => redist0_i_exitcond3_avg_cmp_sign_q_2_q, clk => clock, aclr => resetn );

    -- i_acl_push_i1_memdep_phi_pop1020_push17_avg(BLACKBOX,54)@16
    -- out out_feedback_out_17@20000000
    -- out out_feedback_valid_out_17@20000000
    thei_acl_push_i1_memdep_phi_pop1020_push17_avg : i_acl_push_i1_memdep_phi_pop1020_push17_avg54
    PORT MAP (
        in_data_in => redist6_i_acl_pop_i1_memdep_phi_pop1020_pop17_avg_out_data_out_2_q,
        in_feedback_stall_in_17 => i_acl_pop_i1_memdep_phi_pop1020_pop17_avg_out_feedback_stall_out_17,
        in_notexit => redist1_i_notexit_avg_q_2_q,
        in_stall_in => GND_q,
        in_valid_in => redist15_sync_in_aunroll_x_in_i_valid_15_q,
        out_feedback_out_17 => i_acl_push_i1_memdep_phi_pop1020_push17_avg_out_feedback_out_17,
        out_feedback_valid_out_17 => i_acl_push_i1_memdep_phi_pop1020_push17_avg_out_feedback_valid_out_17,
        clock => clock,
        resetn => resetn
    );

    -- redist10_sync_in_aunroll_x_in_c0_eni5_3_13(DELAY,114)
    redist10_sync_in_aunroll_x_in_c0_eni5_3_13 : dspba_delay
    GENERIC MAP ( width => 1, depth => 13, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_c0_eni5_3, xout => redist10_sync_in_aunroll_x_in_c0_eni5_3_13_q, clk => clock, aclr => resetn );

    -- i_acl_pop_i1_memdep_phi_pop1020_pop17_avg(BLACKBOX,48)@14
    -- out out_feedback_stall_out_17@20000000
    thei_acl_pop_i1_memdep_phi_pop1020_pop17_avg : i_acl_pop_i1_memdep_phi_pop1020_pop17_avg49
    PORT MAP (
        in_data_in => redist10_sync_in_aunroll_x_in_c0_eni5_3_13_q,
        in_dir => redist9_sync_in_aunroll_x_in_c0_eni5_1_13_q,
        in_feedback_in_17 => i_acl_push_i1_memdep_phi_pop1020_push17_avg_out_feedback_out_17,
        in_feedback_valid_in_17 => i_acl_push_i1_memdep_phi_pop1020_push17_avg_out_feedback_valid_out_17,
        in_predicate => GND_q,
        in_stall_in => GND_q,
        in_valid_in => redist14_sync_in_aunroll_x_in_i_valid_13_q,
        out_data_out => i_acl_pop_i1_memdep_phi_pop1020_pop17_avg_out_data_out,
        out_feedback_stall_out_17 => i_acl_pop_i1_memdep_phi_pop1020_pop17_avg_out_feedback_stall_out_17,
        clock => clock,
        resetn => resetn
    );

    -- redist6_i_acl_pop_i1_memdep_phi_pop1020_pop17_avg_out_data_out_2(DELAY,110)
    redist6_i_acl_pop_i1_memdep_phi_pop1020_pop17_avg_out_data_out_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => i_acl_pop_i1_memdep_phi_pop1020_pop17_avg_out_data_out, xout => redist6_i_acl_pop_i1_memdep_phi_pop1020_pop17_avg_out_data_out_2_q, clk => clock, aclr => resetn );

    -- i_xor_avg(LOGICAL,69)@16
    i_xor_avg_q <= i_unnamed_avg45_c xor VCC_q;

    -- i_arrayidx_avg_avg48_mult_multconst_x(CONSTANT,25)
    i_arrayidx_avg_avg48_mult_multconst_x_q <= "0000000000000000000000000000000000000000000000000000000000000";

    -- redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_notEnable(LOGICAL,129)
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_nor(LOGICAL,130)
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_nor_q <= not (redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_notEnable_q or redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_sticky_ena_q);

    -- redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_last(CONSTANT,126)
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_last_q <= "01001";

    -- redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_cmp(LOGICAL,127)
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_cmp_b <= STD_LOGIC_VECTOR("0" & redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_q);
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_cmp_q <= "1" WHEN redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_last_q = redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_cmp_b ELSE "0";

    -- redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_cmpReg(REG,128)
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_cmpReg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_cmpReg_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_cmpReg_q <= STD_LOGIC_VECTOR(redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_cmp_q);
        END IF;
    END PROCESS;

    -- redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_sticky_ena(REG,131)
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_sticky_ena_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_sticky_ena_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_nor_q = "1") THEN
                redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_sticky_ena_q <= STD_LOGIC_VECTOR(redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_enaAnd(LOGICAL,132)
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_enaAnd_q <= redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_sticky_ena_q and VCC_q;

    -- redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt(COUNTER,124)
    -- low=0, high=10, step=1, init=0
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_i <= TO_UNSIGNED(0, 4);
            redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_eq <= '0';
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_i = TO_UNSIGNED(9, 4)) THEN
                redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_eq <= '1';
            ELSE
                redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_eq <= '0';
            END IF;
            IF (redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_eq = '1') THEN
                redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_i <= redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_i + 6;
            ELSE
                redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_i <= redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_i, 4)));

    -- i_acl_push_i32_i_03_pop917_push14_avg(BLACKBOX,57)@16
    -- out out_feedback_out_14@20000000
    -- out out_feedback_valid_out_14@20000000
    thei_acl_push_i32_i_03_pop917_push14_avg : i_acl_push_i32_i_03_pop917_push14_avg56
    PORT MAP (
        in_data_in => redist4_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_15_q,
        in_feedback_stall_in_14 => i_acl_pop_i32_i_03_pop917_pop14_avg_out_feedback_stall_out_14,
        in_notexit => redist1_i_notexit_avg_q_2_q,
        in_stall_in => GND_q,
        in_valid_in => redist15_sync_in_aunroll_x_in_i_valid_15_q,
        out_feedback_out_14 => i_acl_push_i32_i_03_pop917_push14_avg_out_feedback_out_14,
        out_feedback_valid_out_14 => i_acl_push_i32_i_03_pop917_push14_avg_out_feedback_valid_out_14,
        clock => clock,
        resetn => resetn
    );

    -- i_acl_pop_i32_i_03_pop917_pop14_avg(BLACKBOX,50)@1
    -- out out_feedback_stall_out_14@20000000
    thei_acl_pop_i32_i_03_pop917_pop14_avg : i_acl_pop_i32_i_03_pop917_pop14_avg43
    PORT MAP (
        in_data_in => in_c0_eni5_2,
        in_dir => in_c0_eni5_1,
        in_feedback_in_14 => i_acl_push_i32_i_03_pop917_push14_avg_out_feedback_out_14,
        in_feedback_valid_in_14 => i_acl_push_i32_i_03_pop917_push14_avg_out_feedback_valid_out_14,
        in_predicate => GND_q,
        in_stall_in => GND_q,
        in_valid_in => in_i_valid,
        out_data_out => i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out,
        out_feedback_stall_out_14 => i_acl_pop_i32_i_03_pop917_pop14_avg_out_feedback_stall_out_14,
        clock => clock,
        resetn => resetn
    );

    -- redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_wraddr(REG,125)
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_wraddr_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_wraddr_q <= "1010";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_wraddr_q <= STD_LOGIC_VECTOR(redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem(DUALMEM,123)
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_ia <= STD_LOGIC_VECTOR(i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out);
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_aa <= redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_wraddr_q;
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_ab <= redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_rdcnt_q;
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_reset0 <= not (resetn);
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 32,
        widthad_a => 4,
        numwords_a => 11,
        width_b => 32,
        widthad_b => 4,
        numwords_b => 11,
        lpm_type => "altera_syncram",
        width_byteena_a => 1,
        address_reg_b => "CLOCK0",
        indata_reg_b => "CLOCK0",
        rdcontrol_reg_b => "CLOCK0",
        byteena_reg_b => "CLOCK0",
        outdata_reg_b => "CLOCK1",
        outdata_aclr_b => "CLEAR1",
        clock_enable_input_a => "NORMAL",
        clock_enable_input_b => "NORMAL",
        clock_enable_output_b => "NORMAL",
        read_during_write_mode_mixed_ports => "DONT_CARE",
        power_up_uninitialized => "TRUE",
        intended_device_family => "Cyclone V"
    )
    PORT MAP (
        clocken1 => redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clock,
        aclr1 => redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_reset0,
        clock1 => clock,
        address_a => redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_aa,
        data_a => redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_ab,
        q_b => redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_iq
    );
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_q <= redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_iq(31 downto 0);

    -- redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_outputreg(DELAY,122)
    redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_outputreg : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_mem_q, xout => redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_outputreg_q, clk => clock, aclr => resetn );

    -- c_i32_1gr(CONSTANT,39)
    c_i32_1gr_q <= "00000000000000000000000000000001";

    -- i_inc_avg(ADD,66)@14
    i_inc_avg_a <= STD_LOGIC_VECTOR("0" & redist2_i_acl_pop_i32_j_11_pop13_avg_out_data_out_1_q);
    i_inc_avg_b <= STD_LOGIC_VECTOR("0" & c_i32_1gr_q);
    i_inc_avg_o <= STD_LOGIC_VECTOR(UNSIGNED(i_inc_avg_a) + UNSIGNED(i_inc_avg_b));
    i_inc_avg_q <= i_inc_avg_o(32 downto 0);

    -- bgTrunc_i_inc_avg_sel_x(BITSELECT,4)@14
    bgTrunc_i_inc_avg_sel_x_b <= i_inc_avg_q(31 downto 0);

    -- i_acl_push_i32_j_11_push13_avg(BLACKBOX,58)@14
    -- out out_feedback_out_13@20000000
    -- out out_feedback_valid_out_13@20000000
    thei_acl_push_i32_j_11_push13_avg : i_acl_push_i32_j_11_push13_avg58
    PORT MAP (
        in_data_in => bgTrunc_i_inc_avg_sel_x_b,
        in_feedback_stall_in_13 => i_acl_pop_i32_j_11_pop13_avg_out_feedback_stall_out_13,
        in_notexit => i_notexit_avg_q,
        in_stall_in => GND_q,
        in_valid_in => redist14_sync_in_aunroll_x_in_i_valid_13_q,
        out_feedback_out_13 => i_acl_push_i32_j_11_push13_avg_out_feedback_out_13,
        out_feedback_valid_out_13 => i_acl_push_i32_j_11_push13_avg_out_feedback_valid_out_13,
        clock => clock,
        resetn => resetn
    );

    -- c_i32_2gr(CONSTANT,40)
    c_i32_2gr_q <= "11111111111111111111111111111110";

    -- i_acl_pop_i32_j_11_pop13_avg(BLACKBOX,51)@13
    -- out out_feedback_stall_out_13@20000000
    thei_acl_pop_i32_j_11_pop13_avg : i_acl_pop_i32_j_11_pop13_avg41
    PORT MAP (
        in_data_in => c_i32_2gr_q,
        in_dir => redist8_sync_in_aunroll_x_in_c0_eni5_1_12_q,
        in_feedback_in_13 => i_acl_push_i32_j_11_push13_avg_out_feedback_out_13,
        in_feedback_valid_in_13 => i_acl_push_i32_j_11_push13_avg_out_feedback_valid_out_13,
        in_predicate => GND_q,
        in_stall_in => GND_q,
        in_valid_in => redist13_sync_in_aunroll_x_in_i_valid_12_q,
        out_data_out => i_acl_pop_i32_j_11_pop13_avg_out_data_out,
        out_feedback_stall_out_13 => i_acl_pop_i32_j_11_pop13_avg_out_feedback_stall_out_13,
        clock => clock,
        resetn => resetn
    );

    -- redist2_i_acl_pop_i32_j_11_pop13_avg_out_data_out_1(DELAY,106)
    redist2_i_acl_pop_i32_j_11_pop13_avg_out_data_out_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => i_acl_pop_i32_j_11_pop13_avg_out_data_out, xout => redist2_i_acl_pop_i32_j_11_pop13_avg_out_data_out_1_q, clk => clock, aclr => resetn );

    -- i_add_avg(ADD,60)@14
    i_add_avg_a <= STD_LOGIC_VECTOR("0" & redist2_i_acl_pop_i32_j_11_pop13_avg_out_data_out_1_q);
    i_add_avg_b <= STD_LOGIC_VECTOR("0" & redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_outputreg_q);
    i_add_avg_o <= STD_LOGIC_VECTOR(UNSIGNED(i_add_avg_a) + UNSIGNED(i_add_avg_b));
    i_add_avg_q <= i_add_avg_o(32 downto 0);

    -- bgTrunc_i_add_avg_sel_x(BITSELECT,2)@14
    bgTrunc_i_add_avg_sel_x_b <= i_add_avg_q(31 downto 0);

    -- redist17_bgTrunc_i_add_avg_sel_x_b_1(DELAY,121)
    redist17_bgTrunc_i_add_avg_sel_x_b_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => bgTrunc_i_add_avg_sel_x_b, xout => redist17_bgTrunc_i_add_avg_sel_x_b_1_q, clk => clock, aclr => resetn );

    -- i_idxprom_avg_sel_x(BITSELECT,31)@15
    i_idxprom_avg_sel_x_b <= STD_LOGIC_VECTOR(std_logic_vector(resize(signed(redist17_bgTrunc_i_add_avg_sel_x_b_1_q(31 downto 0)), 64)));

    -- i_arrayidx_avg_avg48_mult_x_bs1_merged_bit_select(BITSELECT,103)@15
    i_arrayidx_avg_avg48_mult_x_bs1_merged_bit_select_b <= i_idxprom_avg_sel_x_b(17 downto 0);
    i_arrayidx_avg_avg48_mult_x_bs1_merged_bit_select_c <= i_idxprom_avg_sel_x_b(63 downto 54);
    i_arrayidx_avg_avg48_mult_x_bs1_merged_bit_select_d <= i_idxprom_avg_sel_x_b(35 downto 18);
    i_arrayidx_avg_avg48_mult_x_bs1_merged_bit_select_e <= i_idxprom_avg_sel_x_b(53 downto 36);

    -- i_arrayidx_avg_avg48_mult_x_im3_shift0(BITSHIFT,98)@15
    i_arrayidx_avg_avg48_mult_x_im3_shift0_qint <= i_arrayidx_avg_avg48_mult_x_bs1_merged_bit_select_c & "00";
    i_arrayidx_avg_avg48_mult_x_im3_shift0_q <= i_arrayidx_avg_avg48_mult_x_im3_shift0_qint(11 downto 0);

    -- i_arrayidx_avg_avg48_mult_x_align_15(BITSHIFT,90)@15
    i_arrayidx_avg_avg48_mult_x_align_15_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx_avg_avg48_mult_x_im3_shift0_q) & "000000000000000";
    i_arrayidx_avg_avg48_mult_x_align_15_q <= i_arrayidx_avg_avg48_mult_x_align_15_qint(27 downto 0);

    -- i_arrayidx_avg_avg48_mult_x_im6_shift0(BITSHIFT,99)@15
    i_arrayidx_avg_avg48_mult_x_im6_shift0_qint <= i_arrayidx_avg_avg48_mult_x_bs1_merged_bit_select_d & "00";
    i_arrayidx_avg_avg48_mult_x_im6_shift0_q <= i_arrayidx_avg_avg48_mult_x_im6_shift0_qint(19 downto 0);

    -- i_arrayidx_avg_avg48_mult_x_align_14(BITSHIFT,89)@15
    i_arrayidx_avg_avg48_mult_x_align_14_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx_avg_avg48_mult_x_im6_shift0_q) & "000000000000000000";
    i_arrayidx_avg_avg48_mult_x_align_14_q <= i_arrayidx_avg_avg48_mult_x_align_14_qint(38 downto 0);

    -- i_arrayidx_avg_avg48_mult_x_join_16(BITJOIN,91)@15
    i_arrayidx_avg_avg48_mult_x_join_16_q <= i_arrayidx_avg_avg48_mult_x_align_15_q & i_arrayidx_avg_avg48_mult_x_align_14_q;

    -- i_arrayidx_avg_avg48_mult_x_im9_shift0(BITSHIFT,100)@15
    i_arrayidx_avg_avg48_mult_x_im9_shift0_qint <= i_arrayidx_avg_avg48_mult_x_bs1_merged_bit_select_e & "00";
    i_arrayidx_avg_avg48_mult_x_im9_shift0_q <= i_arrayidx_avg_avg48_mult_x_im9_shift0_qint(19 downto 0);

    -- i_arrayidx_avg_avg48_mult_x_align_12(BITSHIFT,87)@15
    i_arrayidx_avg_avg48_mult_x_align_12_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx_avg_avg48_mult_x_im9_shift0_q) & "000000000000000";
    i_arrayidx_avg_avg48_mult_x_align_12_q <= i_arrayidx_avg_avg48_mult_x_align_12_qint(35 downto 0);

    -- i_arrayidx_avg_avg48_mult_x_im0_shift0(BITSHIFT,97)@15
    i_arrayidx_avg_avg48_mult_x_im0_shift0_qint <= i_arrayidx_avg_avg48_mult_x_bs1_merged_bit_select_b & "00";
    i_arrayidx_avg_avg48_mult_x_im0_shift0_q <= i_arrayidx_avg_avg48_mult_x_im0_shift0_qint(19 downto 0);

    -- i_arrayidx_avg_avg48_mult_x_join_13(BITJOIN,88)@15
    i_arrayidx_avg_avg48_mult_x_join_13_q <= i_arrayidx_avg_avg48_mult_x_align_12_q & STD_LOGIC_VECTOR("0" & i_arrayidx_avg_avg48_mult_x_im0_shift0_q);

    -- i_arrayidx_avg_avg48_mult_x_result_add_0_0(ADD,92)@15
    i_arrayidx_avg_avg48_mult_x_result_add_0_0_a <= STD_LOGIC_VECTOR("00000000000" & i_arrayidx_avg_avg48_mult_x_join_13_q);
    i_arrayidx_avg_avg48_mult_x_result_add_0_0_b <= STD_LOGIC_VECTOR("0" & i_arrayidx_avg_avg48_mult_x_join_16_q);
    i_arrayidx_avg_avg48_mult_x_result_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx_avg_avg48_mult_x_result_add_0_0_a) + UNSIGNED(i_arrayidx_avg_avg48_mult_x_result_add_0_0_b));
    i_arrayidx_avg_avg48_mult_x_result_add_0_0_q <= i_arrayidx_avg_avg48_mult_x_result_add_0_0_o(67 downto 0);

    -- i_arrayidx_avg_avg48_mult_extender_x(BITJOIN,24)@15
    i_arrayidx_avg_avg48_mult_extender_x_q <= i_arrayidx_avg_avg48_mult_multconst_x_q & i_arrayidx_avg_avg48_mult_x_result_add_0_0_q(66 downto 0);

    -- i_arrayidx_avg_avg48_trunc_sel_x(BITSELECT,26)@15
    i_arrayidx_avg_avg48_trunc_sel_x_b <= i_arrayidx_avg_avg48_mult_extender_x_q(63 downto 0);

    -- redist16_i_arrayidx_avg_avg48_trunc_sel_x_b_1(DELAY,120)
    redist16_i_arrayidx_avg_avg48_trunc_sel_x_b_1 : dspba_delay
    GENERIC MAP ( width => 64, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => i_arrayidx_avg_avg48_trunc_sel_x_b, xout => redist16_i_arrayidx_avg_avg48_trunc_sel_x_b_1_q, clk => clock, aclr => resetn );

    -- i_ffwd_dst_x56_avg(BLACKBOX,62)@16
    thei_ffwd_dst_x56_avg : i_ffwd_dst_x56_avg46
    PORT MAP (
        in_intel_reserved_ffwd_0_0 => in_intel_reserved_ffwd_0_0,
        in_stall_in => GND_q,
        in_valid_in => redist15_sync_in_aunroll_x_in_i_valid_15_q,
        out_dest_data_out_0_0 => i_ffwd_dst_x56_avg_out_dest_data_out_0_0,
        clock => clock,
        resetn => resetn
    );

    -- i_arrayidx_avg_avg48_add_x(ADD,27)@16
    i_arrayidx_avg_avg48_add_x_a <= STD_LOGIC_VECTOR("0" & i_ffwd_dst_x56_avg_out_dest_data_out_0_0);
    i_arrayidx_avg_avg48_add_x_b <= STD_LOGIC_VECTOR("0" & redist16_i_arrayidx_avg_avg48_trunc_sel_x_b_1_q);
    i_arrayidx_avg_avg48_add_x_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx_avg_avg48_add_x_a) + UNSIGNED(i_arrayidx_avg_avg48_add_x_b));
    i_arrayidx_avg_avg48_add_x_q <= i_arrayidx_avg_avg48_add_x_o(64 downto 0);

    -- i_arrayidx_avg_avg48_dupName_0_trunc_sel_x(BITSELECT,21)@16
    i_arrayidx_avg_avg48_dupName_0_trunc_sel_x_b <= i_arrayidx_avg_avg48_add_x_q(63 downto 0);

    -- c_i32_32(CONSTANT,41)
    c_i32_32_q <= "00000000000000000000000000100000";

    -- i_unnamed_avg45(COMPARE,68)@15 + 1
    i_unnamed_avg45_a <= STD_LOGIC_VECTOR("00" & redist17_bgTrunc_i_add_avg_sel_x_b_1_q);
    i_unnamed_avg45_b <= STD_LOGIC_VECTOR("00" & c_i32_32_q);
    i_unnamed_avg45_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_unnamed_avg45_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            i_unnamed_avg45_o <= STD_LOGIC_VECTOR(UNSIGNED(i_unnamed_avg45_a) - UNSIGNED(i_unnamed_avg45_b));
        END IF;
    END PROCESS;
    i_unnamed_avg45_c(0) <= i_unnamed_avg45_o(33);

    -- redist4_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_15(DELAY,108)
    redist4_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_15 : dspba_delay
    GENERIC MAP ( width => 32, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist3_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_13_outputreg_q, xout => redist4_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_15_q, clk => clock, aclr => resetn );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- sync_out_aunroll_x(GPOUT,33)@16
    out_c0_exi9_0 <= GND_q;
    out_c0_exi9_1 <= redist4_i_acl_pop_i32_i_03_pop917_pop14_avg_out_data_out_15_q;
    out_c0_exi9_2 <= i_unnamed_avg45_c;
    out_c0_exi9_3 <= i_arrayidx_avg_avg48_dupName_0_trunc_sel_x_b;
    out_c0_exi9_4 <= i_xor_avg_q;
    out_c0_exi9_5 <= redist6_i_acl_pop_i1_memdep_phi_pop1020_pop17_avg_out_data_out_2_q;
    out_c0_exi9_6 <= redist0_i_exitcond3_avg_cmp_sign_q_2_q;
    out_c0_exi9_7 <= redist1_i_notexit_avg_q_2_q;
    out_c0_exi9_8 <= redist7_i_acl_pop_i1_exitcond18_pop15_avg_out_data_out_2_q;
    out_c0_exi9_9 <= redist5_i_acl_pop_i1_notexit1119_pop16_avg_out_data_out_2_q;
    out_o_valid <= redist15_sync_in_aunroll_x_in_i_valid_15_q;

    -- i_acl_push_i1_notexitcond_avg(BLACKBOX,56)@16
    -- out out_feedback_out_3@20000000
    -- out out_feedback_valid_out_3@20000000
    thei_acl_push_i1_notexitcond_avg : i_acl_push_i1_notexitcond_avg60
    PORT MAP (
        in_data_in => redist1_i_notexit_avg_q_2_q,
        in_feedback_stall_in_3 => i_acl_pipeline_keep_going_avg_out_not_exitcond_stall_out,
        in_stall_in => GND_q,
        in_valid_in => redist15_sync_in_aunroll_x_in_i_valid_15_q,
        out_feedback_out_3 => i_acl_push_i1_notexitcond_avg_out_feedback_out_3,
        out_feedback_valid_out_3 => i_acl_push_i1_notexitcond_avg_out_feedback_valid_out_3,
        clock => clock,
        resetn => resetn
    );

    -- i_acl_pipeline_keep_going_avg(BLACKBOX,46)@16
    -- out out_exiting_stall_out@20000000
    -- out out_exiting_valid_out@20000000
    -- out out_initeration_stall_out@20000000
    -- out out_not_exitcond_stall_out@20000000
    -- out out_pipeline_valid_out@20000000
    thei_acl_pipeline_keep_going_avg : i_acl_pipeline_keep_going_avg39
    PORT MAP (
        in_data_in => VCC_q,
        in_initeration_in => GND_q,
        in_initeration_valid_in => GND_q,
        in_not_exitcond_in => i_acl_push_i1_notexitcond_avg_out_feedback_out_3,
        in_not_exitcond_valid_in => i_acl_push_i1_notexitcond_avg_out_feedback_valid_out_3,
        in_pipeline_stall_in => in_pipeline_stall_in,
        in_stall_in => GND_q,
        in_valid_in => redist15_sync_in_aunroll_x_in_i_valid_15_q,
        out_exiting_stall_out => i_acl_pipeline_keep_going_avg_out_exiting_stall_out,
        out_exiting_valid_out => i_acl_pipeline_keep_going_avg_out_exiting_valid_out,
        out_not_exitcond_stall_out => i_acl_pipeline_keep_going_avg_out_not_exitcond_stall_out,
        out_pipeline_valid_out => i_acl_pipeline_keep_going_avg_out_pipeline_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- ext_sig_sync_out(GPOUT,45)
    out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_valid_out <= i_acl_pipeline_keep_going_avg_out_exiting_valid_out;
    out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_stall_out <= i_acl_pipeline_keep_going_avg_out_exiting_stall_out;

    -- pipeline_valid_out_sync(GPOUT,73)
    out_pipeline_valid_out <= i_acl_pipeline_keep_going_avg_out_pipeline_valid_out;

END normal;
