`include "param.v"
module capture(
      input                         clk           ,//时钟   pclk 经过PLL后输出的 24M
      input                         rst_n         ,//复位
      input                 [7:0]   cmos_din      ,
      input                         href          ,//行同步
      input                         vsync         ,//场同步
      input                         en_capture    ,//摄像头配置完成后，配置模块输出的采集使能信号
     
      //输出信号定义
      output        reg     [15:0]  dout    , //送到rbg565_gray
      output        reg             dout_vld, 
      output        reg             dout_sop,
      output        reg             dout_eop
);
    
/************************************** 注释开始 **************************************
模块功能说明：本模块实现摄像头数据采集，将像素数据的高低字节拼接之后，进行分帧处理；
              每5帧中的第0帧发送给SDRAM控制器写入 SDRAM，供 VGA 显示
************************************** 注释结束 **************************************/


    //计数器信号定义
    reg     [11:0]      hys_cnt     ;  //行同步计数器       一行1280个像素
    wire                add_hys_cnt ;
    wire                end_hys_cnt ;
    reg     [ 9:0]      vys_cnt     ;  //帧同步计数器       一帧720行
    wire                add_vys_cnt ;
    wire                end_vys_cnt ;
    
    //检测上升沿    
    reg                 vsync_ff     ;   //vsync 帧同步信号寄存


    //采集图像状态标志信号flag_capture
    reg                 en_capture_ff;
    reg                 flag_capture ;

    //hys_cnt
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            hys_cnt <= 0;
        end
        else if(add_hys_cnt)begin
            if(end_hys_cnt)
                hys_cnt <= 0;
            else
                hys_cnt <= hys_cnt + 1;
        end
    end

    assign add_hys_cnt = flag_capture && href;       
    assign end_hys_cnt = add_hys_cnt && hys_cnt == (`COL<<1)-1;   

    //vys_cnt
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            vys_cnt <= 0;
        end
        else if(add_vys_cnt)begin
            if(end_vys_cnt)
                vys_cnt <= 0;
            else
                vys_cnt <= vys_cnt + 1;
        end
    end

    assign add_vys_cnt = end_hys_cnt;       
    assign end_vys_cnt = add_vys_cnt && vys_cnt == `ROW - 1;   

    //flag_capture  从50M时钟域下同步到84M时钟域下 
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            en_capture_ff <= 0;
        end 
        else begin 
            en_capture_ff <= en_capture;
        end 
    end


    always  @(posedge clk or negedge rst_n)begin //配置好寄存器之后就可以采集了
        if(!rst_n)begin
            flag_capture <= 1'b0;
        end
        else if(en_capture_ff && vsync_ff == 1'b0 && vsync)begin
            flag_capture <= 1'b1;
        end
        else if(end_vys_cnt)begin
            flag_capture <= 1'b0;
        end
    end

    //vsync_ff
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            vsync_ff <= 1'b0;
        end
        else begin
            vsync_ff <= vsync;
        end
    end

    //dout
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            dout <= 0;
        end
        else if(flag_capture && href)begin
            dout <= {dout[7:0],cmos_din};
        end
        /*else if(flag_capture && href && frame_cnt == 0)begin
            dout2sdram <= 16'b11111_000000_00000;       //红色
            //dout2sdram <= dout2sdram + 100;
        end
        else if(flag_capture && href && frame_cnt == 1)begin
            dout2sdram <= 16'b00000_111111_00000;       //绿色
            //dout2sdram <= dout2sdram + 300;
        end
        else if(flag_capture && href && frame_cnt == 2)begin
            dout2sdram <= 16'b00000_000000_11111;       //蓝色
            //dout2sdram <= dout2sdram + 500;
        end
        else if(flag_capture && href)begin 
            dout2sdram <= 16'b11111_000000_11111;       //紫色
            //dout2sdram <= dout2sdram + 700;
        end */
        else begin 
            dout <= 0;
        end 
    end

    //dout_vld
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            dout_vld <= 1'b0;
        end
        else if(add_hys_cnt && hys_cnt[0] == 1)begin
            dout_vld <= 1'b1;
        end
        else begin
            dout_vld <= 1'b0;
        end
    end

    //dout_sop
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            dout_sop <= 1'b0;
        end
        else if(vys_cnt == 0 && add_hys_cnt && hys_cnt == 1)begin
            dout_sop <= 1'b1;
        end
        else begin
            dout_sop <= 1'b0;
        end
    end
    
    //dout_eop
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            dout_eop <= 1'b0;
        end
        else if(add_vys_cnt && end_vys_cnt)begin
            dout_eop <= 1'b1;
        end
        else begin
            dout_eop <= 1'b0;
        end
    end

endmodule

