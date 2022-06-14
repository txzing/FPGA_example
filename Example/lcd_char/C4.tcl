set_global_assignment -name FAMILY "Cyclone IV E"

set_global_assignment -name RESERVE_ALL_UNUSED_PINS_WEAK_PULLUP "AS INPUT TRI-STATED"
set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVTTL"
set_global_assignment -name CYCLONEII_RESERVE_NCEO_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DATA0_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DATA1_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_FLASH_NCE_AFTER_CONFIGURATION "USE AS REGULAR IO"
set_global_assignment -name RESERVE_DCLK_AFTER_CONFIGURATION "USE AS REGULAR IO"

set_location_assignment PIN_E1 -to clk

#key   

# set_location_assignment PIN_E16 -to key[3]
# set_location_assignment PIN_M16 -to key[2]
# set_location_assignment PIN_M15 -to key[1]
# set_location_assignment PIN_N13 -to key[0]
set_location_assignment PIN_N13 -to rst_n

#led  

#set_location_assignment PIN_D16 -to led[3]
#set_location_assignment PIN_F15 -to led[2]
#set_location_assignment PIN_F16 -to led[1]
#set_location_assignment PIN_G15 -to led[0]

#digital led display   
#数码管选段
#set_location_assignment PIN_B7 -to seg_data[0]
#set_location_assignment PIN_A8 -to seg_data[1]
#set_location_assignment PIN_A6 -to seg_data[2]
#set_location_assignment PIN_B5 -to seg_data[3]
#set_location_assignment PIN_B6 -to seg_data[4]
#set_location_assignment PIN_A7 -to seg_data[5]
#set_location_assignment PIN_B8 -to seg_data[6]
#set_location_assignment PIN_A5 -to seg_data[7]

#数码管片选
#set_location_assignment PIN_A4 -to seg_sel[0]
#set_location_assignment PIN_B4 -to seg_sel[1]
#set_location_assignment PIN_A3 -to seg_sel[2]
#set_location_assignment PIN_B3 -to seg_sel[3]
#set_location_assignment PIN_A2 -to seg_sel[4]
#set_location_assignment PIN_B1 -to seg_sel[5]
#sd card spi mode

#sd card spi mode   
#set_location_assignment PIN_J15 -to sd_dclk
#set_location_assignment PIN_K16 -to sd_miso
#set_location_assignment PIN_J16 -to sd_mosi
#set_location_assignment PIN_K15 -to sd_ncs
#
#16bit sdram

#set_location_assignment PIN_T15 -to sdram_addr[12]
#set_location_assignment PIN_R16 -to sdram_addr[11]
#set_location_assignment PIN_R8 -to sdram_addr[10]
#set_location_assignment PIN_P15 -to sdram_addr[9]
#set_location_assignment PIN_P16 -to sdram_addr[8]
#set_location_assignment PIN_N15 -to sdram_addr[7]
#set_location_assignment PIN_N16 -to sdram_addr[6]
#set_location_assignment PIN_L15 -to sdram_addr[5]
#set_location_assignment PIN_L16 -to sdram_addr[4]
#set_location_assignment PIN_R9 -to sdram_addr[3]
#set_location_assignment PIN_T9 -to sdram_addr[2]
#set_location_assignment PIN_P9 -to sdram_addr[1]
#set_location_assignment PIN_T8 -to sdram_addr[0]
#set_location_assignment PIN_T7 -to sdram_ba[1]
#set_location_assignment PIN_R7 -to sdram_ba[0]
#set_location_assignment PIN_T5 -to sdram_cas_n
#set_location_assignment PIN_R14 -to sdram_cke
#set_location_assignment PIN_R4 -to sdram_clk
#set_location_assignment PIN_T6 -to sdram_cs_n
#set_location_assignment PIN_R11 -to sdram_dq[15]
#set_location_assignment PIN_T11 -to sdram_dq[14]
#set_location_assignment PIN_R10 -to sdram_dq[13]
#set_location_assignment PIN_T10 -to sdram_dq[12]
#set_location_assignment PIN_T12 -to sdram_dq[11]
#set_location_assignment PIN_R12 -to sdram_dq[10]
#set_location_assignment PIN_T13 -to sdram_dq[9]
#set_location_assignment PIN_R13 -to sdram_dq[8]
#set_location_assignment PIN_P1 -to sdram_dq[7]
#set_location_assignment PIN_P2 -to sdram_dq[6]
#set_location_assignment PIN_R1 -to sdram_dq[5]
#set_location_assignment PIN_T2 -to sdram_dq[4]
#set_location_assignment PIN_R3 -to sdram_dq[3]
#set_location_assignment PIN_T3 -to sdram_dq[2]
#set_location_assignment PIN_T4 -to sdram_dq[1]
#set_location_assignment PIN_R5 -to sdram_dq[0]
#set_location_assignment PIN_T14 -to sdram_dqm[1]
#set_location_assignment PIN_N2 -to sdram_dqm[0]
#set_location_assignment PIN_R6 -to sdram_ras_n
#set_location_assignment PIN_N1 -to sdram_we_n

