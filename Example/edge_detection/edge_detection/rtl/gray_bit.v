module gray_bit(            //二值化  输出1 或者 0
      input                     clk    ,
      input                     rst_n  ,
      input                     key    ,    //调节灰度阈值 大于value则输出1（白）
      input            [7:0]    din    ,    //输入像素值
      input                     din_vld,
      input                     din_sop,
      input                     din_eop,
      output        reg         dout   ,    //1或0
      output        reg         dout_vld,
      output        reg         dout_sop,
      output        reg         dout_eop
);

//reg定义
    
    reg     [8:0]       value       ;
    wire                add_value   ;
    wire                end_value   ;

//阈值 value设计    大津算法实现起来比较复杂，这里用一个简单的控制来设置二值化判决门限

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            value <= 50;
        end
        else if(add_value)begin
            if(end_value)
                value <= 0;
            else
                value <= value + 3'd4;
        end
    end

    assign add_value = key == 1'b1;       
    assign end_value = add_value && value >= 8'd251;   


//判断滤波后输入的像素值是否大于阈值value

    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            dout <= 0;
        end
        else if(din >= value)begin
            dout <= 1;
        end
        else begin
            dout <= 0;
        end
    end

//dout_vld

    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            dout_vld <= 1'b0;
        end
        else begin
            dout_vld <= din_vld;
        end
    end

//dout_sop

    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            dout_sop <= 1'b0;
        end
        else begin
            dout_sop <= din_sop;
        end
    end

//dout_eop

    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            dout_eop <= 1'b0;
        end
        else begin
            dout_eop <= din_eop;
        end
    end

endmodule

