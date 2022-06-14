transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/FPGA/Desktop/mult_32b_unsigned/src {C:/Users/FPGA/Desktop/mult_32b_unsigned/src/mult_top.v}
vlog -vlog01compat -work work +incdir+C:/Users/FPGA/Desktop/mult_32b_unsigned/src {C:/Users/FPGA/Desktop/mult_32b_unsigned/src/mult_shift_add.v}
vlog -vlog01compat -work work +incdir+C:/Users/FPGA/Desktop/mult_32b_unsigned/ip {C:/Users/FPGA/Desktop/mult_32b_unsigned/ip/pll.v}
vlog -vlog01compat -work work +incdir+C:/Users/FPGA/Desktop/mult_32b_unsigned/prj/db {C:/Users/FPGA/Desktop/mult_32b_unsigned/prj/db/pll_altpll.v}

