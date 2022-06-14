module binary_gray #(parameter DATA_W = 8)(
	input						clk		,
	input						rst_n	,
	
	input						op_code	,//0：b-->g  1：g-->b
	input		[DATA_W-1:0]	din		,
	output	reg	[DATA_W-1:0]	dout	
);

    function [DATA_W-1:0] B_G(input op_code,input [DATA_W-1:0] data);
        integer i;
        begin 
            if(~op_code)begin 		//二进制转格雷码
               B_G = ( data >>1)^data;
            end 
            else if(op_code)begin 	//格雷码转二进制
                B_G[DATA_W-1] = data[DATA_W-1];
                for(i = DATA_W-2;i >= 0; i = i - 1)begin 
                    B_G[i] = B_G[i+1] ^ data[i];
                end 
            end 
         end 
    endfunction 

    always @(posedge clk or negedge rst_n)begin
        if(~rst_n)begin
            dout <= 0;
        end
        else begin
            dout <= B_G(op,din);
        end
    end

endmodule 

