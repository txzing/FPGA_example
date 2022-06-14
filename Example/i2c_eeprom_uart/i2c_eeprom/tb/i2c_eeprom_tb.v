`timescale 1ns/1ns
                
module i2c_eeprom_tb();
//激励信号定义 
    reg				        clk  	    ;
    reg				        rst_n	    ;
    reg     [7:0]			uart_din    ;
    reg				        uart_din_vld;
   
//输出信号定义	 
    wire	            	uart_txd	;

    wire                    i2c_scl     ;
    wire                    i2c_sda     ;
    wire	        		tx_rdy      ;
    wire                    uart_tx_dout;  


//时钟周期参数定义					        
    parameter		CLOCK_CYCLE = 20;    

uart_tx u_uart_tx(
    .clk     (clk           ),
    .rst_n   (rst_n         ),
    .din     (uart_din      ),
    .din_vld (uart_din_vld  ),
    .rdy     (tx_rdy        ),//ready 表示串口发送模块可以接收数据并发送
    .dout    (uart_tx_dout  )    
);

i2c_eeprom u_i2c_eeprom(
    .clk        (clk            ),
    .rst_n      (rst_n          ),

    .uart_rxd   (uart_tx_dout   ),
    .uart_txd   (uart_txd       ),

    .i2c_scl    (i2c_scl        ),
    .i2c_sda    (i2c_sda        )    
);

i2c_slave_model i2c_slave(
    .scl        (i2c_scl        ), 
    .sda        (i2c_sda        )
);

//产生时钟							       		
    initial 	clk = 1'b0;		       		
    always #(CLOCK_CYCLE/2) clk = ~clk;  		

    task SEND;  
        input   [7:0]   wr_data     ;   
        begin
            # 1; 
            uart_din = wr_data;
            uart_din_vld = 1'b1;
            #(CLOCK_CYCLE);
            uart_din_vld = 1'b0;
            @(posedge tx_rdy);
            #(CLOCK_CYCLE*5);
        end 
    endtask 

    integer i = 0;

//产生激励							       		
    initial  begin						       		
        rst_n = 1'b0;								
        uart_din = 0;   
        uart_din_vld = 0;						
        #(CLOCK_CYCLE*20);				            
        rst_n = 1'b1;							
        #(CLOCK_CYCLE*20);	

        for(i=0;i<10;i=i+1)begin 
            //发数据
            SEND(8'h55);    //起始符
            SEND(8'haa);    //写数据指示信号                                         

            SEND(8'h55);    //数据                                          
            SEND(8'h35);    //数据 
            SEND(8'h55);    //数据 
            SEND(8'h67);    //数据 
            SEND(8'hfe);    //数据 
            SEND(8'h8c);    //数据 
            SEND(8'ha2);    //数据 
            SEND(8'hb7);    //数据 
            SEND(8'ha9);    //数据 
            SEND(8'hd0);    //数据 
            SEND(8'h53);    //数据 

            SEND(8'h04);    //结束符
            SEND(8'h0d);    //结束符
            #(CLOCK_CYCLE*200);	    
        
            //发写请求
            SEND(8'h55);    //起始符
            SEND(8'h00);    //写请求 block0
            SEND(8'ha3);    //写地址
            SEND(8'h04);    //结束符
            SEND(8'h0d);    //结束符

            //@(posedge u_i2c_eeprom.u_eeprom_control.wait_wdone2done);
            #(CLOCK_CYCLE*200);	
            //发读请求
            SEND(8'h55);    //起始符
            SEND(8'h10);    //写请求    block0
            SEND(8'ha3);    //读地址
            SEND(8'h04);    //结束符
            SEND(8'h0d);    //结束符
            #(CLOCK_CYCLE*200);	
        end 
        #(CLOCK_CYCLE*200);	
        $stop;
    end 									       	
endmodule 									       	