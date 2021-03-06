transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlib sdram
vmap sdram sdram
vlog -vlog01compat -work sdram +incdir+C:/Users/FPGA/Desktop/SDRAM_test/prj/qsys/synthesis {C:/Users/FPGA/Desktop/SDRAM_test/prj/qsys/synthesis/sdram.v}
vlog -vlog01compat -work sdram +incdir+C:/Users/FPGA/Desktop/SDRAM_test/prj/qsys/synthesis/submodules {C:/Users/FPGA/Desktop/SDRAM_test/prj/qsys/synthesis/submodules/sdram_new_sdram_controller_0.v}
vlog -vlog01compat -work work +incdir+C:/Users/FPGA/Desktop/SDRAM_test/src {C:/Users/FPGA/Desktop/SDRAM_test/src/process.v}
vlog -vlog01compat -work work +incdir+C:/Users/FPGA/Desktop/SDRAM_test/src {C:/Users/FPGA/Desktop/SDRAM_test/src/uart_tx.v}
vlog -vlog01compat -work work +incdir+C:/Users/FPGA/Desktop/SDRAM_test/src {C:/Users/FPGA/Desktop/SDRAM_test/src/uart_rx.v}
vlog -vlog01compat -work work +incdir+C:/Users/FPGA/Desktop/SDRAM_test/src {C:/Users/FPGA/Desktop/SDRAM_test/src/sdram_test.v}
vlog -vlog01compat -work work +incdir+C:/Users/FPGA/Desktop/SDRAM_test/ip {C:/Users/FPGA/Desktop/SDRAM_test/ip/pll.v}
vlog -vlog01compat -work work +incdir+C:/Users/FPGA/Desktop/SDRAM_test/ip {C:/Users/FPGA/Desktop/SDRAM_test/ip/fifo.v}
vlog -vlog01compat -work work +incdir+C:/Users/FPGA/Desktop/SDRAM_test/prj/db {C:/Users/FPGA/Desktop/SDRAM_test/prj/db/pll_altpll.v}

vlog -vlog01compat -work work +incdir+C:/Users/FPGA/Desktop/SDRAM_test/prj/../sim {C:/Users/FPGA/Desktop/SDRAM_test/prj/../sim/sdram_test_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -L sdram -voptargs="+acc"  sdram_test_tb

add wave *
view structure
view signals
run -all
