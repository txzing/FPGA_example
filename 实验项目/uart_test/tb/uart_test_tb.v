`timescale 1ns/1ns
module uart_test_tb();
//�����źŶ��� 
reg				tb_clk  	;
reg				tb_rst_n	;
reg	  [7:0]	    tx_din   	;
reg				tx_din_vld	;

wire            tx;
wire            busy;
 
wire            tb_tx;

//ʱ�����ڲ�������					        
    parameter		CLOCK_CYCLE = 20;    
                                          
uart_tx  u_uart_tx( 
/*input			*/.clk		 (tb_clk),
/*input			*/.rst_n	 (tb_rst_n),
/*input  [7:0]  */.tx_din    (tx_din),//����������
/*input         */.tx_din_vld(tx_din_vld),//ָʾ��ʼ��������
/*output   reg  */.tx        (tx),//��ת��
/*output   reg  */.busy      (busy)
);


uart_test  u_uart_test(
/*input   */.sys_clk   (tb_clk),
/*input   */.sys_rst_n (tb_rst_n),
/*input   */.rx        (tx),
/*output  */.tx        (tb_tx)
);

//����ʱ��							       		
initial 		tb_clk = 1'b0;		       		
always #(CLOCK_CYCLE/2) tb_clk = ~tb_clk;  		
                                                   
//��������							       		
initial  begin
    tx_din_vld = 1'b0 ;						       		
    tb_rst_n = 1'b1;															
    #(CLOCK_CYCLE*2);				            
    tb_rst_n = 1'b0;							
    #(CLOCK_CYCLE*20);				            
    tb_rst_n = 1'b1;							

    send_data(8'hAA);    
    send_data(8'h55); 
    send_data(8'hef);  
    send_data(8'hae);
    send_data(8'h11);    
    send_data(8'h22); 
    send_data(8'h33);  
    send_data(8'h44);     
    //$stop;                                          
                                                                                                    
end


/*�������һ�η�װ�ڡ�task-endtask��֮��ĳ���������ͨ��������ִ�еģ�����ֻ��
�ڵ���ʱ��ִ�У�������������񣬵��������������ж�û�е���������ô��������ǲ���
ִ�еġ�����ĳ������ʱ������Ҫ������ĳЩ���ݲ����ز����������������Ӧ���н�����
�ݵ�����˺ͷ������ݵ�����ˡ����⣬������Ա˴˵��ã����������ڻ����Ե��ú�����*/
    task  send_data;
        input [7:0]   data;
    begin
        #(CLOCK_CYCLE*20);
        #2
        tx_din_vld = 1'b1;
        tx_din = data;
        #(CLOCK_CYCLE);
        tx_din_vld = 1'b0;
        @(negedge busy);
    end
    endtask
endmodule
