vlib work
vmap work work
                                            
#编译testbench文件					       	
vlog    multiplier_32bit_tb.v
#编译 	设计文件					       	 
vlog ../rtl/multiplier_32bit.v

                                       
#指定仿真顶层 							     
vsim -novopt work.multiplier_32bit_tb 
#添加信号到波形窗 							  
add wave -position insertpoint sim:/multiplier_32bit_tb//*