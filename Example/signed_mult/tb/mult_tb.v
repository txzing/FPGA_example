`timescale 1ns/1ns
                
module mult_tb();
//�����źŶ��� 
reg				        tb_clk  	;
reg				        tb_rst_n	;

reg     signed  [7:0]   tb_din0		;//�з������͵�����
reg     signed  [7:0]   tb_din1		;
reg                     tb_din_vld  ;
//����źŶ���	 
wire    signed  [15:0]  tb_dout0	;
wire    signed  [15:0]  tb_dout1    ;
wire                    tb_dout_vld ;

reg     signed  [7:0]   data_0      ;
reg     signed  [7:0]   data_1      ;           

//ʱ�����ڲ�������					        
    parameter		CLOCK_CYCLE = 20;    
                                          
mult u_mult( 
    /*input				            */.clk	        (tb_clk     ),
    /*input				            */.rst_n        (tb_rst_n   ),
    /*input     wire signed [7:0]   */.din_a        (tb_din0    ),
    /*input	    wire signed	[7:0]	*/.din_b        (tb_din1    ),
    /*input     wire                */.din_vld      (tb_din_vld ),
    /*outpu     wire signed	[15:0]	*/.dout0        (tb_dout0   ),
    /*output    wire signed [15:0]  */.dout1        (tb_dout1   ),
    /*output    wire                */.dout_vld     (tb_dout_vld)
);				
//����ʱ��							       		
initial 		tb_clk = 1'b0;		       		
always #(CLOCK_CYCLE/2) tb_clk = ~tb_clk;  		

    integer file_0,file_1;
    initial file_0 = $fopen("mult_file0.txt");     
    initial file_1 = $fopen("mult_file1.txt");     

//��������							       		
initial  begin						       		
    tb_rst_n = 1'b0;								
    tb_din0 = 0;
    tb_din1 = 0;	
    tb_din_vld = 0;				
    #(CLOCK_CYCLE*20);				            
    tb_rst_n = 1'b1;							
    #(CLOCK_CYCLE*20);		                                          
    repeat(20)begin 
        tb_din0 = $random;
        tb_din1 = $random;
        tb_din_vld = 1'b1;
        #(CLOCK_CYCLE*1);
    end      
    tb_din0 = 0;
    tb_din1 = 0;          
    tb_din_vld = 0;                                 
    #(CLOCK_CYCLE*20);
    $stop;                                                  
end 	

    
    always @(posedge tb_clk)begin 
        if(tb_dout_vld)begin   
            $fdisplay(file_0,"%d * %d = %d",data_0,data_1,tb_dout0);   //����Ҫ�������������ݱ仯��д�룬�Զ�����
            $fdisplay(file_1,"%d * %d = %d",data_0,data_1,tb_dout1);   //����Ҫ�������������ݱ仯��д�룬�Զ�����  
        end 
    end

    always @(posedge tb_clk or negedge tb_rst_n)begin 
        if(!tb_rst_n)begin
            data_0 <= 0;
            data_1 <= 0;
        end 
        else begin 
            data_0 <= tb_din0;
            data_1 <= tb_din1;
        end 
    end

endmodule 									       	