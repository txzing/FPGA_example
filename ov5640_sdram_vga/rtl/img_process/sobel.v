module  sobel (
    input           clk         ,
    input           rst_n       ,
    input           din_sop     ,
    input           din_eop     ,
    input           din_vld     ,
    input           din         ,
    output  reg     dout_sop    ,
    output  reg     dout_eop    ,
    output  reg     dout_vld    ,
    output  reg     dout           
);

/**************************************功能介绍***********************************		
Description:	Sobel模板系数
                x: [[-1,0,1],
                    [-2,0,2]
                    [-1,0,1]]
                y：[[1,2,1],
                    [0,0,0],
                    [-1,-2,-1]]
*********************************************************************************/
//信号定义
    wire    [0:0]       taps0   ;
    wire    [0:0]       taps1   ;
    wire    [0:0]       taps2   ;

    reg     [0:0]       taps0_0 ;//对tapsx打拍，产生3列数据
    reg     [0:0]       taps0_1 ;

    reg     [0:0]       taps1_0 ;
    reg     [0:0]       taps1_1 ;

    reg     [0:0]       taps2_0 ;
    reg     [0:0]       taps2_1 ;

    reg     [2:0]       sx_0    ;//第0列加权和
    reg     [2:0]       sx_2    ;//第2列加权和
    reg     [2:0]       sx_abs  ;//第0列和第2列的绝对值
    reg     [2:0]       sy_0    ;//第0行加权和
    reg     [2:0]       sy_2    ;//第2行加权和
    reg     [2:0]       sy_abs  ;//第0行和第2行的绝对值

    reg                 din_sop_0;
    reg                 din_sop_1;
    reg                 din_sop_2;
    reg                 din_eop_0;
    reg                 din_eop_1;
    reg                 din_eop_2;
    reg                 din_vld_0;
    reg                 din_vld_1;
    reg                 din_vld_2;

//打拍
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            din_sop_0 <= 0;
            din_sop_1 <= 0;
            din_sop_2 <= 0;
            din_eop_0 <= 0;
            din_eop_1 <= 0;
            din_eop_2 <= 0;
            din_vld_0 <= 0;
            din_vld_1 <= 0;
            din_vld_2 <= 0;
        end 
        else begin 
            din_sop_0 <= din_sop;
            din_sop_1 <= din_sop_0;
            din_sop_2 <= din_sop_1;
            din_eop_0 <= din_eop;
            din_eop_1 <= din_eop_0;
            din_eop_2 <= din_eop_1;
            din_vld_0 <= din_vld;
            din_vld_1 <= din_vld_0;
            din_vld_2 <= din_vld_1;
        end 
    end
    
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            taps0_0 <= 0;
            taps0_1 <= 0;
            taps1_0 <= 0;
            taps1_1 <= 0;
            taps2_0 <= 0;
            taps2_1 <= 0;
        end 
        else if(din_vld)begin 
            taps0_0 <= taps0;
            taps0_1 <= taps0_0;

            taps1_0 <= taps1;
            taps1_1 <= taps1_0;

            taps2_0 <= taps2;
            taps2_1 <= taps2_0;
        end 
    end

//sx_0  sx_2 sy_0  sy_2
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            sx_0 <= 0;
            sx_2 <= 0;
            sy_0 <= 0;
            sy_2 <= 0;
        end 
        else if(din_vld_0)begin 
            sx_0 <= {2'd0,taps0} + {1'b0,taps1,1'b0} + {2'd0,taps2};        //第0列
            sx_2 <= {2'd0,taps0_1} + {1'b0,taps1_1,1'b0} + {2'd0,taps2_1};  //第2列
            sy_0 <= {2'd0,taps0} + {1'd0,taps0_0,1'b0} + {2'd0,taps0_1};    //第0行
            sy_2 <= {2'd0,taps2} + {1'd0,taps2_0,1'b0} + {2'd0,taps2_1};    //第2行
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            sx_abs <= 0;
            sy_abs <= 0;
        end 
        else if(din_vld_1)begin 
            sx_abs <= (sx_2<sx_0)?sx_0-sx_2:sx_2-sx_0;
            sy_abs <= (sy_2<sy_0)?sy_0-sy_2:sy_2-sy_0;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout <= 0;
            dout_sop <= 0;
            dout_eop <= 0;
            dout_vld <= 0;
        end 
        else begin 
            dout <= (sx_abs + sy_abs) > 3?1'b1:1'b0;
            dout_sop <= din_sop_2;
            dout_eop <= din_eop_2;
            dout_vld <= din_vld_2;
        end 
    end

sobel_shift	u_sobel_shift (
	.aclr       (~rst_n     ),
	.clken      (din_vld    ),
	.clock      (clk        ),
	.shiftin    (din        ),
	.shiftout   (           ),
	.taps0x     (taps0      ),
	.taps1x     (taps1      ),
	.taps2x     (taps2      )
);

endmodule


