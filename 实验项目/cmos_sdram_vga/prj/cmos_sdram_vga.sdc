## Generated SDC file "cmos_sdram_vga.sdc"

## Copyright (C) 2018  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 18.1.0 Build 625 09/12/2018 SJ Standard Edition"

## DATE    "Tue Mar 15 10:55:11 2022"

##
## DEVICE  "EP4CE6F17C8"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk}]
create_clock -name {cmos_pclk} -period 12.000 -waveform { 0.000 6.000 } [get_ports {cmos_pclk}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {u_pll1|altpll_component|auto_generated|pll1|clk[0]} -source [get_pins {u_pll1|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 2 -master_clock {clk} [get_pins {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] 
create_generated_clock -name {u_pll1|altpll_component|auto_generated|pll1|clk[1]} -source [get_pins {u_pll1|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 2 -phase 30.000 -master_clock {clk} [get_pins {u_pll1|altpll_component|auto_generated|pll1|clk[1]}] 
create_generated_clock -name {u_pll1|altpll_component|auto_generated|pll1|clk[2]} -source [get_pins {u_pll1|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 12 -divide_by 25 -master_clock {clk} [get_pins {u_pll1|altpll_component|auto_generated|pll1|clk[2]}] 
create_generated_clock -name {u_pll1|altpll_component|auto_generated|pll1|clk[3]} -source [get_pins {u_pll1|altpll_component|auto_generated|pll1|inclk[0]}] -duty_cycle 50/1 -multiply_by 3 -divide_by 2 -master_clock {clk} [get_pins {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {cmos_pclk}] -rise_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {cmos_pclk}] -rise_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -hold 0.110  
set_clock_uncertainty -rise_from [get_clocks {cmos_pclk}] -fall_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -setup 0.080  
set_clock_uncertainty -rise_from [get_clocks {cmos_pclk}] -fall_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -hold 0.110  
set_clock_uncertainty -fall_from [get_clocks {cmos_pclk}] -rise_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {cmos_pclk}] -rise_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -hold 0.110  
set_clock_uncertainty -fall_from [get_clocks {cmos_pclk}] -fall_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -setup 0.080  
set_clock_uncertainty -fall_from [get_clocks {cmos_pclk}] -fall_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -hold 0.110  
set_clock_uncertainty -rise_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -rise_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -fall_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -rise_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -fall_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -rise_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -fall_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -rise_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}] -fall_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {cmos_pclk}] -setup 0.110  
set_clock_uncertainty -rise_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {cmos_pclk}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {cmos_pclk}] -setup 0.110  
set_clock_uncertainty -rise_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {cmos_pclk}] -hold 0.080  
set_clock_uncertainty -rise_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {cmos_pclk}] -setup 0.110  
set_clock_uncertainty -fall_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {cmos_pclk}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {cmos_pclk}] -setup 0.110  
set_clock_uncertainty -fall_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {cmos_pclk}] -hold 0.080  
set_clock_uncertainty -fall_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[3]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -rise_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}] -fall_to [get_clocks {u_pll1|altpll_component|auto_generated|pll1|clk[0]}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -rise_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -rise_to [get_clocks {clk}]  0.020  
set_clock_uncertainty -fall_from [get_clocks {clk}] -fall_to [get_clocks {clk}]  0.020  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_keepers {*rdptr_g*}] -to [get_keepers {*ws_dgrp|dffpipe_ue9:dffpipe9|dffe10a*}]
set_false_path -from [get_keepers {*delayed_wrptr_g*}] -to [get_keepers {*rs_dgwp|dffpipe_te9:dffpipe6|dffe7a*}]
set_false_path -to [get_pins -nocase -compatibility_mode {*|alt_rst_sync_uq1|altera_reset_synchronizer_int_chain*|clrn}]


#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

