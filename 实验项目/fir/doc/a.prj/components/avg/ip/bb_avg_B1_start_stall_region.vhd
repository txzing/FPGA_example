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

-- VHDL created from bb_avg_B1_start_stall_region
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

entity bb_avg_B1_start_stall_region is
    port (
        out_iord_bl_do_o_fifoready : out std_logic_vector(0 downto 0);  -- ufix1
        out_intel_reserved_ffwd_1_0 : out std_logic_vector(63 downto 0);  -- ufix64
        in_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_iord_bl_do_i_fifodata : in std_logic_vector(127 downto 0);  -- ufix128
        in_iord_bl_do_i_fifovalid : in std_logic_vector(0 downto 0);  -- ufix1
        out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_feedback_in_1 : in std_logic_vector(7 downto 0);  -- ufix8
        out_feedback_stall_out_1 : out std_logic_vector(0 downto 0);  -- ufix1
        in_feedback_valid_in_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_pipeline_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_pipeline_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        out_intel_reserved_ffwd_0_0 : out std_logic_vector(63 downto 0);  -- ufix64
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end bb_avg_B1_start_stall_region;

architecture normal of bb_avg_B1_start_stall_region is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component i_iord_bl_do_unnamed_avg1_avg14 is
        port (
            in_i_dependence : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_iord_bl_do_i_fifodata : in std_logic_vector(127 downto 0);  -- Fixed Point
            in_iord_bl_do_i_fifovalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_data_0 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_o_data_1 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_iord_bl_do_o_fifoready : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_sfc_c0_wt_entry_avg_c0_enter_avg is
        port (
            in_unnamed_avg0_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_pipeline_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit_1 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_pipeline_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component avg_B1_start_merge_reg is
        port (
            in_data_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_pop_i1_throttle_pop_avg12 is
        port (
            in_data_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_dir : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_feedback_in_1 : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_feedback_valid_in_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_feedback_stall_out_1 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_ffwd_src_unnamed_avg2_avg15 is
        port (
            in_enable_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_src_data_in_0_0 : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_intel_reserved_ffwd_0_0 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_ffwd_src_unnamed_avg3_avg17 is
        port (
            in_enable_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_src_data_in_1_0 : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_intel_reserved_ffwd_1_0 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_iord_bl_do_unnamed_avg1_avg_aunroll_x_out_o_data_0 : STD_LOGIC_VECTOR (63 downto 0);
    signal i_iord_bl_do_unnamed_avg1_avg_aunroll_x_out_o_data_1 : STD_LOGIC_VECTOR (63 downto 0);
    signal i_iord_bl_do_unnamed_avg1_avg_aunroll_x_out_iord_bl_do_o_fifoready : STD_LOGIC_VECTOR (0 downto 0);
    signal i_iord_bl_do_unnamed_avg1_avg_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_iord_bl_do_unnamed_avg1_avg_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_out_pipeline_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B1_start_merge_reg_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B1_start_merge_reg_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i1_throttle_pop_avg_out_data_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i1_throttle_pop_avg_out_feedback_stall_out_1 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i1_throttle_pop_avg_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i1_throttle_pop_avg_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_ffwd_src_unnamed_avg2_avg_out_intel_reserved_ffwd_0_0 : STD_LOGIC_VECTOR (63 downto 0);
    signal i_ffwd_src_unnamed_avg2_avg_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_ffwd_src_unnamed_avg2_avg_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_ffwd_src_unnamed_avg3_avg_out_intel_reserved_ffwd_1_0 : STD_LOGIC_VECTOR (63 downto 0);
    signal i_ffwd_src_unnamed_avg3_avg_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_ffwd_src_unnamed_avg3_avg_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_q : STD_LOGIC_VECTOR (127 downto 0);
    signal bubble_select_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_c : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_acl_pop_i1_throttle_pop_avg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_i_acl_pop_i1_throttle_pop_avg_b : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B1_start_merge_reg_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B1_start_merge_reg_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B1_start_merge_reg_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B1_start_merge_reg_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B1_start_merge_reg_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B1_start_merge_reg_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B1_start_merge_reg_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B1_start_merge_reg_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B1_start_merge_reg_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B1_start_merge_reg_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B1_start_merge_reg_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B1_start_merge_reg_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B1_start_merge_reg_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_acl_pop_i1_throttle_pop_avg_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_acl_pop_i1_throttle_pop_avg_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_acl_pop_i1_throttle_pop_avg_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_ffwd_src_unnamed_avg3_avg_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_ffwd_src_unnamed_avg3_avg_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_ffwd_src_unnamed_avg3_avg_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_ffwd_src_unnamed_avg3_avg_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_ffwd_src_unnamed_avg3_avg_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_V0 : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- bubble_join_i_iord_bl_do_unnamed_avg1_avg_aunroll_x(BITJOIN,43)
    bubble_join_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_q <= i_iord_bl_do_unnamed_avg1_avg_aunroll_x_out_o_data_1 & i_iord_bl_do_unnamed_avg1_avg_aunroll_x_out_o_data_0;

    -- bubble_select_i_iord_bl_do_unnamed_avg1_avg_aunroll_x(BITSELECT,44)
    bubble_select_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_q(63 downto 0));
    bubble_select_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_c <= STD_LOGIC_VECTOR(bubble_join_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_q(127 downto 64));

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- i_ffwd_src_unnamed_avg2_avg(BLACKBOX,31)@2
    -- in in_stall_in@20000000
    -- out out_intel_reserved_ffwd_0_0@20000000
    -- out out_stall_out@20000000
    thei_ffwd_src_unnamed_avg2_avg : i_ffwd_src_unnamed_avg2_avg15
    PORT MAP (
        in_enable_in => VCC_q,
        in_src_data_in_0_0 => bubble_select_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_b,
        in_stall_in => SE_out_i_ffwd_src_unnamed_avg3_avg_backStall,
        in_valid_in => SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_V0,
        out_intel_reserved_ffwd_0_0 => i_ffwd_src_unnamed_avg2_avg_out_intel_reserved_ffwd_0_0,
        out_stall_out => i_ffwd_src_unnamed_avg2_avg_out_stall_out,
        out_valid_out => i_ffwd_src_unnamed_avg2_avg_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- i_ffwd_src_unnamed_avg3_avg(BLACKBOX,32)@2
    -- in in_stall_in@20000000
    -- out out_intel_reserved_ffwd_1_0@20000000
    -- out out_stall_out@20000000
    thei_ffwd_src_unnamed_avg3_avg : i_ffwd_src_unnamed_avg3_avg17
    PORT MAP (
        in_enable_in => VCC_q,
        in_src_data_in_1_0 => bubble_select_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_c,
        in_stall_in => SE_out_i_ffwd_src_unnamed_avg3_avg_backStall,
        in_valid_in => SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_V1,
        out_intel_reserved_ffwd_1_0 => i_ffwd_src_unnamed_avg3_avg_out_intel_reserved_ffwd_1_0,
        out_stall_out => i_ffwd_src_unnamed_avg3_avg_out_stall_out,
        out_valid_out => i_ffwd_src_unnamed_avg3_avg_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_i_ffwd_src_unnamed_avg3_avg(STALLENABLE,65)
    -- Valid signal propagation
    SE_out_i_ffwd_src_unnamed_avg3_avg_V0 <= SE_out_i_ffwd_src_unnamed_avg3_avg_wireValid;
    -- Backward Stall generation
    SE_out_i_ffwd_src_unnamed_avg3_avg_backStall <= in_stall_in or not (SE_out_i_ffwd_src_unnamed_avg3_avg_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_ffwd_src_unnamed_avg3_avg_and0 <= i_ffwd_src_unnamed_avg3_avg_out_valid_out;
    SE_out_i_ffwd_src_unnamed_avg3_avg_and1 <= i_ffwd_src_unnamed_avg2_avg_out_valid_out and SE_out_i_ffwd_src_unnamed_avg3_avg_and0;
    SE_out_i_ffwd_src_unnamed_avg3_avg_wireValid <= bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_V0 and SE_out_i_ffwd_src_unnamed_avg3_avg_and1;

    -- bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg(STALLENABLE,88)
    -- Valid signal propagation
    bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_V0 <= bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_R_v_0;
    -- Stall signal propagation
    bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_s_tv_0 <= SE_out_i_ffwd_src_unnamed_avg3_avg_backStall and bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_R_v_0;
    -- Backward Enable generation
    bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_backEN <= not (bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_v_s_0 <= bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_backEN and SE_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_V0;
    -- Backward Stall generation
    bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_backStall <= not (bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_v_s_0);
    bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_backEN = "0") THEN
                bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_R_v_0 <= bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_R_v_0 and bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_s_tv_0;
            ELSE
                bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_R_v_0 <= bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x(STALLENABLE,57)
    -- Valid signal propagation
    SE_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_V0 <= SE_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_wireValid;
    -- Backward Stall generation
    SE_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_backStall <= bubble_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_1_reg_backStall or not (SE_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_wireValid <= i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_out_o_valid;

    -- i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x(BLACKBOX,17)@1
    -- in in_i_stall@20000000
    -- out out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_stall_out@20000000
    -- out out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_valid_out@20000000
    -- out out_o_stall@20000000
    -- out out_pipeline_valid_out@20000000
    thei_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x : i_sfc_c0_wt_entry_avg_c0_enter_avg
    PORT MAP (
        in_unnamed_avg0_0 => GND_q,
        in_i_stall => SE_out_i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_backStall,
        in_i_valid => SE_out_avg_B1_start_merge_reg_V0,
        in_pipeline_stall_in => in_pipeline_stall_in,
        out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_stall_out => i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_stall_out,
        out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_valid_out => i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_valid_out,
        out_o_stall => i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_out_o_stall,
        out_o_valid => i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_out_o_valid,
        out_pipeline_valid_out => i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_out_pipeline_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_stall_entry(STALLENABLE,66)
    -- Valid signal propagation
    SE_stall_entry_V0 <= SE_stall_entry_wireValid;
    -- Backward Stall generation
    SE_stall_entry_backStall <= avg_B1_start_merge_reg_out_stall_out or not (SE_stall_entry_wireValid);
    -- Computing multiple Valid(s)
    SE_stall_entry_wireValid <= in_valid_in;

    -- avg_B1_start_merge_reg(BLACKBOX,18)@0
    -- in in_stall_in@20000000
    -- out out_data_out@1
    -- out out_stall_out@20000000
    -- out out_valid_out@1
    theavg_B1_start_merge_reg : avg_B1_start_merge_reg
    PORT MAP (
        in_data_in => GND_q,
        in_stall_in => SE_out_avg_B1_start_merge_reg_backStall,
        in_valid_in => SE_stall_entry_V0,
        out_stall_out => avg_B1_start_merge_reg_out_stall_out,
        out_valid_out => avg_B1_start_merge_reg_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_avg_B1_start_merge_reg(STALLENABLE,59)
    SE_out_avg_B1_start_merge_reg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_out_avg_B1_start_merge_reg_fromReg0 <= (others => '0');
            SE_out_avg_B1_start_merge_reg_fromReg1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_out_avg_B1_start_merge_reg_fromReg0 <= SE_out_avg_B1_start_merge_reg_toReg0;
            -- Succesor 1
            SE_out_avg_B1_start_merge_reg_fromReg1 <= SE_out_avg_B1_start_merge_reg_toReg1;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_out_avg_B1_start_merge_reg_consumed0 <= (not (i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_out_o_stall) and SE_out_avg_B1_start_merge_reg_wireValid) or SE_out_avg_B1_start_merge_reg_fromReg0;
    SE_out_avg_B1_start_merge_reg_consumed1 <= (not (i_acl_pop_i1_throttle_pop_avg_out_stall_out) and SE_out_avg_B1_start_merge_reg_wireValid) or SE_out_avg_B1_start_merge_reg_fromReg1;
    -- Consuming
    SE_out_avg_B1_start_merge_reg_StallValid <= SE_out_avg_B1_start_merge_reg_backStall and SE_out_avg_B1_start_merge_reg_wireValid;
    SE_out_avg_B1_start_merge_reg_toReg0 <= SE_out_avg_B1_start_merge_reg_StallValid and SE_out_avg_B1_start_merge_reg_consumed0;
    SE_out_avg_B1_start_merge_reg_toReg1 <= SE_out_avg_B1_start_merge_reg_StallValid and SE_out_avg_B1_start_merge_reg_consumed1;
    -- Backward Stall generation
    SE_out_avg_B1_start_merge_reg_or0 <= SE_out_avg_B1_start_merge_reg_consumed0;
    SE_out_avg_B1_start_merge_reg_wireStall <= not (SE_out_avg_B1_start_merge_reg_consumed1 and SE_out_avg_B1_start_merge_reg_or0);
    SE_out_avg_B1_start_merge_reg_backStall <= SE_out_avg_B1_start_merge_reg_wireStall;
    -- Valid signal propagation
    SE_out_avg_B1_start_merge_reg_V0 <= SE_out_avg_B1_start_merge_reg_wireValid and not (SE_out_avg_B1_start_merge_reg_fromReg0);
    SE_out_avg_B1_start_merge_reg_V1 <= SE_out_avg_B1_start_merge_reg_wireValid and not (SE_out_avg_B1_start_merge_reg_fromReg1);
    -- Computing multiple Valid(s)
    SE_out_avg_B1_start_merge_reg_wireValid <= avg_B1_start_merge_reg_out_valid_out;

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- i_acl_pop_i1_throttle_pop_avg(BLACKBOX,30)@1
    -- in in_stall_in@20000000
    -- out out_data_out@2
    -- out out_feedback_stall_out_1@20000000
    -- out out_stall_out@20000000
    -- out out_valid_out@2
    thei_acl_pop_i1_throttle_pop_avg : i_acl_pop_i1_throttle_pop_avg12
    PORT MAP (
        in_data_in => GND_q,
        in_dir => GND_q,
        in_feedback_in_1 => in_feedback_in_1,
        in_feedback_valid_in_1 => in_feedback_valid_in_1,
        in_predicate => GND_q,
        in_stall_in => SE_out_i_acl_pop_i1_throttle_pop_avg_backStall,
        in_valid_in => SE_out_avg_B1_start_merge_reg_V1,
        out_data_out => i_acl_pop_i1_throttle_pop_avg_out_data_out,
        out_feedback_stall_out_1 => i_acl_pop_i1_throttle_pop_avg_out_feedback_stall_out_1,
        out_stall_out => i_acl_pop_i1_throttle_pop_avg_out_stall_out,
        out_valid_out => i_acl_pop_i1_throttle_pop_avg_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_i_acl_pop_i1_throttle_pop_avg(STALLENABLE,61)
    -- Valid signal propagation
    SE_out_i_acl_pop_i1_throttle_pop_avg_V0 <= SE_out_i_acl_pop_i1_throttle_pop_avg_wireValid;
    -- Backward Stall generation
    SE_out_i_acl_pop_i1_throttle_pop_avg_backStall <= i_iord_bl_do_unnamed_avg1_avg_aunroll_x_out_o_stall or not (SE_out_i_acl_pop_i1_throttle_pop_avg_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_acl_pop_i1_throttle_pop_avg_wireValid <= i_acl_pop_i1_throttle_pop_avg_out_valid_out;

    -- SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x(STALLENABLE,55)
    SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_fromReg0 <= (others => '0');
            SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_fromReg1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_fromReg0 <= SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_toReg0;
            -- Succesor 1
            SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_fromReg1 <= SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_toReg1;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_consumed0 <= (not (i_ffwd_src_unnamed_avg2_avg_out_stall_out) and SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_wireValid) or SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_fromReg0;
    SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_consumed1 <= (not (i_ffwd_src_unnamed_avg3_avg_out_stall_out) and SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_wireValid) or SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_fromReg1;
    -- Consuming
    SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_StallValid <= SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_backStall and SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_wireValid;
    SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_toReg0 <= SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_StallValid and SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_consumed0;
    SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_toReg1 <= SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_StallValid and SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_consumed1;
    -- Backward Stall generation
    SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_or0 <= SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_consumed0;
    SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_wireStall <= not (SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_consumed1 and SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_or0);
    SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_backStall <= SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_wireStall;
    -- Valid signal propagation
    SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_V0 <= SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_wireValid and not (SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_fromReg0);
    SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_V1 <= SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_wireValid and not (SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_fromReg1);
    -- Computing multiple Valid(s)
    SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_wireValid <= i_iord_bl_do_unnamed_avg1_avg_aunroll_x_out_o_valid;

    -- bubble_join_i_acl_pop_i1_throttle_pop_avg(BITJOIN,49)
    bubble_join_i_acl_pop_i1_throttle_pop_avg_q <= i_acl_pop_i1_throttle_pop_avg_out_data_out;

    -- bubble_select_i_acl_pop_i1_throttle_pop_avg(BITSELECT,50)
    bubble_select_i_acl_pop_i1_throttle_pop_avg_b <= STD_LOGIC_VECTOR(bubble_join_i_acl_pop_i1_throttle_pop_avg_q(0 downto 0));

    -- i_iord_bl_do_unnamed_avg1_avg_aunroll_x(BLACKBOX,16)@2
    -- in in_i_stall@20000000
    -- out out_iord_bl_do_o_fifoready@20000000
    -- out out_o_stall@20000000
    thei_iord_bl_do_unnamed_avg1_avg_aunroll_x : i_iord_bl_do_unnamed_avg1_avg14
    PORT MAP (
        in_i_dependence => bubble_select_i_acl_pop_i1_throttle_pop_avg_b,
        in_i_stall => SE_out_i_iord_bl_do_unnamed_avg1_avg_aunroll_x_backStall,
        in_i_valid => SE_out_i_acl_pop_i1_throttle_pop_avg_V0,
        in_iord_bl_do_i_fifodata => in_iord_bl_do_i_fifodata,
        in_iord_bl_do_i_fifovalid => in_iord_bl_do_i_fifovalid,
        out_o_data_0 => i_iord_bl_do_unnamed_avg1_avg_aunroll_x_out_o_data_0,
        out_o_data_1 => i_iord_bl_do_unnamed_avg1_avg_aunroll_x_out_o_data_1,
        out_iord_bl_do_o_fifoready => i_iord_bl_do_unnamed_avg1_avg_aunroll_x_out_iord_bl_do_o_fifoready,
        out_o_stall => i_iord_bl_do_unnamed_avg1_avg_aunroll_x_out_o_stall,
        out_o_valid => i_iord_bl_do_unnamed_avg1_avg_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- dupName_0_ext_sig_sync_out_x(GPOUT,2)
    out_iord_bl_do_o_fifoready <= i_iord_bl_do_unnamed_avg1_avg_aunroll_x_out_iord_bl_do_o_fifoready;

    -- dupName_0_regfree_osync_x(GPOUT,5)
    out_intel_reserved_ffwd_1_0 <= i_ffwd_src_unnamed_avg3_avg_out_intel_reserved_ffwd_1_0;

    -- dupName_0_sync_out_x(GPOUT,7)@2
    out_valid_out <= SE_out_i_ffwd_src_unnamed_avg3_avg_V0;

    -- ext_sig_sync_out(GPOUT,26)
    out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_valid_out <= i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_valid_out;
    out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_stall_out <= i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going13_avg_exiting_stall_out;

    -- feedback_stall_out_1_sync(GPOUT,28)
    out_feedback_stall_out_1 <= i_acl_pop_i1_throttle_pop_avg_out_feedback_stall_out_1;

    -- pipeline_valid_out_sync(GPOUT,36)
    out_pipeline_valid_out <= i_sfc_c0_wt_entry_avg_c0_enter_avg_aunroll_x_out_pipeline_valid_out;

    -- regfree_osync(GPOUT,37)
    out_intel_reserved_ffwd_0_0 <= i_ffwd_src_unnamed_avg2_avg_out_intel_reserved_ffwd_0_0;

    -- sync_out(GPOUT,41)@0
    out_stall_out <= SE_stall_entry_backStall;

END normal;
