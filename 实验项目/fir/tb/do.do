vlib work
vmap work work
                                            
#编译testbench文件					       	
vlog    fir_tb.v
#编译 	设计文件					       	 
vlog ../rtl/fir.v                            
#指定仿真顶层 							     
vsim -novopt work.fir_tb 
#添加信号到波形窗 							  
add wave -position insertpoint sim:/fir_tb//*