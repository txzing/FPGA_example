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

-- VHDL created from i_sfc_c0_for_body3_avg_c0_enter26_avg
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

entity i_sfc_c0_for_body3_avg_c0_enter26_avg is
    port (
        in_c0_eni5_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_eni5_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_eni5_2 : in std_logic_vector(31 downto 0);  -- ufix32
        in_c0_eni5_3 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_eni5_4 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_eni5_5 : in std_logic_vector(0 downto 0);  -- ufix1
        in_i_valid : in std_logic_vector(0 downto 0);  -- ufix1
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
        out_o_valid : out std_logic_vector(0 downto 0);  -- ufix1
        out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_pipeline_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_pipeline_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_intel_reserved_ffwd_0_0 : in std_logic_vector(63 downto 0);  -- ufix64
        out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_i_stall : in std_logic_vector(0 downto 0);  -- ufix1
        out_o_stall : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end i_sfc_c0_for_body3_avg_c0_enter26_avg;

architecture normal of i_sfc_c0_for_body3_avg_c0_enter26_avg is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg72 is
        port (
            in_data_in_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_data_in_1 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_data_in_2 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_data_in_3 : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_data_in_4 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_data_in_5 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_data_in_6 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_data_in_7 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_data_in_8 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_data_in_9 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_input_accepted : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out_1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_data_out_2 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out_3 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_data_out_4 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out_5 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out_6 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out_7 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out_8 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out_9 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_entry : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37 is
        port (
            in_c0_eni5_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_eni5_1 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_eni5_2 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_c0_eni5_3 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_eni5_4 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_eni5_5 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_intel_reserved_ffwd_0_0 : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_pipeline_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exi9_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exi9_1 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_c0_exi9_2 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exi9_3 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_c0_exi9_4 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exi9_5 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exi9_6 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exi9_7 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exi9_8 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exi9_9 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_pipeline_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_3 : STD_LOGIC_VECTOR (63 downto 0);
    signal i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_4 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_5 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_6 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_7 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_8 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_9 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_stall_entry : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_2 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_3 : STD_LOGIC_VECTOR (63 downto 0);
    signal i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_4 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_5 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_6 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_7 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_8 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_9 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_pipeline_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal input_accepted_and_q : STD_LOGIC_VECTOR (0 downto 0);
    signal not_stall_out_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- not_stall_out(LOGICAL,8)
    not_stall_out_q <= not (i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_stall_entry);

    -- input_accepted_and(LOGICAL,7)
    input_accepted_and_q <= in_i_valid and not_stall_out_q;

    -- i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x(BLACKBOX,6)@1
    -- out out_c0_exi9_0@16
    -- out out_c0_exi9_1@16
    -- out out_c0_exi9_2@16
    -- out out_c0_exi9_3@16
    -- out out_c0_exi9_4@16
    -- out out_c0_exi9_5@16
    -- out out_c0_exi9_6@16
    -- out out_c0_exi9_7@16
    -- out out_c0_exi9_8@16
    -- out out_c0_exi9_9@16
    -- out out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_stall_out@20000000
    -- out out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_valid_out@20000000
    -- out out_o_valid@16
    -- out out_pipeline_valid_out@20000000
    thei_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x : i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37
    PORT MAP (
        in_c0_eni5_0 => in_c0_eni5_0,
        in_c0_eni5_1 => in_c0_eni5_1,
        in_c0_eni5_2 => in_c0_eni5_2,
        in_c0_eni5_3 => in_c0_eni5_3,
        in_c0_eni5_4 => in_c0_eni5_4,
        in_c0_eni5_5 => in_c0_eni5_5,
        in_i_valid => input_accepted_and_q,
        in_intel_reserved_ffwd_0_0 => in_intel_reserved_ffwd_0_0,
        in_pipeline_stall_in => in_pipeline_stall_in,
        out_c0_exi9_0 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_0,
        out_c0_exi9_1 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_1,
        out_c0_exi9_2 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_2,
        out_c0_exi9_3 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_3,
        out_c0_exi9_4 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_4,
        out_c0_exi9_5 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_5,
        out_c0_exi9_6 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_6,
        out_c0_exi9_7 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_7,
        out_c0_exi9_8 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_8,
        out_c0_exi9_9 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_9,
        out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_stall_out => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_stall_out,
        out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_valid_out => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_valid_out,
        out_o_valid => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_o_valid,
        out_pipeline_valid_out => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_pipeline_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x(BLACKBOX,5)@20000000
    -- out out_data_out_0@20000003
    -- out out_data_out_1@20000003
    -- out out_data_out_2@20000003
    -- out out_data_out_3@20000003
    -- out out_data_out_4@20000003
    -- out out_data_out_5@20000003
    -- out out_data_out_6@20000003
    -- out out_data_out_7@20000003
    -- out out_data_out_8@20000003
    -- out out_data_out_9@20000003
    -- out out_valid_out@20000003
    thei_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x : i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg72
    PORT MAP (
        in_data_in_0 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_0,
        in_data_in_1 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_1,
        in_data_in_2 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_2,
        in_data_in_3 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_3,
        in_data_in_4 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_4,
        in_data_in_5 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_5,
        in_data_in_6 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_6,
        in_data_in_7 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_7,
        in_data_in_8 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_8,
        in_data_in_9 => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_c0_exi9_9,
        in_input_accepted => input_accepted_and_q,
        in_stall_in => in_i_stall,
        in_valid_in => i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_o_valid,
        out_data_out_0 => i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_0,
        out_data_out_1 => i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_1,
        out_data_out_2 => i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_2,
        out_data_out_3 => i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_3,
        out_data_out_4 => i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_4,
        out_data_out_5 => i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_5,
        out_data_out_6 => i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_6,
        out_data_out_7 => i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_7,
        out_data_out_8 => i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_8,
        out_data_out_9 => i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_9,
        out_stall_entry => i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_stall_entry,
        out_valid_out => i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- dupName_0_sync_out_aunroll_x(GPOUT,3)@19
    out_c0_exit31_0 <= i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_0;
    out_c0_exit31_1 <= i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_1;
    out_c0_exit31_2 <= i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_2;
    out_c0_exit31_3 <= i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_3;
    out_c0_exit31_4 <= i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_4;
    out_c0_exit31_5 <= i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_5;
    out_c0_exit31_6 <= i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_6;
    out_c0_exit31_7 <= i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_7;
    out_c0_exit31_8 <= i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_8;
    out_c0_exit31_9 <= i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_data_out_9;
    out_o_valid <= i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_valid_out;

    -- dupName_0_regfree_osync_x(GPOUT,4)
    out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_valid_out <= i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_valid_out;

    -- pipeline_valid_out_sync(GPOUT,10)
    out_pipeline_valid_out <= i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_pipeline_valid_out;

    -- regfree_osync(GPOUT,12)
    out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_stall_out <= i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37_aunroll_x_out_aclp_to_limiter_i_acl_pipeline_keep_going_avg_exiting_stall_out;

    -- sync_out(GPOUT,14)@20000000
    out_o_stall <= i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg_aunroll_x_out_stall_entry;

END normal;
