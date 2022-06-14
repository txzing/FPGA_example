vlib work
vmap work work
                                            
#编译testbench文件					       	
vlog    adder_tb.v
#编译 	设计文件					       	 
vlog ../rtl/signed_adder.v

                                                
#指定仿真顶层 							     
vsim -novopt work.adder_tb 
#添加信号到波形窗 							  
add wave -position insertpoint sim:/adder_tb//*