vlib work
vmap work work
                                            
#编译testbench文件					       	
vlog i2c_tb.v
vlog i2c_slave_model.v 

#编译 	设计文件					       	 
vlog ../rtl/i2c_interface.v
                                                
#指定仿真顶层 							     
vsim -novopt work.i2c_tb 
#添加信号到波形窗 							  
add wave -position insertpoint sim:/i2c_tb//*

