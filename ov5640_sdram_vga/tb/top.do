vlib work
vmap work work
                                            
#编译testbench文件					       	
vlog    top_tb.v
vlog    altera_mf.v
vlog    sdram_slave_model/sdr.v
vlog    sdram_slave_model/sdr_module.v

#编译 	设计文件					       	 
vlog ../rtl/capture.v
vlog ../rtl/sdram/sdram_controler.v
vlog ../rtl/sdram/sdram_ctrl.v
vlog ../rtl/sdram/sdram_intf.v
vlog ../rtl/vga/vga_intf.v
vlog ../ip/pll0/pll0.v 
vlog ../ip/pll1/pll1.v 
vlog ../ip/wrfifo/wrfifo.v                                            
vlog ../ip/rdfifo/rdfifo.v 
vlog ../ip/vga_fifo/vga_fifo.v 

#指定仿真顶层 							     
vsim -novopt work.top_tb 
#添加信号到波形窗 							  
add wave -position insertpoint sim:/top_tb//*
