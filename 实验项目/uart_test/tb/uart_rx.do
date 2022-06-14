#tcl脚本  自动化仿真                         
#创建工作库 名为work                       
vlib work                       
                                    
#映射工作库 work 到 work                   
vmap work work                           
   
#编译testbench文件                     
vlog uart_rx_tb.v                       
                                                    
                                
                                                          
#编译被仿真文件                                                
vlog ../rtl/uart_tx.v                                                                           
vlog ../rtl/param.v  
vlog ../rtl/uart_rx.v                                           
                                                           
                                  
                                                             
#指定仿真顶层                                                 
vsim -novopt work.uart_rx_tb
                                                            
#添加testbench顶层模块中的信号到波形窗
add wave -position insertpoint sim:uart_rx_tb//*            
                                                                                                               
                                                             
#一直仿真下去                                                 
run -all    