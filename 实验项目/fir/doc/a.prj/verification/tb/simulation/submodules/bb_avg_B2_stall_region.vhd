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

-- VHDL created from bb_avg_B2_stall_region
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

entity bb_avg_B2_stall_region is
    port (
        in_forked15 : in std_logic_vector(0 downto 0);  -- ufix1
        in_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exe124 : out std_logic_vector(31 downto 0);  -- ufix32
        out_c0_exe2 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c0_exe3 : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_phi_pop10 : out std_logic_vector(0 downto 0);  -- ufix1
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_feedback_in_10 : in std_logic_vector(7 downto 0);  -- ufix8
        out_feedback_stall_out_10 : out std_logic_vector(0 downto 0);  -- ufix1
        in_feedback_valid_in_10 : in std_logic_vector(0 downto 0);  -- ufix1
        in_pipeline_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_pipeline_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end bb_avg_B2_stall_region;

architecture normal of bb_avg_B2_stall_region is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component avg_B2_merge_reg is
        port (
            in_data_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg is
        port (
            in_c0_eni1_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_eni1_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_pipeline_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit23_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit23_1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_c0_exit23_2 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit23_3 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_pipeline_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_pop_i1_memdep_phi_pop10_avg35 is
        port (
            in_data_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_dir : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_feedback_in_10 : in std_logic_vector(7 downto 0);  -- Fixed Point
            in_feedback_valid_in_10 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_feedback_stall_out_10 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B2_merge_reg_aunroll_x_out_data_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B2_merge_reg_aunroll_x_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B2_merge_reg_aunroll_x_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_c0_exit23_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_c0_exit23_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_c0_exit23_3 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_pipeline_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i1_memdep_phi_pop10_avg_out_data_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i1_memdep_phi_pop10_avg_out_feedback_stall_out_10 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i1_memdep_phi_pop10_avg_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_pop_i1_memdep_phi_pop10_avg_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_avg_B2_merge_reg_aunroll_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_avg_B2_merge_reg_aunroll_x_b : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_q : STD_LOGIC_VECTOR (33 downto 0);
    signal bubble_select_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_c : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_d : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_i_acl_pop_i1_memdep_phi_pop10_avg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_i_acl_pop_i1_memdep_phi_pop10_avg_b : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_stall_entry_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_stall_entry_b : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B2_merge_reg_aunroll_x_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B2_merge_reg_aunroll_x_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B2_merge_reg_aunroll_x_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B2_merge_reg_aunroll_x_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B2_merge_reg_aunroll_x_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B2_merge_reg_aunroll_x_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B2_merge_reg_aunroll_x_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B2_merge_reg_aunroll_x_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B2_merge_reg_aunroll_x_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B2_merge_reg_aunroll_x_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B2_merge_reg_aunroll_x_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B2_merge_reg_aunroll_x_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_avg_B2_merge_reg_aunroll_x_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_acl_pop_i1_memdep_phi_pop10_avg_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_acl_pop_i1_memdep_phi_pop10_avg_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_acl_pop_i1_memdep_phi_pop10_avg_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_acl_pop_i1_memdep_phi_pop10_avg_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_V0 : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1(STALLENABLE,53)
    -- Valid signal propagation
    SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_V0 <= SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_R_v_0;
    -- Stall signal propagation
    SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_s_tv_0 <= i_acl_pop_i1_memdep_phi_pop10_avg_out_stall_out and SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_R_v_0;
    -- Backward Enable generation
    SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_backEN <= not (SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_v_s_0 <= SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_backEN and SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_V0;
    -- Backward Stall generation
    SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_backStall <= not (SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_v_s_0);
    SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_backEN = "0") THEN
                SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_R_v_0 <= SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_R_v_0 and SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_s_tv_0;
            ELSE
                SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_R_v_0 <= SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0(STALLENABLE,52)
    -- Valid signal propagation
    SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_V0 <= SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_R_v_0;
    -- Stall signal propagation
    SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_s_tv_0 <= SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_backStall and SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_R_v_0;
    -- Backward Enable generation
    SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_backEN <= not (SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_v_s_0 <= SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_backEN and SE_out_avg_B2_merge_reg_aunroll_x_V0;
    -- Backward Stall generation
    SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_backStall <= not (SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_v_s_0);
    SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_backEN = "0") THEN
                SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_R_v_0 <= SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_R_v_0 and SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_s_tv_0;
            ELSE
                SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_R_v_0 <= SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_stall_entry(STALLENABLE,50)
    -- Valid signal propagation
    SE_stall_entry_V0 <= SE_stall_entry_wireValid;
    -- Backward Stall generation
    SE_stall_entry_backStall <= avg_B2_merge_reg_aunroll_x_out_stall_out or not (SE_stall_entry_wireValid);
    -- Computing multiple Valid(s)
    SE_stall_entry_wireValid <= in_valid_in;

    -- bubble_join_stall_entry(BITJOIN,41)
    bubble_join_stall_entry_q <= in_forked15;

    -- bubble_select_stall_entry(BITSELECT,42)
    bubble_select_stall_entry_b <= STD_LOGIC_VECTOR(bubble_join_stall_entry_q(0 downto 0));

    -- avg_B2_merge_reg_aunroll_x(BLACKBOX,2)@0
    -- in in_stall_in@20000000
    -- out out_data_out_0@1
    -- out out_stall_out@20000000
    -- out out_valid_out@1
    theavg_B2_merge_reg_aunroll_x : avg_B2_merge_reg
    PORT MAP (
        in_data_in_0 => bubble_select_stall_entry_b,
        in_stall_in => SE_out_avg_B2_merge_reg_aunroll_x_backStall,
        in_valid_in => SE_stall_entry_V0,
        out_data_out_0 => avg_B2_merge_reg_aunroll_x_out_data_out_0,
        out_stall_out => avg_B2_merge_reg_aunroll_x_out_stall_out,
        out_valid_out => avg_B2_merge_reg_aunroll_x_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_avg_B2_merge_reg_aunroll_x(STALLENABLE,45)
    SE_out_avg_B2_merge_reg_aunroll_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_out_avg_B2_merge_reg_aunroll_x_fromReg0 <= (others => '0');
            SE_out_avg_B2_merge_reg_aunroll_x_fromReg1 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_out_avg_B2_merge_reg_aunroll_x_fromReg0 <= SE_out_avg_B2_merge_reg_aunroll_x_toReg0;
            -- Succesor 1
            SE_out_avg_B2_merge_reg_aunroll_x_fromReg1 <= SE_out_avg_B2_merge_reg_aunroll_x_toReg1;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_out_avg_B2_merge_reg_aunroll_x_consumed0 <= (not (SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_backStall) and SE_out_avg_B2_merge_reg_aunroll_x_wireValid) or SE_out_avg_B2_merge_reg_aunroll_x_fromReg0;
    SE_out_avg_B2_merge_reg_aunroll_x_consumed1 <= (not (i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_o_stall) and SE_out_avg_B2_merge_reg_aunroll_x_wireValid) or SE_out_avg_B2_merge_reg_aunroll_x_fromReg1;
    -- Consuming
    SE_out_avg_B2_merge_reg_aunroll_x_StallValid <= SE_out_avg_B2_merge_reg_aunroll_x_backStall and SE_out_avg_B2_merge_reg_aunroll_x_wireValid;
    SE_out_avg_B2_merge_reg_aunroll_x_toReg0 <= SE_out_avg_B2_merge_reg_aunroll_x_StallValid and SE_out_avg_B2_merge_reg_aunroll_x_consumed0;
    SE_out_avg_B2_merge_reg_aunroll_x_toReg1 <= SE_out_avg_B2_merge_reg_aunroll_x_StallValid and SE_out_avg_B2_merge_reg_aunroll_x_consumed1;
    -- Backward Stall generation
    SE_out_avg_B2_merge_reg_aunroll_x_or0 <= SE_out_avg_B2_merge_reg_aunroll_x_consumed0;
    SE_out_avg_B2_merge_reg_aunroll_x_wireStall <= not (SE_out_avg_B2_merge_reg_aunroll_x_consumed1 and SE_out_avg_B2_merge_reg_aunroll_x_or0);
    SE_out_avg_B2_merge_reg_aunroll_x_backStall <= SE_out_avg_B2_merge_reg_aunroll_x_wireStall;
    -- Valid signal propagation
    SE_out_avg_B2_merge_reg_aunroll_x_V0 <= SE_out_avg_B2_merge_reg_aunroll_x_wireValid and not (SE_out_avg_B2_merge_reg_aunroll_x_fromReg0);
    SE_out_avg_B2_merge_reg_aunroll_x_V1 <= SE_out_avg_B2_merge_reg_aunroll_x_wireValid and not (SE_out_avg_B2_merge_reg_aunroll_x_fromReg1);
    -- Computing multiple Valid(s)
    SE_out_avg_B2_merge_reg_aunroll_x_wireValid <= avg_B2_merge_reg_aunroll_x_out_valid_out;

    -- bubble_join_avg_B2_merge_reg_aunroll_x(BITJOIN,30)
    bubble_join_avg_B2_merge_reg_aunroll_x_q <= avg_B2_merge_reg_aunroll_x_out_data_out_0;

    -- bubble_select_avg_B2_merge_reg_aunroll_x(BITSELECT,31)
    bubble_select_avg_B2_merge_reg_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_avg_B2_merge_reg_aunroll_x_q(0 downto 0));

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x(BLACKBOX,9)@1
    -- in in_i_stall@20000000
    -- out out_c0_exit23_0@4
    -- out out_c0_exit23_1@4
    -- out out_c0_exit23_2@4
    -- out out_c0_exit23_3@4
    -- out out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_stall_out@20000000
    -- out out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_valid_out@20000000
    -- out out_o_stall@20000000
    -- out out_o_valid@4
    -- out out_pipeline_valid_out@20000000
    thei_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x : i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg
    PORT MAP (
        in_c0_eni1_0 => GND_q,
        in_c0_eni1_1 => bubble_select_avg_B2_merge_reg_aunroll_x_b,
        in_i_stall => SE_out_i_acl_pop_i1_memdep_phi_pop10_avg_backStall,
        in_i_valid => SE_out_avg_B2_merge_reg_aunroll_x_V1,
        in_pipeline_stall_in => in_pipeline_stall_in,
        out_c0_exit23_1 => i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_c0_exit23_1,
        out_c0_exit23_2 => i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_c0_exit23_2,
        out_c0_exit23_3 => i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_c0_exit23_3,
        out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_stall_out => i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_stall_out,
        out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_valid_out => i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_valid_out,
        out_o_stall => i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_o_stall,
        out_o_valid => i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_o_valid,
        out_pipeline_valid_out => i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_pipeline_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0(REG,27)
    redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_backEN = "1") THEN
                redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_q <= STD_LOGIC_VECTOR(bubble_select_avg_B2_merge_reg_aunroll_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1(REG,28)
    redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_backEN = "1") THEN
                redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_q <= STD_LOGIC_VECTOR(redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_0_q);
            END IF;
        END IF;
    END PROCESS;

    -- i_acl_pop_i1_memdep_phi_pop10_avg(BLACKBOX,17)@3
    -- in in_stall_in@20000000
    -- out out_data_out@4
    -- out out_feedback_stall_out_10@20000000
    -- out out_stall_out@20000000
    -- out out_valid_out@4
    thei_acl_pop_i1_memdep_phi_pop10_avg : i_acl_pop_i1_memdep_phi_pop10_avg35
    PORT MAP (
        in_data_in => GND_q,
        in_dir => redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_q,
        in_feedback_in_10 => in_feedback_in_10,
        in_feedback_valid_in_10 => in_feedback_valid_in_10,
        in_predicate => GND_q,
        in_stall_in => SE_out_i_acl_pop_i1_memdep_phi_pop10_avg_backStall,
        in_valid_in => SE_redist0_avg_B2_merge_reg_aunroll_x_out_data_out_0_2_1_V0,
        out_data_out => i_acl_pop_i1_memdep_phi_pop10_avg_out_data_out,
        out_feedback_stall_out_10 => i_acl_pop_i1_memdep_phi_pop10_avg_out_feedback_stall_out_10,
        out_stall_out => i_acl_pop_i1_memdep_phi_pop10_avg_out_stall_out,
        out_valid_out => i_acl_pop_i1_memdep_phi_pop10_avg_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_i_acl_pop_i1_memdep_phi_pop10_avg(STALLENABLE,49)
    -- Valid signal propagation
    SE_out_i_acl_pop_i1_memdep_phi_pop10_avg_V0 <= SE_out_i_acl_pop_i1_memdep_phi_pop10_avg_wireValid;
    -- Backward Stall generation
    SE_out_i_acl_pop_i1_memdep_phi_pop10_avg_backStall <= in_stall_in or not (SE_out_i_acl_pop_i1_memdep_phi_pop10_avg_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_acl_pop_i1_memdep_phi_pop10_avg_and0 <= i_acl_pop_i1_memdep_phi_pop10_avg_out_valid_out;
    SE_out_i_acl_pop_i1_memdep_phi_pop10_avg_wireValid <= i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_o_valid and SE_out_i_acl_pop_i1_memdep_phi_pop10_avg_and0;

    -- bubble_join_i_acl_pop_i1_memdep_phi_pop10_avg(BITJOIN,37)
    bubble_join_i_acl_pop_i1_memdep_phi_pop10_avg_q <= i_acl_pop_i1_memdep_phi_pop10_avg_out_data_out;

    -- bubble_select_i_acl_pop_i1_memdep_phi_pop10_avg(BITSELECT,38)
    bubble_select_i_acl_pop_i1_memdep_phi_pop10_avg_b <= STD_LOGIC_VECTOR(bubble_join_i_acl_pop_i1_memdep_phi_pop10_avg_q(0 downto 0));

    -- bubble_join_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x(BITJOIN,33)
    bubble_join_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_q <= i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_c0_exit23_3 & i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_c0_exit23_2 & i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_c0_exit23_1;

    -- bubble_select_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x(BITSELECT,34)
    bubble_select_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_q(31 downto 0));
    bubble_select_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_c <= STD_LOGIC_VECTOR(bubble_join_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_q(32 downto 32));
    bubble_select_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_d <= STD_LOGIC_VECTOR(bubble_join_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_q(33 downto 33));

    -- dupName_0_sync_out_x(GPOUT,6)@4
    out_c0_exe124 <= bubble_select_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_b;
    out_c0_exe2 <= bubble_select_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_c;
    out_c0_exe3 <= bubble_select_i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_d;
    out_memdep_phi_pop10 <= bubble_select_i_acl_pop_i1_memdep_phi_pop10_avg_b;
    out_valid_out <= SE_out_i_acl_pop_i1_memdep_phi_pop10_avg_V0;

    -- ext_sig_sync_out(GPOUT,13)
    out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_valid_out <= i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_valid_out;
    out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_stall_out <= i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going9_avg_exiting_stall_out;

    -- feedback_stall_out_10_sync(GPOUT,15)
    out_feedback_stall_out_10 <= i_acl_pop_i1_memdep_phi_pop10_avg_out_feedback_stall_out_10;

    -- pipeline_valid_out_sync(GPOUT,21)
    out_pipeline_valid_out <= i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg_aunroll_x_out_pipeline_valid_out;

    -- sync_out(GPOUT,25)@0
    out_stall_out <= SE_stall_entry_backStall;

END normal;
