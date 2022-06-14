transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/TX/Desktop/hist/ip {C:/Users/TX/Desktop/hist/ip/ram.v}
vlog -vlog01compat -work work +incdir+C:/Users/TX/Desktop/hist/rtl {C:/Users/TX/Desktop/hist/rtl/hist.v}

vlog -vlog01compat -work work +incdir+C:/Users/TX/Desktop/hist/prj/../tb {C:/Users/TX/Desktop/hist/prj/../tb/hist_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  hist_tb

add wave *
view structure
view signals
run -all
