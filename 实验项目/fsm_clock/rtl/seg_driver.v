module seg_driver( 
    input				clk		,
    input				rst_n	,
    input	[23:0]		din		,//24λ����Ӧ��������6������� {24'h123456}
    input   [5:0]       din_mask,//6���������ʾ����,�ߵ�ƽ��Ч
    input   [5:0]       point_n ,//�����С����  
//����ܶ˿�
    output reg [7:0]    seg_data,//��ѡ
    output reg [5:0]    seg_sel_n    
);

localparam  ZER = 7'b100_0000,
            ONE = 7'b111_1001,
            TWO = 7'b010_0100,
            THR = 7'b011_0000,
            FOU = 7'b001_1001,
            FIV = 7'b001_0010,
            SIX = 7'b000_0010,
            SEV = 7'b111_1000,
            EIG = 7'b000_0000,
            NIN = 7'b001_0000;
    
    //��������			 
parameter    SHIFT_TIME = 50_000;                      
    //�м��źŶ���		 
reg  [15:0]  cnt    ;
wire         add_cnt;
wire         end_cnt;

reg  [3:0]   num    ;//�Ĵ���Ӧλѡ��������
reg          point_r;

//1ms����λ������
always @(posedge clk or negedge rst_n)begin 
   if(!rst_n)begin
        cnt <= 0;
    end 
    else if(add_cnt)begin 
            if(end_cnt)begin 
                cnt <= 0;
            end
            else begin 
                cnt <= cnt + 1;
            end 
    end
   else  begin
       cnt <= cnt;
    end
end 

assign add_cnt = 1'b1;
assign end_cnt = add_cnt && cnt == SHIFT_TIME - 1'b1;

//ÿ1ms���������������λѡ��λ
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        seg_sel_n <= 6'b111110;
    end 
    else if(end_cnt)begin 
        seg_sel_n <= {seg_sel_n[4:0],seg_sel_n[5]};
    end 
    else begin 
        seg_sel_n <= seg_sel_n; 
    end 
end

//���ݲ�ͬ����ܣ����벻ͬ��ʾ�ַ�
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        num <= 0;
    end                                 
    else case(seg_sel_n | (~din_mask)) //din <= {24'h123456}     din_mask <= 6'b000111;//�ߵ�ƽ��Ч�����Ƶ�������ܵ���
      6'b111110 :begin num <= din[3:0]   ; point_r <= point_n[0]; end 
      6'b111101 :begin num <= din[7:4]   ; point_r <= point_n[1]; end
      6'b111011 :begin num <= din[11:8]  ; point_r <= point_n[2]; end 
      6'b110111 :begin num <= din[15:12] ; point_r <= point_n[3]; end
      6'b101111 :begin num <= din[19:16] ; point_r <= point_n[4]; end
      6'b011111 :begin num <= din[23:20] ; point_r <= point_n[5]; end
        default: begin num <= 4'hf ; point_r <= 1'b1; end
    endcase
end


//����ܶ�ѡ����
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        seg_data <= 8'hff;//ȫ��
    end 
    else case(num) //�����������ʾ������
        4'd0  : seg_data <= {point_r,ZER};
        4'd1  : seg_data <= {point_r,ONE};
        4'd2  : seg_data <= {point_r,TWO};
        4'd3  : seg_data <= {point_r,THR};
        4'd4  : seg_data <= {point_r,FOU};
        4'd5  : seg_data <= {point_r,FIV};
        4'd6  : seg_data <= {point_r,SIX};
        4'd7  : seg_data <= {point_r,SEV};
        4'd8  : seg_data <= {point_r,EIG};
        4'd9  : seg_data <= {point_r,NIN};
        default : seg_data <= 8'hff;
    endcase
         
end
                        
endmodule