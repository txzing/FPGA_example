
# (C) 2001-2021 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 18.1 625 win32 2021.07.13.15:49:04
# ----------------------------------------
# Auto-generated simulation script rivierapro_setup.tcl
# ----------------------------------------
# This script provides commands to simulate the following IP detected in
# your Quartus project:
#     tb
# 
# Altera recommends that you source this Quartus-generated IP simulation
# script from your own customized top-level script, and avoid editing this
# generated script.
# 
# To write a top-level script that compiles Altera simulation libraries and
# the Quartus-generated IP in your project, along with your design and
# testbench files, copy the text from the TOP-LEVEL TEMPLATE section below
# into a new file, e.g. named "aldec.do", and modify the text as directed.
# 
# ----------------------------------------
# # TOP-LEVEL TEMPLATE - BEGIN
# #
# # QSYS_SIMDIR is used in the Quartus-generated IP simulation script to
# # construct paths to the files required to simulate the IP in your Quartus
# # project. By default, the IP script assumes that you are launching the
# # simulator from the IP script location. If launching from another
# # location, set QSYS_SIMDIR to the output directory you specified when you
# # generated the IP script, relative to the directory from which you launch
# # the simulator.
# #
# set QSYS_SIMDIR <script generation output directory>
# #
# # Source the generated IP simulation script.
# source $QSYS_SIMDIR/aldec/rivierapro_setup.tcl
# #
# # Set any compilation options you require (this is unusual).
# set USER_DEFINED_COMPILE_OPTIONS <compilation options>
# set USER_DEFINED_VHDL_COMPILE_OPTIONS <compilation options for VHDL>
# set USER_DEFINED_VERILOG_COMPILE_OPTIONS <compilation options for Verilog>
# #
# # Call command to compile the Quartus EDA simulation library.
# dev_com
# #
# # Call command to compile the Quartus-generated IP simulation files.
# com
# #
# # Add commands to compile all design files and testbench files, including
# # the top level. (These are all the files required for simulation other
# # than the files compiled by the Quartus-generated IP simulation script)
# #
# vlog -sv2k5 <your compilation options> <design and testbench files>
# #
# # Set the top-level simulation or testbench module/entity name, which is
# # used by the elab command to elaborate the top level.
# #
# set TOP_LEVEL_NAME <simulation top>
# #
# # Set any elaboration options you require.
# set USER_DEFINED_ELAB_OPTIONS <elaboration options>
# #
# # Call command to elaborate your design and testbench.
# elab
# #
# # Run the simulation.
# run
# #
# # Report success to the shell.
# exit -code 0
# #
# # TOP-LEVEL TEMPLATE - END
# ----------------------------------------
# 
# IP SIMULATION SCRIPT
# ----------------------------------------
# If tb is one of several IP cores in your
# Quartus project, you can generate a simulation script
# suitable for inclusion in your top-level simulation
# script by running the following command line:
# 
# ip-setup-simulation --quartus-project=<quartus project>
# 
# ip-setup-simulation will discover the Altera IP
# within the Quartus project, and generate a unified
# script which supports all the Altera IP within the design.
# ----------------------------------------

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "tb"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "D:/intelfpga/18.1/quartus/"
}

