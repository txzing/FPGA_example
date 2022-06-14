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

-- VHDL created from floatComponent_i_sfc_logic_c1_for_body3_avg_c1_enter_avg75_addBlock_typeSFloatIEA0Z3d06o00rf00d06of5q0u
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

entity floatComponent_i_sfc_logic_c1_for_body3_avg_c1_enter_avg75_addBlock_typeSFloatIEA0Z3d06o00rf00d06of5q0u is
    port (
        in_0 : in std_logic_vector(31 downto 0);  -- float32_m23
        in_1 : in std_logic_vector(31 downto 0);  -- float32_m23
        out_primWireOut : out std_logic_vector(31 downto 0);  -- float32_m23
        clock : in std_logic;
        resetn : in std_logic
    );
end floatComponent_i_sfc_logic_c1_for_body3_avg_c1_enter_avg75_addBlock_typeSFloatIEA0Z3d06o00rf00d06of5q0u;

architecture normal of floatComponent_i_sfc_logic_c1_for_body3_avg_c1_enter_avg75_addBlock_typeSFloatIEA0Z3d06o00rf00d06of5q0u is

    attribute altera_attribute : string;
    attribute altera_attribute of normal : architecture is "-name AUTO_SHIFT_REGISTER_RECOGNITION OFF; -name PHYSICAL_SYNTHESIS_REGISTER_DUPLICATION ON; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 10037; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 15400; -name MESSAGE_DISABLE 14130; -name MESSAGE_DISABLE 10036; -name MESSAGE_DISABLE 12020; -name MESSAGE_DISABLE 12030; -name MESSAGE_DISABLE 12010; -name MESSAGE_DISABLE 12110; -name MESSAGE_DISABLE 14320; -name MESSAGE_DISABLE 13410; -name MESSAGE_DISABLE 113007";
    
    signal GND_q : STD_LOGIC_VECTOR (0 downto 0);
    signal VCC_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expFracX_uid7_block_rsrvd_fix_b : STD_LOGIC_VECTOR (30 downto 0);
    signal expFracY_uid8_block_rsrvd_fix_b : STD_LOGIC_VECTOR (30 downto 0);
    signal xGTEy_uid9_block_rsrvd_fix_a : STD_LOGIC_VECTOR (32 downto 0);
    signal xGTEy_uid9_block_rsrvd_fix_b : STD_LOGIC_VECTOR (32 downto 0);
    signal xGTEy_uid9_block_rsrvd_fix_o : STD_LOGIC_VECTOR (32 downto 0);
    signal xGTEy_uid9_block_rsrvd_fix_n : STD_LOGIC_VECTOR (0 downto 0);
    signal sigY_uid10_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal fracY_uid11_block_rsrvd_fix_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expY_uid12_block_rsrvd_fix_b : STD_LOGIC_VECTOR (7 downto 0);
    signal ypn_uid13_block_rsrvd_fix_q : STD_LOGIC_VECTOR (31 downto 0);
    signal aSig_uid17_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal aSig_uid17_block_rsrvd_fix_q : STD_LOGIC_VECTOR (31 downto 0);
    signal bSig_uid18_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal bSig_uid18_block_rsrvd_fix_q : STD_LOGIC_VECTOR (31 downto 0);
    signal cstAllOWE_uid19_block_rsrvd_fix_q : STD_LOGIC_VECTOR (7 downto 0);
    signal cstZeroWF_uid20_block_rsrvd_fix_q : STD_LOGIC_VECTOR (22 downto 0);
    signal cstAllZWE_uid21_block_rsrvd_fix_q : STD_LOGIC_VECTOR (7 downto 0);
    signal exp_aSig_uid22_block_rsrvd_fix_in : STD_LOGIC_VECTOR (30 downto 0);
    signal exp_aSig_uid22_block_rsrvd_fix_b : STD_LOGIC_VECTOR (7 downto 0);
    signal frac_aSig_uid23_block_rsrvd_fix_in : STD_LOGIC_VECTOR (22 downto 0);
    signal frac_aSig_uid23_block_rsrvd_fix_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_aSig_uid17_uid24_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid25_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid26_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid26_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid27_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_aSig_uid28_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_aSig_uid28_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_aSig_uid29_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_aSig_uid29_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid30_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid31_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_aSig_uid32_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_aSig_uid32_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal exp_bSig_uid36_block_rsrvd_fix_in : STD_LOGIC_VECTOR (30 downto 0);
    signal exp_bSig_uid36_block_rsrvd_fix_b : STD_LOGIC_VECTOR (7 downto 0);
    signal frac_bSig_uid37_block_rsrvd_fix_in : STD_LOGIC_VECTOR (22 downto 0);
    signal frac_bSig_uid37_block_rsrvd_fix_b : STD_LOGIC_VECTOR (22 downto 0);
    signal excZ_bSig_uid18_uid38_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excZ_bSig_uid18_uid38_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid39_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal expXIsMax_uid39_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsZero_uid40_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracXIsNotZero_uid41_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_bSig_uid42_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excI_bSig_uid42_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_bSig_uid43_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excN_bSig_uid43_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExpXIsMax_uid44_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal InvExpXIsZero_uid45_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_bSig_uid46_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal excR_bSig_uid46_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigA_uid51_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal sigB_uid52_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal effSub_uid53_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracBz_uid57_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal fracBz_uid57_block_rsrvd_fix_q : STD_LOGIC_VECTOR (22 downto 0);
    signal oFracB_uid60_block_rsrvd_fix_q : STD_LOGIC_VECTOR (23 downto 0);
    signal expAmExpB_uid61_block_rsrvd_fix_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid61_block_rsrvd_fix_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid61_block_rsrvd_fix_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expAmExpB_uid61_block_rsrvd_fix_q : STD_LOGIC_VECTOR (8 downto 0);
    signal cWFP2_uid62_block_rsrvd_fix_q : STD_LOGIC_VECTOR (4 downto 0);
    signal shiftedOut_uid64_block_rsrvd_fix_a : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid64_block_rsrvd_fix_b : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid64_block_rsrvd_fix_o : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid64_block_rsrvd_fix_c : STD_LOGIC_VECTOR (0 downto 0);
    signal padConst_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (24 downto 0);
    signal rightPaddedIn_uid66_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal iShiftedOut_uid68_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal alignFracBPostShiftOut_uid69_block_rsrvd_fix_b : STD_LOGIC_VECTOR (48 downto 0);
    signal alignFracBPostShiftOut_uid69_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (48 downto 0);
    signal alignFracBPostShiftOut_uid69_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal cmpEQ_stickyBits_cZwF_uid72_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invCmpEQ_stickyBits_cZwF_uid73_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal effSubInvSticky_uid75_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal effSubInvSticky_uid75_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal zocst_uid77_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal fracAAddOp_uid78_block_rsrvd_fix_q : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOp_uid81_block_rsrvd_fix_q : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOpPostXor_uid82_block_rsrvd_fix_b : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOpPostXor_uid82_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (26 downto 0);
    signal fracBAddOpPostXor_uid82_block_rsrvd_fix_q : STD_LOGIC_VECTOR (26 downto 0);
    signal fracAddResult_uid83_block_rsrvd_fix_a : STD_LOGIC_VECTOR (27 downto 0);
    signal fracAddResult_uid83_block_rsrvd_fix_b : STD_LOGIC_VECTOR (27 downto 0);
    signal fracAddResult_uid83_block_rsrvd_fix_o : STD_LOGIC_VECTOR (27 downto 0);
    signal fracAddResult_uid83_block_rsrvd_fix_q : STD_LOGIC_VECTOR (27 downto 0);
    signal rangeFracAddResultMwfp3Dto0_uid84_block_rsrvd_fix_in : STD_LOGIC_VECTOR (26 downto 0);
    signal rangeFracAddResultMwfp3Dto0_uid84_block_rsrvd_fix_b : STD_LOGIC_VECTOR (26 downto 0);
    signal fracGRS_uid85_block_rsrvd_fix_q : STD_LOGIC_VECTOR (27 downto 0);
    signal cAmA_uid87_block_rsrvd_fix_q : STD_LOGIC_VECTOR (4 downto 0);
    signal aMinusA_uid88_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostNorm_uid90_block_rsrvd_fix_b : STD_LOGIC_VECTOR (26 downto 0);
    signal oneCST_uid91_block_rsrvd_fix_q : STD_LOGIC_VECTOR (7 downto 0);
    signal expInc_uid92_block_rsrvd_fix_a : STD_LOGIC_VECTOR (8 downto 0);
    signal expInc_uid92_block_rsrvd_fix_b : STD_LOGIC_VECTOR (8 downto 0);
    signal expInc_uid92_block_rsrvd_fix_o : STD_LOGIC_VECTOR (8 downto 0);
    signal expInc_uid92_block_rsrvd_fix_q : STD_LOGIC_VECTOR (8 downto 0);
    signal expPostNorm_uid93_block_rsrvd_fix_a : STD_LOGIC_VECTOR (9 downto 0);
    signal expPostNorm_uid93_block_rsrvd_fix_b : STD_LOGIC_VECTOR (9 downto 0);
    signal expPostNorm_uid93_block_rsrvd_fix_o : STD_LOGIC_VECTOR (9 downto 0);
    signal expPostNorm_uid93_block_rsrvd_fix_q : STD_LOGIC_VECTOR (9 downto 0);
    signal Sticky0_uid94_block_rsrvd_fix_in : STD_LOGIC_VECTOR (0 downto 0);
    signal Sticky0_uid94_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Sticky1_uid95_block_rsrvd_fix_in : STD_LOGIC_VECTOR (1 downto 0);
    signal Sticky1_uid95_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Round_uid96_block_rsrvd_fix_in : STD_LOGIC_VECTOR (2 downto 0);
    signal Round_uid96_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal Guard_uid97_block_rsrvd_fix_in : STD_LOGIC_VECTOR (3 downto 0);
    signal Guard_uid97_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal LSB_uid98_block_rsrvd_fix_in : STD_LOGIC_VECTOR (4 downto 0);
    signal LSB_uid98_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rndBitCond_uid99_block_rsrvd_fix_q : STD_LOGIC_VECTOR (4 downto 0);
    signal cRBit_uid100_block_rsrvd_fix_q : STD_LOGIC_VECTOR (4 downto 0);
    signal rBi_uid101_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal rBi_uid101_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal roundBit_uid102_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracPostNormRndRange_uid103_block_rsrvd_fix_in : STD_LOGIC_VECTOR (25 downto 0);
    signal fracPostNormRndRange_uid103_block_rsrvd_fix_b : STD_LOGIC_VECTOR (23 downto 0);
    signal expFracR_uid104_block_rsrvd_fix_q : STD_LOGIC_VECTOR (33 downto 0);
    signal rndExpFrac_uid105_block_rsrvd_fix_a : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExpFrac_uid105_block_rsrvd_fix_b : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExpFrac_uid105_block_rsrvd_fix_o : STD_LOGIC_VECTOR (34 downto 0);
    signal rndExpFrac_uid105_block_rsrvd_fix_q : STD_LOGIC_VECTOR (34 downto 0);
    signal wEP2AllOwE_uid106_block_rsrvd_fix_q : STD_LOGIC_VECTOR (9 downto 0);
    signal rndExp_uid107_block_rsrvd_fix_in : STD_LOGIC_VECTOR (33 downto 0);
    signal rndExp_uid107_block_rsrvd_fix_b : STD_LOGIC_VECTOR (9 downto 0);
    signal rOvfEQMax_uid108_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rndExpFracOvfBits_uid110_block_rsrvd_fix_in : STD_LOGIC_VECTOR (33 downto 0);
    signal rndExpFracOvfBits_uid110_block_rsrvd_fix_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rOvfExtraBits_uid111_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rOvf_uid112_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal rOvf_uid112_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal wEP2AllZ_uid113_block_rsrvd_fix_q : STD_LOGIC_VECTOR (9 downto 0);
    signal rUdfEQMin_uid114_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rUdfExtraBit_uid115_block_rsrvd_fix_in : STD_LOGIC_VECTOR (33 downto 0);
    signal rUdfExtraBit_uid115_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rUdf_uid116_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal rUdf_uid116_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal fracRPreExc_uid117_block_rsrvd_fix_in : STD_LOGIC_VECTOR (23 downto 0);
    signal fracRPreExc_uid117_block_rsrvd_fix_b : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPreExc_uid118_block_rsrvd_fix_in : STD_LOGIC_VECTOR (31 downto 0);
    signal expRPreExc_uid118_block_rsrvd_fix_b : STD_LOGIC_VECTOR (7 downto 0);
    signal regInputs_uid119_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal regInputs_uid119_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRZeroVInC_uid120_block_rsrvd_fix_q : STD_LOGIC_VECTOR (4 downto 0);
    signal excRZero_uid121_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal rInfOvf_uid122_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRInfVInC_uid123_block_rsrvd_fix_q : STD_LOGIC_VECTOR (5 downto 0);
    signal excRInf_uid124_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN2_uid125_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAIBISub_uid126_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excRNaN_uid127_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal concExc_uid128_block_rsrvd_fix_q : STD_LOGIC_VECTOR (2 downto 0);
    signal excREnc_uid129_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal invAMinusA_uid130_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRReg_uid131_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigBBInf_uid132_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal sigAAInf_uid133_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInf_uid134_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excAZBZSigASigB_uid135_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal excBZARSigA_uid136_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRZero_uid137_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInfRZRReg_uid138_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signRInfRZRReg_uid138_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal invExcRNaN_uid139_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid140_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal signRPostExc_uid140_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal oneFracRPostExc2_uid141_block_rsrvd_fix_q : STD_LOGIC_VECTOR (22 downto 0);
    signal fracRPostExc_uid144_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal fracRPostExc_uid144_block_rsrvd_fix_q : STD_LOGIC_VECTOR (22 downto 0);
    signal expRPostExc_uid148_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal expRPostExc_uid148_block_rsrvd_fix_q : STD_LOGIC_VECTOR (7 downto 0);
    signal R_uid149_block_rsrvd_fix_q : STD_LOGIC_VECTOR (31 downto 0);
    signal zs_uid151_lzCountVal_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (15 downto 0);
    signal rVStage_uid152_lzCountVal_uid86_block_rsrvd_fix_b : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid153_lzCountVal_uid86_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid153_lzCountVal_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal mO_uid154_lzCountVal_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vStage_uid155_lzCountVal_uid86_block_rsrvd_fix_in : STD_LOGIC_VECTOR (11 downto 0);
    signal vStage_uid155_lzCountVal_uid86_block_rsrvd_fix_b : STD_LOGIC_VECTOR (11 downto 0);
    signal cStage_uid156_lzCountVal_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vStagei_uid158_lzCountVal_uid86_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid158_lzCountVal_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (15 downto 0);
    signal vCount_uid161_lzCountVal_uid86_block_rsrvd_fix_qi : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid161_lzCountVal_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid164_lzCountVal_uid86_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid164_lzCountVal_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (7 downto 0);
    signal zs_uid165_lzCountVal_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (3 downto 0);
    signal vCount_uid167_lzCountVal_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid170_lzCountVal_uid86_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid170_lzCountVal_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (3 downto 0);
    signal zs_uid171_lzCountVal_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal vCount_uid173_lzCountVal_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid176_lzCountVal_uid86_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal vStagei_uid176_lzCountVal_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid178_lzCountVal_uid86_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal vCount_uid179_lzCountVal_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid180_lzCountVal_uid86_block_rsrvd_fix_q : STD_LOGIC_VECTOR (4 downto 0);
    signal wIntCst_uid184_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (5 downto 0);
    signal shiftedOut_uid185_alignmentShifter_uid65_block_rsrvd_fix_a : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid185_alignmentShifter_uid65_block_rsrvd_fix_b : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid185_alignmentShifter_uid65_block_rsrvd_fix_o : STD_LOGIC_VECTOR (10 downto 0);
    signal shiftedOut_uid185_alignmentShifter_uid65_block_rsrvd_fix_n : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx1Rng16_uid186_alignmentShifter_uid65_block_rsrvd_fix_b : STD_LOGIC_VECTOR (32 downto 0);
    signal rightShiftStage0Idx1_uid188_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx2Rng32_uid189_alignmentShifter_uid65_block_rsrvd_fix_b : STD_LOGIC_VECTOR (16 downto 0);
    signal rightShiftStage0Idx2Pad32_uid190_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (31 downto 0);
    signal rightShiftStage0Idx2_uid191_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0Idx3Rng48_uid192_alignmentShifter_uid65_block_rsrvd_fix_b : STD_LOGIC_VECTOR (0 downto 0);
    signal rightShiftStage0Idx3Pad48_uid193_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage0Idx3_uid194_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx1Rng4_uid197_alignmentShifter_uid65_block_rsrvd_fix_b : STD_LOGIC_VECTOR (44 downto 0);
    signal rightShiftStage1Idx1_uid199_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx2Rng8_uid200_alignmentShifter_uid65_block_rsrvd_fix_b : STD_LOGIC_VECTOR (40 downto 0);
    signal rightShiftStage1Idx2_uid202_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1Idx3Rng12_uid203_alignmentShifter_uid65_block_rsrvd_fix_b : STD_LOGIC_VECTOR (36 downto 0);
    signal rightShiftStage1Idx3Pad12_uid204_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (11 downto 0);
    signal rightShiftStage1Idx3_uid205_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage2Idx1Rng1_uid208_alignmentShifter_uid65_block_rsrvd_fix_b : STD_LOGIC_VECTOR (47 downto 0);
    signal rightShiftStage2Idx1_uid210_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage2Idx2Rng2_uid211_alignmentShifter_uid65_block_rsrvd_fix_b : STD_LOGIC_VECTOR (46 downto 0);
    signal rightShiftStage2Idx2_uid213_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage2Idx3Rng3_uid214_alignmentShifter_uid65_block_rsrvd_fix_b : STD_LOGIC_VECTOR (45 downto 0);
    signal rightShiftStage2Idx3Pad3_uid215_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (2 downto 0);
    signal rightShiftStage2Idx3_uid216_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal rightShiftStage2_uid218_alignmentShifter_uid65_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStage2_uid218_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal zeroOutCst_uid219_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal r_uid220_alignmentShifter_uid65_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal r_uid220_alignmentShifter_uid65_block_rsrvd_fix_q : STD_LOGIC_VECTOR (48 downto 0);
    signal leftShiftStage0Idx1Rng8_uid225_fracPostNormExt_uid89_block_rsrvd_fix_in : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage0Idx1Rng8_uid225_fracPostNormExt_uid89_block_rsrvd_fix_b : STD_LOGIC_VECTOR (19 downto 0);
    signal leftShiftStage0Idx1_uid226_fracPostNormExt_uid89_block_rsrvd_fix_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx2_uid229_fracPostNormExt_uid89_block_rsrvd_fix_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0Idx3Pad24_uid230_fracPostNormExt_uid89_block_rsrvd_fix_q : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage0Idx3Rng24_uid231_fracPostNormExt_uid89_block_rsrvd_fix_in : STD_LOGIC_VECTOR (3 downto 0);
    signal leftShiftStage0Idx3Rng24_uid231_fracPostNormExt_uid89_block_rsrvd_fix_b : STD_LOGIC_VECTOR (3 downto 0);
    signal leftShiftStage0Idx3_uid232_fracPostNormExt_uid89_block_rsrvd_fix_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx1Rng2_uid236_fracPostNormExt_uid89_block_rsrvd_fix_in : STD_LOGIC_VECTOR (25 downto 0);
    signal leftShiftStage1Idx1Rng2_uid236_fracPostNormExt_uid89_block_rsrvd_fix_b : STD_LOGIC_VECTOR (25 downto 0);
    signal leftShiftStage1Idx1_uid237_fracPostNormExt_uid89_block_rsrvd_fix_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx2Rng4_uid239_fracPostNormExt_uid89_block_rsrvd_fix_in : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage1Idx2Rng4_uid239_fracPostNormExt_uid89_block_rsrvd_fix_b : STD_LOGIC_VECTOR (23 downto 0);
    signal leftShiftStage1Idx2_uid240_fracPostNormExt_uid89_block_rsrvd_fix_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1Idx3Pad6_uid241_fracPostNormExt_uid89_block_rsrvd_fix_q : STD_LOGIC_VECTOR (5 downto 0);
    signal leftShiftStage1Idx3Rng6_uid242_fracPostNormExt_uid89_block_rsrvd_fix_in : STD_LOGIC_VECTOR (21 downto 0);
    signal leftShiftStage1Idx3Rng6_uid242_fracPostNormExt_uid89_block_rsrvd_fix_b : STD_LOGIC_VECTOR (21 downto 0);
    signal leftShiftStage1Idx3_uid243_fracPostNormExt_uid89_block_rsrvd_fix_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage1_uid245_fracPostNormExt_uid89_block_rsrvd_fix_s : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStage1_uid245_fracPostNormExt_uid89_block_rsrvd_fix_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage2Idx1Rng1_uid247_fracPostNormExt_uid89_block_rsrvd_fix_in : STD_LOGIC_VECTOR (26 downto 0);
    signal leftShiftStage2Idx1Rng1_uid247_fracPostNormExt_uid89_block_rsrvd_fix_b : STD_LOGIC_VECTOR (26 downto 0);
    signal leftShiftStage2Idx1_uid248_fracPostNormExt_uid89_block_rsrvd_fix_q : STD_LOGIC_VECTOR (27 downto 0);
    signal leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix_s : STD_LOGIC_VECTOR (0 downto 0);
    signal leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix_q : STD_LOGIC_VECTOR (27 downto 0);
    signal rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_in : STD_LOGIC_VECTOR (5 downto 0);
    signal rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_d : STD_LOGIC_VECTOR (1 downto 0);
    signal stickyBits_uid70_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (22 downto 0);
    signal stickyBits_uid70_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (25 downto 0);
    signal rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (7 downto 0);
    signal rVStage_uid166_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid166_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (3 downto 0);
    signal rVStage_uid172_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal rVStage_uid172_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_b : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_c : STD_LOGIC_VECTOR (1 downto 0);
    signal leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_d : STD_LOGIC_VECTOR (0 downto 0);
    signal redist0_leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist1_leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_d_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist2_rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist3_rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist4_rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_d_1_q : STD_LOGIC_VECTOR (1 downto 0);
    signal redist5_r_uid180_lzCountVal_uid86_block_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (4 downto 0);
    signal redist6_vCount_uid167_lzCountVal_uid86_block_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist7_vCount_uid161_lzCountVal_uid86_block_rsrvd_fix_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist8_vStage_uid155_lzCountVal_uid86_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (11 downto 0);
    signal redist9_vCount_uid153_lzCountVal_uid86_block_rsrvd_fix_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist10_rVStage_uid152_lzCountVal_uid86_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (15 downto 0);
    signal redist11_signRInfRZRReg_uid138_block_rsrvd_fix_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist12_regInputs_uid119_block_rsrvd_fix_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist13_expRPreExc_uid118_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist14_fracRPreExc_uid117_block_rsrvd_fix_b_2_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist15_fracPostNormRndRange_uid103_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (23 downto 0);
    signal redist16_aMinusA_uid88_block_rsrvd_fix_q_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist17_fracGRS_uid85_block_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist18_fracGRS_uid85_block_rsrvd_fix_q_3_q : STD_LOGIC_VECTOR (27 downto 0);
    signal redist19_rangeFracAddResultMwfp3Dto0_uid84_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (26 downto 0);
    signal redist20_cmpEQ_stickyBits_cZwF_uid72_block_rsrvd_fix_q_2_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist21_effSub_uid53_block_rsrvd_fix_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist22_sigB_uid52_block_rsrvd_fix_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist23_sigB_uid52_block_rsrvd_fix_b_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist24_sigA_uid51_block_rsrvd_fix_b_3_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist25_sigA_uid51_block_rsrvd_fix_b_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist26_excR_bSig_uid46_block_rsrvd_fix_q_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist27_excN_bSig_uid43_block_rsrvd_fix_q_11_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist28_excI_bSig_uid42_block_rsrvd_fix_q_8_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist29_excI_bSig_uid42_block_rsrvd_fix_q_11_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist30_excZ_bSig_uid18_uid38_block_rsrvd_fix_q_9_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist31_excZ_bSig_uid18_uid38_block_rsrvd_fix_q_12_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist32_frac_bSig_uid37_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist33_excN_aSig_uid29_block_rsrvd_fix_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist34_excI_aSig_uid28_block_rsrvd_fix_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist35_fracXIsZero_uid26_block_rsrvd_fix_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist36_excZ_aSig_uid17_uid24_block_rsrvd_fix_q_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist37_excZ_aSig_uid17_uid24_block_rsrvd_fix_q_4_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist38_frac_aSig_uid23_block_rsrvd_fix_b_4_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist40_expY_uid12_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist41_fracY_uid11_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist42_sigY_uid10_block_rsrvd_fix_b_1_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist43_in_0_in_0_1_q : STD_LOGIC_VECTOR (31 downto 0);
    signal redist38_frac_aSig_uid23_block_rsrvd_fix_b_4_outputreg_q : STD_LOGIC_VECTOR (22 downto 0);
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_outputreg_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_reset0 : std_logic;
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_ia : STD_LOGIC_VECTOR (7 downto 0);
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_aa : STD_LOGIC_VECTOR (2 downto 0);
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_ab : STD_LOGIC_VECTOR (2 downto 0);
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_iq : STD_LOGIC_VECTOR (7 downto 0);
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_q : STD_LOGIC_VECTOR (7 downto 0);
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_i : UNSIGNED (2 downto 0);
    attribute preserve : boolean;
    attribute preserve of redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_i : signal is true;
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_eq : std_logic;
    attribute preserve of redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_eq : signal is true;
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_wraddr_q : STD_LOGIC_VECTOR (2 downto 0);
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_last_q : STD_LOGIC_VECTOR (3 downto 0);
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_cmp_b : STD_LOGIC_VECTOR (3 downto 0);
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_cmp_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_cmpReg_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_notEnable_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_nor_q : STD_LOGIC_VECTOR (0 downto 0);
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_sticky_ena_q : STD_LOGIC_VECTOR (0 downto 0);
    attribute dont_merge : boolean;
    attribute dont_merge of redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_sticky_ena_q : signal is true;
    signal redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_enaAnd_q : STD_LOGIC_VECTOR (0 downto 0);

