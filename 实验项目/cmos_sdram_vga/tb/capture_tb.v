`timescale 1 ns/1 ns
`include "../rtl/param.v"
module capture_tb();

    reg             clk         ;
    reg             rst_n       ;

    reg             enable      ;//采集使能 配置完成
    reg             vsync       ;//摄像头场同步信号
    reg             href        ;//摄像头行参考信号
    reg   [7:0]     din         ;//摄像头像素字节

    wire  [15:0]    dout        ;//像素数据
    wire            dout_sop    ;//包文头 一帧图像第一个像素点
    wire            dout_eop    ;//包文尾 一帧图像最后一个像素点
    wire            dout_vld    ;//像素数据有效

    parameter CYCLE    = 20;
    parameter RST_TIME = 3 ;

capture u_capture(
    /*input          */.clk         (clk       ),//像素时钟 摄像头输出的pclk
    /*input          */.rst_n       (rst_n     ),
    /*input          */.enable      (enable    ),//采集使能 配置完成
    /*input          */.vsync       (vsync     ),//摄像头场同步信号
    /*input          */.href        (href      ),//摄像头行参考信号
    /*input   [7:0]  */.din         (din       ),//摄像头像素字节
    /*output  [15:0] */.dout        (dout      ),//像素数据
    /*output         */.dout_sop    (dout_sop  ),//包文头 一帧图像第一个像素点
    /*output         */.dout_eop    (dout_eop  ),//包文尾 一帧图像最后一个像素点
    /*output         */.dout_vld    (dout_vld  ) //像素数据有效
);

    integer i = 0 ,j = 0;

     initial begin
            clk = 1;
            forever
            #(CYCLE/2)
           clk=~clk;
     end

     initial begin
        rst_n = 1;
        #2;
        rst_n = 0;
        #(CYCLE*RST_TIME);
        rst_n = 1;
    end

    initial begin
      #1;
      enable   = 1;
      vsync    = 0;
      href     = 0;
      din      = 0;
      #(10*CYCLE);
        repeat(2)begin 
            vsync    = 1;
            #(20*CYCLE);
            vsync    = 0;
            #(20*CYCLE);
            for(i=0;i<`V_AP;i=i+1)begin //720行
                for(j=0;j<(`H_AP<<1);j=j+1)begin     //1280*2个像素字节
                    href     = 1'b1;
                    din      = {$random};
                    #(1*CYCLE);
                end
                href     = 0;
                din      = 0;
                #(20*CYCLE);
            end 
            #(20*CYCLE);
        end 
        $stop;
    end




    endmodule