if ![info exists USER_DEFINED_COMPILE_OPTIONS] { 
  set USER_DEFINED_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_VHDL_COMPILE_OPTIONS] { 
  set USER_DEFINED_VHDL_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_VERILOG_COMPILE_OPTIONS] { 
  set USER_DEFINED_VERILOG_COMPILE_OPTIONS ""
}
if ![info exists USER_DEFINED_ELAB_OPTIONS] { 
  set USER_DEFINED_ELAB_OPTIONS ""
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

set Aldec "Riviera"
if { [ string match "*Active-HDL*" [ vsim -version ] ] } {
  set Aldec "Active"
}

if { [ string match "Active" $Aldec ] } {
  scripterconf -tcl
  createdesign "$TOP_LEVEL_NAME"  "."
  opendesign "$TOP_LEVEL_NAME"
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib      ./libraries     
ensure_lib      ./libraries/work
vmap       work ./libraries/work
ensure_lib                       ./libraries/altera_ver           
vmap       altera_ver            ./libraries/altera_ver           
ensure_lib                       ./libraries/lpm_ver              
vmap       lpm_ver               ./libraries/lpm_ver              
ensure_lib                       ./libraries/sgate_ver            
vmap       sgate_ver             ./libraries/sgate_ver            
ensure_lib                       ./libraries/altera_mf_ver        
vmap       altera_mf_ver         ./libraries/altera_mf_ver        
ensure_lib                       ./libraries/altera_lnsim_ver     
vmap       altera_lnsim_ver      ./libraries/altera_lnsim_ver     
ensure_lib                       ./libraries/cyclonev_ver         
vmap       cyclonev_ver          ./libraries/cyclonev_ver         
ensure_lib                       ./libraries/cyclonev_hssi_ver    
vmap       cyclonev_hssi_ver     ./libraries/cyclonev_hssi_ver    
ensure_lib                       ./libraries/cyclonev_pcie_hip_ver
vmap       cyclonev_pcie_hip_ver ./libraries/cyclonev_pcie_hip_ver
ensure_lib                       ./libraries/altera               
vmap       altera                ./libraries/altera               
ensure_lib                       ./libraries/lpm                  
vmap       lpm                   ./libraries/lpm                  
ensure_lib                       ./libraries/sgate                
vmap       sgate                 ./libraries/sgate                
ensure_lib                       ./libraries/altera_mf            
vmap       altera_mf             ./libraries/altera_mf            
ensure_lib                       ./libraries/altera_lnsim         
vmap       altera_lnsim          ./libraries/altera_lnsim         
ensure_lib                       ./libraries/cyclonev             
vmap       cyclonev              ./libraries/cyclonev             
ensure_lib                                                                 ./libraries/altera_common_sv_packages                                      
vmap       altera_common_sv_packages                                       ./libraries/altera_common_sv_packages                                      
ensure_lib                                                                 ./libraries/avg_internal_inst                                              
vmap       avg_internal_inst                                               ./libraries/avg_internal_inst                                              
ensure_lib                                                                 ./libraries/irq_mapper                                                     
vmap       irq_mapper                                                      ./libraries/irq_mapper                                                     
ensure_lib                                                                 ./libraries/stream_source_dpi_bfm_avg_x_inst                               
vmap       stream_source_dpi_bfm_avg_x_inst                                ./libraries/stream_source_dpi_bfm_avg_x_inst                               
ensure_lib                                                                 ./libraries/split_component_start_inst                                     
vmap       split_component_start_inst                                      ./libraries/split_component_start_inst                                     
ensure_lib                                                                 ./libraries/mm_slave_dpi_bfm_avg_avmm_0_rw_inst                            
vmap       mm_slave_dpi_bfm_avg_avmm_0_rw_inst                             ./libraries/mm_slave_dpi_bfm_avg_avmm_0_rw_inst                            
ensure_lib                                                                 ./libraries/main_dpi_controller_inst                                       
vmap       main_dpi_controller_inst                                        ./libraries/main_dpi_controller_inst                                       
ensure_lib                                                                 ./libraries/concatenate_component_done_inst                                
vmap       concatenate_component_done_inst                                 ./libraries/concatenate_component_done_inst                                
ensure_lib                                                                 ./libraries/component_dpi_controller_avg_inst                              
vmap       component_dpi_controller_avg_inst                               ./libraries/component_dpi_controller_avg_inst                              
ensure_lib                                                                 ./libraries/clock_reset_inst                                               
vmap       clock_reset_inst                                                ./libraries/clock_reset_inst                                               
ensure_lib                                                                 ./libraries/avg_inst                                                       
vmap       avg_inst                                                        ./libraries/avg_inst                                                       
ensure_lib                                                                 ./libraries/avg_component_dpi_controller_implicit_ready_conduit_fanout_inst
vmap       avg_component_dpi_controller_implicit_ready_conduit_fanout_inst ./libraries/avg_component_dpi_controller_implicit_ready_conduit_fanout_inst
ensure_lib                                                                 ./libraries/avg_component_dpi_controller_bind_conduit_fanout_inst          
vmap       avg_component_dpi_controller_bind_conduit_fanout_inst           ./libraries/avg_component_dpi_controller_bind_conduit_fanout_inst          

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  eval vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"                    -work altera_ver           
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                             -work lpm_ver              
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                                -work sgate_ver            
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                            -work altera_mf_ver        
  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                        -work altera_lnsim_ver     
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_atoms_ncrypt.v"          -work cyclonev_ver         
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_hmi_atoms_ncrypt.v"      -work cyclonev_ver         
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.v"                       -work cyclonev_ver         
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_hssi_atoms_ncrypt.v"     -work cyclonev_hssi_ver    
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_hssi_atoms.v"                  -work cyclonev_hssi_ver    
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_pcie_hip_atoms_ncrypt.v" -work cyclonev_pcie_hip_ver
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_pcie_hip_atoms.v"              -work cyclonev_pcie_hip_ver
  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_syn_attributes.vhd"              -work altera               
  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_standard_functions.vhd"          -work altera               
  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QUARTUS_INSTALL_DIR/eda/sim_lib/alt_dspbuilder_package.vhd"             -work altera               
  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_europa_support_lib.vhd"          -work altera               
  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives_components.vhd"       -work altera               
  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.vhd"                  -work altera               
  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QUARTUS_INSTALL_DIR/eda/sim_lib/220pack.vhd"                            -work lpm                  
  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.vhd"                           -work lpm                  
  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate_pack.vhd"                         -work sgate                
  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.vhd"                              -work sgate                
  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf_components.vhd"               -work altera_mf            
  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.vhd"                          -work altera_mf            
  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                        -work altera_lnsim         
  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim_components.vhd"            -work altera_lnsim         
  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QUARTUS_INSTALL_DIR/eda/sim_lib/aldec/cyclonev_atoms_ncrypt.v"          -work cyclonev             
  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_atoms.vhd"                     -work cyclonev             
  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QUARTUS_INSTALL_DIR/eda/sim_lib/cyclonev_components.vhd"                -work cyclonev             
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/verbosity_pkg.sv"                                                                                   -work altera_common_sv_packages                                      
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/avalon_mm_pkg.sv"                                                                                   -work altera_common_sv_packages                                      
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/avalon_utilities_pkg.sv"                                                                            -work altera_common_sv_packages                                      
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/dspba_library_package.vhd"                                                                          -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/dspba_library.vhd"                                                                                  -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_data_fifo.v"                                                       -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_fifo.v"                                                            -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_ll_fifo.v"                                                         -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_ll_ram_fifo.v"                                                     -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_valid_fifo_counter.v"                                              -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_dspba_valid_fifo_counter.v"                                        -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_staging_reg.v"                                                     -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/hld_fifo.sv"                                                           -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/hld_fifo_zero_width.sv"                                                -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_high_speed_fifo.sv"                                                -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_low_latency_fifo.sv"                                               -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_zero_latency_fifo.sv"                                              -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_fanout_pipeline.sv"                                                -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_std_synchronizer_nocut.v"                                          -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_tessellated_incr_decr_threshold.sv"                                -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_tessellated_incr_lookahead.sv"                                     -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_reset_handler.sv"                                                  -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_lfsr.sv"                                                           -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_pop.v"                                                             -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_push.v"                                                            -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_token_fifo_counter.v"                                              -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_pipeline.v"                                                        -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_dspba_buffer.v"                                                    -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_enable_sink.v"                                                     -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/st_top.v"                                                              -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_ffwdsrc.v"                                                         -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_full_detector.v"                                                   -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_top.v"                                                             -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_permute_address.v"                                                 -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_pipelined.v"                                                       -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_enabled.v"                                                         -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_basic_coalescer.v"                                                 -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_simple.v"                                                          -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_streaming.v"                                                       -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_burst_master.v"                                                    -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_bursting_load_stores.v"                                            -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_non_aligned_write.v"                                               -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_read_cache.v"                                                      -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_atomic.v"                                                          -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_prefetch_block.v"                                                  -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_wide_wrapper.v"                                                    -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_streaming_prefetch.v"                                              -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_aligned_burst_coalesced_lsu.v"                                     -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_toggle_detect.v"                                                   -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_debug_mem.v"                                                       -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_burst_coalesced_pipelined_write.sv"                                -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/lsu_burst_coalesced_pipelined_read.sv"                                 -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_fifo_stall_valid_lookahead.sv"                                     -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_loop_limiter.v"                                                    -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_reset_wire.v"                                                      -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_function_wrapper.vhd"                                                                           -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_function.vhd"                                                                                   -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B2_sr_1.vhd"                                                                                 -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B3.vhd"                                                                                      -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B3_branch.vhd"                                                                                  -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B3_merge.vhd"                                                                                   -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B3_stall_region.vhd"                                                                         -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B3_merge_reg.vhd"                                                                               -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_sfc_c0_for_body3_avg_c0_enter26_avg.vhd"                                                          -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_sfc_exit_c0_for_body3_avg_c0_exit31_avg72.vhd"                                                -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_sfc_exit_c0_for_body3_avg_c0_exit3A0Z_avg97_data_fifo.vhd"                                    -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_sfc_exit_c0_for_body3_avg_c0_exit3A0Zvg_full_detector.vhd"                                    -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_sfc_logic_c0_for_body3_avg_c0_enter26_avg37.vhd"                                                  -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pipeline_keep_going_avg39.vhd"                                                                -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pop_i1_exitcond18_pop15_avg64.vhd"                                                            -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pop_i1_memdep_phi_pop1020_pop17_avg49.vhd"                                                    -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pop_i1_notexit1119_pop16_avg68.vhd"                                                           -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pop_i32_i_03_pop917_pop14_avg43.vhd"                                                          -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pop_i32_j_11_pop13_avg41.vhd"                                                                 -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pop_i4_fpgaindvars_iv_pop11_avg51.vhd"                                                        -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i1_exitcond18_push15_avg66.vhd"                                                          -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i1_memdep_phi_pop1020_push17_avg54.vhd"                                                  -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i1_notexit1119_push16_avg70.vhd"                                                         -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i1_notexitcond_avg60.vhd"                                                                -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i32_i_03_pop917_push14_avg56.vhd"                                                        -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i32_j_11_push13_avg58.vhd"                                                               -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i4_fpgaindvars_iv_push11_avg62.vhd"                                                      -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_ffwd_dst_x56_avg46.vhd"                                                                           -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_sfc_c1_for_body3_avg_c1_enter_avg.vhd"                                                            -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_sfc_exit_c1_for_body3_avg_c1_exit_avg81.vhd"                                                  -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_sfc_exit_c1_for_body3_avg_c1_exit_avg99_data_fifo.vhd"                                        -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_sfc_exit_c1_for_body3_avg_c1_exit_A0Zvg_full_detector.vhd"                                    -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_sfc_logic_c1_for_body3_avg_c1_enter_avg75.vhd"                                                    -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pop_f_sum_12_pop12_avg77.vhd"                                                                 -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_f_sum_12_push12_avg79.vhd"                                                               -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/floatComponent_i_sfc_logic_c1_for_body3_A0Zo00rf00d06of5q0u.vhd"                                    -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_load_unnamed_avg4_avg73.vhd"                                                                      -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/readdata_reg_unnamed_avg4_avg0.vhd"                                                                 -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B3_sr_1.vhd"                                                                                 -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B4.vhd"                                                                                      -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B4_merge.vhd"                                                                                   -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B4_branch.vhd"                                                                                  -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B4_stall_region.vhd"                                                                         -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_sfc_c0_for_end_avg_c0_enter36_avg.vhd"                                                            -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_sfc_exit_c0_for_end_avg_c0_exit39_avg84.vhd"                                                  -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_sfc_exit_c0_for_end_avg_c0_exit39_A0Zavg101_data_fifo.vhd"                                    -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_sfc_exit_c0_for_end_avg_c0_exit39_A0Zvg_full_detector.vhd"                                    -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_sfc_logic_c0_for_end_avg_c0_enter36_avg82.vhd"                                                    -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/floatComponent_i_sfc_logic_c0_for_end_avA0Z03p06o303d0jzj0u.vhd"                                    -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/floatComponent_i_sfc_logic_c0_for_end_avA0Z303d06o00rf01pzc.vhd"                                    -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i1_memdep_phi_push10_avg90.vhd"                                                          -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i1_memdep_phi_push10_avg_reg.vhd"                                                        -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_ffwd_dst_y67_avg85.vhd"                                                                           -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_store_memdep_avg88.vhd"                                                                           -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B4_sr_0.vhd"                                                                                 -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B5_sr_0.vhd"                                                                                 -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B0_runOnce.vhd"                                                                              -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B0_runOnce_branch.vhd"                                                                          -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B0_runOnce_merge.vhd"                                                                           -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B0_runOnce_stall_region.vhd"                                                                 -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B0_runOnce_merge_reg.vhd"                                                                       -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pop_i1_wt_limpop_avg0.vhd"                                                                    -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pop_i1_wt_limpop_avg_reg.vhd"                                                                 -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i1_wt_limpush_avg2.vhd"                                                                  -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i1_wt_limpush_avg_reg.vhd"                                                               -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B1_start.vhd"                                                                                -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B1_start_branch.vhd"                                                                            -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B1_start_merge.vhd"                                                                             -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B1_start_stall_region.vhd"                                                                   -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_iord_bl_do_unnamed_avg1_avg14.vhd"                                                                -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_sfc_c0_wt_entry_avg_c0_enter_avg.vhd"                                                             -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_sfc_exit_c0_wt_entry_avg_c0_exit_avg10.vhd"                                                   -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_sfc_logic_c0_wt_entry_avg_c0_enter_avg4.vhd"                                                      -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pipeline_keep_going13_avg6.vhd"                                                               -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i1_notexitcond14_avg8.vhd"                                                               -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B1_start_merge_reg.vhd"                                                                         -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pop_i1_throttle_pop_avg12.vhd"                                                                -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pop_i1_throttle_pop_avg_reg.vhd"                                                              -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_ffwd_src_unnamed_avg2_avg15.vhd"                                                                  -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_ffwd_src_unnamed_avg3_avg17.vhd"                                                                  -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B2.vhd"                                                                                      -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B2_branch.vhd"                                                                                  -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B2_merge.vhd"                                                                                   -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B2_stall_region.vhd"                                                                         -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B2_merge_reg.vhd"                                                                               -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_sfc_c0_for_cond1_preheader_avg_c0_enter21_avg.vhd"                                                -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_sfc_exit_c0_for_cond1_preheader_avA0Z_c0_exit23_avg34.vhd"                                    -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_sfc_exit_c0_for_cond1_preheader_avA0Z_avg95_data_fifo.vhd"                                    -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_sfc_exit_c0_for_cond1_preheader_avA0Zvg_full_detector.vhd"                                    -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_sfc_logic_c0_for_cond1_preheader_avg_c0_enter21_avg19.vhd"                                        -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pipeline_keep_going9_avg21.vhd"                                                               -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pop_i32_i_03_pop9_avg23.vhd"                                                                  -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pop_i6_fpgaindvars_iv4_pop8_avg25.vhd"                                                        -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i1_notexitcond10_avg30.vhd"                                                              -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i32_i_03_push9_avg28.vhd"                                                                -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i6_fpgaindvars_iv4_push8_avg32.vhd"                                                      -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pop_i1_memdep_phi_pop10_avg35.vhd"                                                            -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pop_i1_memdep_phi_pop10_avg_reg.vhd"                                                          -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B5.vhd"                                                                                      -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B5_branch.vhd"                                                                                  -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/avg_B5_merge.vhd"                                                                                   -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/bb_avg_B5_stall_region.vhd"                                                                         -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i1_throttle_push_avg93.vhd"                                                              -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_push_i1_throttle_push_avg_reg.vhd"                                                            -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_iowr_bl_return_unnamed_avg5_avg92.vhd"                                                            -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pipeline_keep_going13_avg_sr.vhd"                                                             -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pipeline_keep_going13_avg_valid_fifo.vhd"                                                     -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pipeline_keep_going9_avg_sr.vhd"                                                              -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pipeline_keep_going9_avg_valid_fifo.vhd"                                                      -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pipeline_keep_going_avg_sr.vhd"                                                               -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/i_acl_pipeline_keep_going_avg_valid_fifo.vhd"                                                       -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/loop_limiter_avg0.vhd"                                                                              -work avg_internal_inst                                              
  eval  vcom $USER_DEFINED_VHDL_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS          "$QSYS_SIMDIR/submodules/loop_limiter_avg1.vhd"                                                                              -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_avm_to_ic.v"                                                       -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_ic_master_endpoint.v"                                              -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_arb_intf.v"                                                        -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_ic_intf.v"                                                         -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_ic_slave_endpoint.v"                                               -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_ic_slave_rrp.v"                                                    -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_ic_slave_wrp.v"                                                    -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_arb2.v"                                                            -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/acl_ic_to_avm.v"                                                       -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/avg_internal.v"                                                        -l altera_common_sv_packages -work avg_internal_inst                                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/tb_irq_mapper.sv"                                                      -l altera_common_sv_packages -work irq_mapper                                                     
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/hls_sim_stream_source_dpi_bfm.sv"                                      -l altera_common_sv_packages -work stream_source_dpi_bfm_avg_x_inst                               
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/tb_split_component_start_inst.sv"                                      -l altera_common_sv_packages -work split_component_start_inst                                     
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/altera_avalon_mm_slave_bfm.sv"                                         -l altera_common_sv_packages -work mm_slave_dpi_bfm_avg_avmm_0_rw_inst                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/hls_sim_mm_slave_dpi_bfm.sv"                                           -l altera_common_sv_packages -work mm_slave_dpi_bfm_avg_avmm_0_rw_inst                            
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/hls_sim_main_dpi_controller.sv"                                        -l altera_common_sv_packages -work main_dpi_controller_inst                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/tb_concatenate_component_done_inst.sv"                                 -l altera_common_sv_packages -work concatenate_component_done_inst                                
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/hls_sim_stream_sink_dpi_bfm.sv"                                        -l altera_common_sv_packages -work component_dpi_controller_avg_inst                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/hls_sim_stream_source_dpi_bfm.sv"                                      -l altera_common_sv_packages -work component_dpi_controller_avg_inst                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/hls_sim_component_dpi_controller.sv"                                   -l altera_common_sv_packages -work component_dpi_controller_avg_inst                              
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/hls_sim_clock_reset.sv"                                                -l altera_common_sv_packages -work clock_reset_inst                                               
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/submodules/tb_avg_inst.v"                                                                                      -work avg_inst                                                       
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/tb_avg_component_dpi_controller_implicit_ready_conduit_fanout_inst.sv" -l altera_common_sv_packages -work avg_component_dpi_controller_implicit_ready_conduit_fanout_inst
  eval  vlog  $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS      "$QSYS_SIMDIR/submodules/tb_avg_component_dpi_controller_bind_conduit_fanout_inst.sv"           -l altera_common_sv_packages -work avg_component_dpi_controller_bind_conduit_fanout_inst          
  eval  vlog -v2k5 $USER_DEFINED_VERILOG_COMPILE_OPTIONS $USER_DEFINED_COMPILE_OPTIONS "$QSYS_SIMDIR/tb.v"                                                                                                                                                                               
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim +access +r -t ps $ELAB_OPTIONS -L work -L altera_common_sv_packages -L avg_internal_inst -L irq_mapper -L stream_source_dpi_bfm_avg_x_inst -L split_component_start_inst -L mm_slave_dpi_bfm_avg_avmm_0_rw_inst -L main_dpi_controller_inst -L concatenate_component_done_inst -L component_dpi_controller_avg_inst -L clock_reset_inst -L avg_inst -L avg_component_dpi_controller_implicit_ready_conduit_fanout_inst -L avg_component_dpi_controller_bind_conduit_fanout_inst -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with -dbg -O2 option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -dbg -O2 +access +r -t ps $ELAB_OPTIONS -L work -L altera_common_sv_packages -L avg_internal_inst -L irq_mapper -L stream_source_dpi_bfm_avg_x_inst -L split_component_start_inst -L mm_slave_dpi_bfm_avg_avmm_0_rw_inst -L main_dpi_controller_inst -L concatenate_component_done_inst -L component_dpi_controller_avg_inst -L clock_reset_inst -L avg_inst -L avg_component_dpi_controller_implicit_ready_conduit_fanout_inst -L avg_component_dpi_controller_bind_conduit_fanout_inst -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cyclonev_ver -L cyclonev_hssi_ver -L cyclonev_pcie_hip_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cyclonev $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -dbg -O2
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                                         -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                                           -- Compile device library files"
  echo
  echo "com                                               -- Compile the design files in correct order"
  echo
  echo "elab                                              -- Elaborate top level design"
  echo
  echo "elab_debug                                        -- Elaborate the top level design with -dbg -O2 option"
  echo
  echo "ld                                                -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                                          -- Compile all the design files and elaborate the top level design with -dbg -O2"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                                    -- Top level module name."
  echo "                                                     For most designs, this should be overridden"
  echo "                                                     to enable the elab/elab_debug aliases."
  echo
  echo "SYSTEM_INSTANCE_NAME                              -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                                       -- Platform Designer base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR                               -- Quartus installation directory."
  echo
  echo "USER_DEFINED_COMPILE_OPTIONS                      -- User-defined compile options, added to com/dev_com aliases."
  echo
  echo "USER_DEFINED_ELAB_OPTIONS                         -- User-defined elaboration options, added to elab/elab_debug aliases."
  echo
  echo "USER_DEFINED_VHDL_COMPILE_OPTIONS                 -- User-defined vhdl compile options, added to com/dev_com aliases."
  echo
  echo "USER_DEFINED_VERILOG_COMPILE_OPTIONS              -- User-defined verilog compile options, added to com/dev_com aliases."
}
file_copy
h
