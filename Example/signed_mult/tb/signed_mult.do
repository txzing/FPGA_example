vlib work
vmap work work
                                            
#编译testbench文件					       	
vlog    signed_mult_tb.v
#编译 	设计文件					       	 
vlog ../rtl/signed_mult.v

                                                
#指定仿真顶层 							     
vsim -novopt work.signed_mult_tb 
#添加信号到波形窗 							  
add wave -position insertpoint sim:/signed_mult_tb//*