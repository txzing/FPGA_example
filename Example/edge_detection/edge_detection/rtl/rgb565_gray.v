module rgb565_gray(
      input                     clk     ,
      input                     rst_n   ,
      input         [15:0]      din     ,//R:din[15:11], G:din[10:5], B:din[4:0] 
      input                     din_vld ,//输入图像数据有效指示信号
      input                     din_sop ,//输入数据帧第一个像素
      input                     din_eop ,//输入数据帧最后一个像素
      output    reg [ 7:0]      dout    ,//输出的灰度像素数据
      output    reg             dout_vld,//输出的灰度像素数据有效指示信号
      output    reg             dout_sop,//输出的灰度像素数据帧第一个数据
      output    reg             dout_eop //输出的灰度像素数据帧最后一个数据
);

//R 、G 、B信号定义
    
   wire    [7:0]    Red  ;
   wire    [7:0]    Green;
   wire    [7:0]    Blue ;

   assign       Red   = {din[15:11],3'b000};    //低位补0
   assign       Green = {din[10:5 ],2'b00 };
   assign       Blue  = {din[ 4:0 ],3'b000};

///dout 当输入数据有效时，计算RGB转灰度的值

    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            dout <= 0;
        end
        else if(din_vld)begin
            //dout <= (Red * 76 + Green * 150 + Blue * 30) >> 8 ;
            dout <= (Red * 77 + Green * 150 + Blue * 29) >> 8 ;
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


