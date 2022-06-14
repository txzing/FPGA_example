module gs_filter(
      input                         clk      ,
      input                         rst_n    ,
      input                [7:0]    din      ,
      input                         din_vld  ,
      input                         din_sop  ,
      input                         din_eop  ,
      output        wire    [7:0]   dout     ,
      output        reg             dout_vld ,
      output        reg             dout_sop ,
      output        reg             dout_eop
);

//中间信号定i
    
    reg             din_vld_ff0;
    reg             din_vld_ff1;
    reg             din_vld_ff2;

    reg             din_sop_ff0;
    reg             din_sop_ff1;
    reg             din_sop_ff2;

    reg             din_eop_ff0;
    reg             din_eop_ff1;
    reg             din_eop_ff2;

    reg     [7:0]   taps0_ff0  ;
    reg     [7:0]   taps0_ff1  ;

    reg     [7:0]   taps1_ff0  ;
    reg     [7:0]   taps1_ff1  ;

    reg     [7:0]   taps2_ff0  ;
    reg     [7:0]   taps2_ff1  ;

    reg     [10:0]   gs_0       ;
    reg     [10:0]   gs_1       ; 
    reg     [10:0]   gs_2       ;

    reg     [10:0]   gs         ;
//例化信号定义
    
    wire    [7:0]   taps0       ;
    wire    [7:0]   taps1       ;
    wire    [7:0]   taps2       ;

//移位寄存器例化
shift_ram1 shift_ram1(
    .aclr       (~rst_n ),
	.clock      (clk    ),
    .clken      (din_vld),
	.shiftin    (din    ),
	//.shiftout (shiftout),
	.taps0x     (taps0  ),
	.taps1x     (taps1  ),
	.taps2x     (taps2  )
);
    

//din_vld din_sop din_eop 缓存
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            din_vld_ff0 <= 1'b0; 
            din_vld_ff1 <= 1'b0; 
            din_vld_ff2 <= 1'b0; 

            din_sop_ff0 <= 1'b0; 
            din_sop_ff1 <= 1'b0; 
            din_sop_ff2 <= 1'b0;

            din_eop_ff0 <= 1'b0; 
            din_eop_ff1 <= 1'b0; 
            din_eop_ff2 <= 1'b0; 
        end
        else begin
            din_vld_ff0 <= din_vld    ; 
            din_vld_ff1 <= din_vld_ff0; 
            din_vld_ff2 <= din_vld_ff1; 

            din_sop_ff0 <= din_sop    ; 
            din_sop_ff1 <= din_sop_ff0; 
            din_sop_ff2 <= din_sop_ff1;

            din_eop_ff0 <= din_eop    ; 
            din_eop_ff1 <= din_eop_ff0; 
            din_eop_ff2 <= din_eop_ff1;
        end
    end

//产生矩阵      将移位寄存器输出数据tapsx打两拍
    
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
            taps0_ff0 <= taps0;
            taps0_ff1 <= taps0_ff0;
            
            taps1_ff0 <= taps1    ;
            taps1_ff1 <= taps1_ff0;

            taps2_ff0 <= taps2    ;
            taps2_ff1 <= taps2_ff0;
        end
    end

/*    
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            gs <= 0;
        end
        else begin
            gs <= taps0_ff1 + taps1_ff1<<1'd1 + taps2_ff1 + taps0_ff0<<1'd1 + taps1_ff0<<2'd2 + taps2_ff0<<1'd1 + taps0 + taps1<<1'd1 + taps2;
        end
    end
*/


//流水线计算  高斯模板[   1  2  1   
//                      2  4  2  
//                      1  2  1  ]

    //第一级流水线，计算3列数据的乘积之和
    always  @(posedge clk or negedge rst_n)begin    //计算第3列
        if(rst_n==1'b0)begin
            gs_2 <= 0;
        end
        else if(din_vld_ff1) begin
            //gs_2 <= taps0_ff1 + (taps1_ff1<<1'd1) + taps2_ff1;
            gs_2 <= {3'b00,taps0_ff1} + {2'b0,taps1_ff1,1'b0} + {3'b000,taps2_ff1};
        end
    end

    always  @(posedge clk or negedge rst_n)begin    //计算第2列
        if(rst_n==1'b0)begin
            gs_1 <= 0;
        end
        else if(din_vld_ff1)begin       //注意 移位 的优先级 低于 加减 的优先级
            //gs_1 <= (taps0_ff0<<1'd1) + (taps1_ff0<<2'd2) + (taps2_ff0<<1'd1);
            gs_1 <= {2'b0,taps0_ff0,1'b0} + {1'b0,taps1_ff0,2'b0} + {2'b0,taps2_ff0,1'b0};
        end
    end

    always  @(posedge clk or negedge rst_n)begin    //计算第1列
        if(rst_n==1'b0)begin
            gs_0 <= 0;
        end
        else if(din_vld_ff1)begin
            //gs_2 <= taps0 + (taps1<<1'd1) + taps2;
            gs_0 <= {3'b00,taps0} + {2'b0,taps1,1'b0} + {3'b00,taps2};
        end
    end

//流水线计算    第二级流水线，计算最终滤波后的值
    //计算dout
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            gs <= 0;
        end
        else if(din_vld_ff2)begin
            gs <= (gs_0 + gs_1 + gs_2)>>4;
        end
    end

    assign    dout = gs[7:0];

//dout_vld设计
    
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            dout_vld <= 1'b0;
        end
        else if(din_vld_ff2) begin
            dout_vld <= 1'b1;
        end
        else begin 
            dout_vld <= 1'b0;
        end 
    end

//dout_sop设计
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            dout_sop <= 1'b0;
        end
        else if(din_sop_ff2) begin
            dout_sop <= 1'b1;
        end
        else begin 
            dout_sop <= 1'b0;
        end 
    end

//dout_eop设计
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            dout_eop <= 1'b0;
        end
        else if(din_eop_ff2) begin
            dout_eop <= 1'b1;
        end
        else begin 
            dout_eop <= 1'b0;
        end 
    end

endmodule

