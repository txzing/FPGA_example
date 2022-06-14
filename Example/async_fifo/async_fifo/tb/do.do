vlib work
vmap work work

#compile testbench.v
vlog async_fifo_tb.v

#compile design.v 
vlog ../rtl/async_fifo.v

#set top level 
vsim -novopt work.async_fifo_tb

#add signal to wave
add wave -position insertpoint sim:/async_fifo_tb//*

run 2000

