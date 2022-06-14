module mult( 
    input				        clk		,
    input				        rst_n	,

    input   wire    [7:0]       din_a	,
    input	wire    [7:0]	    din_b 	,
    input   wire                din_vld ,
    output	wire    [15:0]	    dout0   ,
    output  wire    [15:0]      dout1	,
    output  wire                dout_vld    
);								 

    //中间信号定义		 
    reg       [15:0]   product0     ;    
    reg       [15:0]   product1     ;    

    //sum
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            product0 <= 0;
            product1 <= 0;
        end 
        else begin 
            product0 <= din_a * din_b; 
            product1 <= {{8{din_a[7]}},din_a} * {{8{din_b[7]}},din_b};
        end 
    end

    assign dout0 = product0;
    assign dout1 = product1;
    assign dout_vld = din_vld;

endmodule