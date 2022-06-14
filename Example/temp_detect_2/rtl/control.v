module control( 
    input				clk		    ,
    input				rst_n	    ,

    input				din_sign    ,
    input		[23:0]  din		    ,
    input		    	din_vld 	,

    output  wire        dout_sign   ,
    output	wire[23:0]	dout	    ,
    output	reg	    	dout_vld	
);	
             
    //中间信号定义		 
    reg		[23:0]	din_r       ;
    reg             din_vld_r0  ;
    reg             din_vld_r1  ;

    wire    [7:0]   tmp_int_w   ;//整数部分
    reg     [7:0]   tmp_int_r   ;
    wire    [15:0]  tmp_dot_w   ;//小数部分
    reg     [15:0]  tmp_dot_r   ;

    wire	[3:0]	tmp_int_w2  ;
    wire	[3:0]	tmp_int_w1  ;
    wire	[3:0]	tmp_int_w0  ;

    reg 	[3:0]	tmp_int_r2  ;
    reg 	[3:0]	tmp_int_r1  ;
    reg 	[3:0]	tmp_int_r0  ;

    wire	[3:0]	tmp_dot_w3  ;
    wire	[3:0]	tmp_dot_w0  ;
    wire	[3:0]	tmp_dot_w1  ;
    wire	[3:0]	tmp_dot_w2  ;

    reg 	[3:0]	tmp_dot_r3  ;
    reg 	[3:0]	tmp_dot_r0  ;
    reg 	[3:0]	tmp_dot_r1  ;
    reg 	[3:0]	tmp_dot_r2  ;

//din_r 
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            din_r <= 0;
        end 
        else if(din_vld)begin 
            din_r <= din;
        end 
    end

//din_vld_r0  din_vld_r1
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            din_vld_r0 <= 0;
            din_vld_r1 <= 0;
        end 
        else begin 
            din_vld_r0 <= din_vld;
            din_vld_r1 <= din_vld_r0;
        end 
    end

    assign tmp_int_w = din_r/10000;
    assign tmp_dot_w = din_r%10000;

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            tmp_int_r <= 0;
        end 
        else if(din_vld_r0)begin 
            tmp_int_r <= tmp_int_w;
            tmp_dot_r <= tmp_dot_w;
        end 
    end

    assign tmp_int_w2 = tmp_int_r/100;//百位
    assign tmp_int_w1 = tmp_int_r/10%10 ;//十位
    assign tmp_int_w0 = tmp_int_r%10;//个位

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            tmp_int_r2 <= 0;
            tmp_int_r1 <= 0;
            tmp_int_r0 <= 0;
        end 
        else if(din_vld_r1)begin 
            tmp_int_r2 <= tmp_int_w2;
            tmp_int_r1 <= tmp_int_w1;
            tmp_int_r0 <= tmp_int_w0;
        end 
    end

    assign tmp_dot_w0 = tmp_dot_r/1000;
    assign tmp_dot_w1 = tmp_dot_r/100%10;
    assign tmp_dot_w2 = tmp_dot_r/10%10;
    assign tmp_dot_w3 = tmp_dot_r%10;

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            tmp_dot_r0 <= 0;
            tmp_dot_r1 <= 0;
            tmp_dot_r2 <= 0;
            tmp_dot_r3 <= 0;
        end 
        else if(din_vld_r1)begin 
            tmp_dot_r0 <= tmp_dot_w0;
            tmp_dot_r1 <= tmp_dot_w1;
            tmp_dot_r2 <= tmp_dot_w2;
            tmp_dot_r3 <= tmp_dot_w3;
        end 
    end

    assign dout = {tmp_int_r1,tmp_int_r0,tmp_dot_r0,tmp_dot_r1,tmp_dot_r2,tmp_dot_r3}; 

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout_vld <= 1'b0;
        end 
        else begin 
            dout_vld <= din_vld_r1; 
        end 
    end

    assign dout_sign = din_sign;

endmodule