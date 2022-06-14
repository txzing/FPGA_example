`timescale 1ps/1ps
`include "../rtl/param.v"       

module cap_tb();
//激励信号定义 
    reg                 clk		    ;
    reg                 rst_n	    ;
    reg     [7:0]       cmos_din	;
    reg                 cmos_vsync  ;
    reg                 cmos_href   ;
    reg                 cap_en      ;

//输出信号定义	 
    wire    [15:0]      pixel   	;
    wire                pixel_vld   ;
    wire                pixel_sop   ;
    wire                pixel_eop   ;

//时钟周期参数定义					        
    parameter		CLOCK_CYCLE = 20;    
                                          
capture u_cap( 
    /*input				*/.clk		    (clk		),   //pclk
    /*input				*/.rst_n	    (rst_n	    ),
    /*input		[7:0]	*/.cmos_din	    (cmos_din	),
    /*input		        */.cmos_vsync	(cmos_vsync ),
    /*input		        */.cmos_href 	(cmos_href  ),
    /*input             */.cap_en       (cap_en     ),//采集使能信号
    /*output	[15:0]	*/.pixel   	    (pixel   	),
    /*output		    */.pixel_vld	(pixel_vld  ),
    /*output            */.pixel_sop    (pixel_sop  ),//数据包文头
    /*output            */.pixel_eop    (pixel_eop  )//数据包文尾
);	
//产生时钟							       		
initial 		clk = 1'b1;		       		
always #(CLOCK_CYCLE/2) clk = ~clk;  		

    integer i , j ;                                    
//产生激励							       		
initial  begin						       		
    rst_n = 1'b0;								
    cmos_din	= 0;
    cmos_vsync  = 0;
    cmos_href   = 0;
    cap_en      = 0;								
    #(CLOCK_CYCLE*20);				            
    rst_n = 1'b1;		
    #(CLOCK_CYCLE*20);							
    cap_en      = 1;      
    #(CLOCK_CYCLE*20);	
    repeat(5)begin 		                                         
        cmos_vsync = 1'b1;    
        #(CLOCK_CYCLE*50);	
        cmos_vsync = 1'b0;
        #(CLOCK_CYCLE*50);	
        #2;
        for(i=0;i<`IMG_H;i=i+1)begin 
            cmos_href   = 1;
            for(j=0;j<(`IMG_W<<1);j=j+1)begin 
                cmos_din	= {$random};
                #(CLOCK_CYCLE*1);	
            end 
            #(CLOCK_CYCLE*10);	
        end 
        #(CLOCK_CYCLE*50);	
    end     

    #(CLOCK_CYCLE*50);	
    $stop;                                       
                                                   
end 									       	
endmodule 									       	
