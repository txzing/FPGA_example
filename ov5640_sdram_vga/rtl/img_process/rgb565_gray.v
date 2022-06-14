/**************************************功能介绍***********************************	
Description:		RGB888-->Gray公式
    gray = R*0.299 + G*0.587 + B*0.114
         = 306 * R + 601 * G + 117 * B;
    先把小数乘以一个较大的值A，转化为整数（取整），然后将计算和除以A，即可得到灰度值。

*********************************************************************************/
module rgb565_gray( 
    input				clk		,
    input				rst_n	,

    input		[15:0]	din		,//rgb565格式输入
    input		        din_vld ,
    input		    	din_sop	,
    input               din_eop ,

    output		[7:0]	dout	,//灰度输出
    output		    	dout_vld,
    output              dout_sop,
    output              dout_eop
);								  
                        
    //中间信号定义
    reg     [7:0]   din_r       ;//输入数据寄存
    reg     [7:0]   din_g       ;
    reg     [7:0]   din_b       ;

    wire    [17:0]  red_w       ;//计算各通道分量	 
    wire    [17:0]  green_w     ;
    wire    [17:0]  blue_w      ;

    reg		[17:0]	red_r       ;
    reg		[17:0]	green_r     ;
    reg     [17:0]  blue_r      ;

    wire	[19:0]	gray_w      ;
    reg	    [19:0]	gray_r      ;

    reg             din_vld_r0  ; 
    reg             din_vld_r1  ;
    reg             din_vld_r2  ;
    reg             din_sop_r0  ;
    reg             din_sop_r1  ;
    reg             din_sop_r2  ;
    reg             din_eop_r0  ;
    reg             din_eop_r1  ;
    reg             din_eop_r2  ;

//同步
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            din_r <= 0;
            din_g <= 0;
            din_b <= 0;
        end 
        else if(din_vld)begin 
            din_r <= {din[15:11],3'd0};
            din_g <= {din[10:5],2'd0};
            din_b <= {din[4:0],3'd0};
        end 
    end

//第一步 计算各通道分量
    assign red_w    = din_r*306;
    assign green_w  = din_g*601;
    assign blue_w   = din_b*117;

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            red_r   <= 0;
            green_r <= 0;
            blue_r  <= 0;
        end 
        else if(din_vld_r0)begin 
            red_r   <= red_w  ;
            green_r <= green_w;
            blue_r  <= blue_w ;
        end 
    end

//第二步 计算各通道分量之和
    assign gray_w = red_r + green_r + blue_r;

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            gray_r <= 0;
        end 
        else if(din_vld_r1)begin 
            gray_r <= gray_w;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            din_vld_r0 <= 0;
            din_sop_r0 <= 0;
            din_eop_r0 <= 0;

            din_vld_r1 <= 0;
            din_sop_r1 <= 0;
            din_eop_r1 <= 0;

            din_vld_r2 <= 0;
            din_sop_r2 <= 0;
            din_eop_r2 <= 0;
        end 
        else begin 
            din_vld_r0 <= din_vld;
            din_sop_r0 <= din_sop;
            din_eop_r0 <= din_eop;
            din_vld_r1 <= din_vld_r0;
            din_sop_r1 <= din_sop_r0;
            din_eop_r1 <= din_eop_r0;
            din_vld_r2 <= din_vld_r1;
            din_sop_r2 <= din_sop_r1;
            din_eop_r2 <= din_eop_r1;
        end 
    end

//输出
    assign dout     = gray_r[17:10]; //除以10之后取低8bit
    assign dout_vld = din_vld_r2;
    assign dout_sop = din_sop_r2;
    assign dout_eop = din_eop_r2;

endmodule
