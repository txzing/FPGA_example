module multiplier_32bit (
    input               clk     ,
    input               rst_n   ,

    input       [31:0]  din_a   ,
    input       [31:0]  din_b   ,
    input               din_vld ,

    output  reg [63:0]  dout    ,
    output  reg         dout_vld    
);
/**************************************功能介绍***********************************
Copyright:			
Date     :			
Author   :			
Version  :			
Description:实现两个32bit整数乘法器，流水线级数越多，综合出的时钟频率越高，相应地消耗的资源也越多；
            体现了面积----速度互换原则，即想提高电路运行频率可以增加寄存器级数；
            若想节省硬件资源则可以降低电路运行频率。
*********************************************************************************/

/*
//方法1     1个周期输出结果
    reg     [31:0]      din_a_r     ;
    reg     [31:0]      din_b_r     ;
    reg                 din_vld_r   ;

    wire    [63:0]      res_w0      ;
    wire    [63:0]      res_w1      ;
    wire    [63:0]      res_w2      ;
    wire    [63:0]      res_w3      ;
    wire    [63:0]      res_w4      ;
    wire    [63:0]      res_w5      ;
    wire    [63:0]      res_w6      ;
    wire    [63:0]      res_w7      ;
    wire    [63:0]      res_w8      ;
    wire    [63:0]      res_w9      ;
    wire    [63:0]      res_w10     ;
    wire    [63:0]      res_w11     ;
    wire    [63:0]      res_w12     ;
    wire    [63:0]      res_w13     ;
    wire    [63:0]      res_w14     ;
    wire    [63:0]      res_w15     ;
    wire    [63:0]      res_w16     ;
    wire    [63:0]      res_w17     ;
    wire    [63:0]      res_w18     ;
    wire    [63:0]      res_w19     ;
    wire    [63:0]      res_w20     ;
    wire    [63:0]      res_w21     ;
    wire    [63:0]      res_w22     ;
    wire    [63:0]      res_w23     ;
    wire    [63:0]      res_w24     ;
    wire    [63:0]      res_w25     ;
    wire    [63:0]      res_w26     ;
    wire    [63:0]      res_w27     ;
    wire    [63:0]      res_w28     ;
    wire    [63:0]      res_w29     ;
    wire    [63:0]      res_w30     ;
    wire    [63:0]      res_w31     ;

    wire    [63:0]      product     ;

    assign res_w0  = din_a_r[0] ?{32'd0,din_b_r      }:64'd0   ;
    assign res_w1  = din_a_r[1] ?{31'd0,din_b_r,1'd0 }:64'd0    ;
    assign res_w2  = din_a_r[2] ?{30'd0,din_b_r,2'd0 }:64'd0    ;
    assign res_w3  = din_a_r[3] ?{29'd0,din_b_r,3'd0 }:64'd0    ;
    assign res_w4  = din_a_r[4] ?{28'd0,din_b_r,4'd0 }:64'd0    ;
    assign res_w5  = din_a_r[5] ?{27'd0,din_b_r,5'd0 }:64'd0    ;
    assign res_w6  = din_a_r[6] ?{26'd0,din_b_r,6'd0 }:64'd0    ;
    assign res_w7  = din_a_r[7] ?{25'd0,din_b_r,7'd0 }:64'd0    ;
    assign res_w8  = din_a_r[8] ?{24'd0,din_b_r,8'd0 }:64'd0    ;
    assign res_w9  = din_a_r[9] ?{23'd0,din_b_r,9'd0 }:64'd0    ;
    assign res_w10 = din_a_r[10]?{22'd0,din_b_r,10'd0}:64'd0    ;
    assign res_w11 = din_a_r[11]?{21'd0,din_b_r,11'd0}:64'd0    ;
    assign res_w12 = din_a_r[12]?{20'd0,din_b_r,12'd0}:64'd0    ;
    assign res_w13 = din_a_r[13]?{19'd0,din_b_r,13'd0}:64'd0    ;
    assign res_w14 = din_a_r[14]?{18'd0,din_b_r,14'd0}:64'd0    ;
    assign res_w15 = din_a_r[15]?{17'd0,din_b_r,15'd0}:64'd0    ;
    assign res_w16 = din_a_r[16]?{16'd0,din_b_r,16'd0}:64'd0    ;
    assign res_w17 = din_a_r[17]?{15'd0,din_b_r,17'd0}:64'd0    ;
    assign res_w18 = din_a_r[18]?{14'd0,din_b_r,18'd0}:64'd0    ;
    assign res_w19 = din_a_r[19]?{13'd0,din_b_r,19'd0}:64'd0    ;
    assign res_w20 = din_a_r[20]?{12'd0,din_b_r,20'd0}:64'd0    ;
    assign res_w21 = din_a_r[21]?{11'd0,din_b_r,21'd0}:64'd0    ;
    assign res_w22 = din_a_r[22]?{10'd0,din_b_r,22'd0}:64'd0    ;
    assign res_w23 = din_a_r[23]?{9'd0 ,din_b_r,23'd0}:64'd0    ;
    assign res_w24 = din_a_r[24]?{8'd0 ,din_b_r,24'd0}:64'd0    ;
    assign res_w25 = din_a_r[25]?{7'd0 ,din_b_r,25'd0}:64'd0    ;
    assign res_w26 = din_a_r[26]?{6'd0 ,din_b_r,26'd0}:64'd0    ;
    assign res_w27 = din_a_r[27]?{5'd0 ,din_b_r,27'd0}:64'd0    ;
    assign res_w28 = din_a_r[28]?{4'd0 ,din_b_r,28'd0}:64'd0    ;
    assign res_w29 = din_a_r[29]?{3'd0 ,din_b_r,29'd0}:64'd0    ;
    assign res_w30 = din_a_r[30]?{2'd0 ,din_b_r,30'd0}:64'd0    ;
    assign res_w31 = din_a_r[31]?{1'd0 ,din_b_r,31'd0}:64'd0    ;

    assign product =  res_w0  + res_w1  + res_w2  + res_w3  + res_w4 
                    + res_w5  + res_w6  + res_w7  + res_w8  + res_w9 
                    + res_w10 + res_w11 + res_w12 + res_w13 + res_w14
                    + res_w15 + res_w16 + res_w17 + res_w18 + res_w19
                    + res_w20 + res_w21 + res_w22 + res_w23 + res_w24
                    + res_w25 + res_w26 + res_w27 + res_w28 + res_w29
                    + res_w30 + res_w31;
//din_vld_r
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            din_vld_r <= 0;
        end 
        else begin 
            din_vld_r <= din_vld;
        end 
    end

//din_a_r din_b_r
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            din_a_r <= 0;
            din_b_r <= 0;
        end 
        else if(din_vld)begin 
            din_a_r <= din_a;
            din_b_r <= din_b;
        end 
    end    

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout <= 0;
        end  
        else begin 
            dout <= product;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout_vld <= 0;
        end 
        else begin 
            dout_vld <= din_vld_r;
        end 
    end
*/

