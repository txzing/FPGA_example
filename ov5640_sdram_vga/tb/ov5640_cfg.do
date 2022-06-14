vlib work
vmap work work
                                            
#编译testbench文件					       	
vlog    ov5640_cfg_tb.v
vlog    i2c_slave_model.v

#编译 	设计文件					       	 
vlog ../rtl/ov5640_config.v
vlog ../rtl/i2c_config.v 
vlog ../rtl/i2c_interface.v

#指定仿真顶层 							     
vsim -novopt work.ov5640_cfg_tb 
#添加信号到波形窗 							  
add wave -position insertpoint sim:/ov5640_cfg_tb//*

