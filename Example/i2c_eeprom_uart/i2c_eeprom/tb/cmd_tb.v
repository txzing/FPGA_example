`timescale 1ns/1ns
                
module cmd_tb();
//激励信号定义 
    reg               clk     ;
    reg               rst_n   ;
    reg       [7:0]   din     ;//串口接收模块接口
    reg               din_vld ;

//输出信号定义	 
    wire      [7:0]   dout    ;//写入FIFO的数据
    wire              dout_vld;
    wire              wr_en   ;//写请求
    wire              rd_en   ;//读请求
    wire      [8:0]   addr    ;//读写地址
                                          
//时钟周期参数定义					        
    parameter		CLOCK_CYCLE = 20;    
                                          
cmd_analy u_cmd_analy(  //命令帧解析模块
    /*input               */.clk     (clk       ),
    /*input               */.rst_n   (rst_n     ),
    /*input       [7:0]   */.din     (din       ),//串口接收模块接口
    /*input               */.din_vld (din_vld   ),
    /*output  reg [7:0]   */.dout    (dout      ),//写入FIFO的数据
    /*output  reg         */.dout_vld(dout_vld  ),
    /*output  reg         */.wr_en   (wr_en     ),//写请求
    /*output  reg         */.rd_en   (rd_en     ),//读请求
    /*output  reg [8:0]   */.addr    (addr      ) //读写地址
); 

//产生时钟							       		
initial 		clk = 1'b0;		       		
always #(CLOCK_CYCLE/2) clk = ~clk;  		

    task SEND;  
        input   [7:0]   wr_data     ;   
        begin
            # 1; 
            din = wr_data;
            din_vld = 1'b1;
            #(CLOCK_CYCLE);
            din_vld = 1'b0;
            #(CLOCK_CYCLE*5);
        end 
    endtask   

//产生激励							       		
    initial  begin						       		
        rst_n = 1'b0;								
        din     = 0;  
        din_vld	= 0;							
        #(CLOCK_CYCLE*20);				            
        rst_n = 1'b1;	
        #(CLOCK_CYCLE*20);

        //写数据测试						
        SEND(8'h55);    //帧起始符
        SEND(8'haa);    //写数据指示
        SEND(8'hcd);    //写入FIFO的数据   
        SEND(8'h35);    //写入FIFO的数据                                           
        SEND(8'h78);    //写入FIFO的数据   
        SEND(8'hc5);    //写入FIFO的数据   
        SEND(8'h2d);    //写入FIFO的数据   
        SEND(8'h18);    //写入FIFO的数据 
        SEND(8'hf4);    //写入FIFO的数据  
        SEND(8'hb7);    //写入FIFO的数据
        SEND(8'h04);    //帧结束符
        SEND(8'h0d);    //帧结束符                                                 
        #(CLOCK_CYCLE*20);

        //写请求测试
        SEND(8'h55);    //帧起始符
        SEND(8'h00);    //写请求 写block0
        SEND(8'hcd);    //写数据的地址
        SEND(8'h04);    //帧结束符
        SEND(8'h0d);    //帧结束符 
        #(CLOCK_CYCLE*20);   

        //读请求测试
        SEND(8'h55);    //帧起始符
        SEND(8'h10);    //读请求 读block0
        SEND(8'hcd);    //读数据的地址
        SEND(8'h04);    //帧结束符
        SEND(8'h0d);    //帧结束符 
        #(CLOCK_CYCLE*20);   
        $stop;
    end 	

endmodule 									       	