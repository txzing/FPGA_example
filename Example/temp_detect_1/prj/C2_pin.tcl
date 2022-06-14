#约束器件类型以及未用管脚标准
set_global_assignment -name FAMILY "Cyclone II" 
set_global_assignment -name DEVICE EP2C5T144C8

set_global_assignment -name STRATIX_DEVICE_IO_STANDARD "3.3-V LVTTL"
set_global_assignment -name RESERVE_ALL_UNUSED_PINS "AS INPUT TRI-STATED"

#引脚参数导入脚本
#时钟、复位
set_location_assignment PIN_17 -to sys_clk
set_location_assignment PIN_74 -to sys_rst_n

#UART
#set_location_assignment PIN_59 -to uart_rx
#set_location_assignment PIN_90 -to uart_tx

#LED
#set_location_assignment PIN_8 -to led[7]
#set_location_assignment PIN_9 -to led[6]
#set_location_assignment PIN_4 -to led[5]
#set_location_assignment PIN_3 -to led[4]
#set_location_assignment PIN_144 -to led[3]
#set_location_assignment PIN_143 -to led[2]
#set_location_assignment PIN_142 -to led[1]
#set_location_assignment PIN_141 -to led[0]

#独立按键
#set_location_assignment PIN_72 -to key_in[3]
#set_location_assignment PIN_70 -to key_in[2]
#set_location_assignment PIN_67 -to key_in[1]
#set_location_assignment PIN_64 -to key_in[0]

#set_location_assignment PIN_64 -to key_in

#数码管选段
set_location_assignment PIN_136 -to seg_sig[0]
set_location_assignment PIN_122 -to seg_sig[1]
set_location_assignment PIN_129 -to seg_sig[2]
set_location_assignment PIN_135 -to seg_sig[3]
set_location_assignment PIN_137 -to seg_sig[4]
set_location_assignment PIN_134 -to seg_sig[5]
set_location_assignment PIN_125 -to seg_sig[6]
set_location_assignment PIN_133 -to seg_sig[7]

#数码管片选
set_location_assignment PIN_115 -to seg_sel[0]
set_location_assignment PIN_118 -to seg_sel[1]
set_location_assignment PIN_119 -to seg_sel[2]
set_location_assignment PIN_120 -to seg_sel[3]
set_location_assignment PIN_121 -to seg_sel[4]
set_location_assignment PIN_126 -to seg_sel[5]
set_location_assignment PIN_132 -to seg_sel[6]
set_location_assignment PIN_139 -to seg_sel[7]

#DS18B20
set_location_assignment PIN_113 -to dq

#LCD12864
set_location_assignment PIN_63 -to lcd_rw
set_location_assignment PIN_28 -to lcd_psb
set_location_assignment PIN_57 -to lcd_e
set_location_assignment PIN_65 -to lcd_rs
set_location_assignment PIN_53 -to lcd_data[0]
set_location_assignment PIN_43 -to lcd_data[1]
set_location_assignment PIN_42 -to lcd_data[2]
set_location_assignment PIN_41 -to lcd_data[3]
set_location_assignment PIN_40 -to lcd_data[4]
set_location_assignment PIN_32 -to lcd_data[5]
set_location_assignment PIN_31 -to lcd_data[6]
set_location_assignment PIN_30 -to lcd_data[7]


#蜂鸣器
#set_location_assignment PIN_44 -to beep

#AD



#DA





