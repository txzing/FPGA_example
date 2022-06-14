`timescale 1ns/1ns
`include "../rtl/param.v"

module ov5640_cfg_tb();
//激励信号定义 
    reg		    clk  	    ;
    reg		    rst_n	    ;

//输出信号定义	 
    wire        sio_c       ;
    wire        sio_d       ;
    wire        cfg_done    ;
                                          
//时钟周期参数定义					        
    parameter		CLOCK_CYCLE = 20;    


    ov5640_config u_config(
    /*input           */.clk     (clk       ),
    /*input           */.rst_n   (rst_n     ),
    //摄像头接口
    /*output          */.sio_c   (sio_c     ),
    /*inout           */.sio_d   (sio_d     ),
    /*output          */.cfg_done(cfg_done  ) //初始化配置完成
);
                                     
    i2c_slave_model u_slave(
    .scl    (sio_c      )  , 
    .sda    (sio_d      )  
);

    defparam u_config.u_i2c_cfg.WAIT_TIME = 10;
//产生时钟							       		
    initial 		clk = 1'b0;		       		
    always #(CLOCK_CYCLE/2) clk = ~clk;  		
                                                   
//产生激励							       		
initial  begin						       		
    rst_n = 1'b0;																
    #(CLOCK_CYCLE*20);				            
    rst_n = 1'b1;							
                                      
    @(posedge cfg_done);
    #(CLOCK_CYCLE*200);	
    $stop;		                                               
                                                   
end 									       	
endmodule 									       	
