`timescale 1ns/1ns
module uart_test_tb();
//激励信号定义 
reg				tb_clk  	;
reg				tb_rst_n	;
reg	  [7:0]	    tx_din   	;
reg				tx_din_vld	;

wire            tx;
wire            busy;
 
wire            tb_tx;

//时钟周期参数定义					        
    parameter		CLOCK_CYCLE = 20;    
                                          
uart_tx  u_uart_tx( 
/*input			*/.clk		 (tb_clk),
/*input			*/.rst_n	 (tb_rst_n),
/*input  [7:0]  */.tx_din    (tx_din),//待发送数据
/*input         */.tx_din_vld(tx_din_vld),//指示开始发送数据
/*output   reg  */.tx        (tx),//并转串
/*output   reg  */.busy      (busy)
);


uart_test  u_uart_test(
/*input   */.sys_clk   (tb_clk),
/*input   */.sys_rst_n (tb_rst_n),
/*input   */.rx        (tx),
/*output  */.tx        (tb_tx)
);

//产生时钟							       		
initial 		tb_clk = 1'b0;		       		
always #(CLOCK_CYCLE/2) tb_clk = ~tb_clk;  		
                                                   
//产生激励							       		
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


/*任务就是一段封装在“task-endtask”之间的程序。任务是通过调用来执行的，而且只有
在调用时才执行，如果定义了任务，但是在整个过程中都没有调用它，那么这个任务是不会
执行的。调用某个任务时可能需要它处理某些数据并返回操作结果，所以任务应当有接收数
据的输入端和返回数据的输出端。另外，任务可以彼此调用，而且任务内还可以调用函数。*/
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
