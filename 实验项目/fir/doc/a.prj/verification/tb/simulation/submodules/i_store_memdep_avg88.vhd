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

-- VHDL created from i_store_memdep_avg88
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

entity i_store_memdep_avg88 is
    port (
        in_memdep_avm_readdata : in std_logic_vector(63 downto 0);  -- ufix64
        out_memdep_avm_address : out std_logic_vector(63 downto 0);  -- ufix64
        in_i_address : in std_logic_vector(63 downto 0);  -- ufix64
        in_i_predicate : in std_logic_vector(0 downto 0);  -- ufix1
        in_i_valid : in std_logic_vector(0 downto 0);  -- ufix1
        in_i_writedata : in std_logic_vector(31 downto 0);  -- float32_m23
        out_o_valid : out std_logic_vector(0 downto 0);  -- ufix1
        out_o_writeack : out std_logic_vector(0 downto 0);  -- ufix1
        in_memdep_avm_readdatavalid : in std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_burstcount : out std_logic_vector(0 downto 0);  -- ufix1
        in_memdep_avm_waitrequest : in std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_byteenable : out std_logic_vector(7 downto 0);  -- ufix8
        in_memdep_avm_writeack : in std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_enable : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_read : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_write : out std_logic_vector(0 downto 0);  -- ufix1
        out_memdep_avm_writedata : out std_logic_vector(63 downto 0);  -- ufix64
        in_flush : in std_logic_vector(0 downto 0);  -- ufix1
        out_lsu_memdep_o_active : out std_logic_vector(0 downto 0);  -- ufix1
        in_i_stall : in std_logic_vector(0 downto 0);  -- ufix1
        out_o_stall : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end i_store_memdep_avg88;

architecture normal of i_store_memdep_avg88 is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    component lsu_top is
        generic (
            ABITS_PER_LMEM_BANK : INTEGER;
            ADDRSPACE : INTEGER := 1024;
            ALIGNMENT_BYTES : INTEGER := 4;
            ATOMIC : INTEGER := 0;
            ATOMIC_WIDTH : INTEGER := 3;
            AWIDTH : INTEGER := 64;
            BURSTCOUNT_WIDTH : INTEGER := 1;
            ENABLE_BANKED_MEMORY : INTEGER := 0;
            FORCE_NOP_SUPPORT : INTEGER := 0;
            HIGH_FMAX : INTEGER := 1;
            INPUTFIFO_USEDW_MAXBITS : INTEGER := 5;
            KERNEL_SIDE_MEM_LATENCY : INTEGER := 31;
            LMEM_ADDR_PERMUTATION_STYLE : INTEGER := 0;
            MEMORY_SIDE_MEM_LATENCY : INTEGER := 0;
            MWIDTH : INTEGER := 64;
            MWIDTH_BYTES : INTEGER := 8;
            NUMBER_BANKS : INTEGER := 1;
            PROFILE_ADDR_TOGGLE : INTEGER := 0;
            READ : INTEGER := 0;
            STALLFREE : INTEGER := 0;
            STYLE : STRING := "PIPELINED";
            SYNCHRONIZE_RESET : INTEGER := 0;
            USECACHING : INTEGER := 0;
            USEINPUTFIFO : INTEGER := 1;
            USEOUTPUTFIFO : INTEGER := 1;
            USE_BYTE_EN : INTEGER := 0;
            USE_WRITE_ACK : INTEGER := 1;
            WIDTH : INTEGER := 32;
            WIDTH_BYTES : INTEGER := 4;
            WRITEDATAWIDTH_BYTES : INTEGER := 8
        );
        port (
            avm_readdata : in std_logic_vector(63 downto 0);
            avm_readdatavalid : in std_logic;
            avm_waitrequest : in std_logic;
            avm_writeack : in std_logic;
            clock2x : in std_logic;
            flush : in std_logic;
            i_address : in std_logic_vector(63 downto 0);
            i_atomic_op : in std_logic_vector(2 downto 0);
            i_bitwiseor : in std_logic_vector(63 downto 0);
            i_byteenable : in std_logic_vector(3 downto 0);
            i_cmpdata : in std_logic_vector(31 downto 0);
            i_predicate : in std_logic;
            i_stall : in std_logic;
            i_valid : in std_logic;
            i_writedata : in std_logic_vector(31 downto 0);
            stream_base_addr : in std_logic_vector(63 downto 0);
            stream_reset : in std_logic;
            stream_size : in std_logic_vector(31 downto 0);
            avm_address : out std_logic_vector(63 downto 0);
            avm_burstcount : out std_logic;
            avm_byteenable : out std_logic_vector(7 downto 0);
            avm_enable : out std_logic;
            avm_read : out std_logic;
            avm_write : out std_logic;
            avm_writedata : out std_logic_vector(63 downto 0);
            o_active : out std_logic;
            o_input_fifo_depth : out std_logic_vector(4 downto 0);
            o_readdata : out std_logic_vector(31 downto 0);
            o_stall : out std_logic;
            o_valid : out std_logic;
            o_writeack : out std_logic;
            profile_avm_burstcount_total_incr : out std_logic_vector(31 downto 0);
            profile_bw_incr : out std_logic_vector(31 downto 0);
            clock : in std_logic;
            resetn : in std_logic
        );
    end component;


    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal dupName_0_c_i32_0gr_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal dupName_0_c_i64_0gr_x_q : STD_LOGIC_VECTOR (63 downto 0);
    signal agg_adapt_to_ufixed_cast_b : STD_LOGIC_VECTOR (31 downto 0);
    signal c_i3_0gr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal c_i4_1gr_q : STD_LOGIC_VECTOR (3 downto 0);
    signal i_store_memdep_avg89_avm_readdata : STD_LOGIC_VECTOR (63 downto 0);
    signal i_store_memdep_avg89_avm_readdatavalid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_avm_readdatavalid_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_avm_waitrequest : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_avm_waitrequest_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_avm_writeack : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_avm_writeack_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_clock2x : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_clock2x_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_flush : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_flush_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_i_address : STD_LOGIC_VECTOR (63 downto 0);
    signal i_store_memdep_avg89_i_atomic_op : STD_LOGIC_VECTOR (2 downto 0);
    signal i_store_memdep_avg89_i_bitwiseor : STD_LOGIC_VECTOR (63 downto 0);
    signal i_store_memdep_avg89_i_byteenable : STD_LOGIC_VECTOR (3 downto 0);
    signal i_store_memdep_avg89_i_cmpdata : STD_LOGIC_VECTOR (31 downto 0);
    signal i_store_memdep_avg89_i_predicate : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_i_predicate_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_i_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_i_stall_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_i_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_i_valid_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_i_writedata : STD_LOGIC_VECTOR (31 downto 0);
    signal i_store_memdep_avg89_stream_base_addr : STD_LOGIC_VECTOR (63 downto 0);
    signal i_store_memdep_avg89_stream_reset : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_stream_reset_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_stream_size : STD_LOGIC_VECTOR (31 downto 0);
    signal i_store_memdep_avg89_avm_address : STD_LOGIC_VECTOR (63 downto 0);
    signal i_store_memdep_avg89_avm_burstcount : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_avm_burstcount_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_avm_byteenable : STD_LOGIC_VECTOR (7 downto 0);
    signal i_store_memdep_avg89_avm_enable : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_avm_enable_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_avm_read : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_avm_read_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_avm_write : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_avm_write_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_avm_writedata : STD_LOGIC_VECTOR (63 downto 0);
    signal i_store_memdep_avg89_o_active : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_o_active_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_o_input_fifo_depth : STD_LOGIC_VECTOR (4 downto 0);
    signal i_store_memdep_avg89_o_readdata : STD_LOGIC_VECTOR (31 downto 0);
    signal i_store_memdep_avg89_o_stall : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_o_stall_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_o_valid : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_o_valid_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_o_writeack : STD_LOGIC_VECTOR (0 downto 0);
    signal i_store_memdep_avg89_o_writeack_bitsignaltemp : std_logic;
    signal i_store_memdep_avg89_profile_avm_burstcount_total_incr : STD_LOGIC_VECTOR (31 downto 0);
    signal i_store_memdep_avg89_profile_bw_incr : STD_LOGIC_VECTOR (31 downto 0);

begin


    -- agg_adapt_to_ufixed_cast(BITSELECT,18)
    agg_adapt_to_ufixed_cast_b <= STD_LOGIC_VECTOR(in_i_writedata(31 downto 0));

    -- dupName_0_c_i32_0gr_x(CONSTANT,3)
    dupName_0_c_i32_0gr_x_q <= "00000000000000000000000000000000";

    -- c_i4_1gr(CONSTANT,22)
    c_i4_1gr_q <= "1111";

    -- dupName_0_c_i64_0gr_x(CONSTANT,4)
    dupName_0_c_i64_0gr_x_q <= "0000000000000000000000000000000000000000000000000000000000000000";

    -- c_i3_0gr(CONSTANT,21)
    c_i3_0gr_q <= "000";

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- i_store_memdep_avg89(EXTIFACE,24)
    i_store_memdep_avg89_avm_readdata <= in_memdep_avm_readdata;
    i_store_memdep_avg89_avm_readdatavalid <= in_memdep_avm_readdatavalid;
    i_store_memdep_avg89_avm_waitrequest <= in_memdep_avm_waitrequest;
    i_store_memdep_avg89_avm_writeack <= in_memdep_avm_writeack;
    i_store_memdep_avg89_clock2x <= GND_q;
    i_store_memdep_avg89_flush <= in_flush;
    i_store_memdep_avg89_i_address <= in_i_address;
    i_store_memdep_avg89_i_atomic_op <= c_i3_0gr_q;
    i_store_memdep_avg89_i_bitwiseor <= dupName_0_c_i64_0gr_x_q;
    i_store_memdep_avg89_i_byteenable <= c_i4_1gr_q;
    i_store_memdep_avg89_i_cmpdata <= dupName_0_c_i32_0gr_x_q;
    i_store_memdep_avg89_i_predicate <= GND_q;
    i_store_memdep_avg89_i_stall <= in_i_stall;
    i_store_memdep_avg89_i_valid <= in_i_valid;
    i_store_memdep_avg89_i_writedata <= agg_adapt_to_ufixed_cast_b;
    i_store_memdep_avg89_stream_base_addr <= dupName_0_c_i64_0gr_x_q;
    i_store_memdep_avg89_stream_reset <= GND_q;
    i_store_memdep_avg89_stream_size <= dupName_0_c_i32_0gr_x_q;
    i_store_memdep_avg89_avm_readdatavalid_bitsignaltemp <= i_store_memdep_avg89_avm_readdatavalid(0);
    i_store_memdep_avg89_avm_waitrequest_bitsignaltemp <= i_store_memdep_avg89_avm_waitrequest(0);
    i_store_memdep_avg89_avm_writeack_bitsignaltemp <= i_store_memdep_avg89_avm_writeack(0);
    i_store_memdep_avg89_clock2x_bitsignaltemp <= i_store_memdep_avg89_clock2x(0);
    i_store_memdep_avg89_flush_bitsignaltemp <= i_store_memdep_avg89_flush(0);
    i_store_memdep_avg89_i_predicate_bitsignaltemp <= i_store_memdep_avg89_i_predicate(0);
    i_store_memdep_avg89_i_stall_bitsignaltemp <= i_store_memdep_avg89_i_stall(0);
    i_store_memdep_avg89_i_valid_bitsignaltemp <= i_store_memdep_avg89_i_valid(0);
    i_store_memdep_avg89_stream_reset_bitsignaltemp <= i_store_memdep_avg89_stream_reset(0);
    i_store_memdep_avg89_avm_burstcount(0) <= i_store_memdep_avg89_avm_burstcount_bitsignaltemp;
    i_store_memdep_avg89_avm_enable(0) <= i_store_memdep_avg89_avm_enable_bitsignaltemp;
    i_store_memdep_avg89_avm_read(0) <= i_store_memdep_avg89_avm_read_bitsignaltemp;
    i_store_memdep_avg89_avm_write(0) <= i_store_memdep_avg89_avm_write_bitsignaltemp;
    i_store_memdep_avg89_o_active(0) <= i_store_memdep_avg89_o_active_bitsignaltemp;
    i_store_memdep_avg89_o_stall(0) <= i_store_memdep_avg89_o_stall_bitsignaltemp;
    i_store_memdep_avg89_o_valid(0) <= i_store_memdep_avg89_o_valid_bitsignaltemp;
    i_store_memdep_avg89_o_writeack(0) <= i_store_memdep_avg89_o_writeack_bitsignaltemp;
    thei_store_memdep_avg89 : lsu_top
    GENERIC MAP (
        ABITS_PER_LMEM_BANK => 0,
        ADDRSPACE => 1024,
        ALIGNMENT_BYTES => 4,
        ATOMIC => 0,
        ATOMIC_WIDTH => 3,
        AWIDTH => 64,
        BURSTCOUNT_WIDTH => 1,
        ENABLE_BANKED_MEMORY => 0,
        FORCE_NOP_SUPPORT => 0,
        HIGH_FMAX => 1,
        INPUTFIFO_USEDW_MAXBITS => 5,
        KERNEL_SIDE_MEM_LATENCY => 31,
        LMEM_ADDR_PERMUTATION_STYLE => 0,
        MEMORY_SIDE_MEM_LATENCY => 0,
        MWIDTH => 64,
        MWIDTH_BYTES => 8,
        NUMBER_BANKS => 1,
        PROFILE_ADDR_TOGGLE => 0,
        READ => 0,
        STALLFREE => 0,
        STYLE => "PIPELINED",
        SYNCHRONIZE_RESET => 0,
        USECACHING => 0,
        USEINPUTFIFO => 1,
        USEOUTPUTFIFO => 1,
        USE_BYTE_EN => 0,
        USE_WRITE_ACK => 1,
        WIDTH => 32,
        WIDTH_BYTES => 4,
        WRITEDATAWIDTH_BYTES => 8
    )
    PORT MAP (
        avm_readdata => in_memdep_avm_readdata,
        avm_readdatavalid => i_store_memdep_avg89_avm_readdatavalid_bitsignaltemp,
        avm_waitrequest => i_store_memdep_avg89_avm_waitrequest_bitsignaltemp,
        avm_writeack => i_store_memdep_avg89_avm_writeack_bitsignaltemp,
        clock2x => i_store_memdep_avg89_clock2x_bitsignaltemp,
        flush => i_store_memdep_avg89_flush_bitsignaltemp,
        i_address => in_i_address,
        i_atomic_op => c_i3_0gr_q,
        i_bitwiseor => dupName_0_c_i64_0gr_x_q,
        i_byteenable => c_i4_1gr_q,
        i_cmpdata => dupName_0_c_i32_0gr_x_q,
        i_predicate => i_store_memdep_avg89_i_predicate_bitsignaltemp,
        i_stall => i_store_memdep_avg89_i_stall_bitsignaltemp,
        i_valid => i_store_memdep_avg89_i_valid_bitsignaltemp,
        i_writedata => agg_adapt_to_ufixed_cast_b,
        stream_base_addr => dupName_0_c_i64_0gr_x_q,
        stream_reset => i_store_memdep_avg89_stream_reset_bitsignaltemp,
        stream_size => dupName_0_c_i32_0gr_x_q,
        avm_address => i_store_memdep_avg89_avm_address,
        avm_burstcount => i_store_memdep_avg89_avm_burstcount_bitsignaltemp,
        avm_byteenable => i_store_memdep_avg89_avm_byteenable,
        avm_enable => i_store_memdep_avg89_avm_enable_bitsignaltemp,
        avm_read => i_store_memdep_avg89_avm_read_bitsignaltemp,
        avm_write => i_store_memdep_avg89_avm_write_bitsignaltemp,
        avm_writedata => i_store_memdep_avg89_avm_writedata,
        o_active => i_store_memdep_avg89_o_active_bitsignaltemp,
        o_stall => i_store_memdep_avg89_o_stall_bitsignaltemp,
        o_valid => i_store_memdep_avg89_o_valid_bitsignaltemp,
        o_writeack => i_store_memdep_avg89_o_writeack_bitsignaltemp,
        clock => clock,
        resetn => resetn
    );

    -- dupName_0_regfree_osync_x(GPOUT,6)
    out_memdep_avm_address <= i_store_memdep_avg89_avm_address;

    -- dupName_0_sync_out_x(GPOUT,8)@45
    out_o_valid <= i_store_memdep_avg89_o_valid;
    out_o_writeack <= i_store_memdep_avg89_o_writeack;

    -- dupName_1_regfree_osync_x(GPOUT,10)
    out_memdep_avm_burstcount <= i_store_memdep_avg89_avm_burstcount;

    -- dupName_2_regfree_osync_x(GPOUT,12)
    out_memdep_avm_byteenable <= i_store_memdep_avg89_avm_byteenable;

    -- dupName_3_regfree_osync_x(GPOUT,14)
    out_memdep_avm_enable <= i_store_memdep_avg89_avm_enable;

    -- dupName_4_regfree_osync_x(GPOUT,15)
    out_memdep_avm_read <= i_store_memdep_avg89_avm_read;

    -- dupName_5_regfree_osync_x(GPOUT,16)
    out_memdep_avm_write <= i_store_memdep_avg89_avm_write;

    -- dupName_6_regfree_osync_x(GPOUT,17)
    out_memdep_avm_writedata <= i_store_memdep_avg89_avm_writedata;

    -- regfree_osync(GPOUT,26)
    out_lsu_memdep_o_active <= i_store_memdep_avg89_o_active;

    -- sync_out(GPOUT,28)@20000000
    out_o_stall <= i_store_memdep_avg89_o_stall;

END normal;
