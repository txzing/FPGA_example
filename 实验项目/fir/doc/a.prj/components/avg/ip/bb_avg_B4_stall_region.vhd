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

-- VHDL created from bb_avg_B4_stall_region
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

entity bb_avg_B4_stall_region is
    port (
        in_c0_exit311_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit311_1 : in std_logic_vector(31 downto 0);  -- ufix32
        in_c0_exit311_2 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit311_3 : in std_logic_vector(63 downto 0);  -- ufix64
        in_c0_exit311_4 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit311_5 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit311_6 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit311_7 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit311_8 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit311_9 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c1_exit2_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c1_exit2_1 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_lsu_memdep_o_active : out std_logic_vector(0 downto 0);  -- ufix1
        in_intel_reserved_ffwd_1_0 : in std_logic_vector(63 downto 0);  -- ufix64
        out_c0_exe8 : out std_logic_vector(0 downto 0);  -- ufix1
        out_valid_out : out std_logic_vector(0 downto 0);  -- ufix1
        in_memdep_avm_readdata : in std_logic_vector(63 downto 0);  -- ufix64
        in_memdep_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        in_memdep_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        in_memdep_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_address : out std_logic_vector(63 downto 0);  -- ufix64
        out_memdep_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_writedata : out std_logic_vector(63 downto 0);  -- ufix64
        out_memdep_avm_byteenable : out std_logic_vector(7 downto 0);  -- ufix8
        out_memdep_avm_burstcount : out std_logic_vector(0 downto 0);  -- ufix1
        out_feedback_out_10 : out std_logic_vector(7 downto 0);  -- ufix8
        in_feedback_stall_in_10 : in std_logic_vector(0 downto 0);  -- ufix1
        out_feedback_valid_out_10 : out std_logic_vector(0 downto 0);  -- ufix1
        in_flush : in std_logic_vector(0 downto 0);  -- ufix1
        in_stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        out_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end bb_avg_B4_stall_region;

architecture normal of bb_avg_B4_stall_region is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component i_sfc_c0_for_end_avg_c0_enter36_avg is
        port (
            in_c0_eni135_0 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_c0_eni135_1 : in std_logic_vector(31 downto 0);  -- Floating Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit39_0 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_c0_exit39_1 : out std_logic_vector(31 downto 0);  -- Floating Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_acl_push_i1_memdep_phi_push10_avg90 is
        port (
            in_c0_exe9 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_data_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_feedback_stall_in_10 : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_data_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_feedback_out_10 : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_feedback_valid_out_10 : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_ffwd_dst_y67_avg85 is
        port (
            in_intel_reserved_ffwd_1_0 : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_dest_data_out_1_0 : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_stall_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_valid_out : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component i_store_memdep_avg88 is
        port (
            in_flush : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_address : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_i_predicate : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_stall : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_valid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_i_writedata : in std_logic_vector(31 downto 0);  -- Floating Point
            in_memdep_avm_readdata : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_memdep_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_memdep_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_memdep_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_lsu_memdep_o_active : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_avm_address : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_memdep_avm_burstcount : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_avm_byteenable : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_memdep_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_avm_writedata : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_o_stall : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_valid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_o_writeack : out std_logic_vector(0 downto 0);  -- Fixed Point
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    component acl_data_fifo is
        generic (
            DEPTH : INTEGER := 0;
            DATA_WIDTH : INTEGER := 32;
            STRICT_DEPTH : INTEGER := 0;
            ALLOW_FULL_WRITE : INTEGER := 0;
            IMPL : STRING := "ram"
        );
        port (
            clock : in std_logic;
            resetn : in std_logic;
            valid_in : in std_logic;
            stall_in : in std_logic;
            data_in : in std_logic_vector(DATA_WIDTH - 1 downto 0);
            valid_out : out std_logic;
            stall_out : out std_logic;
            data_out : out std_logic_vector(DATA_WIDTH - 1 downto 0);
            full : out std_logic;
            almost_full : out std_logic
        );
    end component;




    component acl_valid_fifo_counter is
        generic (
            DEPTH : INTEGER := 0;
            ASYNC_RESET : INTEGER := 1;
            STRICT_DEPTH : INTEGER := 0;
            ALLOW_FULL_WRITE : INTEGER := 0
        );
        port (
            clock : in std_logic;
            resetn : in std_logic;
            valid_in : in std_logic;
            stall_in : in std_logic;
            valid_out : out std_logic;
            stall_out : out std_logic;
            full : out std_logic
        );
    end component;


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal i_arrayidx8_avg_avg87_dupName_0_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx8_avg_avg87_mult_extender_x_q : STD_LOGIC_VECTOR (127 downto 0);
    signal i_arrayidx8_avg_avg87_mult_multconst_x_q : STD_LOGIC_VECTOR (60 downto 0);
    signal i_arrayidx8_avg_avg87_trunc_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_arrayidx8_avg_avg87_add_x_a : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx8_avg_avg87_add_x_b : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx8_avg_avg87_add_x_o : STD_LOGIC_VECTOR (64 downto 0);
    signal i_arrayidx8_avg_avg87_add_x_q : STD_LOGIC_VECTOR (64 downto 0);
    signal i_idxprom7_avg_sel_x_b : STD_LOGIC_VECTOR (63 downto 0);
    signal i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x_out_c0_exit39_1 : STD_LOGIC_VECTOR (31 downto 0);
    signal i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_push_i1_memdep_phi_push10_avg_out_feedback_out_10 : STD_LOGIC_VECTOR (7 downto 0);
    signal i_acl_push_i1_memdep_phi_push10_avg_out_feedback_valid_out_10 : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_push_i1_memdep_phi_push10_avg_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_acl_push_i1_memdep_phi_push10_avg_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_ffwd_dst_y67_avg_out_dest_data_out_1_0 : STD_LOGIC_VECTOR (63 downto 0);
    signal i_ffwd_dst_y67_avg_out_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_ffwd_dst_y67_avg_out_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg_out_lsu_memdep_o_active : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg_out_memdep_avm_address : STD_LOGIC_VECTOR (63 downto 0);
    signal i_store_memdep_avg_out_memdep_avm_burstcount : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg_out_memdep_avm_byteenable : STD_LOGIC_VECTOR (7 downto 0);
    signal i_store_memdep_avg_out_memdep_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg_out_memdep_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg_out_memdep_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg_out_memdep_avm_writedata : STD_LOGIC_VECTOR (63 downto 0);
    signal i_store_memdep_avg_out_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg_out_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg_out_o_writeack : STD_LOGIC_VECTOR (0 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_align_12_q : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_align_12_qint : STD_LOGIC_VECTOR (35 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_join_13_q : STD_LOGIC_VECTOR (56 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_align_14_q : STD_LOGIC_VECTOR (38 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_align_14_qint : STD_LOGIC_VECTOR (38 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_align_15_q : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_align_15_qint : STD_LOGIC_VECTOR (27 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_join_16_q : STD_LOGIC_VECTOR (66 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_result_add_0_0_a : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_result_add_0_0_b : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_result_add_0_0_o : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_result_add_0_0_q : STD_LOGIC_VECTOR (67 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_im0_shift0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_im0_shift0_qint : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_im3_shift0_q : STD_LOGIC_VECTOR (11 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_im3_shift0_qint : STD_LOGIC_VECTOR (11 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_im6_shift0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_im6_shift0_qint : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_im9_shift0_q : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_im9_shift0_qint : STD_LOGIC_VECTOR (19 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_bs1_merged_bit_select_b : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_bs1_merged_bit_select_c : STD_LOGIC_VECTOR (9 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_bs1_merged_bit_select_d : STD_LOGIC_VECTOR (17 downto 0);
    signal i_arrayidx8_avg_avg87_mult_x_bs1_merged_bit_select_e : STD_LOGIC_VECTOR (17 downto 0);
    signal redist0_stall_entry_aunroll_o5_13_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_stall_entry_aunroll_o5_13_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist0_stall_entry_aunroll_o5_13_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_stall_entry_aunroll_o5_13_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist0_stall_entry_aunroll_o5_13_fifo_data_in : STD_LOGIC_VECTOR (31 downto 0);
    signal redist0_stall_entry_aunroll_o5_13_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_stall_entry_aunroll_o5_13_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist0_stall_entry_aunroll_o5_13_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_stall_entry_aunroll_o5_13_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist0_stall_entry_aunroll_o5_13_fifo_data_out : STD_LOGIC_VECTOR (31 downto 0);
    signal redist1_stall_entry_aunroll_o12_46_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_stall_entry_aunroll_o12_46_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist1_stall_entry_aunroll_o12_46_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_stall_entry_aunroll_o12_46_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist1_stall_entry_aunroll_o12_46_fifo_data_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_stall_entry_aunroll_o12_46_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_stall_entry_aunroll_o12_46_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist1_stall_entry_aunroll_o12_46_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist1_stall_entry_aunroll_o12_46_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist1_stall_entry_aunroll_o12_46_fifo_data_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_stall_entry_aunroll_o13_45_fifo_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_stall_entry_aunroll_o13_45_fifo_valid_in_bitsignaltemp : std_logic;
    signal redist2_stall_entry_aunroll_o13_45_fifo_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_stall_entry_aunroll_o13_45_fifo_stall_in_bitsignaltemp : std_logic;
    signal redist2_stall_entry_aunroll_o13_45_fifo_data_in : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_stall_entry_aunroll_o13_45_fifo_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_stall_entry_aunroll_o13_45_fifo_valid_out_bitsignaltemp : std_logic;
    signal redist2_stall_entry_aunroll_o13_45_fifo_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_stall_entry_aunroll_o13_45_fifo_stall_out_bitsignaltemp : std_logic;
    signal redist2_stall_entry_aunroll_o13_45_fifo_data_out : STD_LOGIC_VECTOR (0 downto 0);
    signal redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_i_ffwd_dst_y67_avg_q : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_select_i_ffwd_dst_y67_avg_b : STD_LOGIC_VECTOR (63 downto 0);
    signal bubble_join_i_store_memdep_avg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_i_store_memdep_avg_b : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_stall_entry_aunroll_q : STD_LOGIC_VECTOR (65 downto 0);
    signal bubble_select_stall_entry_aunroll_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_stall_entry_aunroll_c : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_stall_entry_aunroll_d : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_stall_entry_aunroll_e : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist0_stall_entry_aunroll_o5_13_fifo_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_select_redist0_stall_entry_aunroll_o5_13_fifo_b : STD_LOGIC_VECTOR (31 downto 0);
    signal bubble_join_redist1_stall_entry_aunroll_o12_46_fifo_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_redist1_stall_entry_aunroll_o12_46_fifo_b : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_join_redist2_stall_entry_aunroll_o13_45_fifo_q : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_select_redist2_stall_entry_aunroll_o13_45_fifo_b : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_ffwd_dst_y67_avg_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_ffwd_dst_y67_avg_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_ffwd_dst_y67_avg_and1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_ffwd_dst_y67_avg_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_i_ffwd_dst_y67_avg_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_wireStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_StallValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_toReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_fromReg0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_consumed0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_toReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_fromReg1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_consumed1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_toReg2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_fromReg2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_consumed2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_toReg3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_fromReg3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_consumed3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_toReg4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_fromReg4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_consumed4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_or0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_or1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_or2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_or3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_V1 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_V2 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_V3 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_stall_entry_aunroll_V4 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist0_stall_entry_aunroll_o5_13_fifo_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist0_stall_entry_aunroll_o5_13_fifo_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist0_stall_entry_aunroll_o5_13_fifo_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist1_stall_entry_aunroll_o12_46_fifo_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist1_stall_entry_aunroll_o12_46_fifo_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist1_stall_entry_aunroll_o12_46_fifo_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist1_stall_entry_aunroll_o12_46_fifo_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist2_stall_entry_aunroll_o13_45_fifo_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist2_stall_entry_aunroll_o13_45_fifo_and0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist2_stall_entry_aunroll_o13_45_fifo_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_redist2_stall_entry_aunroll_o13_45_fifo_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_R_v_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_v_s_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_s_tv_0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_backEN : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_stall_entry_aunroll_1_wireValid : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_stall_entry_aunroll_1_backStall : STD_LOGIC_VECTOR (0 downto 0);
    signal SE_out_bubble_out_stall_entry_aunroll_1_V0 : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_aunroll_1_reg_valid_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_aunroll_1_reg_valid_in_bitsignaltemp : std_logic;
    signal bubble_out_stall_entry_aunroll_1_reg_stall_in : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_aunroll_1_reg_stall_in_bitsignaltemp : std_logic;
    signal bubble_out_stall_entry_aunroll_1_reg_valid_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_aunroll_1_reg_valid_out_bitsignaltemp : std_logic;
    signal bubble_out_stall_entry_aunroll_1_reg_stall_out : STD_LOGIC_VECTOR (0 downto 0);
    signal bubble_out_stall_entry_aunroll_1_reg_stall_out_bitsignaltemp : std_logic;

begin


    -- redist2_stall_entry_aunroll_o13_45_fifo(STALLFIFO,75)
    redist2_stall_entry_aunroll_o13_45_fifo_valid_in <= SE_stall_entry_aunroll_V4;
    redist2_stall_entry_aunroll_o13_45_fifo_stall_in <= SE_out_redist2_stall_entry_aunroll_o13_45_fifo_backStall;
    redist2_stall_entry_aunroll_o13_45_fifo_data_in <= bubble_select_stall_entry_aunroll_d;
    redist2_stall_entry_aunroll_o13_45_fifo_valid_in_bitsignaltemp <= redist2_stall_entry_aunroll_o13_45_fifo_valid_in(0);
    redist2_stall_entry_aunroll_o13_45_fifo_stall_in_bitsignaltemp <= redist2_stall_entry_aunroll_o13_45_fifo_stall_in(0);
    redist2_stall_entry_aunroll_o13_45_fifo_valid_out(0) <= redist2_stall_entry_aunroll_o13_45_fifo_valid_out_bitsignaltemp;
    redist2_stall_entry_aunroll_o13_45_fifo_stall_out(0) <= redist2_stall_entry_aunroll_o13_45_fifo_stall_out_bitsignaltemp;
    theredist2_stall_entry_aunroll_o13_45_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 46,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 1,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist2_stall_entry_aunroll_o13_45_fifo_valid_in_bitsignaltemp,
        stall_in => redist2_stall_entry_aunroll_o13_45_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_stall_entry_aunroll_d,
        valid_out => redist2_stall_entry_aunroll_o13_45_fifo_valid_out_bitsignaltemp,
        stall_out => redist2_stall_entry_aunroll_o13_45_fifo_stall_out_bitsignaltemp,
        data_out => redist2_stall_entry_aunroll_o13_45_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- bubble_join_i_store_memdep_avg(BITJOIN,85)
    bubble_join_i_store_memdep_avg_q <= i_store_memdep_avg_out_o_writeack;

    -- bubble_select_i_store_memdep_avg(BITSELECT,86)
    bubble_select_i_store_memdep_avg_b <= STD_LOGIC_VECTOR(bubble_join_i_store_memdep_avg_q(0 downto 0));

    -- bubble_join_redist2_stall_entry_aunroll_o13_45_fifo(BITJOIN,99)
    bubble_join_redist2_stall_entry_aunroll_o13_45_fifo_q <= redist2_stall_entry_aunroll_o13_45_fifo_data_out;

    -- bubble_select_redist2_stall_entry_aunroll_o13_45_fifo(BITSELECT,100)
    bubble_select_redist2_stall_entry_aunroll_o13_45_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist2_stall_entry_aunroll_o13_45_fifo_q(0 downto 0));

    -- i_acl_push_i1_memdep_phi_push10_avg(BLACKBOX,32)@45
    -- in in_stall_in@20000000
    -- out out_data_out@46
    -- out out_feedback_out_10@20000000
    -- out out_feedback_valid_out_10@20000000
    -- out out_stall_out@20000000
    -- out out_valid_out@46
    thei_acl_push_i1_memdep_phi_push10_avg : i_acl_push_i1_memdep_phi_push10_avg90
    PORT MAP (
        in_c0_exe9 => bubble_select_redist2_stall_entry_aunroll_o13_45_fifo_b,
        in_data_in => bubble_select_i_store_memdep_avg_b,
        in_feedback_stall_in_10 => in_feedback_stall_in_10,
        in_stall_in => SE_out_redist1_stall_entry_aunroll_o12_46_fifo_backStall,
        in_valid_in => SE_out_redist2_stall_entry_aunroll_o13_45_fifo_V0,
        out_feedback_out_10 => i_acl_push_i1_memdep_phi_push10_avg_out_feedback_out_10,
        out_feedback_valid_out_10 => i_acl_push_i1_memdep_phi_push10_avg_out_feedback_valid_out_10,
        out_stall_out => i_acl_push_i1_memdep_phi_push10_avg_out_stall_out,
        out_valid_out => i_acl_push_i1_memdep_phi_push10_avg_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_redist1_stall_entry_aunroll_o12_46_fifo(STALLENABLE,130)
    -- Valid signal propagation
    SE_out_redist1_stall_entry_aunroll_o12_46_fifo_V0 <= SE_out_redist1_stall_entry_aunroll_o12_46_fifo_wireValid;
    -- Backward Stall generation
    SE_out_redist1_stall_entry_aunroll_o12_46_fifo_backStall <= in_stall_in or not (SE_out_redist1_stall_entry_aunroll_o12_46_fifo_wireValid);
    -- Computing multiple Valid(s)
    SE_out_redist1_stall_entry_aunroll_o12_46_fifo_and0 <= redist1_stall_entry_aunroll_o12_46_fifo_valid_out;
    SE_out_redist1_stall_entry_aunroll_o12_46_fifo_wireValid <= i_acl_push_i1_memdep_phi_push10_avg_out_valid_out and SE_out_redist1_stall_entry_aunroll_o12_46_fifo_and0;

    -- redist1_stall_entry_aunroll_o12_46_fifo(STALLFIFO,74)
    redist1_stall_entry_aunroll_o12_46_fifo_valid_in <= SE_stall_entry_aunroll_V3;
    redist1_stall_entry_aunroll_o12_46_fifo_stall_in <= SE_out_redist1_stall_entry_aunroll_o12_46_fifo_backStall;
    redist1_stall_entry_aunroll_o12_46_fifo_data_in <= bubble_select_stall_entry_aunroll_c;
    redist1_stall_entry_aunroll_o12_46_fifo_valid_in_bitsignaltemp <= redist1_stall_entry_aunroll_o12_46_fifo_valid_in(0);
    redist1_stall_entry_aunroll_o12_46_fifo_stall_in_bitsignaltemp <= redist1_stall_entry_aunroll_o12_46_fifo_stall_in(0);
    redist1_stall_entry_aunroll_o12_46_fifo_valid_out(0) <= redist1_stall_entry_aunroll_o12_46_fifo_valid_out_bitsignaltemp;
    redist1_stall_entry_aunroll_o12_46_fifo_stall_out(0) <= redist1_stall_entry_aunroll_o12_46_fifo_stall_out_bitsignaltemp;
    theredist1_stall_entry_aunroll_o12_46_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 47,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 1,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist1_stall_entry_aunroll_o12_46_fifo_valid_in_bitsignaltemp,
        stall_in => redist1_stall_entry_aunroll_o12_46_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_stall_entry_aunroll_c,
        valid_out => redist1_stall_entry_aunroll_o12_46_fifo_valid_out_bitsignaltemp,
        stall_out => redist1_stall_entry_aunroll_o12_46_fifo_stall_out_bitsignaltemp,
        data_out => redist1_stall_entry_aunroll_o12_46_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0(STALLENABLE,133)
    -- Valid signal propagation
    SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_V0 <= SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_R_v_0;
    -- Stall signal propagation
    SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_s_tv_0 <= SE_out_i_ffwd_dst_y67_avg_backStall and SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_R_v_0;
    -- Backward Enable generation
    SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_backEN <= not (SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_s_tv_0);
    -- Determine whether to write valid data into the first register stage
    SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_v_s_0 <= SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_backEN and SE_out_redist0_stall_entry_aunroll_o5_13_fifo_V0;
    -- Backward Stall generation
    SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_backStall <= not (SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_v_s_0);
    SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_R_v_0 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_backEN = "0") THEN
                SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_R_v_0 <= SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_R_v_0 and SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_s_tv_0;
            ELSE
                SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_R_v_0 <= SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_v_s_0;
            END IF;

        END IF;
    END PROCESS;

    -- SE_out_redist0_stall_entry_aunroll_o5_13_fifo(STALLENABLE,128)
    -- Valid signal propagation
    SE_out_redist0_stall_entry_aunroll_o5_13_fifo_V0 <= SE_out_redist0_stall_entry_aunroll_o5_13_fifo_wireValid;
    -- Backward Stall generation
    SE_out_redist0_stall_entry_aunroll_o5_13_fifo_backStall <= SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_backStall or not (SE_out_redist0_stall_entry_aunroll_o5_13_fifo_wireValid);
    -- Computing multiple Valid(s)
    SE_out_redist0_stall_entry_aunroll_o5_13_fifo_wireValid <= redist0_stall_entry_aunroll_o5_13_fifo_valid_out;

    -- redist0_stall_entry_aunroll_o5_13_fifo(STALLFIFO,73)
    redist0_stall_entry_aunroll_o5_13_fifo_valid_in <= SE_stall_entry_aunroll_V2;
    redist0_stall_entry_aunroll_o5_13_fifo_stall_in <= SE_out_redist0_stall_entry_aunroll_o5_13_fifo_backStall;
    redist0_stall_entry_aunroll_o5_13_fifo_data_in <= bubble_select_stall_entry_aunroll_b;
    redist0_stall_entry_aunroll_o5_13_fifo_valid_in_bitsignaltemp <= redist0_stall_entry_aunroll_o5_13_fifo_valid_in(0);
    redist0_stall_entry_aunroll_o5_13_fifo_stall_in_bitsignaltemp <= redist0_stall_entry_aunroll_o5_13_fifo_stall_in(0);
    redist0_stall_entry_aunroll_o5_13_fifo_valid_out(0) <= redist0_stall_entry_aunroll_o5_13_fifo_valid_out_bitsignaltemp;
    redist0_stall_entry_aunroll_o5_13_fifo_stall_out(0) <= redist0_stall_entry_aunroll_o5_13_fifo_stall_out_bitsignaltemp;
    theredist0_stall_entry_aunroll_o5_13_fifo : acl_data_fifo
    GENERIC MAP (
        DEPTH => 14,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        DATA_WIDTH => 32,
        IMPL => "ram"
    )
    PORT MAP (
        valid_in => redist0_stall_entry_aunroll_o5_13_fifo_valid_in_bitsignaltemp,
        stall_in => redist0_stall_entry_aunroll_o5_13_fifo_stall_in_bitsignaltemp,
        data_in => bubble_select_stall_entry_aunroll_b,
        valid_out => redist0_stall_entry_aunroll_o5_13_fifo_valid_out_bitsignaltemp,
        stall_out => redist0_stall_entry_aunroll_o5_13_fifo_stall_out_bitsignaltemp,
        data_out => redist0_stall_entry_aunroll_o5_13_fifo_data_out,
        clock => clock,
        resetn => resetn
    );

    -- i_ffwd_dst_y67_avg(BLACKBOX,33)@14
    -- in in_stall_in@20000000
    -- out out_stall_out@20000000
    thei_ffwd_dst_y67_avg : i_ffwd_dst_y67_avg85
    PORT MAP (
        in_intel_reserved_ffwd_1_0 => in_intel_reserved_ffwd_1_0,
        in_stall_in => SE_out_i_ffwd_dst_y67_avg_backStall,
        in_valid_in => SE_out_bubble_out_stall_entry_aunroll_1_V0,
        out_dest_data_out_1_0 => i_ffwd_dst_y67_avg_out_dest_data_out_1_0,
        out_stall_out => i_ffwd_dst_y67_avg_out_stall_out,
        out_valid_out => i_ffwd_dst_y67_avg_out_valid_out,
        clock => clock,
        resetn => resetn
    );

    -- SE_out_bubble_out_stall_entry_aunroll_1(STALLENABLE,153)
    -- Valid signal propagation
    SE_out_bubble_out_stall_entry_aunroll_1_V0 <= SE_out_bubble_out_stall_entry_aunroll_1_wireValid;
    -- Backward Stall generation
    SE_out_bubble_out_stall_entry_aunroll_1_backStall <= i_ffwd_dst_y67_avg_out_stall_out or not (SE_out_bubble_out_stall_entry_aunroll_1_wireValid);
    -- Computing multiple Valid(s)
    SE_out_bubble_out_stall_entry_aunroll_1_wireValid <= bubble_out_stall_entry_aunroll_1_reg_valid_out;

    -- bubble_out_stall_entry_aunroll_1_reg(STALLFIFO,168)
    bubble_out_stall_entry_aunroll_1_reg_valid_in <= SE_stall_entry_aunroll_V0;
    bubble_out_stall_entry_aunroll_1_reg_stall_in <= SE_out_bubble_out_stall_entry_aunroll_1_backStall;
    bubble_out_stall_entry_aunroll_1_reg_valid_in_bitsignaltemp <= bubble_out_stall_entry_aunroll_1_reg_valid_in(0);
    bubble_out_stall_entry_aunroll_1_reg_stall_in_bitsignaltemp <= bubble_out_stall_entry_aunroll_1_reg_stall_in(0);
    bubble_out_stall_entry_aunroll_1_reg_valid_out(0) <= bubble_out_stall_entry_aunroll_1_reg_valid_out_bitsignaltemp;
    bubble_out_stall_entry_aunroll_1_reg_stall_out(0) <= bubble_out_stall_entry_aunroll_1_reg_stall_out_bitsignaltemp;
    thebubble_out_stall_entry_aunroll_1_reg : acl_valid_fifo_counter
    GENERIC MAP (
        DEPTH => 15,
        STRICT_DEPTH => 0,
        ALLOW_FULL_WRITE => 0,
        ASYNC_RESET => 1
    )
    PORT MAP (
        valid_in => bubble_out_stall_entry_aunroll_1_reg_valid_in_bitsignaltemp,
        stall_in => bubble_out_stall_entry_aunroll_1_reg_stall_in_bitsignaltemp,
        valid_out => bubble_out_stall_entry_aunroll_1_reg_valid_out_bitsignaltemp,
        stall_out => bubble_out_stall_entry_aunroll_1_reg_stall_out_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- SE_stall_entry_aunroll(STALLENABLE,114)
    SE_stall_entry_aunroll_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            SE_stall_entry_aunroll_fromReg0 <= (others => '0');
            SE_stall_entry_aunroll_fromReg1 <= (others => '0');
            SE_stall_entry_aunroll_fromReg2 <= (others => '0');
            SE_stall_entry_aunroll_fromReg3 <= (others => '0');
            SE_stall_entry_aunroll_fromReg4 <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            -- Succesor 0
            SE_stall_entry_aunroll_fromReg0 <= SE_stall_entry_aunroll_toReg0;
            -- Succesor 1
            SE_stall_entry_aunroll_fromReg1 <= SE_stall_entry_aunroll_toReg1;
            -- Succesor 2
            SE_stall_entry_aunroll_fromReg2 <= SE_stall_entry_aunroll_toReg2;
            -- Succesor 3
            SE_stall_entry_aunroll_fromReg3 <= SE_stall_entry_aunroll_toReg3;
            -- Succesor 4
            SE_stall_entry_aunroll_fromReg4 <= SE_stall_entry_aunroll_toReg4;
        END IF;
    END PROCESS;
    -- Input Stall processing
    SE_stall_entry_aunroll_consumed0 <= (not (bubble_out_stall_entry_aunroll_1_reg_stall_out) and SE_stall_entry_aunroll_wireValid) or SE_stall_entry_aunroll_fromReg0;
    SE_stall_entry_aunroll_consumed1 <= (not (i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x_out_o_stall) and SE_stall_entry_aunroll_wireValid) or SE_stall_entry_aunroll_fromReg1;
    SE_stall_entry_aunroll_consumed2 <= (not (redist0_stall_entry_aunroll_o5_13_fifo_stall_out) and SE_stall_entry_aunroll_wireValid) or SE_stall_entry_aunroll_fromReg2;
    SE_stall_entry_aunroll_consumed3 <= (not (redist1_stall_entry_aunroll_o12_46_fifo_stall_out) and SE_stall_entry_aunroll_wireValid) or SE_stall_entry_aunroll_fromReg3;
    SE_stall_entry_aunroll_consumed4 <= (not (redist2_stall_entry_aunroll_o13_45_fifo_stall_out) and SE_stall_entry_aunroll_wireValid) or SE_stall_entry_aunroll_fromReg4;
    -- Consuming
    SE_stall_entry_aunroll_StallValid <= SE_stall_entry_aunroll_backStall and SE_stall_entry_aunroll_wireValid;
    SE_stall_entry_aunroll_toReg0 <= SE_stall_entry_aunroll_StallValid and SE_stall_entry_aunroll_consumed0;
    SE_stall_entry_aunroll_toReg1 <= SE_stall_entry_aunroll_StallValid and SE_stall_entry_aunroll_consumed1;
    SE_stall_entry_aunroll_toReg2 <= SE_stall_entry_aunroll_StallValid and SE_stall_entry_aunroll_consumed2;
    SE_stall_entry_aunroll_toReg3 <= SE_stall_entry_aunroll_StallValid and SE_stall_entry_aunroll_consumed3;
    SE_stall_entry_aunroll_toReg4 <= SE_stall_entry_aunroll_StallValid and SE_stall_entry_aunroll_consumed4;
    -- Backward Stall generation
    SE_stall_entry_aunroll_or0 <= SE_stall_entry_aunroll_consumed0;
    SE_stall_entry_aunroll_or1 <= SE_stall_entry_aunroll_consumed1 and SE_stall_entry_aunroll_or0;
    SE_stall_entry_aunroll_or2 <= SE_stall_entry_aunroll_consumed2 and SE_stall_entry_aunroll_or1;
    SE_stall_entry_aunroll_or3 <= SE_stall_entry_aunroll_consumed3 and SE_stall_entry_aunroll_or2;
    SE_stall_entry_aunroll_wireStall <= not (SE_stall_entry_aunroll_consumed4 and SE_stall_entry_aunroll_or3);
    SE_stall_entry_aunroll_backStall <= SE_stall_entry_aunroll_wireStall;
    -- Valid signal propagation
    SE_stall_entry_aunroll_V0 <= SE_stall_entry_aunroll_wireValid and not (SE_stall_entry_aunroll_fromReg0);
    SE_stall_entry_aunroll_V1 <= SE_stall_entry_aunroll_wireValid and not (SE_stall_entry_aunroll_fromReg1);
    SE_stall_entry_aunroll_V2 <= SE_stall_entry_aunroll_wireValid and not (SE_stall_entry_aunroll_fromReg2);
    SE_stall_entry_aunroll_V3 <= SE_stall_entry_aunroll_wireValid and not (SE_stall_entry_aunroll_fromReg3);
    SE_stall_entry_aunroll_V4 <= SE_stall_entry_aunroll_wireValid and not (SE_stall_entry_aunroll_fromReg4);
    -- Computing multiple Valid(s)
    SE_stall_entry_aunroll_wireValid <= in_valid_in;

    -- bubble_join_stall_entry_aunroll(BITJOIN,88)
    bubble_join_stall_entry_aunroll_q <= in_c1_exit2_1 & in_c0_exit311_9 & in_c0_exit311_8 & in_c0_exit311_1;

    -- bubble_select_stall_entry_aunroll(BITSELECT,89)
    bubble_select_stall_entry_aunroll_b <= STD_LOGIC_VECTOR(bubble_join_stall_entry_aunroll_q(31 downto 0));
    bubble_select_stall_entry_aunroll_c <= STD_LOGIC_VECTOR(bubble_join_stall_entry_aunroll_q(32 downto 32));
    bubble_select_stall_entry_aunroll_d <= STD_LOGIC_VECTOR(bubble_join_stall_entry_aunroll_q(33 downto 33));
    bubble_select_stall_entry_aunroll_e <= STD_LOGIC_VECTOR(bubble_join_stall_entry_aunroll_q(65 downto 34));

    -- i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x(BLACKBOX,23)@0
    -- in in_i_stall@20000000
    -- out out_c0_exit39_0@14
    -- out out_c0_exit39_1@14
    -- out out_o_stall@20000000
    -- out out_o_valid@14
    thei_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x : i_sfc_c0_for_end_avg_c0_enter36_avg
    PORT MAP (
        in_c0_eni135_0 => GND_q,
        in_c0_eni135_1 => bubble_select_stall_entry_aunroll_e,
        in_i_stall => SE_out_i_ffwd_dst_y67_avg_backStall,
        in_i_valid => SE_stall_entry_aunroll_V1,
        out_c0_exit39_1 => i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x_out_c0_exit39_1,
        out_o_stall => i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x_out_o_stall,
        out_o_valid => i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x_out_o_valid,
        clock => clock,
        resetn => resetn
    );

    -- bubble_join_i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x(BITJOIN,78)
    bubble_join_i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x_q <= i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x_out_c0_exit39_1;

    -- bubble_select_i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x(BITSELECT,79)
    bubble_select_i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x_b <= STD_LOGIC_VECTOR(bubble_join_i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x_q(31 downto 0));

    -- SE_out_i_ffwd_dst_y67_avg(STALLENABLE,111)
    -- Valid signal propagation
    SE_out_i_ffwd_dst_y67_avg_V0 <= SE_out_i_ffwd_dst_y67_avg_wireValid;
    -- Backward Stall generation
    SE_out_i_ffwd_dst_y67_avg_backStall <= i_store_memdep_avg_out_o_stall or not (SE_out_i_ffwd_dst_y67_avg_wireValid);
    -- Computing multiple Valid(s)
    SE_out_i_ffwd_dst_y67_avg_and0 <= i_ffwd_dst_y67_avg_out_valid_out;
    SE_out_i_ffwd_dst_y67_avg_and1 <= SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_V0 and SE_out_i_ffwd_dst_y67_avg_and0;
    SE_out_i_ffwd_dst_y67_avg_wireValid <= i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x_out_o_valid and SE_out_i_ffwd_dst_y67_avg_and1;

    -- SE_out_redist2_stall_entry_aunroll_o13_45_fifo(STALLENABLE,132)
    -- Valid signal propagation
    SE_out_redist2_stall_entry_aunroll_o13_45_fifo_V0 <= SE_out_redist2_stall_entry_aunroll_o13_45_fifo_wireValid;
    -- Backward Stall generation
    SE_out_redist2_stall_entry_aunroll_o13_45_fifo_backStall <= i_acl_push_i1_memdep_phi_push10_avg_out_stall_out or not (SE_out_redist2_stall_entry_aunroll_o13_45_fifo_wireValid);
    -- Computing multiple Valid(s)
    SE_out_redist2_stall_entry_aunroll_o13_45_fifo_and0 <= redist2_stall_entry_aunroll_o13_45_fifo_valid_out;
    SE_out_redist2_stall_entry_aunroll_o13_45_fifo_wireValid <= i_store_memdep_avg_out_o_valid and SE_out_redist2_stall_entry_aunroll_o13_45_fifo_and0;

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- i_arrayidx8_avg_avg87_mult_multconst_x(CONSTANT,16)
    i_arrayidx8_avg_avg87_mult_multconst_x_q <= "0000000000000000000000000000000000000000000000000000000000000";

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- bubble_join_redist0_stall_entry_aunroll_o5_13_fifo(BITJOIN,93)
    bubble_join_redist0_stall_entry_aunroll_o5_13_fifo_q <= redist0_stall_entry_aunroll_o5_13_fifo_data_out;

    -- bubble_select_redist0_stall_entry_aunroll_o5_13_fifo(BITSELECT,94)
    bubble_select_redist0_stall_entry_aunroll_o5_13_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist0_stall_entry_aunroll_o5_13_fifo_q(31 downto 0));

    -- i_idxprom7_avg_sel_x(BITSELECT,22)@13
    i_idxprom7_avg_sel_x_b <= STD_LOGIC_VECTOR(std_logic_vector(resize(signed(bubble_select_redist0_stall_entry_aunroll_o5_13_fifo_b(31 downto 0)), 64)));

    -- i_arrayidx8_avg_avg87_mult_x_bs1_merged_bit_select(BITSELECT,68)@13
    i_arrayidx8_avg_avg87_mult_x_bs1_merged_bit_select_b <= i_idxprom7_avg_sel_x_b(17 downto 0);
    i_arrayidx8_avg_avg87_mult_x_bs1_merged_bit_select_c <= i_idxprom7_avg_sel_x_b(63 downto 54);
    i_arrayidx8_avg_avg87_mult_x_bs1_merged_bit_select_d <= i_idxprom7_avg_sel_x_b(35 downto 18);
    i_arrayidx8_avg_avg87_mult_x_bs1_merged_bit_select_e <= i_idxprom7_avg_sel_x_b(53 downto 36);

    -- i_arrayidx8_avg_avg87_mult_x_im3_shift0(BITSHIFT,65)@13
    i_arrayidx8_avg_avg87_mult_x_im3_shift0_qint <= i_arrayidx8_avg_avg87_mult_x_bs1_merged_bit_select_c & "00";
    i_arrayidx8_avg_avg87_mult_x_im3_shift0_q <= i_arrayidx8_avg_avg87_mult_x_im3_shift0_qint(11 downto 0);

    -- i_arrayidx8_avg_avg87_mult_x_align_15(BITSHIFT,60)@13
    i_arrayidx8_avg_avg87_mult_x_align_15_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx8_avg_avg87_mult_x_im3_shift0_q) & "000000000000000";
    i_arrayidx8_avg_avg87_mult_x_align_15_q <= i_arrayidx8_avg_avg87_mult_x_align_15_qint(27 downto 0);

    -- i_arrayidx8_avg_avg87_mult_x_im6_shift0(BITSHIFT,66)@13
    i_arrayidx8_avg_avg87_mult_x_im6_shift0_qint <= i_arrayidx8_avg_avg87_mult_x_bs1_merged_bit_select_d & "00";
    i_arrayidx8_avg_avg87_mult_x_im6_shift0_q <= i_arrayidx8_avg_avg87_mult_x_im6_shift0_qint(19 downto 0);

    -- i_arrayidx8_avg_avg87_mult_x_align_14(BITSHIFT,59)@13
    i_arrayidx8_avg_avg87_mult_x_align_14_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx8_avg_avg87_mult_x_im6_shift0_q) & "000000000000000000";
    i_arrayidx8_avg_avg87_mult_x_align_14_q <= i_arrayidx8_avg_avg87_mult_x_align_14_qint(38 downto 0);

    -- i_arrayidx8_avg_avg87_mult_x_join_16(BITJOIN,61)@13
    i_arrayidx8_avg_avg87_mult_x_join_16_q <= i_arrayidx8_avg_avg87_mult_x_align_15_q & i_arrayidx8_avg_avg87_mult_x_align_14_q;

    -- i_arrayidx8_avg_avg87_mult_x_im9_shift0(BITSHIFT,67)@13
    i_arrayidx8_avg_avg87_mult_x_im9_shift0_qint <= i_arrayidx8_avg_avg87_mult_x_bs1_merged_bit_select_e & "00";
    i_arrayidx8_avg_avg87_mult_x_im9_shift0_q <= i_arrayidx8_avg_avg87_mult_x_im9_shift0_qint(19 downto 0);

    -- i_arrayidx8_avg_avg87_mult_x_align_12(BITSHIFT,57)@13
    i_arrayidx8_avg_avg87_mult_x_align_12_qint <= STD_LOGIC_VECTOR("0" & i_arrayidx8_avg_avg87_mult_x_im9_shift0_q) & "000000000000000";
    i_arrayidx8_avg_avg87_mult_x_align_12_q <= i_arrayidx8_avg_avg87_mult_x_align_12_qint(35 downto 0);

    -- i_arrayidx8_avg_avg87_mult_x_im0_shift0(BITSHIFT,64)@13
    i_arrayidx8_avg_avg87_mult_x_im0_shift0_qint <= i_arrayidx8_avg_avg87_mult_x_bs1_merged_bit_select_b & "00";
    i_arrayidx8_avg_avg87_mult_x_im0_shift0_q <= i_arrayidx8_avg_avg87_mult_x_im0_shift0_qint(19 downto 0);

    -- i_arrayidx8_avg_avg87_mult_x_join_13(BITJOIN,58)@13
    i_arrayidx8_avg_avg87_mult_x_join_13_q <= i_arrayidx8_avg_avg87_mult_x_align_12_q & STD_LOGIC_VECTOR("0" & i_arrayidx8_avg_avg87_mult_x_im0_shift0_q);

    -- i_arrayidx8_avg_avg87_mult_x_result_add_0_0(ADD,62)@13
    i_arrayidx8_avg_avg87_mult_x_result_add_0_0_a <= STD_LOGIC_VECTOR("00000000000" & i_arrayidx8_avg_avg87_mult_x_join_13_q);
    i_arrayidx8_avg_avg87_mult_x_result_add_0_0_b <= STD_LOGIC_VECTOR("0" & i_arrayidx8_avg_avg87_mult_x_join_16_q);
    i_arrayidx8_avg_avg87_mult_x_result_add_0_0_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx8_avg_avg87_mult_x_result_add_0_0_a) + UNSIGNED(i_arrayidx8_avg_avg87_mult_x_result_add_0_0_b));
    i_arrayidx8_avg_avg87_mult_x_result_add_0_0_q <= i_arrayidx8_avg_avg87_mult_x_result_add_0_0_o(67 downto 0);

    -- i_arrayidx8_avg_avg87_mult_extender_x(BITJOIN,15)@13
    i_arrayidx8_avg_avg87_mult_extender_x_q <= i_arrayidx8_avg_avg87_mult_multconst_x_q & i_arrayidx8_avg_avg87_mult_x_result_add_0_0_q(66 downto 0);

    -- i_arrayidx8_avg_avg87_trunc_sel_x(BITSELECT,17)@13
    i_arrayidx8_avg_avg87_trunc_sel_x_b <= i_arrayidx8_avg_avg87_mult_extender_x_q(63 downto 0);

    -- redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0(REG,76)
    redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_q <= "0000000000000000000000000000000000000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (SE_redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_backEN = "1") THEN
                redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_q <= STD_LOGIC_VECTOR(i_arrayidx8_avg_avg87_trunc_sel_x_b);
            END IF;
        END IF;
    END PROCESS;

    -- bubble_join_i_ffwd_dst_y67_avg(BITJOIN,82)
    bubble_join_i_ffwd_dst_y67_avg_q <= i_ffwd_dst_y67_avg_out_dest_data_out_1_0;

    -- bubble_select_i_ffwd_dst_y67_avg(BITSELECT,83)
    bubble_select_i_ffwd_dst_y67_avg_b <= STD_LOGIC_VECTOR(bubble_join_i_ffwd_dst_y67_avg_q(63 downto 0));

    -- i_arrayidx8_avg_avg87_add_x(ADD,18)@14
    i_arrayidx8_avg_avg87_add_x_a <= STD_LOGIC_VECTOR("0" & bubble_select_i_ffwd_dst_y67_avg_b);
    i_arrayidx8_avg_avg87_add_x_b <= STD_LOGIC_VECTOR("0" & redist3_i_arrayidx8_avg_avg87_trunc_sel_x_b_1_0_q);
    i_arrayidx8_avg_avg87_add_x_o <= STD_LOGIC_VECTOR(UNSIGNED(i_arrayidx8_avg_avg87_add_x_a) + UNSIGNED(i_arrayidx8_avg_avg87_add_x_b));
    i_arrayidx8_avg_avg87_add_x_q <= i_arrayidx8_avg_avg87_add_x_o(64 downto 0);

    -- i_arrayidx8_avg_avg87_dupName_0_trunc_sel_x(BITSELECT,12)@14
    i_arrayidx8_avg_avg87_dupName_0_trunc_sel_x_b <= i_arrayidx8_avg_avg87_add_x_q(63 downto 0);

    -- i_store_memdep_avg(BLACKBOX,36)@14
    -- in in_i_stall@20000000
    -- out out_lsu_memdep_o_active@20000000
    -- out out_memdep_avm_address@20000000
    -- out out_memdep_avm_burstcount@20000000
    -- out out_memdep_avm_byteenable@20000000
    -- out out_memdep_avm_enable@20000000
    -- out out_memdep_avm_read@20000000
    -- out out_memdep_avm_write@20000000
    -- out out_memdep_avm_writedata@20000000
    -- out out_o_stall@20000000
    -- out out_o_valid@45
    -- out out_o_writeack@45
    thei_store_memdep_avg : i_store_memdep_avg88
    PORT MAP (
        in_flush => in_flush,
        in_i_address => i_arrayidx8_avg_avg87_dupName_0_trunc_sel_x_b,
        in_i_predicate => GND_q,
        in_i_stall => SE_out_redist2_stall_entry_aunroll_o13_45_fifo_backStall,
        in_i_valid => SE_out_i_ffwd_dst_y67_avg_V0,
        in_i_writedata => bubble_select_i_sfc_c0_for_end_avg_c0_enter36_avg_aunroll_x_b,
        in_memdep_avm_readdata => in_memdep_avm_readdata,
        in_memdep_avm_readdatavalid => in_memdep_avm_readdatavalid,
        in_memdep_avm_waitrequest => in_memdep_avm_waitrequest,
        in_memdep_avm_writeack => in_memdep_avm_writeack,
        out_lsu_memdep_o_active => i_store_memdep_avg_out_lsu_memdep_o_active,
        out_memdep_avm_address => i_store_memdep_avg_out_memdep_avm_address,
        out_memdep_avm_burstcount => i_store_memdep_avg_out_memdep_avm_burstcount,
        out_memdep_avm_byteenable => i_store_memdep_avg_out_memdep_avm_byteenable,
        out_memdep_avm_enable => i_store_memdep_avg_out_memdep_avm_enable,
        out_memdep_avm_read => i_store_memdep_avg_out_memdep_avm_read,
        out_memdep_avm_write => i_store_memdep_avg_out_memdep_avm_write,
        out_memdep_avm_writedata => i_store_memdep_avg_out_memdep_avm_writedata,
        out_o_stall => i_store_memdep_avg_out_o_stall,
        out_o_valid => i_store_memdep_avg_out_o_valid,
        out_o_writeack => i_store_memdep_avg_out_o_writeack,
        clock => clock,
        resetn => resetn
    );

    -- dupName_0_ext_sig_sync_out_x(GPOUT,3)
    out_lsu_memdep_o_active <= i_store_memdep_avg_out_lsu_memdep_o_active;

    -- bubble_join_redist1_stall_entry_aunroll_o12_46_fifo(BITJOIN,96)
    bubble_join_redist1_stall_entry_aunroll_o12_46_fifo_q <= redist1_stall_entry_aunroll_o12_46_fifo_data_out;

    -- bubble_select_redist1_stall_entry_aunroll_o12_46_fifo(BITSELECT,97)
    bubble_select_redist1_stall_entry_aunroll_o12_46_fifo_b <= STD_LOGIC_VECTOR(bubble_join_redist1_stall_entry_aunroll_o12_46_fifo_q(0 downto 0));

    -- dupName_0_sync_out_x(GPOUT,7)@46
    out_c0_exe8 <= bubble_select_redist1_stall_entry_aunroll_o12_46_fifo_b;
    out_valid_out <= SE_out_redist1_stall_entry_aunroll_o12_46_fifo_V0;

    -- ext_sig_sync_out(GPOUT,28)
    out_memdep_avm_address <= i_store_memdep_avg_out_memdep_avm_address;
    out_memdep_avm_enable <= i_store_memdep_avg_out_memdep_avm_enable;
    out_memdep_avm_read <= i_store_memdep_avg_out_memdep_avm_read;
    out_memdep_avm_write <= i_store_memdep_avg_out_memdep_avm_write;
    out_memdep_avm_writedata <= i_store_memdep_avg_out_memdep_avm_writedata;
    out_memdep_avm_byteenable <= i_store_memdep_avg_out_memdep_avm_byteenable;
    out_memdep_avm_burstcount <= i_store_memdep_avg_out_memdep_avm_burstcount;

    -- feedback_out_10_sync(GPOUT,29)
    out_feedback_out_10 <= i_acl_push_i1_memdep_phi_push10_avg_out_feedback_out_10;

    -- feedback_valid_out_10_sync(GPOUT,31)
    out_feedback_valid_out_10 <= i_acl_push_i1_memdep_phi_push10_avg_out_feedback_valid_out_10;

    -- sync_out(GPOUT,44)@0
    out_stall_out <= SE_stall_entry_aunroll_backStall;

END normal;
