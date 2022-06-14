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

-- VHDL created from i_sfc_logic_c1_for_body3_avg_c1_enter_avg75
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

entity i_sfc_logic_c1_for_body3_avg_c1_enter_avg75 is
    port (
        in_c1_eni4_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c1_eni4_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c1_eni4_2 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_c1_eni4_3 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c1_eni4_4 : in std_logic_vector(0 downto 0);  -- ufix1
        in_i_valid : in std_logic_vector(0 downto 0);  -- ufix1
        out_c1_exi1_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_c1_exi1_1 : out std_logic_vector(31 downto 0);  -- float32_m23
        out_o_valid : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end i_sfc_logic_c1_for_body3_avg_c1_enter_avg75;

architecture normal of i_sfc_logic_c1_for_body3_avg_c1_enter_avg75 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component i_acl_pop_f_sum_12_pop12_avg77 is
        port (
            in_data_in : in std_logic_vector(31 downto 0);  -- Floating Point
            in_dir : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_feedback_in_12 : in std_logic_vector(31 downto 0);  -- Fixed Point
            in_feedback_valid_in_12 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(31 downto 0);  -- Floating Point
            out_feedback_stall_out_12 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_push_f_sum_12_push12_avg79 is
        port (
            in_c1_ene4 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_data_in : in std_logic_vector(31 downto 0);  -- Floating Point
            in_feedback_stall_in_12 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(31 downto 0);  -- Floating Point
            out_feedback_out_12 : out std_logic_vector(31 downto 0);  -- Fixed Point
            out_feedback_valid_out_12 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component floatComponent_i_sfc_logic_c1_for_body3_avg_c1_enter_avg75_addBlock_typeSFloatIEA0Z3d06o00rf00d06of5q0u is
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
    signal c_float_0_000000e_00_q : STD_LOGIC_VECTOR (31 downto 0);
    signal i_acl_pop_f_sum_12_pop12_avg_out_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal i_acl_pop_f_sum_12_pop12_avg_out_feedback_stall_out_12 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_push_f_sum_12_push12_avg_out_feedback_out_12 : STD_LOGIC_VECTOR (31 downto 0);
    signal i_acl_push_f_sum_12_push12_avg_out_feedback_valid_out_12 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_add6_a_avg_out_primWireOut : STD_LOGIC_VECTOR (31 downto 0);
    signal i_p_avg_s : STD_LOGIC_VECTOR (0 downto 0);
    signal i_p_avg_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist0_i_acl_pop_f_sum_12_pop12_avg_out_data_out_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist1_sync_in_aunroll_x_in_c1_eni4_4_15_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_sync_in_aunroll_x_in_i_valid_15_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- redist2_sync_in_aunroll_x_in_i_valid_15(DELAY,13)
    redist2_sync_in_aunroll_x_in_i_valid_15 : dspba_delay
    GENERIC MAP ( width => 1, depth => 15, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_i_valid, xout => redist2_sync_in_aunroll_x_in_i_valid_15_q, clk => clock, aclr => resetn );

    -- c_float_0_000000e_00(FLOATCONSTANT,5)
    c_float_0_000000e_00_q <= "00000000000000000000000000000000";

    -- i_p_avg(MUX,10)@51 + 1
    i_p_avg_s <= in_c1_eni4_1;
    i_p_avg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            i_p_avg_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (i_p_avg_s) IS
                WHEN "0" => i_p_avg_q <= c_float_0_000000e_00_q;
                WHEN "1" => i_p_avg_q <= in_c1_eni4_2;
                WHEN OTHERS => i_p_avg_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist1_sync_in_aunroll_x_in_c1_eni4_4_15(DELAY,12)
    redist1_sync_in_aunroll_x_in_c1_eni4_4_15 : dspba_delay
    GENERIC MAP ( width => 1, depth => 15, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_c1_eni4_4, xout => redist1_sync_in_aunroll_x_in_c1_eni4_4_15_q, clk => clock, aclr => resetn );

    -- i_acl_push_f_sum_12_push12_avg(BLACKBOX,8)@66
    -- out out_feedback_out_12@20000000
    -- out out_feedback_valid_out_12@20000000
    thei_acl_push_f_sum_12_push12_avg : i_acl_push_f_sum_12_push12_avg79
    PORT MAP (
        in_c1_ene4 => redist1_sync_in_aunroll_x_in_c1_eni4_4_15_q,
        in_data_in => i_add6_a_avg_out_primWireOut,
        in_feedback_stall_in_12 => i_acl_pop_f_sum_12_pop12_avg_out_feedback_stall_out_12,
        in_stall_in => GND_q,
        in_valid_in => redist2_sync_in_aunroll_x_in_i_valid_15_q,
        out_feedback_out_12 => i_acl_push_f_sum_12_push12_avg_out_feedback_out_12,
        out_feedback_valid_out_12 => i_acl_push_f_sum_12_push12_avg_out_feedback_valid_out_12,
        clock => clock,
        resetn => resetn
    );

    -- i_acl_pop_f_sum_12_pop12_avg(BLACKBOX,7)@51
    -- out out_feedback_stall_out_12@20000000
    thei_acl_pop_f_sum_12_pop12_avg : i_acl_pop_f_sum_12_pop12_avg77
    PORT MAP (
        in_data_in => c_float_0_000000e_00_q,
        in_dir => in_c1_eni4_3,
        in_feedback_in_12 => i_acl_push_f_sum_12_push12_avg_out_feedback_out_12,
        in_feedback_valid_in_12 => i_acl_push_f_sum_12_push12_avg_out_feedback_valid_out_12,
        in_predicate => GND_q,
        in_stall_in => GND_q,
        in_valid_in => in_i_valid,
        out_data_out => i_acl_pop_f_sum_12_pop12_avg_out_data_out,
        out_feedback_stall_out_12 => i_acl_pop_f_sum_12_pop12_avg_out_feedback_stall_out_12,
        clock => clock,
        resetn => resetn
    );

    -- redist0_i_acl_pop_f_sum_12_pop12_avg_out_data_out_1(DELAY,11)
    redist0_i_acl_pop_f_sum_12_pop12_avg_out_data_out_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => i_acl_pop_f_sum_12_pop12_avg_out_data_out, xout => redist0_i_acl_pop_f_sum_12_pop12_avg_out_data_out_1_q, clk => clock, aclr => resetn );

    -- i_add6_a_avg(BLACKBOX,9)@52
    -- out out_primWireOut@66
    thei_add6_a_avg : floatComponent_i_sfc_logic_c1_for_body3_avg_c1_enter_avg75_addBlock_typeSFloatIEA0Z3d06o00rf00d06of5q0u
    PORT MAP (
        in_0 => redist0_i_acl_pop_f_sum_12_pop12_avg_out_data_out_1_q,
        in_1 => i_p_avg_q,
        out_primWireOut => i_add6_a_avg_out_primWireOut,
        clock => clock,
        resetn => resetn
    );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- sync_out_aunroll_x(GPOUT,4)@66
    out_c1_exi1_0 <= GND_q;
    out_c1_exi1_1 <= i_add6_a_avg_out_primWireOut;
    out_o_valid <= redist2_sync_in_aunroll_x_in_i_valid_15_q;

END normal;
