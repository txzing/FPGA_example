
vlib work
vmap work work

#compile testbench.v
vlog controller_tb.v
vlog sdram_slave_model/sdr.v
vlog sdram_slave_model/sdr_module.v
vlog altera_mf.v

#compile design.v 
vlog ../rtl/sdram_controller.v
vlog ../rtl/sdram_ctrl.v
vlog ../rtl/sdram_interface.v

vlog ../ip/wrfifo/wrfifo.v
vlog ../ip/rdfifo/rdfifo.v

#set top level 
vsim -novopt work.controller_tb

#add signal to wave
add wave -position insertpoint sim:/controller_tb//*

