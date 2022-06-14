vlib work
vmap work work
                                            
#编译testbench文件					       	
vlog imp_tb.v
vlog altera_mf.v 

#编译 	设计文件					       	 
vlog ../rtl/img_process.v
vlog ../rtl/rgb565_gray.v 
vlog ../rtl/gs_filter.v
vlog ../rtl/gray2bin.v 
vlog ../rtl/sobel.v 

vlog ../ip/gs_shift/gs_shift.v 
vlog ../ip/sobel_shift/sobel_shift.v 


#指定仿真顶层 							     
vsim -novopt work.imp_tb 
#添加信号到波形窗 							  
add wave -position insertpoint sim:/imp_tb//*
