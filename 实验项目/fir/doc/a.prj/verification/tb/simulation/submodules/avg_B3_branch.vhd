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

-- VHDL created from avg_B3_branch
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

entity avg_B3_branch is
    port (
        in_c0_exit31_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit31_1 : in std_logic_vector(31 downto 0);  -- ufix32
        in_c0_exit31_2 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit31_3 : in std_logic_vector(63 downto 0);  -- ufix64
        in_c0_exit31_4 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit31_5 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit31_6 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit31_7 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit31_8 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c0_exit31_9 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c1_exit_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_c1_exit_1 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_c0_exe6 : in std_logic_vector(0 downto 0);  -- ufix1
        in_stall_in_0 : in std_logic_vector(0 downto 0);  -- ufix1
        in_stall_in_1 : in std_logic_vector(0 downto 0);  -- ufix1
        in_valid_in : in std_logic_vector(0 downto 0);  -- ufix1
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
        out_stall_out : out std_logic_vector(0 downto 0);  -- ufix1
        out_valid_out_0 : out std_logic_vector(0 downto 0);  -- ufix1
        out_valid_out_1 : out std_logic_vector(0 downto 0);  -- ufix1
        clock : in std_logic;
        resetn : in std_logic
    );
end avg_B3_branch;

architecture normal of avg_B3_branch is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal c0_exit31_reg_0_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal c0_exit31_reg_1_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal c0_exit31_reg_2_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal c0_exit31_reg_3_x_q : STD_LOGIC_VECTOR (63 downto 0);
    signal c0_exit31_reg_4_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal c0_exit31_reg_5_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal c0_exit31_reg_6_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal c0_exit31_reg_7_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal c0_exit31_reg_8_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal c0_exit31_reg_9_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal c1_exit_reg_0_x_q : STD_LOGIC_VECTOR (0 downto 0);
    signal c1_exit_reg_1_x_q : STD_LOGIC_VECTOR (31 downto 0);
    signal avg_B3_branch_enable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal avg_B3_branch_enable_not_q : STD_LOGIC_VECTOR (0 downto 0);
    signal c0_exe6_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal not_stall_in_0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal not_stall_in_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal not_valid_0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal not_valid_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal not_valid_or_not_stall_0_q : STD_LOGIC_VECTOR (0 downto 0);
    signal not_valid_or_not_stall_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal valid_0_reg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal valid_1_reg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal valid_out_0_and_q : STD_LOGIC_VECTOR (0 downto 0);
    signal valid_out_1_and_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- not_stall_in_1(LOGICAL,49)
    not_stall_in_1_q <= not (in_stall_in_1);

    -- c0_exe6_cmp(LOGICAL,47)
    c0_exe6_cmp_q <= not (in_c0_exe6);

    -- valid_out_1_and(LOGICAL,57)
    valid_out_1_and_q <= in_valid_in and c0_exe6_cmp_q;

    -- valid_1_reg(REG,55)
    valid_1_reg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            valid_1_reg_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (avg_B3_branch_enable_q = "1") THEN
                valid_1_reg_q <= valid_out_1_and_q;
            END IF;
        END IF;
    END PROCESS;

    -- not_valid_1(LOGICAL,51)
    not_valid_1_q <= not (valid_1_reg_q);

    -- not_valid_or_not_stall_1(LOGICAL,53)
    not_valid_or_not_stall_1_q <= not_valid_1_q or not_stall_in_1_q;

    -- not_stall_in_0(LOGICAL,48)
    not_stall_in_0_q <= not (in_stall_in_0);

    -- valid_out_0_and(LOGICAL,56)
    valid_out_0_and_q <= in_valid_in and in_c0_exe6;

    -- valid_0_reg(REG,54)
    valid_0_reg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            valid_0_reg_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (avg_B3_branch_enable_q = "1") THEN
                valid_0_reg_q <= valid_out_0_and_q;
            END IF;
        END IF;
    END PROCESS;

    -- not_valid_0(LOGICAL,50)
    not_valid_0_q <= not (valid_0_reg_q);

    -- not_valid_or_not_stall_0(LOGICAL,52)
    not_valid_or_not_stall_0_q <= not_valid_0_q or not_stall_in_0_q;

    -- avg_B3_branch_enable(LOGICAL,45)
    avg_B3_branch_enable_q <= not_valid_or_not_stall_0_q and not_valid_or_not_stall_1_q;

    -- c0_exit31_reg_0_x(REG,2)
    c0_exit31_reg_0_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            c0_exit31_reg_0_x_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (avg_B3_branch_enable_q = "1") THEN
                c0_exit31_reg_0_x_q <= in_c0_exit31_0;
            END IF;
        END IF;
    END PROCESS;

    -- out_c0_exit31_0(GPOUT,30)
    out_c0_exit31_0 <= c0_exit31_reg_0_x_q;

    -- c0_exit31_reg_1_x(REG,3)
    c0_exit31_reg_1_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            c0_exit31_reg_1_x_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (avg_B3_branch_enable_q = "1") THEN
                c0_exit31_reg_1_x_q <= in_c0_exit31_1;
            END IF;
        END IF;
    END PROCESS;

    -- out_c0_exit31_1(GPOUT,31)
    out_c0_exit31_1 <= c0_exit31_reg_1_x_q;

    -- c0_exit31_reg_2_x(REG,4)
    c0_exit31_reg_2_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            c0_exit31_reg_2_x_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (avg_B3_branch_enable_q = "1") THEN
                c0_exit31_reg_2_x_q <= in_c0_exit31_2;
            END IF;
        END IF;
    END PROCESS;

    -- out_c0_exit31_2(GPOUT,32)
    out_c0_exit31_2 <= c0_exit31_reg_2_x_q;

    -- c0_exit31_reg_3_x(REG,5)
    c0_exit31_reg_3_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            c0_exit31_reg_3_x_q <= "0000000000000000000000000000000000000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (avg_B3_branch_enable_q = "1") THEN
                c0_exit31_reg_3_x_q <= in_c0_exit31_3;
            END IF;
        END IF;
    END PROCESS;

    -- out_c0_exit31_3(GPOUT,33)
    out_c0_exit31_3 <= c0_exit31_reg_3_x_q;

    -- c0_exit31_reg_4_x(REG,6)
    c0_exit31_reg_4_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            c0_exit31_reg_4_x_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (avg_B3_branch_enable_q = "1") THEN
                c0_exit31_reg_4_x_q <= in_c0_exit31_4;
            END IF;
        END IF;
    END PROCESS;

    -- out_c0_exit31_4(GPOUT,34)
    out_c0_exit31_4 <= c0_exit31_reg_4_x_q;

    -- c0_exit31_reg_5_x(REG,7)
    c0_exit31_reg_5_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            c0_exit31_reg_5_x_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (avg_B3_branch_enable_q = "1") THEN
                c0_exit31_reg_5_x_q <= in_c0_exit31_5;
            END IF;
        END IF;
    END PROCESS;

    -- out_c0_exit31_5(GPOUT,35)
    out_c0_exit31_5 <= c0_exit31_reg_5_x_q;

    -- c0_exit31_reg_6_x(REG,8)
    c0_exit31_reg_6_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            c0_exit31_reg_6_x_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (avg_B3_branch_enable_q = "1") THEN
                c0_exit31_reg_6_x_q <= in_c0_exit31_6;
            END IF;
        END IF;
    END PROCESS;

    -- out_c0_exit31_6(GPOUT,36)
    out_c0_exit31_6 <= c0_exit31_reg_6_x_q;

    -- c0_exit31_reg_7_x(REG,9)
    c0_exit31_reg_7_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            c0_exit31_reg_7_x_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (avg_B3_branch_enable_q = "1") THEN
                c0_exit31_reg_7_x_q <= in_c0_exit31_7;
            END IF;
        END IF;
    END PROCESS;

    -- out_c0_exit31_7(GPOUT,37)
    out_c0_exit31_7 <= c0_exit31_reg_7_x_q;

    -- c0_exit31_reg_8_x(REG,10)
    c0_exit31_reg_8_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            c0_exit31_reg_8_x_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (avg_B3_branch_enable_q = "1") THEN
                c0_exit31_reg_8_x_q <= in_c0_exit31_8;
            END IF;
        END IF;
    END PROCESS;

    -- out_c0_exit31_8(GPOUT,38)
    out_c0_exit31_8 <= c0_exit31_reg_8_x_q;

    -- c0_exit31_reg_9_x(REG,11)
    c0_exit31_reg_9_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            c0_exit31_reg_9_x_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (avg_B3_branch_enable_q = "1") THEN
                c0_exit31_reg_9_x_q <= in_c0_exit31_9;
            END IF;
        END IF;
    END PROCESS;

    -- out_c0_exit31_9(GPOUT,39)
    out_c0_exit31_9 <= c0_exit31_reg_9_x_q;

    -- c1_exit_reg_0_x(REG,12)
    c1_exit_reg_0_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            c1_exit_reg_0_x_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (avg_B3_branch_enable_q = "1") THEN
                c1_exit_reg_0_x_q <= in_c1_exit_0;
            END IF;
        END IF;
    END PROCESS;

    -- out_c1_exit_0(GPOUT,40)
    out_c1_exit_0 <= c1_exit_reg_0_x_q;

    -- c1_exit_reg_1_x(REG,13)
    c1_exit_reg_1_x_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            c1_exit_reg_1_x_q <= "00000000000000000000000000000000";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (avg_B3_branch_enable_q = "1") THEN
                c1_exit_reg_1_x_q <= STD_LOGIC_VECTOR(in_c1_exit_1);
            END IF;
        END IF;
    END PROCESS;

    -- out_c1_exit_1(GPOUT,41)
    out_c1_exit_1 <= c1_exit_reg_1_x_q;

    -- avg_B3_branch_enable_not(LOGICAL,46)
    avg_B3_branch_enable_not_q <= not (avg_B3_branch_enable_q);

    -- out_stall_out(GPOUT,42)
    out_stall_out <= avg_B3_branch_enable_not_q;

    -- out_valid_out_0(GPOUT,43)
    out_valid_out_0 <= valid_0_reg_q;

    -- out_valid_out_1(GPOUT,44)
    out_valid_out_1 <= valid_1_reg_q;

END normal;
