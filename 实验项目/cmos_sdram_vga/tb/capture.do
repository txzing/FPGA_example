vlib work
vmap work work

#compile testbench.v
vlog capture_tb.v

#compile design.v 
vlog ../rtl/capture.v


#set top level 
vsim -novopt work.capture_tb

#add signal to wave
add wave -position insertpoint sim:/capture_tb/*
add wave -position insertpoint sim:/capture_tb/u_capture/*

