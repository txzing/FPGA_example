#tcl�ű�  �Զ�������                         
#���������� ��Ϊwork                       
vlib work                       
                                    
#ӳ�乤���� work �� work                   
vmap work work                           
   
#����testbench�ļ�                     
vlog uart_rx_tb.v                       
                                                    
                                
                                                          
#���뱻�����ļ�                                                
vlog ../rtl/uart_tx.v                                                                           
vlog ../rtl/param.v  
vlog ../rtl/uart_rx.v                                           
                                                           
                                  
                                                             
#ָ�����涥��                                                 
vsim -novopt work.uart_rx_tb
                                                            
#���testbench����ģ���е��źŵ����δ�
add wave -position insertpoint sim:uart_rx_tb//*            
                                                                                                               
                                                             
#һֱ������ȥ                                                 
run -all    