/*
//方法2     使用2级流水线
    reg     [31:0]      din_a_r     ;
    reg     [31:0]      din_b_r     ;
    reg                 din_vld_r   ;
    reg                 din_vld_r1  ;
    reg                 din_vld_r2  ;

    wire    [63:0]      res_w0      ;
    wire    [63:0]      res_w1      ;
    wire    [63:0]      res_w2      ;
    wire    [63:0]      res_w3      ;
    wire    [63:0]      res_w4      ;
    wire    [63:0]      res_w5      ;
    wire    [63:0]      res_w6      ;
    wire    [63:0]      res_w7      ;

    reg     [63:0]      res_r0      ;
    reg     [63:0]      res_r1      ;
    reg     [63:0]      res_r2      ;
    reg     [63:0]      res_r3      ;
    reg     [63:0]      res_r4      ;
    reg     [63:0]      res_r5      ;
    reg     [63:0]      res_r6      ;
    reg     [63:0]      res_r7      ;

    wire    [63:0]      product_w0  ;
    reg     [63:0]      product_r0  ;

    wire    [63:0]      res_w8      ;
    wire    [63:0]      res_w9      ;
    wire    [63:0]      res_w10     ;
    wire    [63:0]      res_w11     ;
    wire    [63:0]      res_w12     ;
    wire    [63:0]      res_w13     ;
    wire    [63:0]      res_w14     ;
    wire    [63:0]      res_w15     ;

    reg     [63:0]      res_r8      ;
    reg     [63:0]      res_r9      ;
    reg     [63:0]      res_r10     ;
    reg     [63:0]      res_r11     ;
    reg     [63:0]      res_r12     ;
    reg     [63:0]      res_r13     ;
    reg     [63:0]      res_r14     ;
    reg     [63:0]      res_r15     ;

    wire    [63:0]      product_w1  ;
    reg     [63:0]      product_r1  ;

    wire    [63:0]      res_w16     ;
    wire    [63:0]      res_w17     ;
    wire    [63:0]      res_w18     ;
    wire    [63:0]      res_w19     ;
    wire    [63:0]      res_w20     ;
    wire    [63:0]      res_w21     ;
    wire    [63:0]      res_w22     ;
    wire    [63:0]      res_w23     ;

    reg     [63:0]      res_r16     ;
    reg     [63:0]      res_r17     ;
    reg     [63:0]      res_r18     ;
    reg     [63:0]      res_r19     ;
    reg     [63:0]      res_r20     ;
    reg     [63:0]      res_r21     ;
    reg     [63:0]      res_r22     ;
    reg     [63:0]      res_r23     ;

    wire    [63:0]      product_w2  ;
    reg     [63:0]      product_r2  ;

    wire    [63:0]      res_w24     ;
    wire    [63:0]      res_w25     ;
    wire    [63:0]      res_w26     ;
    wire    [63:0]      res_w27     ;
    wire    [63:0]      res_w28     ;
    wire    [63:0]      res_w29     ;
    wire    [63:0]      res_w30     ;
    wire    [63:0]      res_w31     ;

    reg     [63:0]      res_r24     ;
    reg     [63:0]      res_r25     ;
    reg     [63:0]      res_r26     ;
    reg     [63:0]      res_r27     ;
    reg     [63:0]      res_r28     ;
    reg     [63:0]      res_r29     ;
    reg     [63:0]      res_r30     ;
    reg     [63:0]      res_r31     ;

    wire    [63:0]      product_w3  ;
    reg     [63:0]      product_r3  ;

    wire    [63:0]      product     ;

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            din_a_r <= 0;
            din_b_r <= 0;
        end 
        else begin 
            din_a_r <= din_a;
            din_b_r <= din_b;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            din_vld_r  <= 0;
            din_vld_r1 <= 0;
            din_vld_r2 <= 0;
        end 
        else begin 
            din_vld_r  <= din_vld;
            din_vld_r1 <= din_vld_r;
            din_vld_r2 <= din_vld_r1;
        end 
    end

    //第一级
    assign res_w0  = din_a_r[0] ?{32'd0,din_b_r      }:64'd0    ;
    assign res_w1  = din_a_r[1] ?{31'd0,din_b_r,1'd0 }:64'd0    ;
    assign res_w2  = din_a_r[2] ?{30'd0,din_b_r,2'd0 }:64'd0    ;
    assign res_w3  = din_a_r[3] ?{29'd0,din_b_r,3'd0 }:64'd0    ;
    assign res_w4  = din_a_r[4] ?{28'd0,din_b_r,4'd0 }:64'd0    ;
    assign res_w5  = din_a_r[5] ?{27'd0,din_b_r,5'd0 }:64'd0    ;
    assign res_w6  = din_a_r[6] ?{26'd0,din_b_r,6'd0 }:64'd0    ;
    assign res_w7  = din_a_r[7] ?{25'd0,din_b_r,7'd0 }:64'd0    ;
    assign res_w8  = din_a_r[8] ?{24'd0,din_b_r,8'd0 }:64'd0    ;
    assign res_w9  = din_a_r[9] ?{23'd0,din_b_r,9'd0 }:64'd0    ;
    assign res_w10 = din_a_r[10]?{22'd0,din_b_r,10'd0}:64'd0    ;
    assign res_w11 = din_a_r[11]?{21'd0,din_b_r,11'd0}:64'd0    ;
    assign res_w12 = din_a_r[12]?{20'd0,din_b_r,12'd0}:64'd0    ;
    assign res_w13 = din_a_r[13]?{19'd0,din_b_r,13'd0}:64'd0    ;
    assign res_w14 = din_a_r[14]?{18'd0,din_b_r,14'd0}:64'd0    ;
    assign res_w15 = din_a_r[15]?{17'd0,din_b_r,15'd0}:64'd0    ;
    assign res_w16 = din_a_r[16]?{16'd0,din_b_r,16'd0}:64'd0    ;
    assign res_w17 = din_a_r[17]?{15'd0,din_b_r,17'd0}:64'd0    ;
    assign res_w18 = din_a_r[18]?{14'd0,din_b_r,18'd0}:64'd0    ;
    assign res_w19 = din_a_r[19]?{13'd0,din_b_r,19'd0}:64'd0    ;
    assign res_w20 = din_a_r[20]?{12'd0,din_b_r,20'd0}:64'd0    ;
    assign res_w21 = din_a_r[21]?{11'd0,din_b_r,21'd0}:64'd0    ;
    assign res_w22 = din_a_r[22]?{10'd0,din_b_r,22'd0}:64'd0    ;
    assign res_w23 = din_a_r[23]?{9'd0 ,din_b_r,23'd0}:64'd0    ;
    assign res_w24 = din_a_r[24]?{8'd0 ,din_b_r,24'd0}:64'd0    ;
    assign res_w25 = din_a_r[25]?{7'd0 ,din_b_r,25'd0}:64'd0    ;
    assign res_w26 = din_a_r[26]?{6'd0 ,din_b_r,26'd0}:64'd0    ;
    assign res_w27 = din_a_r[27]?{5'd0 ,din_b_r,27'd0}:64'd0    ;
    assign res_w28 = din_a_r[28]?{4'd0 ,din_b_r,28'd0}:64'd0    ;
    assign res_w29 = din_a_r[29]?{3'd0 ,din_b_r,29'd0}:64'd0    ;
    assign res_w30 = din_a_r[30]?{2'd0 ,din_b_r,30'd0}:64'd0    ;
    assign res_w31 = din_a_r[31]?{1'd0 ,din_b_r,31'd0}:64'd0    ;

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            res_r0  <= 0;res_r1  <= 0;res_r2  <= 0;res_r3  <= 0;
            res_r4  <= 0;res_r5  <= 0;res_r6  <= 0;res_r7  <= 0;
            res_r8  <= 0;res_r9  <= 0;res_r10 <= 0;res_r11 <= 0;
            res_r12 <= 0;res_r13 <= 0;res_r14 <= 0;res_r15 <= 0;
            res_r16 <= 0;res_r17 <= 0;res_r18 <= 0;res_r19 <= 0;
            res_r20 <= 0;res_r21 <= 0;res_r22 <= 0;res_r23 <= 0;
            res_r24 <= 0;res_r25 <= 0;res_r26 <= 0;res_r27 <= 0;
            res_r28 <= 0;res_r29 <= 0;res_r30 <= 0;res_r31 <= 0;
        end 
        else if(din_vld_r)begin 
            res_r0  <= res_w0 ;res_r1  <= res_w1 ;res_r2  <= res_w2 ;res_r3  <= res_w3 ;
            res_r4  <= res_w4 ;res_r5  <= res_w5 ;res_r6  <= res_w6 ;res_r7  <= res_w7 ;
            res_r8  <= res_w8 ;res_r9  <= res_w9 ;res_r10 <= res_w10;res_r11 <= res_w11;
            res_r12 <= res_w12;res_r13 <= res_w13;res_r14 <= res_w14;res_r15 <= res_w15;
            res_r16 <= res_w16;res_r17 <= res_w17;res_r18 <= res_w18;res_r19 <= res_w19;
            res_r20 <= res_w20;res_r21 <= res_w21;res_r22 <= res_w22;res_r23 <= res_w23;
            res_r24 <= res_w24;res_r25 <= res_w25;res_r26 <= res_w26;res_r27 <= res_w27;
            res_r28 <= res_w28;res_r29 <= res_w29;res_r30 <= res_w30;res_r31 <= res_w31;
        end 
    end

//第二级
    assign product_w0 = res_r0  + res_r1  + res_r2  + res_r3  + res_r4  + res_r5 +  res_r6  + res_r7;
    assign product_w1 = res_r8  + res_r9  + res_r10 + res_r11 + res_r12 + res_r13 + res_r14 + res_r15;
    assign product_w2 = res_r16 + res_r17 + res_r18 + res_r19 + res_r20 + res_r21 + res_r22 + res_r23;
    assign product_w3 = res_r24 + res_r25 + res_r26 + res_r27 + res_r28 + res_r29 + res_r30 + res_r31;

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            product_r0 <= 0;
            product_r1 <= 0;    
            product_r2 <= 0;    
            product_r3 <= 0;    
        end 
        else if(din_vld_r1)begin 
            product_r0 <= product_w0;
            product_r1 <= product_w1;    
            product_r2 <= product_w2;    
            product_r3 <= product_w3;
        end 
    end

//第三级
    assign product = product_r0 + product_r1 + product_r2 + product_r3;

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout <= 0;
        end 
        else if(din_vld_r2)begin 
            dout <= product;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout_vld <= 0;
        end 
        else if(din_vld_r2)begin 
            dout_vld <= 1'b1;
        end 
        else begin 
            dout_vld <= 1'b0;
        end 
    end


*/
//方法3   使用3级流水线  
    reg     [31:0]      din_a_r     ;
    reg     [31:0]      din_b_r     ;
    reg                 din_vld_r   ;

    reg                 din_vld_r0  ;
    reg                 din_vld_r1  ;
    reg                 din_vld_r2  ;

    wire    [63:0]      res0_w0,res0_w1,res0_w2,res0_w3;
    reg     [63:0]      res0_r0,res0_r1,res0_r2,res0_r3;
    
    wire    [63:0]      res1_w0      ;
    reg     [63:0]      res1_r0      ;

    wire    [63:0]      res0_w4,res0_w5,res0_w6,res0_w7;
    reg     [63:0]      res0_r4,res0_r5,res0_r6,res0_r7;

    wire    [63:0]      res1_w1      ;
    reg     [63:0]      res1_r1      ;

    wire    [63:0]      res0_w8,res0_w9,res0_w10,res0_w11;
    reg     [63:0]      res0_r8,res0_r9,res0_r10,res0_r11;

    wire    [63:0]      res1_w2  ;
    reg     [63:0]      res1_r2  ;

    wire    [63:0]      res0_w12,res0_w13,res0_w14,res0_w15;
    reg     [63:0]      res0_r12,res0_r13,res0_r14,res0_r15;

    wire    [63:0]      res1_w3      ;
    reg     [63:0]      res1_r3      ;

    wire    [63:0]      res0_w16,res0_w17,res0_w18,res0_w19;
    reg     [63:0]      res0_r16,res0_r17,res0_r18,res0_r19;

    wire    [63:0]      res1_w4  ;
    reg     [63:0]      res1_r4  ;

    wire    [63:0]      res0_w20,res0_w21,res0_w22,res0_w23;
    reg     [63:0]      res0_r20,res0_r21,res0_r22,res0_r23;

    wire    [63:0]      res1_w5  ;
    reg     [63:0]      res1_r5  ;

    wire    [63:0]      res0_w24,res0_w25,res0_w26,res0_w27;
    reg     [63:0]      res0_r24,res0_r25,res0_r26,res0_r27;
    
    wire    [63:0]      res1_w6  ;
    reg     [63:0]      res1_r6  ;

    wire    [63:0]      res0_w28,res0_w29,res0_w30,res0_w31;
    reg     [63:0]      res0_r28,res0_r29,res0_r30,res0_r31;

    wire    [63:0]      res1_w7  ;
    reg     [63:0]      res1_r7  ;

    wire    [63:0]      res2_w0     ;
    wire    [63:0]      res2_w1     ;
    reg     [63:0]      res2_r0     ;
    reg     [63:0]      res2_r1     ;

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            din_a_r <= 0;
            din_b_r <= 0;
        end 
        else begin 
            din_a_r <= din_a;
            din_b_r <= din_b;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            din_vld_r  <= 0;
            din_vld_r0 <= 0;
            din_vld_r1 <= 0;
            din_vld_r2 <= 0;
        end 
        else begin 
            din_vld_r  <= din_vld;
            din_vld_r0 <= din_vld_r;
            din_vld_r1 <= din_vld_r0;
            din_vld_r2 <= din_vld_r1;
        end 
    end

    //第一级
    assign res0_w0  = din_a_r[0] ?{32'd0,din_b_r      }:64'd0    ;
    assign res0_w1  = din_a_r[1] ?{31'd0,din_b_r,1'd0 }:64'd0    ;
    assign res0_w2  = din_a_r[2] ?{30'd0,din_b_r,2'd0 }:64'd0    ;
    assign res0_w3  = din_a_r[3] ?{29'd0,din_b_r,3'd0 }:64'd0    ;
    
    assign res0_w4  = din_a_r[4] ?{28'd0,din_b_r,4'd0 }:64'd0    ;
    assign res0_w5  = din_a_r[5] ?{27'd0,din_b_r,5'd0 }:64'd0    ;
    assign res0_w6  = din_a_r[6] ?{26'd0,din_b_r,6'd0 }:64'd0    ;
    assign res0_w7  = din_a_r[7] ?{25'd0,din_b_r,7'd0 }:64'd0    ;
    
    assign res0_w8  = din_a_r[8] ?{24'd0,din_b_r,8'd0 }:64'd0    ;
    assign res0_w9  = din_a_r[9] ?{23'd0,din_b_r,9'd0 }:64'd0    ;
    assign res0_w10 = din_a_r[10]?{22'd0,din_b_r,10'd0}:64'd0    ;
    assign res0_w11 = din_a_r[11]?{21'd0,din_b_r,11'd0}:64'd0    ;
    
    assign res0_w12 = din_a_r[12]?{20'd0,din_b_r,12'd0}:64'd0    ;
    assign res0_w13 = din_a_r[13]?{19'd0,din_b_r,13'd0}:64'd0    ;
    assign res0_w14 = din_a_r[14]?{18'd0,din_b_r,14'd0}:64'd0    ;
    assign res0_w15 = din_a_r[15]?{17'd0,din_b_r,15'd0}:64'd0    ;
    
    assign res0_w16 = din_a_r[16]?{16'd0,din_b_r,16'd0}:64'd0    ;
    assign res0_w17 = din_a_r[17]?{15'd0,din_b_r,17'd0}:64'd0    ;
    assign res0_w18 = din_a_r[18]?{14'd0,din_b_r,18'd0}:64'd0    ;
    assign res0_w19 = din_a_r[19]?{13'd0,din_b_r,19'd0}:64'd0    ;
    
    assign res0_w20 = din_a_r[20]?{12'd0,din_b_r,20'd0}:64'd0    ;
    assign res0_w21 = din_a_r[21]?{11'd0,din_b_r,21'd0}:64'd0    ;
    assign res0_w22 = din_a_r[22]?{10'd0,din_b_r,22'd0}:64'd0    ;
    assign res0_w23 = din_a_r[23]?{9'd0 ,din_b_r,23'd0}:64'd0    ;
    
    assign res0_w24 = din_a_r[24]?{8'd0 ,din_b_r,24'd0}:64'd0    ;
    assign res0_w25 = din_a_r[25]?{7'd0 ,din_b_r,25'd0}:64'd0    ;
    assign res0_w26 = din_a_r[26]?{6'd0 ,din_b_r,26'd0}:64'd0    ;
    assign res0_w27 = din_a_r[27]?{5'd0 ,din_b_r,27'd0}:64'd0    ;
    
    assign res0_w28 = din_a_r[28]?{4'd0 ,din_b_r,28'd0}:64'd0    ;
    assign res0_w29 = din_a_r[29]?{3'd0 ,din_b_r,29'd0}:64'd0    ;
    assign res0_w30 = din_a_r[30]?{2'd0 ,din_b_r,30'd0}:64'd0    ;
    assign res0_w31 = din_a_r[31]?{1'd0 ,din_b_r,31'd0}:64'd0    ;

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            res0_r0  <= 0;res0_r1  <= 0;res0_r2  <= 0;res0_r3  <= 0;
            res0_r4  <= 0;res0_r5  <= 0;res0_r6  <= 0;res0_r7  <= 0;
            res0_r8  <= 0;res0_r9  <= 0;res0_r10 <= 0;res0_r11 <= 0;
            res0_r12 <= 0;res0_r13 <= 0;res0_r14 <= 0;res0_r15 <= 0;
            res0_r16 <= 0;res0_r17 <= 0;res0_r18 <= 0;res0_r19 <= 0;
            res0_r20 <= 0;res0_r21 <= 0;res0_r22 <= 0;res0_r23 <= 0;
            res0_r24 <= 0;res0_r25 <= 0;res0_r26 <= 0;res0_r27 <= 0;
            res0_r28 <= 0;res0_r29 <= 0;res0_r30 <= 0;res0_r31 <= 0;
        end 
        else if(din_vld_r)begin 
            res0_r0  <= res0_w0 ;res0_r1  <= res0_w1 ;res0_r2  <= res0_w2 ;res0_r3  <= res0_w3 ;
            res0_r4  <= res0_w4 ;res0_r5  <= res0_w5 ;res0_r6  <= res0_w6 ;res0_r7  <= res0_w7 ;
            res0_r8  <= res0_w8 ;res0_r9  <= res0_w9 ;res0_r10 <= res0_w10;res0_r11 <= res0_w11;
            res0_r12 <= res0_w12;res0_r13 <= res0_w13;res0_r14 <= res0_w14;res0_r15 <= res0_w15;
            res0_r16 <= res0_w16;res0_r17 <= res0_w17;res0_r18 <= res0_w18;res0_r19 <= res0_w19;
            res0_r20 <= res0_w20;res0_r21 <= res0_w21;res0_r22 <= res0_w22;res0_r23 <= res0_w23;
            res0_r24 <= res0_w24;res0_r25 <= res0_w25;res0_r26 <= res0_w26;res0_r27 <= res0_w27;
            res0_r28 <= res0_w28;res0_r29 <= res0_w29;res0_r30 <= res0_w30;res0_r31 <= res0_w31;
        end 
    end

    assign res1_w0 = res0_r0  + res0_r1  + res0_r2  + res0_r3;
    assign res1_w1 = res0_r4  + res0_r5  + res0_r6  + res0_r7;
    assign res1_w2 = res0_r8  + res0_r9  + res0_r10 + res0_r11;
    assign res1_w3 = res0_r12 + res0_r13 + res0_r14 + res0_r15;
    assign res1_w4 = res0_r16 + res0_r17 + res0_r18 + res0_r19;
    assign res1_w5 = res0_r20 + res0_r21 + res0_r22 + res0_r23;
    assign res1_w6 = res0_r24 + res0_r25 + res0_r26 + res0_r27;
    assign res1_w7 = res0_r28 + res0_r29 + res0_r30 + res0_r31;

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            res1_r0 <= 0;
            res1_r1 <= 0;
            res1_r2 <= 0;
            res1_r3 <= 0;
            res1_r4 <= 0;
            res1_r5 <= 0;
            res1_r6 <= 0;
            res1_r7 <= 0;
        end 
        else if(din_vld_r0)begin 
            res1_r0 <= res1_w0;
            res1_r1 <= res1_w1;
            res1_r2 <= res1_w2;
            res1_r3 <= res1_w3;
            res1_r4 <= res1_w4;
            res1_r5 <= res1_w5;
            res1_r6 <= res1_w6;
            res1_r7 <= res1_w7;
        end 
    end

    assign res2_w0 = res1_r0 + res1_r1 + res1_r2 + res1_r3;
    assign res2_w1 = res1_r4 + res1_r5 + res1_r6 + res1_r7;

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            res2_r0 <= 0;
            res2_r1 <= 0;
        end 
        else if(din_vld_r1)begin 
            res2_r0 <= res2_w0;
            res2_r1 <= res2_w1;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout <= 0;
        end 
        else if(din_vld_r2)begin 
            dout <= res2_r0 + res2_r1;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout_vld <= 0;
        end 
        else begin 
            dout_vld <= din_vld_r2;
        end 
    end

endmodule


