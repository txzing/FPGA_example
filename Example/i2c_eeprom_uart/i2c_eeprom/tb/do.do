vlib work
vmap work work
                                            
#编译testbench文件					       	
vlog    i2c_eeprom_tb.v
vlog    altera_mf.v 
vlog    i2c_slave_model.v 

#编译 	设计文件					       	 
vlog ../rtl/uart_tx.v
vlog ../rtl/uart_rx.v
vlog ../rtl/cmd_analy.v
vlog ../rtl/eeprom_control.v
vlog ../rtl/i2c_interface.v
vlog ../rtl/i2c_eeprom.v

vlog ../ip/wr_fifo/wrfifo.v
vlog ../ip/rd_fifo/rdfifo.v

#指定仿真顶层 							     
vsim -novopt work.i2c_eeprom_tb 
#添加信号到波形窗 							  
add wave -position insertpoint sim:/i2c_eeprom_tb//*