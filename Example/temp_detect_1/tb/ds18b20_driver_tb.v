`timescale 1ns/1ns
                
module ds18b20_driver_tb();
//激励信号定义 
    reg               clk         ;
    reg               rst_n       ;
    reg               dq_in       ;

//输出信号定义	 
    wire              dq_out      ;
    wire              dq_out_en   ;
    wire              temp_sign   ;
    wire     [23:0]   temp_out    ;
    wire              temp_out_vld;
                                          
//时钟周期参数定义					        
    parameter		CLOCK_CYCLE = 20;    
                                          
    ds18b20_driver u_ds18b20_driver(
    .clk          (clk          ),
    .rst_n        (rst_n        ),
    .dq_in        (dq_in        ),
    .dq_out       (dq_out       ),
    .dq_out_en    (dq_out_en    ), 
    .temp_sign    (temp_sign    ),//温度值符号位 0：正 1：负温
    .temp_out     (temp_out     ),
    .temp_out_vld (temp_out_vld )           
    );

    defparam    u_ds18b20_driver.TIME_RST = 200,
                u_ds18b20_driver.TIME_PRE = 100,
                u_ds18b20_driver.TIME_WAIT = 750;

//产生时钟							       		
    initial 		clk = 1'b0;		       		
    always #(CLOCK_CYCLE/2) clk = ~clk;  		

    integer  i=0;  

//产生激励							       		
    initial  begin						       		
        rst_n = 1'b0;								
        dq_in = 0;								
        #(CLOCK_CYCLE*20);				            
        rst_n = 1'b1;							
        repeat(5)begin
            for(i=0;i<500000;i=i+1)begin 
                dq_in = {$random};
                #(CLOCK_CYCLE*20);		
            end 
            #(CLOCK_CYCLE*20);	
        end 
        $stop;
    end 

endmodule



