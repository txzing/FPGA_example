#tcl�ű�  �Զ�������                         
#���������� ��Ϊwork                       
vlib work                       
                                    
#ӳ�乤���� work �� work                   
vmap work work                           
   
#����testbench�ļ�                     
vlog uart_tx_tb.v                       
                                                    
                                
                                                          
#���뱻�����ļ�                                                
vlog ../rtl/uart_tx.v                                                                           
vlog ../rtl/param.v                                          
                                                           
                                  
                                                             
#ָ�����涥��                                                 
vsim -novopt work.uart_tx_tb
                                                            
#���testbench����ģ���е��źŵ����δ�
add wave -position insertpoint sim:uart_tx_tb//*            
                                                                                                               
                                                             
#һֱ������ȥ                                                 
run -all    