vlib work
vmap work work
                                            
#编译testbench文件					       	
vlog    mult_tb.v
#编译 	设计文件					       	 
vlog ../rtl/mult.v

                                                
#指定仿真顶层 							     
vsim -novopt work.mult_tb 
#添加信号到波形窗 							  
add wave -position insertpoint sim:/mult_tb//*