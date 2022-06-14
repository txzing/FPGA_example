vlib work
vmap work work

vlog hist_tb.v

vlog ../rtl/hist.v
vlog ../ip/ram.v
vlog altera_mf.v

vsim -novopt work.hist_tb

add wave -position insertpoint sim:/hist_tb//*