begin


    -- cAmA_uid87_block_rsrvd_fix(CONSTANT,86)
    cAmA_uid87_block_rsrvd_fix_q <= "11100";

    -- zs_uid151_lzCountVal_uid86_block_rsrvd_fix(CONSTANT,150)
    zs_uid151_lzCountVal_uid86_block_rsrvd_fix_q <= "0000000000000000";

    -- sigY_uid10_block_rsrvd_fix(BITSELECT,9)@0
    sigY_uid10_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(in_1(31 downto 31));

    -- redist42_sigY_uid10_block_rsrvd_fix_b_1(DELAY,299)
    redist42_sigY_uid10_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => sigY_uid10_block_rsrvd_fix_b, xout => redist42_sigY_uid10_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- expY_uid12_block_rsrvd_fix(BITSELECT,11)@0
    expY_uid12_block_rsrvd_fix_b <= in_1(30 downto 23);

    -- redist40_expY_uid12_block_rsrvd_fix_b_1(DELAY,297)
    redist40_expY_uid12_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expY_uid12_block_rsrvd_fix_b, xout => redist40_expY_uid12_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- fracY_uid11_block_rsrvd_fix(BITSELECT,10)@0
    fracY_uid11_block_rsrvd_fix_b <= in_1(22 downto 0);

    -- redist41_fracY_uid11_block_rsrvd_fix_b_1(DELAY,298)
    redist41_fracY_uid11_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => fracY_uid11_block_rsrvd_fix_b, xout => redist41_fracY_uid11_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- ypn_uid13_block_rsrvd_fix(BITJOIN,12)@1
    ypn_uid13_block_rsrvd_fix_q <= redist42_sigY_uid10_block_rsrvd_fix_b_1_q & redist40_expY_uid12_block_rsrvd_fix_b_1_q & redist41_fracY_uid11_block_rsrvd_fix_b_1_q;

    -- redist43_in_0_in_0_1(DELAY,300)
    redist43_in_0_in_0_1 : dspba_delay
    GENERIC MAP ( width => 32, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => in_0, xout => redist43_in_0_in_0_1_q, clk => clock, aclr => resetn );

    -- GND(CONSTANT,0)
    GND_q <= "0";

    -- expFracY_uid8_block_rsrvd_fix(BITSELECT,7)@0
    expFracY_uid8_block_rsrvd_fix_b <= in_1(30 downto 0);

    -- expFracX_uid7_block_rsrvd_fix(BITSELECT,6)@0
    expFracX_uid7_block_rsrvd_fix_b <= in_0(30 downto 0);

    -- xGTEy_uid9_block_rsrvd_fix(COMPARE,8)@0 + 1
    xGTEy_uid9_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("00" & expFracX_uid7_block_rsrvd_fix_b);
    xGTEy_uid9_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("00" & expFracY_uid8_block_rsrvd_fix_b);
    xGTEy_uid9_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            xGTEy_uid9_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            xGTEy_uid9_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(xGTEy_uid9_block_rsrvd_fix_a) - UNSIGNED(xGTEy_uid9_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    xGTEy_uid9_block_rsrvd_fix_n(0) <= not (xGTEy_uid9_block_rsrvd_fix_o(32));

    -- bSig_uid18_block_rsrvd_fix(MUX,17)@1
    bSig_uid18_block_rsrvd_fix_s <= xGTEy_uid9_block_rsrvd_fix_n;
    bSig_uid18_block_rsrvd_fix_combproc: PROCESS (bSig_uid18_block_rsrvd_fix_s, redist43_in_0_in_0_1_q, ypn_uid13_block_rsrvd_fix_q)
    BEGIN
        CASE (bSig_uid18_block_rsrvd_fix_s) IS
            WHEN "0" => bSig_uid18_block_rsrvd_fix_q <= redist43_in_0_in_0_1_q;
            WHEN "1" => bSig_uid18_block_rsrvd_fix_q <= ypn_uid13_block_rsrvd_fix_q;
            WHEN OTHERS => bSig_uid18_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- sigB_uid52_block_rsrvd_fix(BITSELECT,51)@1
    sigB_uid52_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(bSig_uid18_block_rsrvd_fix_q(31 downto 31));

    -- redist22_sigB_uid52_block_rsrvd_fix_b_3(DELAY,279)
    redist22_sigB_uid52_block_rsrvd_fix_b_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => sigB_uid52_block_rsrvd_fix_b, xout => redist22_sigB_uid52_block_rsrvd_fix_b_3_q, clk => clock, aclr => resetn );

    -- aSig_uid17_block_rsrvd_fix(MUX,16)@1
    aSig_uid17_block_rsrvd_fix_s <= xGTEy_uid9_block_rsrvd_fix_n;
    aSig_uid17_block_rsrvd_fix_combproc: PROCESS (aSig_uid17_block_rsrvd_fix_s, ypn_uid13_block_rsrvd_fix_q, redist43_in_0_in_0_1_q)
    BEGIN
        CASE (aSig_uid17_block_rsrvd_fix_s) IS
            WHEN "0" => aSig_uid17_block_rsrvd_fix_q <= ypn_uid13_block_rsrvd_fix_q;
            WHEN "1" => aSig_uid17_block_rsrvd_fix_q <= redist43_in_0_in_0_1_q;
            WHEN OTHERS => aSig_uid17_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- sigA_uid51_block_rsrvd_fix(BITSELECT,50)@1
    sigA_uid51_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(aSig_uid17_block_rsrvd_fix_q(31 downto 31));

    -- redist24_sigA_uid51_block_rsrvd_fix_b_3(DELAY,281)
    redist24_sigA_uid51_block_rsrvd_fix_b_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => sigA_uid51_block_rsrvd_fix_b, xout => redist24_sigA_uid51_block_rsrvd_fix_b_3_q, clk => clock, aclr => resetn );

    -- effSub_uid53_block_rsrvd_fix(LOGICAL,52)@4
    effSub_uid53_block_rsrvd_fix_q <= redist24_sigA_uid51_block_rsrvd_fix_b_3_q xor redist22_sigB_uid52_block_rsrvd_fix_b_3_q;

    -- exp_bSig_uid36_block_rsrvd_fix(BITSELECT,35)@1
    exp_bSig_uid36_block_rsrvd_fix_in <= bSig_uid18_block_rsrvd_fix_q(30 downto 0);
    exp_bSig_uid36_block_rsrvd_fix_b <= exp_bSig_uid36_block_rsrvd_fix_in(30 downto 23);

    -- exp_aSig_uid22_block_rsrvd_fix(BITSELECT,21)@1
    exp_aSig_uid22_block_rsrvd_fix_in <= aSig_uid17_block_rsrvd_fix_q(30 downto 0);
    exp_aSig_uid22_block_rsrvd_fix_b <= exp_aSig_uid22_block_rsrvd_fix_in(30 downto 23);

    -- expAmExpB_uid61_block_rsrvd_fix(SUB,60)@1 + 1
    expAmExpB_uid61_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("0" & exp_aSig_uid22_block_rsrvd_fix_b);
    expAmExpB_uid61_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("0" & exp_bSig_uid36_block_rsrvd_fix_b);
    expAmExpB_uid61_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            expAmExpB_uid61_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            expAmExpB_uid61_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(expAmExpB_uid61_block_rsrvd_fix_a) - UNSIGNED(expAmExpB_uid61_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    expAmExpB_uid61_block_rsrvd_fix_q <= expAmExpB_uid61_block_rsrvd_fix_o(8 downto 0);

    -- cWFP2_uid62_block_rsrvd_fix(CONSTANT,61)
    cWFP2_uid62_block_rsrvd_fix_q <= "11001";

    -- shiftedOut_uid64_block_rsrvd_fix(COMPARE,63)@2 + 1
    shiftedOut_uid64_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("000000" & cWFP2_uid62_block_rsrvd_fix_q);
    shiftedOut_uid64_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("00" & expAmExpB_uid61_block_rsrvd_fix_q);
    shiftedOut_uid64_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            shiftedOut_uid64_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            shiftedOut_uid64_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid64_block_rsrvd_fix_a) - UNSIGNED(shiftedOut_uid64_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    shiftedOut_uid64_block_rsrvd_fix_c(0) <= shiftedOut_uid64_block_rsrvd_fix_o(10);

    -- iShiftedOut_uid68_block_rsrvd_fix(LOGICAL,67)@3
    iShiftedOut_uid68_block_rsrvd_fix_q <= not (shiftedOut_uid64_block_rsrvd_fix_c);

    -- zeroOutCst_uid219_alignmentShifter_uid65_block_rsrvd_fix(CONSTANT,218)
    zeroOutCst_uid219_alignmentShifter_uid65_block_rsrvd_fix_q <= "0000000000000000000000000000000000000000000000000";

    -- rightShiftStage2Idx3Pad3_uid215_alignmentShifter_uid65_block_rsrvd_fix(CONSTANT,214)
    rightShiftStage2Idx3Pad3_uid215_alignmentShifter_uid65_block_rsrvd_fix_q <= "000";

    -- rightShiftStage2Idx3Rng3_uid214_alignmentShifter_uid65_block_rsrvd_fix(BITSELECT,213)@3
    rightShiftStage2Idx3Rng3_uid214_alignmentShifter_uid65_block_rsrvd_fix_b <= rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_q(48 downto 3);

    -- rightShiftStage2Idx3_uid216_alignmentShifter_uid65_block_rsrvd_fix(BITJOIN,215)@3
    rightShiftStage2Idx3_uid216_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage2Idx3Pad3_uid215_alignmentShifter_uid65_block_rsrvd_fix_q & rightShiftStage2Idx3Rng3_uid214_alignmentShifter_uid65_block_rsrvd_fix_b;

    -- zs_uid171_lzCountVal_uid86_block_rsrvd_fix(CONSTANT,170)
    zs_uid171_lzCountVal_uid86_block_rsrvd_fix_q <= "00";

    -- rightShiftStage2Idx2Rng2_uid211_alignmentShifter_uid65_block_rsrvd_fix(BITSELECT,210)@3
    rightShiftStage2Idx2Rng2_uid211_alignmentShifter_uid65_block_rsrvd_fix_b <= rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_q(48 downto 2);

    -- rightShiftStage2Idx2_uid213_alignmentShifter_uid65_block_rsrvd_fix(BITJOIN,212)@3
    rightShiftStage2Idx2_uid213_alignmentShifter_uid65_block_rsrvd_fix_q <= zs_uid171_lzCountVal_uid86_block_rsrvd_fix_q & rightShiftStage2Idx2Rng2_uid211_alignmentShifter_uid65_block_rsrvd_fix_b;

    -- rightShiftStage2Idx1Rng1_uid208_alignmentShifter_uid65_block_rsrvd_fix(BITSELECT,207)@3
    rightShiftStage2Idx1Rng1_uid208_alignmentShifter_uid65_block_rsrvd_fix_b <= rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_q(48 downto 1);

    -- rightShiftStage2Idx1_uid210_alignmentShifter_uid65_block_rsrvd_fix(BITJOIN,209)@3
    rightShiftStage2Idx1_uid210_alignmentShifter_uid65_block_rsrvd_fix_q <= GND_q & rightShiftStage2Idx1Rng1_uid208_alignmentShifter_uid65_block_rsrvd_fix_b;

    -- rightShiftStage1Idx3Pad12_uid204_alignmentShifter_uid65_block_rsrvd_fix(CONSTANT,203)
    rightShiftStage1Idx3Pad12_uid204_alignmentShifter_uid65_block_rsrvd_fix_q <= "000000000000";

    -- rightShiftStage1Idx3Rng12_uid203_alignmentShifter_uid65_block_rsrvd_fix(BITSELECT,202)@2
    rightShiftStage1Idx3Rng12_uid203_alignmentShifter_uid65_block_rsrvd_fix_b <= rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix_q(48 downto 12);

    -- rightShiftStage1Idx3_uid205_alignmentShifter_uid65_block_rsrvd_fix(BITJOIN,204)@2
    rightShiftStage1Idx3_uid205_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage1Idx3Pad12_uid204_alignmentShifter_uid65_block_rsrvd_fix_q & rightShiftStage1Idx3Rng12_uid203_alignmentShifter_uid65_block_rsrvd_fix_b;

    -- cstAllZWE_uid21_block_rsrvd_fix(CONSTANT,20)
    cstAllZWE_uid21_block_rsrvd_fix_q <= "00000000";

    -- rightShiftStage1Idx2Rng8_uid200_alignmentShifter_uid65_block_rsrvd_fix(BITSELECT,199)@2
    rightShiftStage1Idx2Rng8_uid200_alignmentShifter_uid65_block_rsrvd_fix_b <= rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix_q(48 downto 8);

    -- rightShiftStage1Idx2_uid202_alignmentShifter_uid65_block_rsrvd_fix(BITJOIN,201)@2
    rightShiftStage1Idx2_uid202_alignmentShifter_uid65_block_rsrvd_fix_q <= cstAllZWE_uid21_block_rsrvd_fix_q & rightShiftStage1Idx2Rng8_uid200_alignmentShifter_uid65_block_rsrvd_fix_b;

    -- zs_uid165_lzCountVal_uid86_block_rsrvd_fix(CONSTANT,164)
    zs_uid165_lzCountVal_uid86_block_rsrvd_fix_q <= "0000";

    -- rightShiftStage1Idx1Rng4_uid197_alignmentShifter_uid65_block_rsrvd_fix(BITSELECT,196)@2
    rightShiftStage1Idx1Rng4_uid197_alignmentShifter_uid65_block_rsrvd_fix_b <= rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix_q(48 downto 4);

    -- rightShiftStage1Idx1_uid199_alignmentShifter_uid65_block_rsrvd_fix(BITJOIN,198)@2
    rightShiftStage1Idx1_uid199_alignmentShifter_uid65_block_rsrvd_fix_q <= zs_uid165_lzCountVal_uid86_block_rsrvd_fix_q & rightShiftStage1Idx1Rng4_uid197_alignmentShifter_uid65_block_rsrvd_fix_b;

    -- rightShiftStage0Idx3Pad48_uid193_alignmentShifter_uid65_block_rsrvd_fix(CONSTANT,192)
    rightShiftStage0Idx3Pad48_uid193_alignmentShifter_uid65_block_rsrvd_fix_q <= "000000000000000000000000000000000000000000000000";

    -- rightShiftStage0Idx3Rng48_uid192_alignmentShifter_uid65_block_rsrvd_fix(BITSELECT,191)@2
    rightShiftStage0Idx3Rng48_uid192_alignmentShifter_uid65_block_rsrvd_fix_b <= rightPaddedIn_uid66_block_rsrvd_fix_q(48 downto 48);

    -- rightShiftStage0Idx3_uid194_alignmentShifter_uid65_block_rsrvd_fix(BITJOIN,193)@2
    rightShiftStage0Idx3_uid194_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage0Idx3Pad48_uid193_alignmentShifter_uid65_block_rsrvd_fix_q & rightShiftStage0Idx3Rng48_uid192_alignmentShifter_uid65_block_rsrvd_fix_b;

    -- rightShiftStage0Idx2Pad32_uid190_alignmentShifter_uid65_block_rsrvd_fix(CONSTANT,189)
    rightShiftStage0Idx2Pad32_uid190_alignmentShifter_uid65_block_rsrvd_fix_q <= "00000000000000000000000000000000";

    -- rightShiftStage0Idx2Rng32_uid189_alignmentShifter_uid65_block_rsrvd_fix(BITSELECT,188)@2
    rightShiftStage0Idx2Rng32_uid189_alignmentShifter_uid65_block_rsrvd_fix_b <= rightPaddedIn_uid66_block_rsrvd_fix_q(48 downto 32);

    -- rightShiftStage0Idx2_uid191_alignmentShifter_uid65_block_rsrvd_fix(BITJOIN,190)@2
    rightShiftStage0Idx2_uid191_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage0Idx2Pad32_uid190_alignmentShifter_uid65_block_rsrvd_fix_q & rightShiftStage0Idx2Rng32_uid189_alignmentShifter_uid65_block_rsrvd_fix_b;

    -- rightShiftStage0Idx1Rng16_uid186_alignmentShifter_uid65_block_rsrvd_fix(BITSELECT,185)@2
    rightShiftStage0Idx1Rng16_uid186_alignmentShifter_uid65_block_rsrvd_fix_b <= rightPaddedIn_uid66_block_rsrvd_fix_q(48 downto 16);

    -- rightShiftStage0Idx1_uid188_alignmentShifter_uid65_block_rsrvd_fix(BITJOIN,187)@2
    rightShiftStage0Idx1_uid188_alignmentShifter_uid65_block_rsrvd_fix_q <= zs_uid151_lzCountVal_uid86_block_rsrvd_fix_q & rightShiftStage0Idx1Rng16_uid186_alignmentShifter_uid65_block_rsrvd_fix_b;

    -- excZ_bSig_uid18_uid38_block_rsrvd_fix(LOGICAL,37)@1 + 1
    excZ_bSig_uid18_uid38_block_rsrvd_fix_qi <= "1" WHEN exp_bSig_uid36_block_rsrvd_fix_b = cstAllZWE_uid21_block_rsrvd_fix_q ELSE "0";
    excZ_bSig_uid18_uid38_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excZ_bSig_uid18_uid38_block_rsrvd_fix_qi, xout => excZ_bSig_uid18_uid38_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- InvExpXIsZero_uid45_block_rsrvd_fix(LOGICAL,44)@2
    InvExpXIsZero_uid45_block_rsrvd_fix_q <= not (excZ_bSig_uid18_uid38_block_rsrvd_fix_q);

    -- cstZeroWF_uid20_block_rsrvd_fix(CONSTANT,19)
    cstZeroWF_uid20_block_rsrvd_fix_q <= "00000000000000000000000";

    -- frac_bSig_uid37_block_rsrvd_fix(BITSELECT,36)@1
    frac_bSig_uid37_block_rsrvd_fix_in <= bSig_uid18_block_rsrvd_fix_q(22 downto 0);
    frac_bSig_uid37_block_rsrvd_fix_b <= frac_bSig_uid37_block_rsrvd_fix_in(22 downto 0);

    -- redist32_frac_bSig_uid37_block_rsrvd_fix_b_1(DELAY,289)
    redist32_frac_bSig_uid37_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => frac_bSig_uid37_block_rsrvd_fix_b, xout => redist32_frac_bSig_uid37_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- fracBz_uid57_block_rsrvd_fix(MUX,56)@2
    fracBz_uid57_block_rsrvd_fix_s <= excZ_bSig_uid18_uid38_block_rsrvd_fix_q;
    fracBz_uid57_block_rsrvd_fix_combproc: PROCESS (fracBz_uid57_block_rsrvd_fix_s, redist32_frac_bSig_uid37_block_rsrvd_fix_b_1_q, cstZeroWF_uid20_block_rsrvd_fix_q)
    BEGIN
        CASE (fracBz_uid57_block_rsrvd_fix_s) IS
            WHEN "0" => fracBz_uid57_block_rsrvd_fix_q <= redist32_frac_bSig_uid37_block_rsrvd_fix_b_1_q;
            WHEN "1" => fracBz_uid57_block_rsrvd_fix_q <= cstZeroWF_uid20_block_rsrvd_fix_q;
            WHEN OTHERS => fracBz_uid57_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oFracB_uid60_block_rsrvd_fix(BITJOIN,59)@2
    oFracB_uid60_block_rsrvd_fix_q <= InvExpXIsZero_uid45_block_rsrvd_fix_q & fracBz_uid57_block_rsrvd_fix_q;

    -- padConst_uid65_block_rsrvd_fix(CONSTANT,64)
    padConst_uid65_block_rsrvd_fix_q <= "0000000000000000000000000";

    -- rightPaddedIn_uid66_block_rsrvd_fix(BITJOIN,65)@2
    rightPaddedIn_uid66_block_rsrvd_fix_q <= oFracB_uid60_block_rsrvd_fix_q & padConst_uid65_block_rsrvd_fix_q;

    -- rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix(MUX,195)@2
    rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix_s <= rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_b;
    rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix_combproc: PROCESS (rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix_s, rightPaddedIn_uid66_block_rsrvd_fix_q, rightShiftStage0Idx1_uid188_alignmentShifter_uid65_block_rsrvd_fix_q, rightShiftStage0Idx2_uid191_alignmentShifter_uid65_block_rsrvd_fix_q, rightShiftStage0Idx3_uid194_alignmentShifter_uid65_block_rsrvd_fix_q)
    BEGIN
        CASE (rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix_s) IS
            WHEN "00" => rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix_q <= rightPaddedIn_uid66_block_rsrvd_fix_q;
            WHEN "01" => rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage0Idx1_uid188_alignmentShifter_uid65_block_rsrvd_fix_q;
            WHEN "10" => rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage0Idx2_uid191_alignmentShifter_uid65_block_rsrvd_fix_q;
            WHEN "11" => rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage0Idx3_uid194_alignmentShifter_uid65_block_rsrvd_fix_q;
            WHEN OTHERS => rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select(BITSELECT,251)@2
    rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_in <= expAmExpB_uid61_block_rsrvd_fix_q(5 downto 0);
    rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_b <= rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_in(5 downto 4);
    rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_c <= rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_in(3 downto 2);
    rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_d <= rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_in(1 downto 0);

    -- rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix(MUX,206)@2 + 1
    rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_s <= rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_c;
    rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_s) IS
                WHEN "00" => rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage0_uid196_alignmentShifter_uid65_block_rsrvd_fix_q;
                WHEN "01" => rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage1Idx1_uid199_alignmentShifter_uid65_block_rsrvd_fix_q;
                WHEN "10" => rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage1Idx2_uid202_alignmentShifter_uid65_block_rsrvd_fix_q;
                WHEN "11" => rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage1Idx3_uid205_alignmentShifter_uid65_block_rsrvd_fix_q;
                WHEN OTHERS => rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist4_rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_d_1(DELAY,261)
    redist4_rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_d_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_d, xout => redist4_rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_d_1_q, clk => clock, aclr => resetn );

    -- rightShiftStage2_uid218_alignmentShifter_uid65_block_rsrvd_fix(MUX,217)@3
    rightShiftStage2_uid218_alignmentShifter_uid65_block_rsrvd_fix_s <= redist4_rightShiftStageSel5Dto4_uid195_alignmentShifter_uid65_block_rsrvd_fix_merged_bit_select_d_1_q;
    rightShiftStage2_uid218_alignmentShifter_uid65_block_rsrvd_fix_combproc: PROCESS (rightShiftStage2_uid218_alignmentShifter_uid65_block_rsrvd_fix_s, rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_q, rightShiftStage2Idx1_uid210_alignmentShifter_uid65_block_rsrvd_fix_q, rightShiftStage2Idx2_uid213_alignmentShifter_uid65_block_rsrvd_fix_q, rightShiftStage2Idx3_uid216_alignmentShifter_uid65_block_rsrvd_fix_q)
    BEGIN
        CASE (rightShiftStage2_uid218_alignmentShifter_uid65_block_rsrvd_fix_s) IS
            WHEN "00" => rightShiftStage2_uid218_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage1_uid207_alignmentShifter_uid65_block_rsrvd_fix_q;
            WHEN "01" => rightShiftStage2_uid218_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage2Idx1_uid210_alignmentShifter_uid65_block_rsrvd_fix_q;
            WHEN "10" => rightShiftStage2_uid218_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage2Idx2_uid213_alignmentShifter_uid65_block_rsrvd_fix_q;
            WHEN "11" => rightShiftStage2_uid218_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage2Idx3_uid216_alignmentShifter_uid65_block_rsrvd_fix_q;
            WHEN OTHERS => rightShiftStage2_uid218_alignmentShifter_uid65_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- wIntCst_uid184_alignmentShifter_uid65_block_rsrvd_fix(CONSTANT,183)
    wIntCst_uid184_alignmentShifter_uid65_block_rsrvd_fix_q <= "110001";

    -- shiftedOut_uid185_alignmentShifter_uid65_block_rsrvd_fix(COMPARE,184)@2 + 1
    shiftedOut_uid185_alignmentShifter_uid65_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("00" & expAmExpB_uid61_block_rsrvd_fix_q);
    shiftedOut_uid185_alignmentShifter_uid65_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("00000" & wIntCst_uid184_alignmentShifter_uid65_block_rsrvd_fix_q);
    shiftedOut_uid185_alignmentShifter_uid65_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            shiftedOut_uid185_alignmentShifter_uid65_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            shiftedOut_uid185_alignmentShifter_uid65_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(shiftedOut_uid185_alignmentShifter_uid65_block_rsrvd_fix_a) - UNSIGNED(shiftedOut_uid185_alignmentShifter_uid65_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    shiftedOut_uid185_alignmentShifter_uid65_block_rsrvd_fix_n(0) <= not (shiftedOut_uid185_alignmentShifter_uid65_block_rsrvd_fix_o(10));

    -- r_uid220_alignmentShifter_uid65_block_rsrvd_fix(MUX,219)@3
    r_uid220_alignmentShifter_uid65_block_rsrvd_fix_s <= shiftedOut_uid185_alignmentShifter_uid65_block_rsrvd_fix_n;
    r_uid220_alignmentShifter_uid65_block_rsrvd_fix_combproc: PROCESS (r_uid220_alignmentShifter_uid65_block_rsrvd_fix_s, rightShiftStage2_uid218_alignmentShifter_uid65_block_rsrvd_fix_q, zeroOutCst_uid219_alignmentShifter_uid65_block_rsrvd_fix_q)
    BEGIN
        CASE (r_uid220_alignmentShifter_uid65_block_rsrvd_fix_s) IS
            WHEN "0" => r_uid220_alignmentShifter_uid65_block_rsrvd_fix_q <= rightShiftStage2_uid218_alignmentShifter_uid65_block_rsrvd_fix_q;
            WHEN "1" => r_uid220_alignmentShifter_uid65_block_rsrvd_fix_q <= zeroOutCst_uid219_alignmentShifter_uid65_block_rsrvd_fix_q;
            WHEN OTHERS => r_uid220_alignmentShifter_uid65_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- alignFracBPostShiftOut_uid69_block_rsrvd_fix(LOGICAL,68)@3 + 1
    alignFracBPostShiftOut_uid69_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((48 downto 1 => iShiftedOut_uid68_block_rsrvd_fix_q(0)) & iShiftedOut_uid68_block_rsrvd_fix_q));
    alignFracBPostShiftOut_uid69_block_rsrvd_fix_qi <= r_uid220_alignmentShifter_uid65_block_rsrvd_fix_q and alignFracBPostShiftOut_uid69_block_rsrvd_fix_b;
    alignFracBPostShiftOut_uid69_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 49, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => alignFracBPostShiftOut_uid69_block_rsrvd_fix_qi, xout => alignFracBPostShiftOut_uid69_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- stickyBits_uid70_block_rsrvd_fix_merged_bit_select(BITSELECT,252)@4
    stickyBits_uid70_block_rsrvd_fix_merged_bit_select_b <= alignFracBPostShiftOut_uid69_block_rsrvd_fix_q(22 downto 0);
    stickyBits_uid70_block_rsrvd_fix_merged_bit_select_c <= alignFracBPostShiftOut_uid69_block_rsrvd_fix_q(48 downto 23);

    -- fracBAddOp_uid81_block_rsrvd_fix(BITJOIN,80)@4
    fracBAddOp_uid81_block_rsrvd_fix_q <= GND_q & stickyBits_uid70_block_rsrvd_fix_merged_bit_select_c;

    -- fracBAddOpPostXor_uid82_block_rsrvd_fix(LOGICAL,81)@4 + 1
    fracBAddOpPostXor_uid82_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR((26 downto 1 => effSub_uid53_block_rsrvd_fix_q(0)) & effSub_uid53_block_rsrvd_fix_q));
    fracBAddOpPostXor_uid82_block_rsrvd_fix_qi <= fracBAddOp_uid81_block_rsrvd_fix_q xor fracBAddOpPostXor_uid82_block_rsrvd_fix_b;
    fracBAddOpPostXor_uid82_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => fracBAddOpPostXor_uid82_block_rsrvd_fix_qi, xout => fracBAddOpPostXor_uid82_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- zocst_uid77_block_rsrvd_fix(CONSTANT,76)
    zocst_uid77_block_rsrvd_fix_q <= "01";

    -- frac_aSig_uid23_block_rsrvd_fix(BITSELECT,22)@1
    frac_aSig_uid23_block_rsrvd_fix_in <= aSig_uid17_block_rsrvd_fix_q(22 downto 0);
    frac_aSig_uid23_block_rsrvd_fix_b <= frac_aSig_uid23_block_rsrvd_fix_in(22 downto 0);

    -- redist38_frac_aSig_uid23_block_rsrvd_fix_b_4(DELAY,295)
    redist38_frac_aSig_uid23_block_rsrvd_fix_b_4 : dspba_delay
    GENERIC MAP ( width => 23, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => frac_aSig_uid23_block_rsrvd_fix_b, xout => redist38_frac_aSig_uid23_block_rsrvd_fix_b_4_q, clk => clock, aclr => resetn );

    -- redist38_frac_aSig_uid23_block_rsrvd_fix_b_4_outputreg(DELAY,301)
    redist38_frac_aSig_uid23_block_rsrvd_fix_b_4_outputreg : dspba_delay
    GENERIC MAP ( width => 23, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist38_frac_aSig_uid23_block_rsrvd_fix_b_4_q, xout => redist38_frac_aSig_uid23_block_rsrvd_fix_b_4_outputreg_q, clk => clock, aclr => resetn );

    -- cmpEQ_stickyBits_cZwF_uid72_block_rsrvd_fix(LOGICAL,71)@4
    cmpEQ_stickyBits_cZwF_uid72_block_rsrvd_fix_q <= "1" WHEN stickyBits_uid70_block_rsrvd_fix_merged_bit_select_b = cstZeroWF_uid20_block_rsrvd_fix_q ELSE "0";

    -- effSubInvSticky_uid75_block_rsrvd_fix(LOGICAL,74)@4 + 1
    effSubInvSticky_uid75_block_rsrvd_fix_qi <= effSub_uid53_block_rsrvd_fix_q and cmpEQ_stickyBits_cZwF_uid72_block_rsrvd_fix_q;
    effSubInvSticky_uid75_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => effSubInvSticky_uid75_block_rsrvd_fix_qi, xout => effSubInvSticky_uid75_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- fracAAddOp_uid78_block_rsrvd_fix(BITJOIN,77)@5
    fracAAddOp_uid78_block_rsrvd_fix_q <= zocst_uid77_block_rsrvd_fix_q & redist38_frac_aSig_uid23_block_rsrvd_fix_b_4_outputreg_q & GND_q & effSubInvSticky_uid75_block_rsrvd_fix_q;

    -- fracAddResult_uid83_block_rsrvd_fix(ADD,82)@5
    fracAddResult_uid83_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("0" & fracAAddOp_uid78_block_rsrvd_fix_q);
    fracAddResult_uid83_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("0" & fracBAddOpPostXor_uid82_block_rsrvd_fix_q);
    fracAddResult_uid83_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(fracAddResult_uid83_block_rsrvd_fix_a) + UNSIGNED(fracAddResult_uid83_block_rsrvd_fix_b));
    fracAddResult_uid83_block_rsrvd_fix_q <= fracAddResult_uid83_block_rsrvd_fix_o(27 downto 0);

    -- rangeFracAddResultMwfp3Dto0_uid84_block_rsrvd_fix(BITSELECT,83)@5
    rangeFracAddResultMwfp3Dto0_uid84_block_rsrvd_fix_in <= fracAddResult_uid83_block_rsrvd_fix_q(26 downto 0);
    rangeFracAddResultMwfp3Dto0_uid84_block_rsrvd_fix_b <= rangeFracAddResultMwfp3Dto0_uid84_block_rsrvd_fix_in(26 downto 0);

    -- redist19_rangeFracAddResultMwfp3Dto0_uid84_block_rsrvd_fix_b_1(DELAY,276)
    redist19_rangeFracAddResultMwfp3Dto0_uid84_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 27, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rangeFracAddResultMwfp3Dto0_uid84_block_rsrvd_fix_b, xout => redist19_rangeFracAddResultMwfp3Dto0_uid84_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- redist20_cmpEQ_stickyBits_cZwF_uid72_block_rsrvd_fix_q_2(DELAY,277)
    redist20_cmpEQ_stickyBits_cZwF_uid72_block_rsrvd_fix_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => cmpEQ_stickyBits_cZwF_uid72_block_rsrvd_fix_q, xout => redist20_cmpEQ_stickyBits_cZwF_uid72_block_rsrvd_fix_q_2_q, clk => clock, aclr => resetn );

    -- invCmpEQ_stickyBits_cZwF_uid73_block_rsrvd_fix(LOGICAL,72)@6
    invCmpEQ_stickyBits_cZwF_uid73_block_rsrvd_fix_q <= not (redist20_cmpEQ_stickyBits_cZwF_uid72_block_rsrvd_fix_q_2_q);

    -- fracGRS_uid85_block_rsrvd_fix(BITJOIN,84)@6
    fracGRS_uid85_block_rsrvd_fix_q <= redist19_rangeFracAddResultMwfp3Dto0_uid84_block_rsrvd_fix_b_1_q & invCmpEQ_stickyBits_cZwF_uid73_block_rsrvd_fix_q;

    -- rVStage_uid152_lzCountVal_uid86_block_rsrvd_fix(BITSELECT,151)@6
    rVStage_uid152_lzCountVal_uid86_block_rsrvd_fix_b <= fracGRS_uid85_block_rsrvd_fix_q(27 downto 12);

    -- vCount_uid153_lzCountVal_uid86_block_rsrvd_fix(LOGICAL,152)@6 + 1
    vCount_uid153_lzCountVal_uid86_block_rsrvd_fix_qi <= "1" WHEN rVStage_uid152_lzCountVal_uid86_block_rsrvd_fix_b = zs_uid151_lzCountVal_uid86_block_rsrvd_fix_q ELSE "0";
    vCount_uid153_lzCountVal_uid86_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vCount_uid153_lzCountVal_uid86_block_rsrvd_fix_qi, xout => vCount_uid153_lzCountVal_uid86_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist9_vCount_uid153_lzCountVal_uid86_block_rsrvd_fix_q_3(DELAY,266)
    redist9_vCount_uid153_lzCountVal_uid86_block_rsrvd_fix_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vCount_uid153_lzCountVal_uid86_block_rsrvd_fix_q, xout => redist9_vCount_uid153_lzCountVal_uid86_block_rsrvd_fix_q_3_q, clk => clock, aclr => resetn );

    -- redist17_fracGRS_uid85_block_rsrvd_fix_q_1(DELAY,274)
    redist17_fracGRS_uid85_block_rsrvd_fix_q_1 : dspba_delay
    GENERIC MAP ( width => 28, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => fracGRS_uid85_block_rsrvd_fix_q, xout => redist17_fracGRS_uid85_block_rsrvd_fix_q_1_q, clk => clock, aclr => resetn );

    -- vStage_uid155_lzCountVal_uid86_block_rsrvd_fix(BITSELECT,154)@7
    vStage_uid155_lzCountVal_uid86_block_rsrvd_fix_in <= redist17_fracGRS_uid85_block_rsrvd_fix_q_1_q(11 downto 0);
    vStage_uid155_lzCountVal_uid86_block_rsrvd_fix_b <= vStage_uid155_lzCountVal_uid86_block_rsrvd_fix_in(11 downto 0);

    -- mO_uid154_lzCountVal_uid86_block_rsrvd_fix(CONSTANT,153)
    mO_uid154_lzCountVal_uid86_block_rsrvd_fix_q <= "1111";

    -- cStage_uid156_lzCountVal_uid86_block_rsrvd_fix(BITJOIN,155)@7
    cStage_uid156_lzCountVal_uid86_block_rsrvd_fix_q <= vStage_uid155_lzCountVal_uid86_block_rsrvd_fix_b & mO_uid154_lzCountVal_uid86_block_rsrvd_fix_q;

    -- redist10_rVStage_uid152_lzCountVal_uid86_block_rsrvd_fix_b_1(DELAY,267)
    redist10_rVStage_uid152_lzCountVal_uid86_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 16, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rVStage_uid152_lzCountVal_uid86_block_rsrvd_fix_b, xout => redist10_rVStage_uid152_lzCountVal_uid86_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- vStagei_uid158_lzCountVal_uid86_block_rsrvd_fix(MUX,157)@7
    vStagei_uid158_lzCountVal_uid86_block_rsrvd_fix_s <= vCount_uid153_lzCountVal_uid86_block_rsrvd_fix_q;
    vStagei_uid158_lzCountVal_uid86_block_rsrvd_fix_combproc: PROCESS (vStagei_uid158_lzCountVal_uid86_block_rsrvd_fix_s, redist10_rVStage_uid152_lzCountVal_uid86_block_rsrvd_fix_b_1_q, cStage_uid156_lzCountVal_uid86_block_rsrvd_fix_q)
    BEGIN
        CASE (vStagei_uid158_lzCountVal_uid86_block_rsrvd_fix_s) IS
            WHEN "0" => vStagei_uid158_lzCountVal_uid86_block_rsrvd_fix_q <= redist10_rVStage_uid152_lzCountVal_uid86_block_rsrvd_fix_b_1_q;
            WHEN "1" => vStagei_uid158_lzCountVal_uid86_block_rsrvd_fix_q <= cStage_uid156_lzCountVal_uid86_block_rsrvd_fix_q;
            WHEN OTHERS => vStagei_uid158_lzCountVal_uid86_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select(BITSELECT,253)@7
    rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b <= vStagei_uid158_lzCountVal_uid86_block_rsrvd_fix_q(15 downto 8);
    rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c <= vStagei_uid158_lzCountVal_uid86_block_rsrvd_fix_q(7 downto 0);

    -- vCount_uid161_lzCountVal_uid86_block_rsrvd_fix(LOGICAL,160)@7 + 1
    vCount_uid161_lzCountVal_uid86_block_rsrvd_fix_qi <= "1" WHEN rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b = cstAllZWE_uid21_block_rsrvd_fix_q ELSE "0";
    vCount_uid161_lzCountVal_uid86_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vCount_uid161_lzCountVal_uid86_block_rsrvd_fix_qi, xout => vCount_uid161_lzCountVal_uid86_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist7_vCount_uid161_lzCountVal_uid86_block_rsrvd_fix_q_2(DELAY,264)
    redist7_vCount_uid161_lzCountVal_uid86_block_rsrvd_fix_q_2 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vCount_uid161_lzCountVal_uid86_block_rsrvd_fix_q, xout => redist7_vCount_uid161_lzCountVal_uid86_block_rsrvd_fix_q_2_q, clk => clock, aclr => resetn );

    -- redist3_rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c_1(DELAY,260)
    redist3_rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c, xout => redist3_rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c_1_q, clk => clock, aclr => resetn );

    -- redist2_rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b_1(DELAY,259)
    redist2_rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b_1 : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b, xout => redist2_rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b_1_q, clk => clock, aclr => resetn );

    -- vStagei_uid164_lzCountVal_uid86_block_rsrvd_fix(MUX,163)@8
    vStagei_uid164_lzCountVal_uid86_block_rsrvd_fix_s <= vCount_uid161_lzCountVal_uid86_block_rsrvd_fix_q;
    vStagei_uid164_lzCountVal_uid86_block_rsrvd_fix_combproc: PROCESS (vStagei_uid164_lzCountVal_uid86_block_rsrvd_fix_s, redist2_rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b_1_q, redist3_rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c_1_q)
    BEGIN
        CASE (vStagei_uid164_lzCountVal_uid86_block_rsrvd_fix_s) IS
            WHEN "0" => vStagei_uid164_lzCountVal_uid86_block_rsrvd_fix_q <= redist2_rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b_1_q;
            WHEN "1" => vStagei_uid164_lzCountVal_uid86_block_rsrvd_fix_q <= redist3_rVStage_uid160_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c_1_q;
            WHEN OTHERS => vStagei_uid164_lzCountVal_uid86_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid166_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select(BITSELECT,254)@8
    rVStage_uid166_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b <= vStagei_uid164_lzCountVal_uid86_block_rsrvd_fix_q(7 downto 4);
    rVStage_uid166_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c <= vStagei_uid164_lzCountVal_uid86_block_rsrvd_fix_q(3 downto 0);

    -- vCount_uid167_lzCountVal_uid86_block_rsrvd_fix(LOGICAL,166)@8
    vCount_uid167_lzCountVal_uid86_block_rsrvd_fix_q <= "1" WHEN rVStage_uid166_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b = zs_uid165_lzCountVal_uid86_block_rsrvd_fix_q ELSE "0";

    -- redist6_vCount_uid167_lzCountVal_uid86_block_rsrvd_fix_q_1(DELAY,263)
    redist6_vCount_uid167_lzCountVal_uid86_block_rsrvd_fix_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vCount_uid167_lzCountVal_uid86_block_rsrvd_fix_q, xout => redist6_vCount_uid167_lzCountVal_uid86_block_rsrvd_fix_q_1_q, clk => clock, aclr => resetn );

    -- vStagei_uid170_lzCountVal_uid86_block_rsrvd_fix(MUX,169)@8 + 1
    vStagei_uid170_lzCountVal_uid86_block_rsrvd_fix_s <= vCount_uid167_lzCountVal_uid86_block_rsrvd_fix_q;
    vStagei_uid170_lzCountVal_uid86_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            vStagei_uid170_lzCountVal_uid86_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (vStagei_uid170_lzCountVal_uid86_block_rsrvd_fix_s) IS
                WHEN "0" => vStagei_uid170_lzCountVal_uid86_block_rsrvd_fix_q <= rVStage_uid166_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b;
                WHEN "1" => vStagei_uid170_lzCountVal_uid86_block_rsrvd_fix_q <= rVStage_uid166_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c;
                WHEN OTHERS => vStagei_uid170_lzCountVal_uid86_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- rVStage_uid172_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select(BITSELECT,255)@9
    rVStage_uid172_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b <= vStagei_uid170_lzCountVal_uid86_block_rsrvd_fix_q(3 downto 2);
    rVStage_uid172_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c <= vStagei_uid170_lzCountVal_uid86_block_rsrvd_fix_q(1 downto 0);

    -- vCount_uid173_lzCountVal_uid86_block_rsrvd_fix(LOGICAL,172)@9
    vCount_uid173_lzCountVal_uid86_block_rsrvd_fix_q <= "1" WHEN rVStage_uid172_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b = zs_uid171_lzCountVal_uid86_block_rsrvd_fix_q ELSE "0";

    -- vStagei_uid176_lzCountVal_uid86_block_rsrvd_fix(MUX,175)@9
    vStagei_uid176_lzCountVal_uid86_block_rsrvd_fix_s <= vCount_uid173_lzCountVal_uid86_block_rsrvd_fix_q;
    vStagei_uid176_lzCountVal_uid86_block_rsrvd_fix_combproc: PROCESS (vStagei_uid176_lzCountVal_uid86_block_rsrvd_fix_s, rVStage_uid172_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b, rVStage_uid172_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c)
    BEGIN
        CASE (vStagei_uid176_lzCountVal_uid86_block_rsrvd_fix_s) IS
            WHEN "0" => vStagei_uid176_lzCountVal_uid86_block_rsrvd_fix_q <= rVStage_uid172_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_b;
            WHEN "1" => vStagei_uid176_lzCountVal_uid86_block_rsrvd_fix_q <= rVStage_uid172_lzCountVal_uid86_block_rsrvd_fix_merged_bit_select_c;
            WHEN OTHERS => vStagei_uid176_lzCountVal_uid86_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- rVStage_uid178_lzCountVal_uid86_block_rsrvd_fix(BITSELECT,177)@9
    rVStage_uid178_lzCountVal_uid86_block_rsrvd_fix_b <= vStagei_uid176_lzCountVal_uid86_block_rsrvd_fix_q(1 downto 1);

    -- vCount_uid179_lzCountVal_uid86_block_rsrvd_fix(LOGICAL,178)@9
    vCount_uid179_lzCountVal_uid86_block_rsrvd_fix_q <= "1" WHEN rVStage_uid178_lzCountVal_uid86_block_rsrvd_fix_b = GND_q ELSE "0";

    -- r_uid180_lzCountVal_uid86_block_rsrvd_fix(BITJOIN,179)@9
    r_uid180_lzCountVal_uid86_block_rsrvd_fix_q <= redist9_vCount_uid153_lzCountVal_uid86_block_rsrvd_fix_q_3_q & redist7_vCount_uid161_lzCountVal_uid86_block_rsrvd_fix_q_2_q & redist6_vCount_uid167_lzCountVal_uid86_block_rsrvd_fix_q_1_q & vCount_uid173_lzCountVal_uid86_block_rsrvd_fix_q & vCount_uid179_lzCountVal_uid86_block_rsrvd_fix_q;

    -- redist5_r_uid180_lzCountVal_uid86_block_rsrvd_fix_q_1(DELAY,262)
    redist5_r_uid180_lzCountVal_uid86_block_rsrvd_fix_q_1 : dspba_delay
    GENERIC MAP ( width => 5, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => r_uid180_lzCountVal_uid86_block_rsrvd_fix_q, xout => redist5_r_uid180_lzCountVal_uid86_block_rsrvd_fix_q_1_q, clk => clock, aclr => resetn );

    -- aMinusA_uid88_block_rsrvd_fix(LOGICAL,87)@10
    aMinusA_uid88_block_rsrvd_fix_q <= "1" WHEN redist5_r_uid180_lzCountVal_uid86_block_rsrvd_fix_q_1_q = cAmA_uid87_block_rsrvd_fix_q ELSE "0";

    -- invAMinusA_uid130_block_rsrvd_fix(LOGICAL,129)@10
    invAMinusA_uid130_block_rsrvd_fix_q <= not (aMinusA_uid88_block_rsrvd_fix_q);

    -- redist25_sigA_uid51_block_rsrvd_fix_b_9(DELAY,282)
    redist25_sigA_uid51_block_rsrvd_fix_b_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist24_sigA_uid51_block_rsrvd_fix_b_3_q, xout => redist25_sigA_uid51_block_rsrvd_fix_b_9_q, clk => clock, aclr => resetn );

    -- cstAllOWE_uid19_block_rsrvd_fix(CONSTANT,18)
    cstAllOWE_uid19_block_rsrvd_fix_q <= "11111111";

    -- expXIsMax_uid39_block_rsrvd_fix(LOGICAL,38)@1 + 1
    expXIsMax_uid39_block_rsrvd_fix_qi <= "1" WHEN exp_bSig_uid36_block_rsrvd_fix_b = cstAllOWE_uid19_block_rsrvd_fix_q ELSE "0";
    expXIsMax_uid39_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expXIsMax_uid39_block_rsrvd_fix_qi, xout => expXIsMax_uid39_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- invExpXIsMax_uid44_block_rsrvd_fix(LOGICAL,43)@2
    invExpXIsMax_uid44_block_rsrvd_fix_q <= not (expXIsMax_uid39_block_rsrvd_fix_q);

    -- excR_bSig_uid46_block_rsrvd_fix(LOGICAL,45)@2 + 1
    excR_bSig_uid46_block_rsrvd_fix_qi <= InvExpXIsZero_uid45_block_rsrvd_fix_q and invExpXIsMax_uid44_block_rsrvd_fix_q;
    excR_bSig_uid46_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excR_bSig_uid46_block_rsrvd_fix_qi, xout => excR_bSig_uid46_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist26_excR_bSig_uid46_block_rsrvd_fix_q_8(DELAY,283)
    redist26_excR_bSig_uid46_block_rsrvd_fix_q_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excR_bSig_uid46_block_rsrvd_fix_q, xout => redist26_excR_bSig_uid46_block_rsrvd_fix_q_8_q, clk => clock, aclr => resetn );

    -- redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_notEnable(LOGICAL,309)
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_notEnable_q <= STD_LOGIC_VECTOR(not (VCC_q));

    -- redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_nor(LOGICAL,310)
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_nor_q <= not (redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_notEnable_q or redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_sticky_ena_q);

    -- redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_last(CONSTANT,306)
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_last_q <= "0100";

    -- redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_cmp(LOGICAL,307)
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_cmp_b <= STD_LOGIC_VECTOR("0" & redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_q);
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_cmp_q <= "1" WHEN redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_last_q = redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_cmp_b ELSE "0";

    -- redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_cmpReg(REG,308)
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_cmpReg_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_cmpReg_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_cmpReg_q <= STD_LOGIC_VECTOR(redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_cmp_q);
        END IF;
    END PROCESS;

    -- redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_sticky_ena(REG,311)
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_sticky_ena_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_sticky_ena_q <= "0";
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_nor_q = "1") THEN
                redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_sticky_ena_q <= STD_LOGIC_VECTOR(redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_cmpReg_q);
            END IF;
        END IF;
    END PROCESS;

    -- redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_enaAnd(LOGICAL,312)
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_enaAnd_q <= redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_sticky_ena_q and VCC_q;

    -- redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt(COUNTER,304)
    -- low=0, high=5, step=1, init=0
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_i <= TO_UNSIGNED(0, 3);
            redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_eq <= '0';
        ELSIF (clock'EVENT AND clock = '1') THEN
            IF (redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_i = TO_UNSIGNED(4, 3)) THEN
                redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_eq <= '1';
            ELSE
                redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_eq <= '0';
            END IF;
            IF (redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_eq = '1') THEN
                redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_i <= redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_i + 3;
            ELSE
                redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_i <= redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_i + 1;
            END IF;
        END IF;
    END PROCESS;
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_q <= STD_LOGIC_VECTOR(STD_LOGIC_VECTOR(RESIZE(redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_i, 3)));

    -- redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_wraddr(REG,305)
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_wraddr_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_wraddr_q <= "101";
        ELSIF (clock'EVENT AND clock = '1') THEN
            redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_wraddr_q <= STD_LOGIC_VECTOR(redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_q);
        END IF;
    END PROCESS;

    -- redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem(DUALMEM,303)
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_ia <= STD_LOGIC_VECTOR(exp_aSig_uid22_block_rsrvd_fix_b);
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_aa <= redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_wraddr_q;
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_ab <= redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_rdcnt_q;
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_reset0 <= not (resetn);
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_dmem : altera_syncram
    GENERIC MAP (
        ram_block_type => "MLAB",
        operation_mode => "DUAL_PORT",
        width_a => 8,
        widthad_a => 3,
        numwords_a => 6,
        width_b => 8,
        widthad_b => 3,
        numwords_b => 6,
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
        clocken1 => redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_enaAnd_q(0),
        clocken0 => VCC_q(0),
        clock0 => clock,
        aclr1 => redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_reset0,
        clock1 => clock,
        address_a => redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_aa,
        data_a => redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_ia,
        wren_a => VCC_q(0),
        address_b => redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_ab,
        q_b => redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_iq
    );
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_q <= redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_iq(7 downto 0);

    -- redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_outputreg(DELAY,302)
    redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_outputreg : dspba_delay
    GENERIC MAP ( width => 8, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_mem_q, xout => redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_outputreg_q, clk => clock, aclr => resetn );

    -- expXIsMax_uid25_block_rsrvd_fix(LOGICAL,24)@9
    expXIsMax_uid25_block_rsrvd_fix_q <= "1" WHEN redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_outputreg_q = cstAllOWE_uid19_block_rsrvd_fix_q ELSE "0";

    -- invExpXIsMax_uid30_block_rsrvd_fix(LOGICAL,29)@9
    invExpXIsMax_uid30_block_rsrvd_fix_q <= not (expXIsMax_uid25_block_rsrvd_fix_q);

    -- excZ_aSig_uid17_uid24_block_rsrvd_fix(LOGICAL,23)@9
    excZ_aSig_uid17_uid24_block_rsrvd_fix_q <= "1" WHEN redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_outputreg_q = cstAllZWE_uid21_block_rsrvd_fix_q ELSE "0";

    -- InvExpXIsZero_uid31_block_rsrvd_fix(LOGICAL,30)@9
    InvExpXIsZero_uid31_block_rsrvd_fix_q <= not (excZ_aSig_uid17_uid24_block_rsrvd_fix_q);

    -- excR_aSig_uid32_block_rsrvd_fix(LOGICAL,31)@9 + 1
    excR_aSig_uid32_block_rsrvd_fix_qi <= InvExpXIsZero_uid31_block_rsrvd_fix_q and invExpXIsMax_uid30_block_rsrvd_fix_q;
    excR_aSig_uid32_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excR_aSig_uid32_block_rsrvd_fix_qi, xout => excR_aSig_uid32_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- signRReg_uid131_block_rsrvd_fix(LOGICAL,130)@10
    signRReg_uid131_block_rsrvd_fix_q <= excR_aSig_uid32_block_rsrvd_fix_q and redist26_excR_bSig_uid46_block_rsrvd_fix_q_8_q and redist25_sigA_uid51_block_rsrvd_fix_b_9_q and invAMinusA_uid130_block_rsrvd_fix_q;

    -- redist23_sigB_uid52_block_rsrvd_fix_b_9(DELAY,280)
    redist23_sigB_uid52_block_rsrvd_fix_b_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 6, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist22_sigB_uid52_block_rsrvd_fix_b_3_q, xout => redist23_sigB_uid52_block_rsrvd_fix_b_9_q, clk => clock, aclr => resetn );

    -- redist30_excZ_bSig_uid18_uid38_block_rsrvd_fix_q_9(DELAY,287)
    redist30_excZ_bSig_uid18_uid38_block_rsrvd_fix_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 8, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excZ_bSig_uid18_uid38_block_rsrvd_fix_q, xout => redist30_excZ_bSig_uid18_uid38_block_rsrvd_fix_q_9_q, clk => clock, aclr => resetn );

    -- redist36_excZ_aSig_uid17_uid24_block_rsrvd_fix_q_1(DELAY,293)
    redist36_excZ_aSig_uid17_uid24_block_rsrvd_fix_q_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excZ_aSig_uid17_uid24_block_rsrvd_fix_q, xout => redist36_excZ_aSig_uid17_uid24_block_rsrvd_fix_q_1_q, clk => clock, aclr => resetn );

    -- excAZBZSigASigB_uid135_block_rsrvd_fix(LOGICAL,134)@10
    excAZBZSigASigB_uid135_block_rsrvd_fix_q <= redist36_excZ_aSig_uid17_uid24_block_rsrvd_fix_q_1_q and redist30_excZ_bSig_uid18_uid38_block_rsrvd_fix_q_9_q and redist25_sigA_uid51_block_rsrvd_fix_b_9_q and redist23_sigB_uid52_block_rsrvd_fix_b_9_q;

    -- excBZARSigA_uid136_block_rsrvd_fix(LOGICAL,135)@10
    excBZARSigA_uid136_block_rsrvd_fix_q <= redist30_excZ_bSig_uid18_uid38_block_rsrvd_fix_q_9_q and excR_aSig_uid32_block_rsrvd_fix_q and redist25_sigA_uid51_block_rsrvd_fix_b_9_q;

    -- signRZero_uid137_block_rsrvd_fix(LOGICAL,136)@10
    signRZero_uid137_block_rsrvd_fix_q <= excBZARSigA_uid136_block_rsrvd_fix_q or excAZBZSigASigB_uid135_block_rsrvd_fix_q;

    -- fracXIsZero_uid40_block_rsrvd_fix(LOGICAL,39)@2
    fracXIsZero_uid40_block_rsrvd_fix_q <= "1" WHEN cstZeroWF_uid20_block_rsrvd_fix_q = redist32_frac_bSig_uid37_block_rsrvd_fix_b_1_q ELSE "0";

    -- excI_bSig_uid42_block_rsrvd_fix(LOGICAL,41)@2 + 1
    excI_bSig_uid42_block_rsrvd_fix_qi <= expXIsMax_uid39_block_rsrvd_fix_q and fracXIsZero_uid40_block_rsrvd_fix_q;
    excI_bSig_uid42_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excI_bSig_uid42_block_rsrvd_fix_qi, xout => excI_bSig_uid42_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist28_excI_bSig_uid42_block_rsrvd_fix_q_8(DELAY,285)
    redist28_excI_bSig_uid42_block_rsrvd_fix_q_8 : dspba_delay
    GENERIC MAP ( width => 1, depth => 7, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excI_bSig_uid42_block_rsrvd_fix_q, xout => redist28_excI_bSig_uid42_block_rsrvd_fix_q_8_q, clk => clock, aclr => resetn );

    -- sigBBInf_uid132_block_rsrvd_fix(LOGICAL,131)@10
    sigBBInf_uid132_block_rsrvd_fix_q <= redist23_sigB_uid52_block_rsrvd_fix_b_9_q and redist28_excI_bSig_uid42_block_rsrvd_fix_q_8_q;

    -- fracXIsZero_uid26_block_rsrvd_fix(LOGICAL,25)@5 + 1
    fracXIsZero_uid26_block_rsrvd_fix_qi <= "1" WHEN cstZeroWF_uid20_block_rsrvd_fix_q = redist38_frac_aSig_uid23_block_rsrvd_fix_b_4_outputreg_q ELSE "0";
    fracXIsZero_uid26_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => fracXIsZero_uid26_block_rsrvd_fix_qi, xout => fracXIsZero_uid26_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist35_fracXIsZero_uid26_block_rsrvd_fix_q_4(DELAY,292)
    redist35_fracXIsZero_uid26_block_rsrvd_fix_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => fracXIsZero_uid26_block_rsrvd_fix_q, xout => redist35_fracXIsZero_uid26_block_rsrvd_fix_q_4_q, clk => clock, aclr => resetn );

    -- excI_aSig_uid28_block_rsrvd_fix(LOGICAL,27)@9 + 1
    excI_aSig_uid28_block_rsrvd_fix_qi <= expXIsMax_uid25_block_rsrvd_fix_q and redist35_fracXIsZero_uid26_block_rsrvd_fix_q_4_q;
    excI_aSig_uid28_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excI_aSig_uid28_block_rsrvd_fix_qi, xout => excI_aSig_uid28_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- sigAAInf_uid133_block_rsrvd_fix(LOGICAL,132)@10
    sigAAInf_uid133_block_rsrvd_fix_q <= redist25_sigA_uid51_block_rsrvd_fix_b_9_q and excI_aSig_uid28_block_rsrvd_fix_q;

    -- signRInf_uid134_block_rsrvd_fix(LOGICAL,133)@10
    signRInf_uid134_block_rsrvd_fix_q <= sigAAInf_uid133_block_rsrvd_fix_q or sigBBInf_uid132_block_rsrvd_fix_q;

    -- signRInfRZRReg_uid138_block_rsrvd_fix(LOGICAL,137)@10 + 1
    signRInfRZRReg_uid138_block_rsrvd_fix_qi <= signRInf_uid134_block_rsrvd_fix_q or signRZero_uid137_block_rsrvd_fix_q or signRReg_uid131_block_rsrvd_fix_q;
    signRInfRZRReg_uid138_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => signRInfRZRReg_uid138_block_rsrvd_fix_qi, xout => signRInfRZRReg_uid138_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist11_signRInfRZRReg_uid138_block_rsrvd_fix_q_3(DELAY,268)
    redist11_signRInfRZRReg_uid138_block_rsrvd_fix_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => signRInfRZRReg_uid138_block_rsrvd_fix_q, xout => redist11_signRInfRZRReg_uid138_block_rsrvd_fix_q_3_q, clk => clock, aclr => resetn );

    -- fracXIsNotZero_uid41_block_rsrvd_fix(LOGICAL,40)@2
    fracXIsNotZero_uid41_block_rsrvd_fix_q <= not (fracXIsZero_uid40_block_rsrvd_fix_q);

    -- excN_bSig_uid43_block_rsrvd_fix(LOGICAL,42)@2 + 1
    excN_bSig_uid43_block_rsrvd_fix_qi <= expXIsMax_uid39_block_rsrvd_fix_q and fracXIsNotZero_uid41_block_rsrvd_fix_q;
    excN_bSig_uid43_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excN_bSig_uid43_block_rsrvd_fix_qi, xout => excN_bSig_uid43_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist27_excN_bSig_uid43_block_rsrvd_fix_q_11(DELAY,284)
    redist27_excN_bSig_uid43_block_rsrvd_fix_q_11 : dspba_delay
    GENERIC MAP ( width => 1, depth => 10, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excN_bSig_uid43_block_rsrvd_fix_q, xout => redist27_excN_bSig_uid43_block_rsrvd_fix_q_11_q, clk => clock, aclr => resetn );

    -- fracXIsNotZero_uid27_block_rsrvd_fix(LOGICAL,26)@9
    fracXIsNotZero_uid27_block_rsrvd_fix_q <= not (redist35_fracXIsZero_uid26_block_rsrvd_fix_q_4_q);

    -- excN_aSig_uid29_block_rsrvd_fix(LOGICAL,28)@9 + 1
    excN_aSig_uid29_block_rsrvd_fix_qi <= expXIsMax_uid25_block_rsrvd_fix_q and fracXIsNotZero_uid27_block_rsrvd_fix_q;
    excN_aSig_uid29_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excN_aSig_uid29_block_rsrvd_fix_qi, xout => excN_aSig_uid29_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist33_excN_aSig_uid29_block_rsrvd_fix_q_4(DELAY,290)
    redist33_excN_aSig_uid29_block_rsrvd_fix_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excN_aSig_uid29_block_rsrvd_fix_q, xout => redist33_excN_aSig_uid29_block_rsrvd_fix_q_4_q, clk => clock, aclr => resetn );

    -- excRNaN2_uid125_block_rsrvd_fix(LOGICAL,124)@13
    excRNaN2_uid125_block_rsrvd_fix_q <= redist33_excN_aSig_uid29_block_rsrvd_fix_q_4_q or redist27_excN_bSig_uid43_block_rsrvd_fix_q_11_q;

    -- redist21_effSub_uid53_block_rsrvd_fix_q_9(DELAY,278)
    redist21_effSub_uid53_block_rsrvd_fix_q_9 : dspba_delay
    GENERIC MAP ( width => 1, depth => 9, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => effSub_uid53_block_rsrvd_fix_q, xout => redist21_effSub_uid53_block_rsrvd_fix_q_9_q, clk => clock, aclr => resetn );

    -- redist29_excI_bSig_uid42_block_rsrvd_fix_q_11(DELAY,286)
    redist29_excI_bSig_uid42_block_rsrvd_fix_q_11 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist28_excI_bSig_uid42_block_rsrvd_fix_q_8_q, xout => redist29_excI_bSig_uid42_block_rsrvd_fix_q_11_q, clk => clock, aclr => resetn );

    -- redist34_excI_aSig_uid28_block_rsrvd_fix_q_4(DELAY,291)
    redist34_excI_aSig_uid28_block_rsrvd_fix_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => excI_aSig_uid28_block_rsrvd_fix_q, xout => redist34_excI_aSig_uid28_block_rsrvd_fix_q_4_q, clk => clock, aclr => resetn );

    -- excAIBISub_uid126_block_rsrvd_fix(LOGICAL,125)@13
    excAIBISub_uid126_block_rsrvd_fix_q <= redist34_excI_aSig_uid28_block_rsrvd_fix_q_4_q and redist29_excI_bSig_uid42_block_rsrvd_fix_q_11_q and redist21_effSub_uid53_block_rsrvd_fix_q_9_q;

    -- excRNaN_uid127_block_rsrvd_fix(LOGICAL,126)@13
    excRNaN_uid127_block_rsrvd_fix_q <= excAIBISub_uid126_block_rsrvd_fix_q or excRNaN2_uid125_block_rsrvd_fix_q;

    -- invExcRNaN_uid139_block_rsrvd_fix(LOGICAL,138)@13
    invExcRNaN_uid139_block_rsrvd_fix_q <= not (excRNaN_uid127_block_rsrvd_fix_q);

    -- VCC(CONSTANT,1)
    VCC_q <= "1";

    -- signRPostExc_uid140_block_rsrvd_fix(LOGICAL,139)@13 + 1
    signRPostExc_uid140_block_rsrvd_fix_qi <= invExcRNaN_uid139_block_rsrvd_fix_q and redist11_signRInfRZRReg_uid138_block_rsrvd_fix_q_3_q;
    signRPostExc_uid140_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => signRPostExc_uid140_block_rsrvd_fix_qi, xout => signRPostExc_uid140_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- cRBit_uid100_block_rsrvd_fix(CONSTANT,99)
    cRBit_uid100_block_rsrvd_fix_q <= "01000";

    -- leftShiftStage2Idx1Rng1_uid247_fracPostNormExt_uid89_block_rsrvd_fix(BITSELECT,246)@10
    leftShiftStage2Idx1Rng1_uid247_fracPostNormExt_uid89_block_rsrvd_fix_in <= leftShiftStage1_uid245_fracPostNormExt_uid89_block_rsrvd_fix_q(26 downto 0);
    leftShiftStage2Idx1Rng1_uid247_fracPostNormExt_uid89_block_rsrvd_fix_b <= leftShiftStage2Idx1Rng1_uid247_fracPostNormExt_uid89_block_rsrvd_fix_in(26 downto 0);

    -- leftShiftStage2Idx1_uid248_fracPostNormExt_uid89_block_rsrvd_fix(BITJOIN,247)@10
    leftShiftStage2Idx1_uid248_fracPostNormExt_uid89_block_rsrvd_fix_q <= leftShiftStage2Idx1Rng1_uid247_fracPostNormExt_uid89_block_rsrvd_fix_b & GND_q;

    -- leftShiftStage1Idx3Rng6_uid242_fracPostNormExt_uid89_block_rsrvd_fix(BITSELECT,241)@10
    leftShiftStage1Idx3Rng6_uid242_fracPostNormExt_uid89_block_rsrvd_fix_in <= leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_q(21 downto 0);
    leftShiftStage1Idx3Rng6_uid242_fracPostNormExt_uid89_block_rsrvd_fix_b <= leftShiftStage1Idx3Rng6_uid242_fracPostNormExt_uid89_block_rsrvd_fix_in(21 downto 0);

    -- leftShiftStage1Idx3Pad6_uid241_fracPostNormExt_uid89_block_rsrvd_fix(CONSTANT,240)
    leftShiftStage1Idx3Pad6_uid241_fracPostNormExt_uid89_block_rsrvd_fix_q <= "000000";

    -- leftShiftStage1Idx3_uid243_fracPostNormExt_uid89_block_rsrvd_fix(BITJOIN,242)@10
    leftShiftStage1Idx3_uid243_fracPostNormExt_uid89_block_rsrvd_fix_q <= leftShiftStage1Idx3Rng6_uid242_fracPostNormExt_uid89_block_rsrvd_fix_b & leftShiftStage1Idx3Pad6_uid241_fracPostNormExt_uid89_block_rsrvd_fix_q;

    -- leftShiftStage1Idx2Rng4_uid239_fracPostNormExt_uid89_block_rsrvd_fix(BITSELECT,238)@10
    leftShiftStage1Idx2Rng4_uid239_fracPostNormExt_uid89_block_rsrvd_fix_in <= leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_q(23 downto 0);
    leftShiftStage1Idx2Rng4_uid239_fracPostNormExt_uid89_block_rsrvd_fix_b <= leftShiftStage1Idx2Rng4_uid239_fracPostNormExt_uid89_block_rsrvd_fix_in(23 downto 0);

    -- leftShiftStage1Idx2_uid240_fracPostNormExt_uid89_block_rsrvd_fix(BITJOIN,239)@10
    leftShiftStage1Idx2_uid240_fracPostNormExt_uid89_block_rsrvd_fix_q <= leftShiftStage1Idx2Rng4_uid239_fracPostNormExt_uid89_block_rsrvd_fix_b & zs_uid165_lzCountVal_uid86_block_rsrvd_fix_q;

    -- leftShiftStage1Idx1Rng2_uid236_fracPostNormExt_uid89_block_rsrvd_fix(BITSELECT,235)@10
    leftShiftStage1Idx1Rng2_uid236_fracPostNormExt_uid89_block_rsrvd_fix_in <= leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_q(25 downto 0);
    leftShiftStage1Idx1Rng2_uid236_fracPostNormExt_uid89_block_rsrvd_fix_b <= leftShiftStage1Idx1Rng2_uid236_fracPostNormExt_uid89_block_rsrvd_fix_in(25 downto 0);

    -- leftShiftStage1Idx1_uid237_fracPostNormExt_uid89_block_rsrvd_fix(BITJOIN,236)@10
    leftShiftStage1Idx1_uid237_fracPostNormExt_uid89_block_rsrvd_fix_q <= leftShiftStage1Idx1Rng2_uid236_fracPostNormExt_uid89_block_rsrvd_fix_b & zs_uid171_lzCountVal_uid86_block_rsrvd_fix_q;

    -- leftShiftStage0Idx3Rng24_uid231_fracPostNormExt_uid89_block_rsrvd_fix(BITSELECT,230)@9
    leftShiftStage0Idx3Rng24_uid231_fracPostNormExt_uid89_block_rsrvd_fix_in <= redist18_fracGRS_uid85_block_rsrvd_fix_q_3_q(3 downto 0);
    leftShiftStage0Idx3Rng24_uid231_fracPostNormExt_uid89_block_rsrvd_fix_b <= leftShiftStage0Idx3Rng24_uid231_fracPostNormExt_uid89_block_rsrvd_fix_in(3 downto 0);

    -- leftShiftStage0Idx3Pad24_uid230_fracPostNormExt_uid89_block_rsrvd_fix(CONSTANT,229)
    leftShiftStage0Idx3Pad24_uid230_fracPostNormExt_uid89_block_rsrvd_fix_q <= "000000000000000000000000";

    -- leftShiftStage0Idx3_uid232_fracPostNormExt_uid89_block_rsrvd_fix(BITJOIN,231)@9
    leftShiftStage0Idx3_uid232_fracPostNormExt_uid89_block_rsrvd_fix_q <= leftShiftStage0Idx3Rng24_uid231_fracPostNormExt_uid89_block_rsrvd_fix_b & leftShiftStage0Idx3Pad24_uid230_fracPostNormExt_uid89_block_rsrvd_fix_q;

    -- redist8_vStage_uid155_lzCountVal_uid86_block_rsrvd_fix_b_2(DELAY,265)
    redist8_vStage_uid155_lzCountVal_uid86_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 12, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => vStage_uid155_lzCountVal_uid86_block_rsrvd_fix_b, xout => redist8_vStage_uid155_lzCountVal_uid86_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- leftShiftStage0Idx2_uid229_fracPostNormExt_uid89_block_rsrvd_fix(BITJOIN,228)@9
    leftShiftStage0Idx2_uid229_fracPostNormExt_uid89_block_rsrvd_fix_q <= redist8_vStage_uid155_lzCountVal_uid86_block_rsrvd_fix_b_2_q & zs_uid151_lzCountVal_uid86_block_rsrvd_fix_q;

    -- leftShiftStage0Idx1Rng8_uid225_fracPostNormExt_uid89_block_rsrvd_fix(BITSELECT,224)@9
    leftShiftStage0Idx1Rng8_uid225_fracPostNormExt_uid89_block_rsrvd_fix_in <= redist18_fracGRS_uid85_block_rsrvd_fix_q_3_q(19 downto 0);
    leftShiftStage0Idx1Rng8_uid225_fracPostNormExt_uid89_block_rsrvd_fix_b <= leftShiftStage0Idx1Rng8_uid225_fracPostNormExt_uid89_block_rsrvd_fix_in(19 downto 0);

    -- leftShiftStage0Idx1_uid226_fracPostNormExt_uid89_block_rsrvd_fix(BITJOIN,225)@9
    leftShiftStage0Idx1_uid226_fracPostNormExt_uid89_block_rsrvd_fix_q <= leftShiftStage0Idx1Rng8_uid225_fracPostNormExt_uid89_block_rsrvd_fix_b & cstAllZWE_uid21_block_rsrvd_fix_q;

    -- redist18_fracGRS_uid85_block_rsrvd_fix_q_3(DELAY,275)
    redist18_fracGRS_uid85_block_rsrvd_fix_q_3 : dspba_delay
    GENERIC MAP ( width => 28, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist17_fracGRS_uid85_block_rsrvd_fix_q_1_q, xout => redist18_fracGRS_uid85_block_rsrvd_fix_q_3_q, clk => clock, aclr => resetn );

    -- leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select(BITSELECT,256)@9
    leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_b <= r_uid180_lzCountVal_uid86_block_rsrvd_fix_q(4 downto 3);
    leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_c <= r_uid180_lzCountVal_uid86_block_rsrvd_fix_q(2 downto 1);
    leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_d <= r_uid180_lzCountVal_uid86_block_rsrvd_fix_q(0 downto 0);

    -- leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix(MUX,233)@9 + 1
    leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_s <= leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_b;
    leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_q <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_s) IS
                WHEN "00" => leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_q <= redist18_fracGRS_uid85_block_rsrvd_fix_q_3_q;
                WHEN "01" => leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_q <= leftShiftStage0Idx1_uid226_fracPostNormExt_uid89_block_rsrvd_fix_q;
                WHEN "10" => leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_q <= leftShiftStage0Idx2_uid229_fracPostNormExt_uid89_block_rsrvd_fix_q;
                WHEN "11" => leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_q <= leftShiftStage0Idx3_uid232_fracPostNormExt_uid89_block_rsrvd_fix_q;
                WHEN OTHERS => leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_q <= (others => '0');
            END CASE;
        END IF;
    END PROCESS;

    -- redist0_leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_c_1(DELAY,257)
    redist0_leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_c_1 : dspba_delay
    GENERIC MAP ( width => 2, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_c, xout => redist0_leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_c_1_q, clk => clock, aclr => resetn );

    -- leftShiftStage1_uid245_fracPostNormExt_uid89_block_rsrvd_fix(MUX,244)@10
    leftShiftStage1_uid245_fracPostNormExt_uid89_block_rsrvd_fix_s <= redist0_leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_c_1_q;
    leftShiftStage1_uid245_fracPostNormExt_uid89_block_rsrvd_fix_combproc: PROCESS (leftShiftStage1_uid245_fracPostNormExt_uid89_block_rsrvd_fix_s, leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_q, leftShiftStage1Idx1_uid237_fracPostNormExt_uid89_block_rsrvd_fix_q, leftShiftStage1Idx2_uid240_fracPostNormExt_uid89_block_rsrvd_fix_q, leftShiftStage1Idx3_uid243_fracPostNormExt_uid89_block_rsrvd_fix_q)
    BEGIN
        CASE (leftShiftStage1_uid245_fracPostNormExt_uid89_block_rsrvd_fix_s) IS
            WHEN "00" => leftShiftStage1_uid245_fracPostNormExt_uid89_block_rsrvd_fix_q <= leftShiftStage0_uid234_fracPostNormExt_uid89_block_rsrvd_fix_q;
            WHEN "01" => leftShiftStage1_uid245_fracPostNormExt_uid89_block_rsrvd_fix_q <= leftShiftStage1Idx1_uid237_fracPostNormExt_uid89_block_rsrvd_fix_q;
            WHEN "10" => leftShiftStage1_uid245_fracPostNormExt_uid89_block_rsrvd_fix_q <= leftShiftStage1Idx2_uid240_fracPostNormExt_uid89_block_rsrvd_fix_q;
            WHEN "11" => leftShiftStage1_uid245_fracPostNormExt_uid89_block_rsrvd_fix_q <= leftShiftStage1Idx3_uid243_fracPostNormExt_uid89_block_rsrvd_fix_q;
            WHEN OTHERS => leftShiftStage1_uid245_fracPostNormExt_uid89_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- redist1_leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_d_1(DELAY,258)
    redist1_leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_d_1 : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_d, xout => redist1_leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_d_1_q, clk => clock, aclr => resetn );

    -- leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix(MUX,249)@10
    leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix_s <= redist1_leftShiftStageSel4Dto3_uid233_fracPostNormExt_uid89_block_rsrvd_fix_merged_bit_select_d_1_q;
    leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix_combproc: PROCESS (leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix_s, leftShiftStage1_uid245_fracPostNormExt_uid89_block_rsrvd_fix_q, leftShiftStage2Idx1_uid248_fracPostNormExt_uid89_block_rsrvd_fix_q)
    BEGIN
        CASE (leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix_s) IS
            WHEN "0" => leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix_q <= leftShiftStage1_uid245_fracPostNormExt_uid89_block_rsrvd_fix_q;
            WHEN "1" => leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix_q <= leftShiftStage2Idx1_uid248_fracPostNormExt_uid89_block_rsrvd_fix_q;
            WHEN OTHERS => leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- LSB_uid98_block_rsrvd_fix(BITSELECT,97)@10
    LSB_uid98_block_rsrvd_fix_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix_q(4 downto 0));
    LSB_uid98_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(LSB_uid98_block_rsrvd_fix_in(4 downto 4));

    -- Guard_uid97_block_rsrvd_fix(BITSELECT,96)@10
    Guard_uid97_block_rsrvd_fix_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix_q(3 downto 0));
    Guard_uid97_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(Guard_uid97_block_rsrvd_fix_in(3 downto 3));

    -- Round_uid96_block_rsrvd_fix(BITSELECT,95)@10
    Round_uid96_block_rsrvd_fix_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix_q(2 downto 0));
    Round_uid96_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(Round_uid96_block_rsrvd_fix_in(2 downto 2));

    -- Sticky1_uid95_block_rsrvd_fix(BITSELECT,94)@10
    Sticky1_uid95_block_rsrvd_fix_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix_q(1 downto 0));
    Sticky1_uid95_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(Sticky1_uid95_block_rsrvd_fix_in(1 downto 1));

    -- Sticky0_uid94_block_rsrvd_fix(BITSELECT,93)@10
    Sticky0_uid94_block_rsrvd_fix_in <= STD_LOGIC_VECTOR(leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix_q(0 downto 0));
    Sticky0_uid94_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(Sticky0_uid94_block_rsrvd_fix_in(0 downto 0));

    -- rndBitCond_uid99_block_rsrvd_fix(BITJOIN,98)@10
    rndBitCond_uid99_block_rsrvd_fix_q <= LSB_uid98_block_rsrvd_fix_b & Guard_uid97_block_rsrvd_fix_b & Round_uid96_block_rsrvd_fix_b & Sticky1_uid95_block_rsrvd_fix_b & Sticky0_uid94_block_rsrvd_fix_b;

    -- rBi_uid101_block_rsrvd_fix(LOGICAL,100)@10 + 1
    rBi_uid101_block_rsrvd_fix_qi <= "1" WHEN rndBitCond_uid99_block_rsrvd_fix_q = cRBit_uid100_block_rsrvd_fix_q ELSE "0";
    rBi_uid101_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rBi_uid101_block_rsrvd_fix_qi, xout => rBi_uid101_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- roundBit_uid102_block_rsrvd_fix(LOGICAL,101)@11
    roundBit_uid102_block_rsrvd_fix_q <= not (rBi_uid101_block_rsrvd_fix_q);

    -- oneCST_uid91_block_rsrvd_fix(CONSTANT,90)
    oneCST_uid91_block_rsrvd_fix_q <= "00000001";

    -- expInc_uid92_block_rsrvd_fix(ADD,91)@9 + 1
    expInc_uid92_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("0" & redist39_exp_aSig_uid22_block_rsrvd_fix_b_8_outputreg_q);
    expInc_uid92_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("0" & oneCST_uid91_block_rsrvd_fix_q);
    expInc_uid92_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            expInc_uid92_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            expInc_uid92_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(expInc_uid92_block_rsrvd_fix_a) + UNSIGNED(expInc_uid92_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    expInc_uid92_block_rsrvd_fix_q <= expInc_uid92_block_rsrvd_fix_o(8 downto 0);

    -- expPostNorm_uid93_block_rsrvd_fix(SUB,92)@10 + 1
    expPostNorm_uid93_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("0" & expInc_uid92_block_rsrvd_fix_q);
    expPostNorm_uid93_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("00000" & redist5_r_uid180_lzCountVal_uid86_block_rsrvd_fix_q_1_q);
    expPostNorm_uid93_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            expPostNorm_uid93_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            expPostNorm_uid93_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(expPostNorm_uid93_block_rsrvd_fix_a) - UNSIGNED(expPostNorm_uid93_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    expPostNorm_uid93_block_rsrvd_fix_q <= expPostNorm_uid93_block_rsrvd_fix_o(9 downto 0);

    -- fracPostNorm_uid90_block_rsrvd_fix(BITSELECT,89)@10
    fracPostNorm_uid90_block_rsrvd_fix_b <= leftShiftStage2_uid250_fracPostNormExt_uid89_block_rsrvd_fix_q(27 downto 1);

    -- fracPostNormRndRange_uid103_block_rsrvd_fix(BITSELECT,102)@10
    fracPostNormRndRange_uid103_block_rsrvd_fix_in <= fracPostNorm_uid90_block_rsrvd_fix_b(25 downto 0);
    fracPostNormRndRange_uid103_block_rsrvd_fix_b <= fracPostNormRndRange_uid103_block_rsrvd_fix_in(25 downto 2);

    -- redist15_fracPostNormRndRange_uid103_block_rsrvd_fix_b_1(DELAY,272)
    redist15_fracPostNormRndRange_uid103_block_rsrvd_fix_b_1 : dspba_delay
    GENERIC MAP ( width => 24, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => fracPostNormRndRange_uid103_block_rsrvd_fix_b, xout => redist15_fracPostNormRndRange_uid103_block_rsrvd_fix_b_1_q, clk => clock, aclr => resetn );

    -- expFracR_uid104_block_rsrvd_fix(BITJOIN,103)@11
    expFracR_uid104_block_rsrvd_fix_q <= expPostNorm_uid93_block_rsrvd_fix_q & redist15_fracPostNormRndRange_uid103_block_rsrvd_fix_b_1_q;

    -- rndExpFrac_uid105_block_rsrvd_fix(ADD,104)@11 + 1
    rndExpFrac_uid105_block_rsrvd_fix_a <= STD_LOGIC_VECTOR("0" & expFracR_uid104_block_rsrvd_fix_q);
    rndExpFrac_uid105_block_rsrvd_fix_b <= STD_LOGIC_VECTOR("0000000000000000000000000000000000" & roundBit_uid102_block_rsrvd_fix_q);
    rndExpFrac_uid105_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            rndExpFrac_uid105_block_rsrvd_fix_o <= (others => '0');
        ELSIF (clock'EVENT AND clock = '1') THEN
            rndExpFrac_uid105_block_rsrvd_fix_o <= STD_LOGIC_VECTOR(UNSIGNED(rndExpFrac_uid105_block_rsrvd_fix_a) + UNSIGNED(rndExpFrac_uid105_block_rsrvd_fix_b));
        END IF;
    END PROCESS;
    rndExpFrac_uid105_block_rsrvd_fix_q <= rndExpFrac_uid105_block_rsrvd_fix_o(34 downto 0);

    -- expRPreExc_uid118_block_rsrvd_fix(BITSELECT,117)@12
    expRPreExc_uid118_block_rsrvd_fix_in <= rndExpFrac_uid105_block_rsrvd_fix_q(31 downto 0);
    expRPreExc_uid118_block_rsrvd_fix_b <= expRPreExc_uid118_block_rsrvd_fix_in(31 downto 24);

    -- redist13_expRPreExc_uid118_block_rsrvd_fix_b_2(DELAY,270)
    redist13_expRPreExc_uid118_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 8, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => expRPreExc_uid118_block_rsrvd_fix_b, xout => redist13_expRPreExc_uid118_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- rndExpFracOvfBits_uid110_block_rsrvd_fix(BITSELECT,109)@12
    rndExpFracOvfBits_uid110_block_rsrvd_fix_in <= rndExpFrac_uid105_block_rsrvd_fix_q(33 downto 0);
    rndExpFracOvfBits_uid110_block_rsrvd_fix_b <= rndExpFracOvfBits_uid110_block_rsrvd_fix_in(33 downto 32);

    -- rOvfExtraBits_uid111_block_rsrvd_fix(LOGICAL,110)@12
    rOvfExtraBits_uid111_block_rsrvd_fix_q <= "1" WHEN rndExpFracOvfBits_uid110_block_rsrvd_fix_b = zocst_uid77_block_rsrvd_fix_q ELSE "0";

    -- wEP2AllOwE_uid106_block_rsrvd_fix(CONSTANT,105)
    wEP2AllOwE_uid106_block_rsrvd_fix_q <= "0011111111";

    -- rndExp_uid107_block_rsrvd_fix(BITSELECT,106)@12
    rndExp_uid107_block_rsrvd_fix_in <= rndExpFrac_uid105_block_rsrvd_fix_q(33 downto 0);
    rndExp_uid107_block_rsrvd_fix_b <= rndExp_uid107_block_rsrvd_fix_in(33 downto 24);

    -- rOvfEQMax_uid108_block_rsrvd_fix(LOGICAL,107)@12
    rOvfEQMax_uid108_block_rsrvd_fix_q <= "1" WHEN rndExp_uid107_block_rsrvd_fix_b = wEP2AllOwE_uid106_block_rsrvd_fix_q ELSE "0";

    -- rOvf_uid112_block_rsrvd_fix(LOGICAL,111)@12 + 1
    rOvf_uid112_block_rsrvd_fix_qi <= rOvfEQMax_uid108_block_rsrvd_fix_q or rOvfExtraBits_uid111_block_rsrvd_fix_q;
    rOvf_uid112_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rOvf_uid112_block_rsrvd_fix_qi, xout => rOvf_uid112_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- regInputs_uid119_block_rsrvd_fix(LOGICAL,118)@10 + 1
    regInputs_uid119_block_rsrvd_fix_qi <= excR_aSig_uid32_block_rsrvd_fix_q and redist26_excR_bSig_uid46_block_rsrvd_fix_q_8_q;
    regInputs_uid119_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => regInputs_uid119_block_rsrvd_fix_qi, xout => regInputs_uid119_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist12_regInputs_uid119_block_rsrvd_fix_q_3(DELAY,269)
    redist12_regInputs_uid119_block_rsrvd_fix_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => regInputs_uid119_block_rsrvd_fix_q, xout => redist12_regInputs_uid119_block_rsrvd_fix_q_3_q, clk => clock, aclr => resetn );

    -- rInfOvf_uid122_block_rsrvd_fix(LOGICAL,121)@13
    rInfOvf_uid122_block_rsrvd_fix_q <= redist12_regInputs_uid119_block_rsrvd_fix_q_3_q and rOvf_uid112_block_rsrvd_fix_q;

    -- excRInfVInC_uid123_block_rsrvd_fix(BITJOIN,122)@13
    excRInfVInC_uid123_block_rsrvd_fix_q <= rInfOvf_uid122_block_rsrvd_fix_q & redist27_excN_bSig_uid43_block_rsrvd_fix_q_11_q & redist33_excN_aSig_uid29_block_rsrvd_fix_q_4_q & redist29_excI_bSig_uid42_block_rsrvd_fix_q_11_q & redist34_excI_aSig_uid28_block_rsrvd_fix_q_4_q & redist21_effSub_uid53_block_rsrvd_fix_q_9_q;

    -- excRInf_uid124_block_rsrvd_fix(LOOKUP,123)@13
    excRInf_uid124_block_rsrvd_fix_combproc: PROCESS (excRInfVInC_uid123_block_rsrvd_fix_q)
    BEGIN
        -- Begin reserved scope level
        CASE (excRInfVInC_uid123_block_rsrvd_fix_q) IS
            WHEN "000000" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "000001" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "000010" => excRInf_uid124_block_rsrvd_fix_q <= "1";
            WHEN "000011" => excRInf_uid124_block_rsrvd_fix_q <= "1";
            WHEN "000100" => excRInf_uid124_block_rsrvd_fix_q <= "1";
            WHEN "000101" => excRInf_uid124_block_rsrvd_fix_q <= "1";
            WHEN "000110" => excRInf_uid124_block_rsrvd_fix_q <= "1";
            WHEN "000111" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "001000" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "001001" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "001010" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "001011" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "001100" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "001101" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "001110" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "001111" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "010000" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "010001" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "010010" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "010011" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "010100" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "010101" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "010110" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "010111" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "011000" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "011001" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "011010" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "011011" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "011100" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "011101" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "011110" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "011111" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "100000" => excRInf_uid124_block_rsrvd_fix_q <= "1";
            WHEN "100001" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "100010" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "100011" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "100100" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "100101" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "100110" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "100111" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "101000" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "101001" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "101010" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "101011" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "101100" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "101101" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "101110" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "101111" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "110000" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "110001" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "110010" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "110011" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "110100" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "110101" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "110110" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "110111" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "111000" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "111001" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "111010" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "111011" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "111100" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "111101" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "111110" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN "111111" => excRInf_uid124_block_rsrvd_fix_q <= "0";
            WHEN OTHERS => -- unreachable
                           excRInf_uid124_block_rsrvd_fix_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- redist16_aMinusA_uid88_block_rsrvd_fix_q_3(DELAY,273)
    redist16_aMinusA_uid88_block_rsrvd_fix_q_3 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => aMinusA_uid88_block_rsrvd_fix_q, xout => redist16_aMinusA_uid88_block_rsrvd_fix_q_3_q, clk => clock, aclr => resetn );

    -- rUdfExtraBit_uid115_block_rsrvd_fix(BITSELECT,114)@12
    rUdfExtraBit_uid115_block_rsrvd_fix_in <= STD_LOGIC_VECTOR(rndExpFrac_uid105_block_rsrvd_fix_q(33 downto 0));
    rUdfExtraBit_uid115_block_rsrvd_fix_b <= STD_LOGIC_VECTOR(rUdfExtraBit_uid115_block_rsrvd_fix_in(33 downto 33));

    -- wEP2AllZ_uid113_block_rsrvd_fix(CONSTANT,112)
    wEP2AllZ_uid113_block_rsrvd_fix_q <= "0000000000";

    -- rUdfEQMin_uid114_block_rsrvd_fix(LOGICAL,113)@12
    rUdfEQMin_uid114_block_rsrvd_fix_q <= "1" WHEN rndExp_uid107_block_rsrvd_fix_b = wEP2AllZ_uid113_block_rsrvd_fix_q ELSE "0";

    -- rUdf_uid116_block_rsrvd_fix(LOGICAL,115)@12 + 1
    rUdf_uid116_block_rsrvd_fix_qi <= rUdfEQMin_uid114_block_rsrvd_fix_q or rUdfExtraBit_uid115_block_rsrvd_fix_b;
    rUdf_uid116_block_rsrvd_fix_delay : dspba_delay
    GENERIC MAP ( width => 1, depth => 1, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => rUdf_uid116_block_rsrvd_fix_qi, xout => rUdf_uid116_block_rsrvd_fix_q, clk => clock, aclr => resetn );

    -- redist31_excZ_bSig_uid18_uid38_block_rsrvd_fix_q_12(DELAY,288)
    redist31_excZ_bSig_uid18_uid38_block_rsrvd_fix_q_12 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist30_excZ_bSig_uid18_uid38_block_rsrvd_fix_q_9_q, xout => redist31_excZ_bSig_uid18_uid38_block_rsrvd_fix_q_12_q, clk => clock, aclr => resetn );

    -- redist37_excZ_aSig_uid17_uid24_block_rsrvd_fix_q_4(DELAY,294)
    redist37_excZ_aSig_uid17_uid24_block_rsrvd_fix_q_4 : dspba_delay
    GENERIC MAP ( width => 1, depth => 3, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => redist36_excZ_aSig_uid17_uid24_block_rsrvd_fix_q_1_q, xout => redist37_excZ_aSig_uid17_uid24_block_rsrvd_fix_q_4_q, clk => clock, aclr => resetn );

    -- excRZeroVInC_uid120_block_rsrvd_fix(BITJOIN,119)@13
    excRZeroVInC_uid120_block_rsrvd_fix_q <= redist16_aMinusA_uid88_block_rsrvd_fix_q_3_q & rUdf_uid116_block_rsrvd_fix_q & redist12_regInputs_uid119_block_rsrvd_fix_q_3_q & redist31_excZ_bSig_uid18_uid38_block_rsrvd_fix_q_12_q & redist37_excZ_aSig_uid17_uid24_block_rsrvd_fix_q_4_q;

    -- excRZero_uid121_block_rsrvd_fix(LOOKUP,120)@13
    excRZero_uid121_block_rsrvd_fix_combproc: PROCESS (excRZeroVInC_uid120_block_rsrvd_fix_q)
    BEGIN
        -- Begin reserved scope level
        CASE (excRZeroVInC_uid120_block_rsrvd_fix_q) IS
            WHEN "00000" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "00001" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "00010" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "00011" => excRZero_uid121_block_rsrvd_fix_q <= "1";
            WHEN "00100" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "00101" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "00110" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "00111" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "01000" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "01001" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "01010" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "01011" => excRZero_uid121_block_rsrvd_fix_q <= "1";
            WHEN "01100" => excRZero_uid121_block_rsrvd_fix_q <= "1";
            WHEN "01101" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "01110" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "01111" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "10000" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "10001" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "10010" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "10011" => excRZero_uid121_block_rsrvd_fix_q <= "1";
            WHEN "10100" => excRZero_uid121_block_rsrvd_fix_q <= "1";
            WHEN "10101" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "10110" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "10111" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "11000" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "11001" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "11010" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "11011" => excRZero_uid121_block_rsrvd_fix_q <= "1";
            WHEN "11100" => excRZero_uid121_block_rsrvd_fix_q <= "1";
            WHEN "11101" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "11110" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN "11111" => excRZero_uid121_block_rsrvd_fix_q <= "0";
            WHEN OTHERS => -- unreachable
                           excRZero_uid121_block_rsrvd_fix_q <= (others => '-');
        END CASE;
        -- End reserved scope level
    END PROCESS;

    -- concExc_uid128_block_rsrvd_fix(BITJOIN,127)@13
    concExc_uid128_block_rsrvd_fix_q <= excRNaN_uid127_block_rsrvd_fix_q & excRInf_uid124_block_rsrvd_fix_q & excRZero_uid121_block_rsrvd_fix_q;

    -- excREnc_uid129_block_rsrvd_fix(LOOKUP,128)@13 + 1
    excREnc_uid129_block_rsrvd_fix_clkproc: PROCESS (clock, resetn)
    BEGIN
        IF (resetn = '0') THEN
            excREnc_uid129_block_rsrvd_fix_q <= "01";
        ELSIF (clock'EVENT AND clock = '1') THEN
            CASE (concExc_uid128_block_rsrvd_fix_q) IS
                WHEN "000" => excREnc_uid129_block_rsrvd_fix_q <= "01";
                WHEN "001" => excREnc_uid129_block_rsrvd_fix_q <= "00";
                WHEN "010" => excREnc_uid129_block_rsrvd_fix_q <= "10";
                WHEN "011" => excREnc_uid129_block_rsrvd_fix_q <= "10";
                WHEN "100" => excREnc_uid129_block_rsrvd_fix_q <= "11";
                WHEN "101" => excREnc_uid129_block_rsrvd_fix_q <= "11";
                WHEN "110" => excREnc_uid129_block_rsrvd_fix_q <= "11";
                WHEN "111" => excREnc_uid129_block_rsrvd_fix_q <= "11";
                WHEN OTHERS => -- unreachable
                               excREnc_uid129_block_rsrvd_fix_q <= (others => '-');
            END CASE;
        END IF;
    END PROCESS;

    -- expRPostExc_uid148_block_rsrvd_fix(MUX,147)@14
    expRPostExc_uid148_block_rsrvd_fix_s <= excREnc_uid129_block_rsrvd_fix_q;
    expRPostExc_uid148_block_rsrvd_fix_combproc: PROCESS (expRPostExc_uid148_block_rsrvd_fix_s, cstAllZWE_uid21_block_rsrvd_fix_q, redist13_expRPreExc_uid118_block_rsrvd_fix_b_2_q, cstAllOWE_uid19_block_rsrvd_fix_q)
    BEGIN
        CASE (expRPostExc_uid148_block_rsrvd_fix_s) IS
            WHEN "00" => expRPostExc_uid148_block_rsrvd_fix_q <= cstAllZWE_uid21_block_rsrvd_fix_q;
            WHEN "01" => expRPostExc_uid148_block_rsrvd_fix_q <= redist13_expRPreExc_uid118_block_rsrvd_fix_b_2_q;
            WHEN "10" => expRPostExc_uid148_block_rsrvd_fix_q <= cstAllOWE_uid19_block_rsrvd_fix_q;
            WHEN "11" => expRPostExc_uid148_block_rsrvd_fix_q <= cstAllOWE_uid19_block_rsrvd_fix_q;
            WHEN OTHERS => expRPostExc_uid148_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- oneFracRPostExc2_uid141_block_rsrvd_fix(CONSTANT,140)
    oneFracRPostExc2_uid141_block_rsrvd_fix_q <= "00000000000000000000001";

    -- fracRPreExc_uid117_block_rsrvd_fix(BITSELECT,116)@12
    fracRPreExc_uid117_block_rsrvd_fix_in <= rndExpFrac_uid105_block_rsrvd_fix_q(23 downto 0);
    fracRPreExc_uid117_block_rsrvd_fix_b <= fracRPreExc_uid117_block_rsrvd_fix_in(23 downto 1);

    -- redist14_fracRPreExc_uid117_block_rsrvd_fix_b_2(DELAY,271)
    redist14_fracRPreExc_uid117_block_rsrvd_fix_b_2 : dspba_delay
    GENERIC MAP ( width => 23, depth => 2, reset_kind => "ASYNC", reset_high => '0' )
    PORT MAP ( xin => fracRPreExc_uid117_block_rsrvd_fix_b, xout => redist14_fracRPreExc_uid117_block_rsrvd_fix_b_2_q, clk => clock, aclr => resetn );

    -- fracRPostExc_uid144_block_rsrvd_fix(MUX,143)@14
    fracRPostExc_uid144_block_rsrvd_fix_s <= excREnc_uid129_block_rsrvd_fix_q;
    fracRPostExc_uid144_block_rsrvd_fix_combproc: PROCESS (fracRPostExc_uid144_block_rsrvd_fix_s, cstZeroWF_uid20_block_rsrvd_fix_q, redist14_fracRPreExc_uid117_block_rsrvd_fix_b_2_q, oneFracRPostExc2_uid141_block_rsrvd_fix_q)
    BEGIN
        CASE (fracRPostExc_uid144_block_rsrvd_fix_s) IS
            WHEN "00" => fracRPostExc_uid144_block_rsrvd_fix_q <= cstZeroWF_uid20_block_rsrvd_fix_q;
            WHEN "01" => fracRPostExc_uid144_block_rsrvd_fix_q <= redist14_fracRPreExc_uid117_block_rsrvd_fix_b_2_q;
            WHEN "10" => fracRPostExc_uid144_block_rsrvd_fix_q <= cstZeroWF_uid20_block_rsrvd_fix_q;
            WHEN "11" => fracRPostExc_uid144_block_rsrvd_fix_q <= oneFracRPostExc2_uid141_block_rsrvd_fix_q;
            WHEN OTHERS => fracRPostExc_uid144_block_rsrvd_fix_q <= (others => '0');
        END CASE;
    END PROCESS;

    -- R_uid149_block_rsrvd_fix(BITJOIN,148)@14
    R_uid149_block_rsrvd_fix_q <= signRPostExc_uid140_block_rsrvd_fix_q & expRPostExc_uid148_block_rsrvd_fix_q & fracRPostExc_uid144_block_rsrvd_fix_q;

    -- out_primWireOut(GPOUT,5)@14
    out_primWireOut <= R_uid149_block_rsrvd_fix_q;

END normal;
