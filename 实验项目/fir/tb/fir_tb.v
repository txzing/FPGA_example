`timescale 1ns/1ns
                
module fir_tb();
//激励信号定义 
    reg				tb_clk  	;
    reg				tb_rst_n	;
    reg     [7:0]   tb_din 		;
    reg				tb_din_vld  ;
//输出信号定义	 
    wire	[7:0]	tb_dout 	;
    wire	    	tb_dout_vld ;
                                          
//时钟周期参数定义					        
    parameter		CLOCK_CYCLE = 20;    
    parameter       LEN         = 32;   

    fir u_fir(
	   .clock   (tb_clk     ),
	   .reset   (tb_rst_n   ),
	   .vin     (tb_din_vld ),
	   .din     (tb_din     ),
	   .vout    (tb_dout_vld),
	   .dout    (tb_dout    )
	   );
//产生时钟							       		
    initial 		tb_clk = 1'b0;		       		
    always #(CLOCK_CYCLE/2) tb_clk = ~tb_clk;  		

    integer i = 0,j=0,k=0;
    integer wr_file0,wr_file1;

    initial wr_file0 = $fopen("input_data.txt");     //以只写的方式打开data.txt文件 
    initial wr_file1 = $fopen("output_result.txt");  //以只写的方式打开result.txt文件 
//产生激励							       		
    initial  begin						       		
        tb_rst_n = 1'b0;								
        tb_din = 0;	
        tb_din_vld = 0;							
        #(CLOCK_CYCLE*20);				            
        tb_rst_n = 1'b1;
        #(CLOCK_CYCLE*20);	
        for(i=0;i<5;i=i+1)begin 
            #2; 
            for(j=0;j<LEN;j=j+1)begin 
                tb_din = {$random};
                tb_din_vld = 1'b1;
                $fdisplay(wr_file0,"a[%d] = %d ",i*LEN+j,tb_din);      //将测试数据写入文件以便检查 自动换行 
                #(CLOCK_CYCLE*1);	
            end 	
            tb_din = 0;	
            tb_din_vld = 0;	
            #(CLOCK_CYCLE*20);
        end 	
        $stop;                                            
    end 
    always @(posedge tb_clk)begin 
        if(tb_dout_vld)begin 
            $fdisplay(wr_file1,"b[%d] is %d",k,tb_dout);  //自动换行
            k = k + 1;
        end 
    end


endmodule 									       	