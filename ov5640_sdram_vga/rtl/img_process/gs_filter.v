module gs_filter (
    input               clk     ,
    input               rst_n   ,

    input               din_sop ,
    input               din_eop ,
    input               din_vld ,
    input       [7:0]   din     ,//灰度输入

    output              dout_sop,
    output              dout_eop,
    output              dout_vld,
    output      [7:0]   dout     //灰度输出
);

/**************************************功能介绍***********************************		
Description: 
    高斯滤波卷积模板  [1 2 1]	
                    [2 4 2]
                    [1 2 1]  系数之和 16
*********************************************************************************/

//信号定义

    wire    [7:0]       taps0   ;
    wire    [7:0]       taps1   ;
    wire    [7:0]       taps2   ;

    reg     [7:0]       taps0_0 ;//对tapsx打拍，产生3列数据
    reg     [7:0]       taps0_1 ;

    reg     [7:0]       taps1_0 ;
    reg     [7:0]       taps1_1 ;

    reg     [7:0]       taps2_0 ;
    reg     [7:0]       taps2_1 ;

    reg     [9:0]       gs_0    ;//第0列加权和
    reg     [9:0]       gs_1    ;
    reg     [9:0]       gs_2    ;
    reg     [11:0]      gs      ;//三列的加权和

    reg                 din_sop_0;
    reg                 din_sop_1;
    reg                 din_sop_2;
    reg                 din_eop_0;
    reg                 din_eop_1;
    reg                 din_eop_2;
    reg                 din_vld_0;
    reg                 din_vld_1;
    reg                 din_vld_2;

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

//流水线计算
//第一级
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            gs_0 <= 0;
            gs_1 <= 0;
            gs_2 <= 0;
        end 
        else if(din_vld_0)begin  
            gs_0 <= {2'd0,taps0} + {1'b0,taps0_0,1'd0} + {2'd0,taps0_1};
            gs_1 <= {1'd0,taps1,1'd0} + {taps1_0,2'd0} + {1'd0,taps1_1,1'd0};
            gs_2 <= {2'd0,taps2} + {1'b0,taps2_0,1'd0} + {2'd0,taps2_1};
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            gs <= 0;
        end 
        else if(din_vld_1)begin 
            gs <= (gs_0 + gs_1 + gs_2) >> 4;
        end 
    end

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

//输出
    assign dout     = gs[7:0] ;
    assign dout_sop = din_sop_2;
    assign dout_eop = din_eop_2;
    assign dout_vld = din_vld_2;
    
//移位寄存器例化
    gs_shift	u_gs_shift (
	.aclr       (~rst_n     ),
	.clken      (din_vld    ),
	.clock      (clk        ),
	.shiftin    (din        ),
	.shiftout   (),
	.taps0x     (taps0      ),
	.taps1x     (taps1      ),
	.taps2x     (taps2      )
	);


endmodule

