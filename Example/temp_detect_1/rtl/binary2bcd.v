module binary2bcd #(parameter DIN_W = 19,DOUT_W = 24)(
input                         clk         ,//时钟
input                         rst_n       ,//复位
input                         en          ,
input          [DIN_W-1:0]    binary_din  ,//输入二进制数据
//输出信号定义
output    reg  [DOUT_W-1:0]   bcd_dout    ,   //输出BCD码数据
output    reg                 bcd_dout_vld 
);

//状态机参数定义
localparam    IDLE  = 3'b001,
              SHIFT = 3'b010,
              DONE  = 3'b100;

//信号定义

reg     [2:0]       state_c ;
reg     [2:0]       state_n ;

reg     [DIN_W-1:0] 	    din_r   ;       //数据锁存
reg     [4:0]       shift_cnt;      //移位次数计数器
wire                add_shift_cnt;
wire                end_shift_cnt;

reg     [3:0]       data0;      //如果输入数据位宽改变了，那么这里的位宽也需要相应改变
reg     [3:0]       data1;
reg     [3:0]       data2;
reg     [3:0]       data3;
reg     [3:0]       data4;
reg     [3:0]       data5;
reg     [3:0]       data6;

wire    [3:0]       data_tmp0;
wire    [3:0]       data_tmp1;
wire    [3:0]       data_tmp2;
wire    [3:0]       data_tmp3;
wire    [3:0]       data_tmp4;
wire    [3:0]       data_tmp5;
wire    [3:0]       data_tmp6;

wire                idle2shift_start; 
wire                shift2done_start;
wire                done2idle_start ;

always @(posedge clk or negedge rst_n) begin 
    if (!rst_n) begin
        state_c <= IDLE ;
    end
    else begin
        state_c <= state_n;
   end
end

always @(*) begin 
    case(state_c)  
        IDLE :begin
            if(idle2shift_start) 
                state_n = SHIFT ;
            else 
                state_n = state_c ;
        end
        SHIFT :begin
            if(shift2done_start) 
                state_n = DONE ;
            else 
                state_n = state_c ;
        end
        DONE :begin
            if(done2idle_start) 
                state_n = IDLE ;
            else 
                state_n = state_c ;
        end
        default : state_n = IDLE ;
    endcase
end

assign idle2shift_start = state_c==IDLE  && (en == 1'b1);
assign shift2done_start = state_c==SHIFT && (end_shift_cnt);
assign done2idle_start  = state_c==DONE      ;

always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        shift_cnt <= 0;
    end
    else if(add_shift_cnt)begin
			  if(end_shift_cnt)
					shift_cnt <= 0;
			  else
					shift_cnt <= shift_cnt + 1'b1;
    end
end

assign add_shift_cnt = state_c==SHIFT;       
assign end_shift_cnt = add_shift_cnt && shift_cnt == DIN_W-1;   

//din_r
always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        din_r <= 0;
    end
    else if(state_c == SHIFT)begin    //移位状态下，每个时钟周期向左移1位
        din_r <= din_r << 1'b1;
    end
    else begin                      //否则的话就保持binary_din的值
        din_r <= binary_din;        
    end
end

//data0 
always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        data0 <= 4'd0;
        data1 <= 4'd0;
        data2 <= 4'd0;
        data3 <= 4'd0;
        data4 <= 4'd0;
		data5 <= 4'd0;
        data6 <= 4'd0;
    end
    else if(state_c == SHIFT)begin  //移位寄存器
        data0 <= {data_tmp0[2:0],din_r[DIN_W-1]};
        data1 <= {data_tmp1[2:0],data_tmp0[3]};
        data2 <= {data_tmp2[2:0],data_tmp1[3]};
        data3 <= {data_tmp3[2:0],data_tmp2[3]};
        data4 <= {data_tmp4[2:0],data_tmp3[3]};
		data5 <= {data_tmp5[2:0],data_tmp4[3]};
        data5 <= {data_tmp6[2:0],data_tmp5[3]};
    end
    else  begin  //移位寄存器
        data0 <= 4'd0;
        data1 <= 4'd0;
        data2 <= 4'd0;
        data3 <= 4'd0;
        data4 <= 4'd0;
		data5 <= 4'd0;
        data6 <= 4'd0;
    end
end

assign     data_tmp0 = (data0 > 4'd4)?(data0 + 4'd3):data0;
assign     data_tmp1 = (data1 > 4'd4)?(data1 + 4'd3):data1;
assign     data_tmp2 = (data2 > 4'd4)?(data2 + 4'd3):data2;
assign     data_tmp3 = (data3 > 4'd4)?(data3 + 4'd3):data3;
assign     data_tmp4 = (data4 > 4'd4)?(data4 + 4'd3):data4;
assign     data_tmp5 = (data5 > 4'd4)?(data5 + 4'd3):data5;
assign     data_tmp6 = (data6 > 4'd4)?(data6 + 4'd3):data6;

always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        bcd_dout <= 0;
    end
    else if(state_c == DONE)begin
        bcd_dout <= {data6,data5,data4,data3,data2,data1,data0};
    end
end

always  @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        bcd_dout_vld <= 1'b0;
    end
    else if(state_c == DONE)begin
        bcd_dout_vld <= 1'b1;
    end
    else begin 
        bcd_dout_vld <= 1'b0;
    end 
end

/*
使用4bit二进制数表示0--9

办法：二进制有多少位就移位多少次，在移位过程中，后三比特值大于4就加三

4'b1111 --> 4'd15  0001 0101 

8‘b0000_0001    第一次移位   
8‘b0000_0011 	第二次移位
8‘b0000_0111   +3  第三次移位  (移位后的3比特大于5，故加3)
8‘b0000_1010   
8‘b0001_0101  (将加三后的值再移位)

每次将剩余的待转换二进制序列最高位左移进BCD码寄存器，
每移一位后判断每一位BCD码是否大于4，若是则加3调整，
否则不变。直至移位结束。注：最后一次移位不需要加3调整。


8'b10010111   -->  8'd151
		
bcd数					二进制数		左移加3
12'b0000_0000_0000		8'b10010111		初值
12'b0000_0000_0001		8'b00101110		第一次移位
12'b0000_0000_0010		8'b01011100		第二次移位
12'b0000_0000_0100		8'b10111000		第三次移位
12'b0000_0000_1001		8'b01110000		第四次移位
12'b0000_0000_1100		8'b01110000		加3
12'b0000_0001_1000		8'b11100000		第五次移位
12'b0000_0001_1011		8'b11100000		加3
12'b0000_0011_0111		8'b11000000		第六次移位
12'b0000_0011_1010		8'b11000000		加3
12'b0000_0111_0101		8'b10000000		第七次移位
12'b0000_1010_1000		8'b10000000		加3
12'b0001_0101_0001		8'b00000000		第八次移位
*/

endmodule


