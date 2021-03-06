module sobel(       //判断像素点是否为边缘点
      input                     clk      ,
      input                     rst_n    ,
      input                     din      ,
      input                     din_vld  ,
      input                     din_sop  ,
      input                     din_eop  ,
      
      output        reg         dout     ,
      output        reg         dout_vld ,
      output        reg         dout_sop ,
      output        reg         dout_eop
);
//reg信号定义
    
    reg                 din_vld_ff0;
    reg                 din_vld_ff1;
    reg                 din_vld_ff2;
    reg                 din_vld_ff3;
    
    reg                 din_sop_ff0;
    reg                 din_sop_ff1;
    reg                 din_sop_ff2;
    reg                 din_sop_ff3;

    reg                 din_eop_ff0;
    reg                 din_eop_ff1;
    reg                 din_eop_ff2;
    reg                 din_eop_ff3;
    
    reg                 taps0_ff0;
    reg                 taps0_ff1;
    reg                 taps1_ff0;
    reg                 taps1_ff1;
    reg                 taps2_ff0;
    reg                 taps2_ff1;
    
    reg     [2:0]       g        ;
    reg     [2:0]       gx       ;  //第0、2行绝对值之和
    reg     [2:0]       gy       ;  //第0、2列绝对值之和
    reg     [2:0]       gx_0     ;  //第0行像素加权和
    reg     [2:0]       gx_2     ;  //第2行像素加权和
    reg     [2:0]       gy_0     ;  //第0列像素加权和
    reg     [2:0]       gy_2     ;  //第2列像素加权和

//wire信号定义
    
    wire                taps0;  
    wire                taps1;    
    wire                taps2;  


//移位寄存器例化
    shift_ram2 shift_ram2(
    .aclr       (~rst_n ),
	.clken      (din_vld),
	.clock      (clk    ),
	.shiftin    (din    ),
//	.shiftout   (shiftout),
	.taps0x     (taps0  ),
	.taps1x     (taps1  ),
	.taps2x     (taps2  )
);


    //打3拍
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            din_vld_ff0 <= 1'b0;
            din_vld_ff1 <= 1'b0;
            din_vld_ff2 <= 1'b0;
            din_vld_ff3 <= 1'b0;
    
            din_sop_ff0 <= 1'b0;
            din_sop_ff1 <= 1'b0;
            din_sop_ff2 <= 1'b0;
            din_sop_ff3 <= 1'b0;

            din_eop_ff0 <= 1'b0;
            din_eop_ff1 <= 1'b0;
            din_eop_ff2 <= 1'b0;
            din_eop_ff3 <= 1'b0;
        end
        else begin
            din_vld_ff0 <= din_vld;
            din_vld_ff1 <= din_vld_ff0;
            din_vld_ff2 <= din_vld_ff1;
            din_vld_ff3 <= din_vld_ff2;
    
            din_sop_ff0 <= din_sop;
            din_sop_ff1 <= din_sop_ff0;
            din_sop_ff2 <= din_sop_ff1;
            din_sop_ff3 <= din_sop_ff2;

            din_eop_ff0 <= din_eop;
            din_eop_ff1 <= din_eop_ff0;
            din_eop_ff2 <= din_eop_ff1;
            din_eop_ff3 <= din_eop_ff2;
        end
    end


//建立3*3矩阵

    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            taps0_ff0 <= 0;
            taps0_ff1 <= 0;
            taps1_ff0 <= 0;
            taps1_ff1 <= 0;
            taps2_ff0 <= 0;
            taps2_ff1 <= 0;
        end
        else if(din_vld_ff0)begin
            taps0_ff0 <= taps0    ;
            taps0_ff1 <= taps0_ff0;
            taps1_ff0 <= taps1    ;
            taps1_ff1 <= taps1_ff0;
            taps2_ff0 <= taps2    ;
            taps2_ff1 <= taps2_ff0;
        end
    end

//按照sobel算子计算第0、2行加权和 第0、2列加权和
/*
sobel算子 ：Gx = -1 0 +1    Gy = +1 +2 +1
                 -2 0 +2          0  0  0
                 -1 0 +1         -1 -2 -1
*/
    //gx
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            gx_0 <= 0;
        end                 //计算第2列加权和
        else if(din_vld_ff1) begin
            //gx_0 <= 1*taps0_ff1 + 2*taps1_ff1 + 1*taps2_ff1;
            gx_0 <= {1'b0,taps0_ff1} + {taps1_ff1,1'b0} + {1'b0,taps2_ff1};
        end
    end
    
     always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            gx_2 <= 0;
        end                  //计算第0列加权和
        else if(din_vld_ff1) begin
            //gx_2 <= 1*taps0 + 2*taps1 + 1*taps2;
            gx_2 <= {1'b0,taps0} + {taps1,1'b0} + {1'b0,taps2};
        end
    end

    always  @(posedge clk or negedge rst_n)begin        //计算 gx 的绝对值 | gx_0 - gx_2 |
        if(rst_n==1'b0)begin
            gx <= 0;
        end
        else if(din_vld_ff2) begin
            gx <= (gx_0 >gx_2)?(gx_0 - gx_2):(gx_2 - gx_0);
        end
    end

    //gy
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            gy_0 <= 0;
        end
        else if(din_vld_ff1)begin
            gy_0 <= {1'b0,taps0_ff1} + {taps0_ff0,1'b0} + {1'b0,taps0};
            //gy_0 <= 1*taps0_ff1 + 2*taps0_ff0 + 1*taps0;
        end
    end

    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            gy_2 <= 0;
        end
        else if(din_vld_ff1)begin
            gy_2 <= {1'b0,taps2_ff1} + {taps2_ff0,1'b0} + {1'b0,taps2};
            //gy_2 <= 1*taps2_ff1 + 2*taps2_ff0 + 1*taps2;
        end
    end

    always  @(posedge clk or negedge rst_n)begin        //计算 gy 的绝对值  | gy_0 - gy_2 |
        if(rst_n==1'b0)begin
            gy <= 0;
        end
        else if(din_vld_ff2)begin
            gy <= (gy_0 > gy_2)?(gy_0 - gy_2):(gy_2 - gy_0);
        end
    end

//计算gx 与gy的绝对值之和   近似为 gx、gy 平方和的开平方

    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            g <= 0;
        end
        else if(din_vld_ff3)begin
            g <= gx + gy;
        end
    end

    // assign      dout = (g >= 3)?1'b1:1'b0;  //边缘点为白色
    // assign      dout = ~g[2];
    always  @(*)begin
        dout = (g >= 3)?1'b1:1'b0;  //边缘点为白色
        //dout = (g >= 1)?1'b0:1'b1;  //边缘点为黑色
    end

    

//dout_vld

    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            dout_vld <= 1'b0;
        end
        else if(din_vld_ff3)begin
            dout_vld <= 1'b1;
        end
        else begin 
            dout_vld <= 1'b0;
        end 
    end


//dout_sop
    
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            dout_sop <= 1'b0;
        end
        else if(din_sop_ff3)begin
            dout_sop <= 1'b1;
        end
        else begin
            dout_sop <= 1'b0;
        end
    end

//dout_eop
    
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            dout_eop <= 1'b0;
        end
        else if(din_eop_ff3)begin
            dout_eop <= 1'b1;
        end
        else begin
            dout_eop <= 1'b0;       
        end 
    end

endmodule

