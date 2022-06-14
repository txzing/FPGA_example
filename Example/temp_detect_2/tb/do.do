vlib work
vmap work work
                                            
#编译testbench文件					       	
vlog    ds18b20_driver_tb.v
#编译 	设计文件					       	 
vlog ../rtl/ds18b20_driver.v
                                                
#指定仿真顶层 							     
vsim -novopt work.ds18b20_driver_tb 
#添加信号到波形窗 							  
add wave -position insertpoint sim:/ds18b20_driver_tb//*