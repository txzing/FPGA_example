vlib work
vmap work work
                                            
#����testbench�ļ�					       	
vlog    mult_tb.v
#���� 	����ļ�					       	 
vlog ../rtl/mult.v

                                                
#ָ�����涥�� 							     
vsim -novopt work.mult_tb 
#����źŵ����δ� 							  
add wave -position insertpoint sim:/mult_tb//*