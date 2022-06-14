module binary2bcd #(parameter DIN_W = 19,DOUT_W = 24)(
input                         clk         ,//ʱ��
input                         rst_n       ,//��λ
input                         en          ,
input          [DIN_W-1:0]    binary_din  ,//�������������
//����źŶ���
output    reg  [DOUT_W-1:0]   bcd_dout    ,   //���BCD������
output    reg                 bcd_dout_vld 
);

//״̬����������
localparam    IDLE  = 3'b001,
              SHIFT = 3'b010,
              DONE  = 3'b100;

//�źŶ���

reg     [2:0]       state_c ;
reg     [2:0]       state_n ;

reg     [DIN_W-1:0] 	    din_r   ;       //��������
reg     [4:0]       shift_cnt;      //��λ����������
wire                add_shift_cnt;
wire                end_shift_cnt;

reg     [3:0]       data0;      //�����������λ��ı��ˣ���ô�����λ��Ҳ��Ҫ��Ӧ�ı�
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
    else if(state_c == SHIFT)begin    //��λ״̬�£�ÿ��ʱ������������1λ
        din_r <= din_r << 1'b1;
    end
    else begin                      //����Ļ��ͱ���binary_din��ֵ
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
    else if(state_c == SHIFT)begin  //��λ�Ĵ���
        data0 <= {data_tmp0[2:0],din_r[DIN_W-1]};
        data1 <= {data_tmp1[2:0],data_tmp0[3]};
        data2 <= {data_tmp2[2:0],data_tmp1[3]};
        data3 <= {data_tmp3[2:0],data_tmp2[3]};
        data4 <= {data_tmp4[2:0],data_tmp3[3]};
		data5 <= {data_tmp5[2:0],data_tmp4[3]};
        data5 <= {data_tmp6[2:0],data_tmp5[3]};
    end
    else  begin  //��λ�Ĵ���
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
ʹ��4bit����������ʾ0--9

�취���������ж���λ����λ���ٴΣ�����λ�����У���������ֵ����4�ͼ���

4'b1111 --> 4'd15  0001 0101 

8��b0000_0001    ��һ����λ   
8��b0000_0011 	�ڶ�����λ
8��b0000_0111   +3  ��������λ  (��λ���3���ش���5���ʼ�3)
8��b0000_1010   
8��b0001_0101  (���������ֵ����λ)

ÿ�ν�ʣ��Ĵ�ת���������������λ���ƽ�BCD��Ĵ�����
ÿ��һλ���ж�ÿһλBCD���Ƿ����4���������3������
���򲻱䡣ֱ����λ������ע�����һ����λ����Ҫ��3������


8'b10010111   -->  8'd151
		
bcd��					��������		���Ƽ�3
12'b0000_0000_0000		8'b10010111		��ֵ
12'b0000_0000_0001		8'b00101110		��һ����λ
12'b0000_0000_0010		8'b01011100		�ڶ�����λ
12'b0000_0000_0100		8'b10111000		��������λ
12'b0000_0000_1001		8'b01110000		���Ĵ���λ
12'b0000_0000_1100		8'b01110000		��3
12'b0000_0001_1000		8'b11100000		�������λ
12'b0000_0001_1011		8'b11100000		��3
12'b0000_0011_0111		8'b11000000		��������λ
12'b0000_0011_1010		8'b11000000		��3
12'b0000_0111_0101		8'b10000000		���ߴ���λ
12'b0000_1010_1000		8'b10000000		��3
12'b0001_0101_0001		8'b00000000		�ڰ˴���λ
*/

endmodule