# 16bit vga output

#set_location_assignment PIN_F6 -to vga_out_b[4]
#set_location_assignment PIN_E5 -to vga_out_b[3]
#set_location_assignment PIN_D3 -to vga_out_b[2]
#set_location_assignment PIN_D4 -to vga_out_b[1]
#set_location_assignment PIN_C3 -to vga_out_b[0]
#set_location_assignment PIN_J6 -to vga_out_g[5]
#set_location_assignment PIN_L8 -to vga_out_g[4]
#set_location_assignment PIN_K8 -to vga_out_g[3]
#set_location_assignment PIN_F7 -to vga_out_g[2]
#set_location_assignment PIN_G5 -to vga_out_g[1]
#set_location_assignment PIN_F5 -to vga_out_g[0]
#set_location_assignment PIN_L6 -to vga_out_hs
#set_location_assignment PIN_L4 -to vga_out_r[4]
#set_location_assignment PIN_L3 -to vga_out_r[3]
#set_location_assignment PIN_L7 -to vga_out_r[2]
#set_location_assignment PIN_K5 -to vga_out_r[1]
#set_location_assignment PIN_K6 -to vga_out_r[0]
#set_location_assignment PIN_N3 -to vga_out_vs

#cmos an5640 module 

#set_location_assignment PIN_C3 -to cmos_db[7]
#set_location_assignment PIN_E5 -to cmos_db[6]
#set_location_assignment PIN_F2 -to cmos_db[5]
#set_location_assignment PIN_F3 -to cmos_db[4]
#set_location_assignment PIN_M1 -to cmos_db[3]
#set_location_assignment PIN_D4 -to cmos_db[2]
#set_location_assignment PIN_G5 -to cmos_db[1]
#set_location_assignment PIN_F5 -to cmos_db[0] 
#set_location_assignment PIN_D1 -to cmos_href
#set_location_assignment PIN_D5 -to cmos_pclk 
#set_location_assignment PIN_C6 -to cmos_scl 
#set_location_assignment PIN_D6 -to cmos_sda 
#set_location_assignment PIN_F6 -to cmos_vsync 
#set_location_assignment PIN_D3 -to cmos_xclk 
#set_location_assignment PIN_F1 -to cmos_rst_n
#set_location_assignment PIN_G2 -to cmos_pwdn

#lcd an430 J2

set_location_assignment PIN_J11 -to lcd_b[7]
set_location_assignment PIN_G16 -to lcd_b[6]
set_location_assignment PIN_K10 -to lcd_b[5]
set_location_assignment PIN_K9 -to lcd_b[4]
set_location_assignment PIN_G11 -to lcd_b[3]
set_location_assignment PIN_F14 -to lcd_b[2]
set_location_assignment PIN_F13 -to lcd_b[1]
set_location_assignment PIN_F11 -to lcd_b[0]
set_location_assignment PIN_J12 -to lcd_dclk
set_location_assignment PIN_K11 -to lcd_de
set_location_assignment PIN_D14 -to lcd_g[7]
set_location_assignment PIN_F10 -to lcd_g[6]
set_location_assignment PIN_C14 -to lcd_g[5]
set_location_assignment PIN_E11 -to lcd_g[4]
set_location_assignment PIN_D12 -to lcd_g[3]
set_location_assignment PIN_D11 -to lcd_g[2]
set_location_assignment PIN_C11 -to lcd_g[1]
set_location_assignment PIN_E10 -to lcd_g[0]
set_location_assignment PIN_J13 -to lcd_hs
set_location_assignment PIN_D9 -to lcd_r[7]
set_location_assignment PIN_C9 -to lcd_r[6]
set_location_assignment PIN_E9 -to lcd_r[5]
set_location_assignment PIN_F9 -to lcd_r[4]
set_location_assignment PIN_F7 -to lcd_r[3]
set_location_assignment PIN_E8 -to lcd_r[2]
set_location_assignment PIN_D8 -to lcd_r[1]
set_location_assignment PIN_E7 -to lcd_r[0]
set_location_assignment PIN_J14 -to lcd_vs

#wm8731 audio module an831 on J2

# set_location_assignment pin_b4 -to wm8731_adcdat
# set_location_assignment pin_a2 -to wm8731_bclk
# set_location_assignment pin_b3 -to wm8731_dacdat
# set_location_assignment pin_a3 -to wm8731_daclrc
# set_location_assignment pin_b1 -to wm8731_scl
# set_location_assignment pin_c2 -to wm8731_sda
# set_location_assignment pin_b5 -to wm8731_adclrc

