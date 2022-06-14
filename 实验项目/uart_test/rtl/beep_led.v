module beep_led( 
    input				clk		,
    input				rst_n	,
    input	[1:0]	    cmd	    ,
    output reg [3:0]    led     ,
    output reg          beep_n	
);								 

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        led     <= 4'd0;
        beep_n  <= 1'b1 ;
    end 
    else 
        case(cmd)
            2'b00 : begin
                led     <= 4'd0;
                beep_n  <= 1'b1;
            end
            2'b01 : begin
                led     <= 4'hf;
                beep_n  <= 1'b1;
            end
            2'b10 : begin
                led     <= 4'h0;
                beep_n  <= 1'b0;
            end
            2'b11 : begin
                led     <= 4'hf;
                beep_n  <= 1'b0;
            end
            default:begin
                led     <= 4'd0;
                beep_n  <= 1'b1;
            end
        endcase
end

                        
endmodule