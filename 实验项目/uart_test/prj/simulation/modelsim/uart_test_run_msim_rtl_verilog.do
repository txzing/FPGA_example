transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/TX/Desktop/uart_test/rtl {C:/Users/TX/Desktop/uart_test/rtl/param.v}
vlog -vlog01compat -work work +incdir+C:/Users/TX/Desktop/uart_test/rtl {C:/Users/TX/Desktop/uart_test/rtl/uart_tx.v}

vlog -vlog01compat -work work +incdir+C:/Users/TX/Desktop/uart_test/prj/../tb {C:/Users/TX/Desktop/uart_test/prj/../tb/uart_tx_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  uart_tx_tb

add wave *
view structure
view signals
run -all
