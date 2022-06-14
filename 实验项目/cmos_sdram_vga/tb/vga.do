vlib work
vmap work work

#compile testbench.v
vlog vga_tb.v

#compile design.v 
vlog ../rtl/vga_interface.v
vlog ../ip/vga_buf/vga_buf.v

#set top level 
vsim -novopt work.vga_tb

#add signal to wave
add wave -position insertpoint sim:/vga_tb/*
add wave -position insertpoint sim:/vga_tb.u_vga/*
run
