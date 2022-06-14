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

-- VHDL created from avg_function_wrapper
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

entity avg_function_wrapper is
    port (
        avm_memdep_readdata : in std_logic_vector(63 downto 0);  -- ufix64
        avm_memdep_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        avm_memdep_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        avm_memdep_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_avg4_readdata : in std_logic_vector(63 downto 0);  -- ufix64
        avm_unnamed_avg4_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_avg4_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_avg4_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        avst_iord_bl_do_data : in std_logic_vector(127 downto 0);  -- ufix128
        avst_iord_bl_do_valid : in std_logic_vector(0 downto 0);  -- ufix1
        avst_iowr_bl_return_almostfull : in std_logic_vector(0 downto 0);  -- ufix1
        avst_iowr_bl_return_ready : in std_logic_vector(0 downto 0);  -- ufix1
        stall : in std_logic_vector(0 downto 0);  -- ufix1
        stall_in : in std_logic_vector(0 downto 0);  -- ufix1
        start : in std_logic_vector(0 downto 0);  -- ufix1
        valid_in : in std_logic_vector(0 downto 0);  -- ufix1
        x : in std_logic_vector(63 downto 0);  -- ufix64
        y : in std_logic_vector(63 downto 0);  -- ufix64
        avm_memdep_address : out std_logic_vector(63 downto 0);  -- ufix64
        avm_memdep_burstcount : out std_logic_vector(0 downto 0);  -- ufix1
        avm_memdep_byteenable : out std_logic_vector(7 downto 0);  -- ufix8
        avm_memdep_enable : out std_logic_vector(0 downto 0);  -- ufix1
        avm_memdep_read : out std_logic_vector(0 downto 0);  -- ufix1
        avm_memdep_write : out std_logic_vector(0 downto 0);  -- ufix1
        avm_memdep_writedata : out std_logic_vector(63 downto 0);  -- ufix64
        avm_unnamed_avg4_address : out std_logic_vector(63 downto 0);  -- ufix64
        avm_unnamed_avg4_burstcount : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_avg4_byteenable : out std_logic_vector(7 downto 0);  -- ufix8
        avm_unnamed_avg4_enable : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_avg4_read : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_avg4_write : out std_logic_vector(0 downto 0);  -- ufix1
        avm_unnamed_avg4_writedata : out std_logic_vector(63 downto 0);  -- ufix64
        avst_iord_bl_do_ready : out std_logic_vector(0 downto 0);  -- ufix1
        avst_iowr_bl_return_data : out std_logic_vector(0 downto 0);  -- ufix1
        avst_iowr_bl_return_valid : out std_logic_vector(0 downto 0);  -- ufix1
        busy : out std_logic_vector(0 downto 0);  -- ufix1
        done : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end avg_function_wrapper;

architecture normal of avg_function_wrapper is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component avg_function is
        port (
            in_arg_do : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_arg_return : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_arg_x : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_arg_y : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_iord_bl_do_i_fifodata : in std_logic_vector(127 downto 0);  -- Fixed Point
            in_iord_bl_do_i_fifovalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_iowr_bl_return_i_fifoready : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_memdep_avm_readdata : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_memdep_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_memdep_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_memdep_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_stall_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_start : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_avg4_avm_readdata : in std_logic_vector(63 downto 0);  -- Fixed Point
            in_unnamed_avg4_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_avg4_avm_waitrequest : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_unnamed_avg4_avm_writeack : in std_logic_vector(0 downto 0);  -- Fixed Point
            in_valid_in : in std_logic_vector(0 downto 0);  -- Fixed Point
            out_iord_bl_do_o_fifoready : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_iowr_bl_return_o_fifodata : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_iowr_bl_return_o_fifovalid : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_avm_address : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_memdep_avm_burstcount : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_avm_byteenable : out std_logic_vector(7 downto 0);  -- Fixed Point
            out_memdep_avm_enable : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_avm_read : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_avm_write : out std_logic_vector(0 downto 0);  -- Fixed Point
            out_memdep_avm_writedata : out std_logic_vector(63 downto 0);  -- Fixed Point
            out_o_active_memdep : out std_logic_vector(0 downto 0);  -- Fixed Point
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


    component acl_reset_wire is
        port (
            o_resetn : out std_logic;
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_function_out_iord_bl_do_o_fifoready : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_function_out_iowr_bl_return_o_fifodata : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_function_out_iowr_bl_return_o_fifovalid : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_function_out_memdep_avm_address : STD_LOGIC_VECTOR (63 downto 0);
    signal avg_function_out_memdep_avm_burstcount : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_function_out_memdep_avm_byteenable : STD_LOGIC_VECTOR (7 downto 0);
    signal avg_function_out_memdep_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_function_out_memdep_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_function_out_memdep_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_function_out_memdep_avm_writedata : STD_LOGIC_VECTOR (63 downto 0);
    signal avg_function_out_unnamed_avg4_avm_address : STD_LOGIC_VECTOR (63 downto 0);
    signal avg_function_out_unnamed_avg4_avm_burstcount : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_function_out_unnamed_avg4_avm_byteenable : STD_LOGIC_VECTOR (7 downto 0);
    signal avg_function_out_unnamed_avg4_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_function_out_unnamed_avg4_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_function_out_unnamed_avg4_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_function_out_unnamed_avg4_avm_writedata : STD_LOGIC_VECTOR (63 downto 0);
    signal busy_and_q : STD_LOGIC_VECTOR (0 downto 0);
    signal busy_or_q : STD_LOGIC_VECTOR (0 downto 0);
    signal do_const_q : STD_LOGIC_VECTOR (63 downto 0);
    signal implicit_input_q : STD_LOGIC_VECTOR (127 downto 0);
    signal not_ready_q : STD_LOGIC_VECTOR (0 downto 0);
    signal not_stall_q : STD_LOGIC_VECTOR (0 downto 0);
    signal pos_reset_q : STD_LOGIC_VECTOR (0 downto 0);
    signal reset_wire_inst_o_resetn : STD_LOGIC_VECTOR (0 downto 0);
    signal reset_wire_inst_o_resetn_bitsignaltemp : std_logic;

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- not_stall(LOGICAL,28)
    not_stall_q <= not (stall);

    -- implicit_input(BITJOIN,8)
    implicit_input_q <= y & x;

    -- do_const(CONSTANT,7)
    do_const_q <= "0000000000000000000000000000000000000000000000000000000000000000";

    -- avg_function(BLACKBOX,2)
    theavg_function : avg_function
    PORT MAP (
        in_arg_do => do_const_q,
        in_arg_return => do_const_q,
        in_arg_x => do_const_q,
        in_arg_y => do_const_q,
        in_iord_bl_do_i_fifodata => implicit_input_q,
        in_iord_bl_do_i_fifovalid => start,
        in_iowr_bl_return_i_fifoready => not_stall_q,
        in_memdep_avm_readdata => avm_memdep_readdata,
        in_memdep_avm_readdatavalid => avm_memdep_readdatavalid,
        in_memdep_avm_waitrequest => avm_memdep_waitrequest,
        in_memdep_avm_writeack => avm_memdep_writeack,
        in_stall_in => GND_q,
        in_start => GND_q,
        in_unnamed_avg4_avm_readdata => avm_unnamed_avg4_readdata,
        in_unnamed_avg4_avm_readdatavalid => avm_unnamed_avg4_readdatavalid,
        in_unnamed_avg4_avm_waitrequest => avm_unnamed_avg4_waitrequest,
        in_unnamed_avg4_avm_writeack => avm_unnamed_avg4_writeack,
        in_valid_in => VCC_q,
        out_iord_bl_do_o_fifoready => avg_function_out_iord_bl_do_o_fifoready,
        out_iowr_bl_return_o_fifodata => avg_function_out_iowr_bl_return_o_fifodata,
        out_iowr_bl_return_o_fifovalid => avg_function_out_iowr_bl_return_o_fifovalid,
        out_memdep_avm_address => avg_function_out_memdep_avm_address,
        out_memdep_avm_burstcount => avg_function_out_memdep_avm_burstcount,
        out_memdep_avm_byteenable => avg_function_out_memdep_avm_byteenable,
        out_memdep_avm_enable => avg_function_out_memdep_avm_enable,
        out_memdep_avm_read => avg_function_out_memdep_avm_read,
        out_memdep_avm_write => avg_function_out_memdep_avm_write,
        out_memdep_avm_writedata => avg_function_out_memdep_avm_writedata,
        out_unnamed_avg4_avm_address => avg_function_out_unnamed_avg4_avm_address,
        out_unnamed_avg4_avm_burstcount => avg_function_out_unnamed_avg4_avm_burstcount,
        out_unnamed_avg4_avm_byteenable => avg_function_out_unnamed_avg4_avm_byteenable,
        out_unnamed_avg4_avm_enable => avg_function_out_unnamed_avg4_avm_enable,
        out_unnamed_avg4_avm_read => avg_function_out_unnamed_avg4_avm_read,
        out_unnamed_avg4_avm_write => avg_function_out_unnamed_avg4_avm_write,
        out_unnamed_avg4_avm_writedata => avg_function_out_unnamed_avg4_avm_writedata,
        clock => clock,
        resetn => resetn
    );

    -- avm_memdep_address(GPOUT,29)
    avm_memdep_address <= avg_function_out_memdep_avm_address;

    -- avm_memdep_burstcount(GPOUT,30)
    avm_memdep_burstcount <= avg_function_out_memdep_avm_burstcount;

    -- avm_memdep_byteenable(GPOUT,31)
    avm_memdep_byteenable <= avg_function_out_memdep_avm_byteenable;

    -- avm_memdep_enable(GPOUT,32)
    avm_memdep_enable <= avg_function_out_memdep_avm_enable;

    -- avm_memdep_read(GPOUT,33)
    avm_memdep_read <= avg_function_out_memdep_avm_read;

    -- avm_memdep_write(GPOUT,34)
    avm_memdep_write <= avg_function_out_memdep_avm_write;

    -- avm_memdep_writedata(GPOUT,35)
    avm_memdep_writedata <= avg_function_out_memdep_avm_writedata;

    -- avm_unnamed_avg4_address(GPOUT,36)
    avm_unnamed_avg4_address <= avg_function_out_unnamed_avg4_avm_address;

    -- avm_unnamed_avg4_burstcount(GPOUT,37)
    avm_unnamed_avg4_burstcount <= avg_function_out_unnamed_avg4_avm_burstcount;

    -- avm_unnamed_avg4_byteenable(GPOUT,38)
    avm_unnamed_avg4_byteenable <= avg_function_out_unnamed_avg4_avm_byteenable;

    -- avm_unnamed_avg4_enable(GPOUT,39)
    avm_unnamed_avg4_enable <= avg_function_out_unnamed_avg4_avm_enable;

    -- avm_unnamed_avg4_read(GPOUT,40)
    avm_unnamed_avg4_read <= avg_function_out_unnamed_avg4_avm_read;

    -- avm_unnamed_avg4_write(GPOUT,41)
    avm_unnamed_avg4_write <= avg_function_out_unnamed_avg4_avm_write;

    -- avm_unnamed_avg4_writedata(GPOUT,42)
    avm_unnamed_avg4_writedata <= avg_function_out_unnamed_avg4_avm_writedata;

    -- avst_iord_bl_do_ready(GPOUT,43)
    avst_iord_bl_do_ready <= avg_function_out_iord_bl_do_o_fifoready;

    -- avst_iowr_bl_return_data(GPOUT,44)
    avst_iowr_bl_return_data <= avg_function_out_iowr_bl_return_o_fifodata;

    -- avst_iowr_bl_return_valid(GPOUT,45)
    avst_iowr_bl_return_valid <= avg_function_out_iowr_bl_return_o_fifovalid;

    -- not_ready(LOGICAL,27)
    not_ready_q <= not (avg_function_out_iord_bl_do_o_fifoready);

    -- busy_and(LOGICAL,3)
    busy_and_q <= not_ready_q and start;

    -- reset_wire_inst(EXTIFACE,49)
    reset_wire_inst_o_resetn(0) <= reset_wire_inst_o_resetn_bitsignaltemp;
    thereset_wire_inst : acl_reset_wire
    PORT MAP (
        o_resetn => reset_wire_inst_o_resetn_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- pos_reset(LOGICAL,48)
    pos_reset_q <= not (reset_wire_inst_o_resetn);

    -- busy_or(LOGICAL,4)
    busy_or_q <= pos_reset_q or busy_and_q;

    -- busy(GPOUT,46)
    busy <= busy_or_q;

    -- done(GPOUT,47)
    done <= avg_function_out_iowr_bl_return_o_fifovalid;

END normal;
