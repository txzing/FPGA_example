`timescale 1ns/1ns
                
module imp_tb();
//激励信号定义 
reg				clk  	    ;
reg				rst_n	    ;
reg     [15:0]  din	        ;
reg             din_vld     ;
reg             din_sop     ;
reg             din_eop     ;


//输出信号定义	 
wire    [15:0]  dout	    ;
wire            dout_vld    ;
wire            dout_sop    ;
wire            dout_eop    ;
                                          
//时钟周期参数定义					        
    parameter		CLOCK_CYCLE = 20;    
                                          
img_process u_imp( 
    /*input				*/.clk		(clk	    ),
    /*input				*/.rst_n	(rst_n      ),
    /*input		[15:0]  */.din		(din	    ),
    /*input		    	*/.din_vld	(din_vld    ),
    /*input             */.din_sop  (din_sop    ),
    /*input             */.din_eop  (din_eop    ),
    /*output	[15:0]	*/.dout	    (dout	    ),
    /*output	        */.dout_vld (dout_vld   ),
    /*output            */.dout_sop (dout_sop   ),
    /*output            */.dout_eop (dout_eop   ) 
);				
//产生时钟							       		
    initial 		clk = 1'b0;		       		
    always #(CLOCK_CYCLE/2) clk = ~clk;  		

    integer i , j;                                      
//产生激励							       		
initial  begin						       		
    rst_n = 1'b0;								
    din	    = 0;
    din_vld = 0;
    din_sop = 0;
    din_eop = 0;
    #(CLOCK_CYCLE*20);				            
    rst_n = 1'b1;							

    for(i=0;i<720;i=i+1)begin 
        for(j=0;j<1280;j=j+1)begin 
            din	    = {$random};
            din_vld = 1'b1;
            din_sop = (i==0 && j == 0)?1'b1:1'b0;
            din_eop = (i==719 && j==1279)?1'b1:1'b0;
            #(CLOCK_CYCLE*1);
        end 
    end 
    din	    = 0;
    din_vld = 0;
    din_sop = 0;
    din_eop = 0;

    #(CLOCK_CYCLE*20);
    $stop;
                                      
end 									       	
endmodule 									       	
