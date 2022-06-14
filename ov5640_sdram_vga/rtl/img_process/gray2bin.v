module gray2bin #(parameter TH = 100) (
    input               clk         ,
    input               rst_n       ,

    input               din_sop     ,
    input               din_eop     ,
    input               din_vld     ,
    input       [7:0]   din         ,//灰度图像输入

    output  reg         dout_sop    ,
    output  reg         dout_eop    ,
    output  reg         dout_vld    ,
    output  reg         dout         //二值图像输出 0 1
);

    //dout  
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout <= 0;
        end 
        else if(din <= TH)begin 
            dout <= 0;
        end 
        else begin 
            dout <= 1;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout_sop <= 0;
            dout_eop <= 0;
            dout_vld <= 0;
        end 
        else begin 
            dout_sop <= din_sop;
            dout_eop <= din_eop;
            dout_vld <= din_vld;
        end 
    end

endmodule

