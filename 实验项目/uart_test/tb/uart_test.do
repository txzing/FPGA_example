#tcl�ű�  �Զ�������                         
#���������� ��Ϊwork                       
vlib work                       
                                    
#ӳ�乤���� work �� work                   
vmap work work                           
   
#����testbench�ļ�                     
vlog uart_test_tb.v                       
                                                    
vlog altera_mf.v                                
vlog ../ip/SYNC_FIFO/sync_fifo.v

#���뱻�����ļ�                                                
vlog ../rtl/uart_tx.v                                                                           
vlog ../rtl/param.v  
vlog ../rtl/uart_rx.v 
vlog ../rtl/uart_test.v    
vlog ../rtl/control.v       

   
                                                           
                                  
                                                             
#ָ�����涥��                                                 
vsim -novopt work.uart_test_tb
                                                            
#���testbench����ģ���е��źŵ����δ�
add wave -position insertpoint sim:uart_test_tb//*            
                                                                                                               
                                                             
#һֱ������ȥ                                                 
run -all    