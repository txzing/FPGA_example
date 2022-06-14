#时钟 复位
set_location_assignment PIN_AF14 -to clk 
set_location_assignment PIN_AJ4 -to rst_n   

#SDRAM 
set_location_assignment PIN_AK14 -to sdram_addr[0]
set_location_assignment PIN_AH14 -to sdram_addr[1]
set_location_assignment PIN_AG15 -to sdram_addr[2]
set_location_assignment PIN_AE14 -to sdram_addr[3]
set_location_assignment PIN_AB15 -to sdram_addr[4]
set_location_assignment PIN_AC14 -to sdram_addr[5]
set_location_assignment PIN_AD14 -to sdram_addr[6]
set_location_assignment PIN_AF15 -to sdram_addr[7]
set_location_assignment PIN_AH15 -to sdram_addr[8]
set_location_assignment PIN_AG13 -to sdram_addr[9]
set_location_assignment PIN_AG12 -to sdram_addr[10]
set_location_assignment PIN_AH13 -to sdram_addr[11]
set_location_assignment PIN_AJ14 -to sdram_addr[12]
set_location_assignment PIN_AF13 -to sdram_bank[0]
set_location_assignment PIN_AJ12 -to sdram_bank[1]
set_location_assignment PIN_AF11 -to sdram_casn
set_location_assignment PIN_AK13 -to sdram_cke
set_location_assignment PIN_AH12 -to sdram_clk
set_location_assignment PIN_AG11 -to sdram_csn
set_location_assignment PIN_AK6 -to sdram_dq[0]
set_location_assignment PIN_AJ7 -to sdram_dq[1]
set_location_assignment PIN_AK7 -to sdram_dq[2]
set_location_assignment PIN_AK8 -to sdram_dq[3]
set_location_assignment PIN_AK9 -to sdram_dq[4]
set_location_assignment PIN_AG10 -to sdram_dq[5]
set_location_assignment PIN_AK11 -to sdram_dq[6]
set_location_assignment PIN_AJ11 -to sdram_dq[7]
set_location_assignment PIN_AH10 -to sdram_dq[8]
set_location_assignment PIN_AJ10 -to sdram_dq[9]
set_location_assignment PIN_AJ9 -to sdram_dq[10]
set_location_assignment PIN_AH9 -to sdram_dq[11]
set_location_assignment PIN_AH8 -to sdram_dq[12]
set_location_assignment PIN_AH7 -to sdram_dq[13]
set_location_assignment PIN_AJ6 -to sdram_dq[14]
set_location_assignment PIN_AJ5 -to sdram_dq[15]
set_location_assignment PIN_AB13 -to sdram_dqm[0]
set_location_assignment PIN_AK12 -to sdram_dqm[1]
set_location_assignment PIN_AE13 -to sdram_rasn
set_location_assignment PIN_AA13 -to sdram_wen

#VGA DAC
set_location_assignment PIN_AK29  -to vga_r[0]
set_location_assignment PIN_AK28  -to vga_r[1] 
set_location_assignment PIN_AK27  -to vga_r[2]      
set_location_assignment PIN_AJ27  -to vga_r[3] 
set_location_assignment PIN_AH27  -to vga_r[4] 
set_location_assignment PIN_AF26  -to vga_r[5] 
set_location_assignment PIN_AG26  -to vga_r[6] 
set_location_assignment PIN_AJ26  -to vga_r[7] 

set_location_assignment PIN_AK26  -to vga_g[0]   
set_location_assignment PIN_AJ25  -to vga_g[1]  
set_location_assignment PIN_AH25  -to vga_g[2]
set_location_assignment PIN_AK24  -to vga_g[3]
set_location_assignment PIN_AJ24  -to vga_g[4]
set_location_assignment PIN_AH24  -to vga_g[5]
set_location_assignment PIN_AK23  -to vga_g[6]
set_location_assignment PIN_AH23  -to vga_g[7]

set_location_assignment PIN_AJ21  -to vga_b[0]  
set_location_assignment PIN_AJ20  -to vga_b[1]    
set_location_assignment PIN_AH20  -to vga_b[2] 
set_location_assignment PIN_AJ19  -to vga_b[3] 
set_location_assignment PIN_AH19  -to vga_b[4] 
set_location_assignment PIN_AJ17  -to vga_b[5] 
set_location_assignment PIN_AJ16  -to vga_b[6] 
set_location_assignment PIN_AK16  -to vga_b[7] 

set_location_assignment PIN_AK22  -to vga_blank 
set_location_assignment PIN_AJ22  -to vga_sync  
set_location_assignment PIN_AK21  -to vga_clk   
set_location_assignment PIN_AK19  -to vga_hsync 
set_location_assignment PIN_AK18  -to vga_vsync 


#OV5640  GPIO       正点原子版摄像头模组
set_location_assignment PIN_AF10 -to cmos_sda
set_location_assignment PIN_AG8  -to cmos_din[4]
set_location_assignment PIN_AG7  -to cmos_din[5]
set_location_assignment PIN_AG3  -to cmos_pclk
set_location_assignment PIN_AF8  -to cmos_din[0]
set_location_assignment PIN_AF9  -to cmos_reset
set_location_assignment PIN_AG6  -to cmos_din[6]
set_location_assignment PIN_AG5  -to cmos_din[7]
set_location_assignment PIN_AF5  -to cmos_din[2]
set_location_assignment PIN_AF6  -to cmos_din[1]
set_location_assignment PIN_AE7  -to cmos_href 
set_location_assignment PIN_AF4  -to cmos_din[3] 
set_location_assignment PIN_AG1  -to cmos_pwdn 
set_location_assignment PIN_AG2  -to cmos_xclk
set_location_assignment PIN_AE11 -to cmos_vsync 
set_location_assignment PIN_AE9  -to cmos_scl 

#gnd                     vcc 
#scl   GPIO24    AE9     vsync   GPIO25  AE11
#sda   GPIO22    AF10    href    GPIO23  AE7
#d0    GPIO20    AF8     rst     GPIO21  AF9
#d2    GPIO18    AF5     d1      GPIO19  AF6
#d4    GPIO16    AG8     d3      GPIO17  AF4
#d6    GPIO14    AG6     d5      GPIO15  AG7
#pclk  GPIO12    AG3     d7      GPIO13  AG5
#pwdn  GPIO10    AG1     xclk    GPIO11  AG2

#OV5640  GPIO   
#set_location_assignment PIN_AF10 -to cmos_vsync
#set_location_assignment PIN_AG8  -to cmos_href 
#set_location_assignment PIN_AG7  -to cmos_din[0]
#set_location_assignment PIN_AG3  -to cmos_din[1]
#set_location_assignment PIN_AF8  -to cmos_din[2]
#set_location_assignment PIN_AF9  -to cmos_din[3]
#set_location_assignment PIN_AG6  -to cmos_din[4]
#set_location_assignment PIN_AG5  -to cmos_din[5]
#set_location_assignment PIN_AF5  -to cmos_din[6]
#set_location_assignment PIN_AF6  -to cmos_din[7]
#set_location_assignment PIN_AE7  -to cmos_pclk 
#set_location_assignment PIN_AF4  -to cmos_xclk 
#set_location_assignment PIN_AG1  -to cmos_pwdn 
#set_location_assignment PIN_AG2  -to cmos_reset
#set_location_assignment PIN_AE11 -to cmos_scl 
#set_location_assignment PIN_AE9  -to cmos_sda 

