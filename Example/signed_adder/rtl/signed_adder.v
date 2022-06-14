module signed_adder(    //有符号数加法
    input				        clk		,
    input				        rst_n	,

    input   wire signed [7:0]   din_a	,
    input	wire signed	[7:0]	din_b 	,
    input   wire                din_vld ,
    output	wire signed	[8:0]	dout0   ,
    output  wire signed [8:0]   dout1	,
    output  wire                dout_vld    
);								 

    //中间信号定义		 
    reg     signed  [8:0]   sum0     ;    
    reg     signed  [8:0]   sum1     ;    

    //sum
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            sum0 <= 0;
            sum1 <= 0;
        end 
        else begin  
/*
verilog中的加法和乘法操作前，会先对操作数据扩位成结果相同的位宽，然后进行加法或者乘法处理。比如a/b都为4位数据，
c为5位数据，c = a + b，这个运算的时候会先把a和b扩位成5位，然后按照无符号加法进行相加。
*/
            sum0 <= din_a + din_b;   //第一种计算方法，自动增加位宽
            sum1 <= {din_a[7],din_a} + {din_b[7],din_b};   //第二种计算方法，手动增加位宽
        end 
    end

    assign dout0 = sum0;
    assign dout1 = sum1;
    assign dout_vld = din_vld;

endmodule