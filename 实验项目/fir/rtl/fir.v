`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Tensorchip Co Ltd.
// Create Date: 04/08/2020 11:35:46 AM
// Revision 0.01 - File Created
// Additional Comments:实现滑动平均滤波，滑动窗口为5。
//做了时序优化，最大能够达到150MHz。
//////////////////////////////////////////////////////////////////////////////////


module fir(
	   clock,
	   reset,
	   vin,     //valid datain
	   din,
	   vout,
	   dout
	   );
   input clock;            // clock : system clock
   input reset;            // reset : synchronized reset
   input vin;              // vin   : valid input. high effective输入有效
   input [7:0] din;        // din   : input data sequence输入
   output  reg    vout;       // vout  : valid output, high effective输出有效
   output reg [7:0]	 dout;
//信号定义
    reg						vin_ff0;
    reg						vin_ff1;
    reg						vin_ff2;
    reg						vin_ff3;
    reg						vin_ff4;
    reg                     vin_ff5;
   
    reg		[7:0]			din_ff0;
    reg		[7:0]			din_ff1;
    reg		[7:0]			din_ff2;
    reg		[7:0]			din_ff3;
    reg		[7:0]			din_ff4;
    
    wire	[10:0]			sum0_w0  ;  //第一级流水
    wire	[10:0]			sum0_w1  ;

    reg		[10:0]			sum0_r0  ;
    reg		[10:0]			sum0_r1  ;
    reg     [10:0]          sum0_r2  ;
    
    wire	[10:0]			sum1_w0  ;  //第二级流水
    reg		[10:0]			sum1_r0  ;

    wire    [15:0]          prod_w0  ;  //第三级流水线
    reg     [15:0]          prod_r0  ;  

    wire    [11:0]          ave_w0   ;  //第四级输出
    reg     [11:0]          ave_r0   ;

   //打拍
	always @(posedge clock or negedge reset)begin
		if(~reset)begin
			din_ff0 <= 1'b0;
			din_ff1 <= 1'b0;
	        din_ff2 <= 1'b0;
			din_ff3 <= 1'b0;
            din_ff4 <= 1'b0;
            vin_ff5 <= 1'b0;
		end
		else if(vin)begin
			din_ff0 <= din    ;
			din_ff1 <= din_ff0;
			din_ff2 <= din_ff1;
			din_ff3 <= din_ff2;
			din_ff4 <= din_ff3;
            vin_ff5 <= vin_ff4;
		end
        else begin 
            din_ff0 <= 0    ;
			din_ff1 <= din_ff0;
			din_ff2 <= din_ff1;
			din_ff3 <= din_ff2;
			din_ff4 <= din_ff3;
            vin_ff5 <= vin_ff4;
        end 
	end

	always @(posedge clock or negedge reset)begin 
        if(~reset)begin
            vin_ff0 <= 1'b0;
            vin_ff1 <= 1'b0;
            vin_ff2 <= 1'b0;
            vin_ff3 <= 1'b0;
            vin_ff4 <= 1'b0;
        end 
        else begin 
            vin_ff0 <= vin    ;
            vin_ff1 <= vin_ff0;
            vin_ff2 <= vin_ff1;
            vin_ff3 <= vin_ff2;
            vin_ff4 <= vin_ff3;
        end 
    end
   
    assign sum0_w0 = din_ff0 + din_ff1; //第一级流水
    assign sum0_w1 = din_ff2 + din_ff3;

    always @(posedge clock or negedge reset)begin 
        if(~reset)begin
            sum0_r0 <= 0;
            sum0_r1 <= 0;
            sum0_r2 <= 0;
        end 
        else if(vin_ff2)begin 
            sum0_r0 <= sum0_w0;
            sum0_r1 <= sum0_w1;
            sum0_r2 <= din_ff4;
        end 
    end

    assign sum1_w0 = sum0_r0 + sum0_r1 + sum0_r2;     //第二级流水
   
    always @(posedge clock or negedge reset)begin 
        if(~reset)begin
            sum1_r0 <= 0;
        end 
        else if(vin_ff3)begin 
            sum1_r0 <= sum1_w0;
        end 
    end

    assign prod_w0 = sum1_r0*51;        //第三级计算乘积
    always @(posedge clock or negedge reset)begin   
        if(!reset)begin
            prod_r0 <= 0;
        end 
        else if(vin_ff4)begin 
            prod_r0 <= prod_w0;
        end 
    end
    
    assign  ave_w0 = prod_r0>>8;       //第四级计算均值 并输出结果
    always @(posedge clock or negedge reset)begin 
        if(~reset)begin
            dout <= 0;
        end 
        else if(vin_ff5)begin 
            dout <= ave_w0;
        end 
    end

	always @(posedge clock or negedge reset)begin   
		if(!reset)begin
			vout <= 0;
		end 
		else begin 
			vout <= vin_ff5;
		end  
	end

endmodule
