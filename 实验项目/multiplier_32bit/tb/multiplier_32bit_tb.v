`timescale 1ns/1ns
                
module multiplier_32bit_tb();
//激励信号定义 
    reg				clk  	    ;
    reg				rst_n	    ;

    reg     [31:0]  din_a  		;
    reg		[31:0]  din_b  		;
    reg				din_vld		;
//输出信号定义	 
    wire	[63:0]  dout	    ;
    wire	        dout_vld    ;
                                          
//时钟周期参数定义					        
    parameter		CLOCK_CYCLE = 20;    
                                          
multiplier_32bit multiplier_32bit(
    .clk        (clk        ),
    .rst_n      (rst_n      ),

    .din_a      (din_a      ),
    .din_b      (din_b      ),
    .din_vld    (din_vld    ),

    .dout       (dout       ),
    .dout_vld   (dout_vld   )    
);
//产生时钟							       		
    initial 		clk = 1'b0;		       		
    always #(CLOCK_CYCLE/2) clk = ~clk;  		

    integer i = 0;

//产生激励							       		
    initial  begin						       		
        rst_n = 1'b0;								
        din_a   = 0;
        din_b   = 0;
        din_vld = 0;								
        #(CLOCK_CYCLE*20);				            
        rst_n = 1'b1;							
        #(CLOCK_CYCLE*20);	
        for(i=0;i<20;i=i+1)begin 
            din_a   = {$random};
            din_b   = {$random};
            din_vld = 1'b1;
            #(CLOCK_CYCLE*1);	
        end 
        din_a   = 0;
        din_b   = 0;
        din_vld = 0;                                           
        #(CLOCK_CYCLE*20);	
        $stop;                                           
                                                   
    end 									       	
endmodule
