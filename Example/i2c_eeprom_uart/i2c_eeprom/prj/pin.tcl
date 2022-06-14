#参数导入脚本；
#时钟、复位
set_location_assignment PIN_E1 -to clk
set_location_assignment PIN_E15 -to rst_n

#KEY
#set_location_assignment PIN_E16 -to key_in[0]
#set_location_assignment PIN_M16 -to key_in[1]
#set_location_assignment PIN_M15 -to key_in[2]

#LED
#set_location_assignment PIN_D16 -to led[3]
#set_location_assignment PIN_F15 -to led[2]
#set_location_assignment PIN_F16 -to led[1]
#set_location_assignment PIN_G15 -to led[0]

#数码管段选
#set_location_assignment PIN_B7 -to dig[0]
#set_location_assignment PIN_A8 -to dig[1]
#set_location_assignment PIN_A6 -to dig[2]
#set_location_assignment PIN_B5 -to dig[3]
#set_location_assignment PIN_B6 -to dig[4]
#set_location_assignment PIN_A7 -to dig[5]
#set_location_assignment PIN_B8 -to dig[6]
#set_location_assignment PIN_A5 -to dig[7]

#数码管片选
#set_location_assignment PIN_A4 -to sel[5]
#set_location_assignment PIN_B4 -to sel[4]
#set_location_assignment PIN_A3 -to sel[3]
#set_location_assignment PIN_B3 -to sel[2]
#set_location_assignment PIN_A2 -to sel[1]
#set_location_assignment PIN_B1 -to sel[0]

#set_location_assignment PIN_M12 -to sda
#set_location_assignment PIN_L12 -to scl

#UART
set_location_assignment PIN_M2 -to uart_rxd
set_location_assignment PIN_G1 -to uart_txd

#eeprom
set_location_assignment PIN_L2 -to i2c_sda
set_location_assignment PIN_L1 -to i2c_scl

