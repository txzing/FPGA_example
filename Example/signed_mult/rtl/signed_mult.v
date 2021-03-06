module signed_mult(     //有符号数乘法
    input				        clk		,
    input				        rst_n	,

    input   wire signed [7:0]   din_a	,
    input	wire signed	[7:0]	din_b 	,
    input   wire                din_vld ,
    output	wire signed	[15:0]	dout0   ,
    output  wire signed [15:0]  dout1	,
    output  wire                dout_vld    
);								 

    //中间信号定义		 
    reg     signed  [15:0]   product0     ;    
    reg     signed  [15:0]   product1     ;    

    //sum
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            product0 <= 0;
            product1 <= 0;
        end 
        else begin
/*
如果想把a、b作为有符号数来相乘，那么就得在a/b数据定义的时候用signed修改，
或者在计算的时候用$signed()来修饰，这样在c = a * b，这个运算开始的扩位就会按照有符号数的方式进行扩位，
在高位补符号位，乘法得出的结果就是a、b视为有符号数的结果。当然c要视为有符号数据。
*/
            product0 <= din_a * din_b;      //第一种计算方法，自动扩展位宽
        //    product1 <= {{8{din_a[7]}},din_a} * {{8{din_b[7]}},din_b};  //手动扩展位宽

            product1 <= $signed(din_a) * $signed(din_b);  //强制转换
        end 
    end

    assign dout0 = product0;
    assign dout1 = product1;
    assign dout_vld = din_vld;

endmodule