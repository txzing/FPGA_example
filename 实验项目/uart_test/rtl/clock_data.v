/**************************************���ܽ���***********************************
Copyright:			
Date     :			
Author   :			
Version  :			
Description:		
*********************************************************************************/
module clock_data( 
    input				clk		  ,
    input				rst_n	  ,
    output   [23:0]     clock_data,
    output   reg        alarm_en  ,    //���ӱ�־�ź�
    output              time_1s         //1s�������ź�
);	
    //��������		
parameter   TIME_1S = 5000_0000;
parameter   CURRENT_TIME = 24'h10_00_00;//��ʼʱ��
parameter   ALARM_TIME   = 24'h10_02_00;//����ʱ��
    //�м��źŶ���		 
reg   [25:0]  cnt_1s; //1s��׼ʱ�������
wire          add_cnt_1s;
wire          end_cnt_1s;
 
reg   [3:0]   cnt_s_g;//���λ������
wire          add_cnt_s_g;
wire          end_cnt_s_g;

reg   [3:0]   cnt_s_s;//��ʮλ��s����
wire          add_cnt_s_s;
wire          end_cnt_s_s;

reg   [3:0]   cnt_m_g;//�ָ�λ������
wire          add_cnt_m_g;
wire          end_cnt_m_g;

reg   [3:0]   cnt_m_s;//��ʮλ��s����
wire          add_cnt_m_s;
wire          end_cnt_m_s;

reg   [3:0]   cnt_h_g;//ʱ��λ������
wire          add_cnt_h_g;
wire          end_cnt_h_g;

reg   [3:0]   cnt_h_s;//ʱʮλ��s����
wire          add_cnt_h_s;
wire          end_cnt_h_s;



always @(posedge clk or negedge rst_n)begin 
   if(!rst_n)begin
        cnt_1s <= 0;
    end 
    else if(add_cnt_1s)begin 
            if(end_cnt_1s)begin 
                cnt_1s <= 0;
            end
            else begin 
                cnt_1s <= cnt_1s + 1;
            end 
    end
   else  begin
       cnt_1s <= cnt_1s;
    end
end 

assign add_cnt_1s = 1'b1;
assign end_cnt_1s = add_cnt_1s && cnt_1s == TIME_1S - 1'b1;
assign time_1s = end_cnt_1s;

always @(posedge clk or negedge rst_n)begin 
   if(!rst_n)begin
        cnt_s_g <= CURRENT_TIME[3:0];
    end 
    else if(add_cnt_s_g)begin 
            if(end_cnt_s_g)begin 
                cnt_s_g <= 0;
            end
            else begin 
                cnt_s_g <= cnt_s_g + 1;
            end 
    end
   else  begin
       cnt_s_g <= cnt_s_g;
    end
end 

assign add_cnt_s_g = end_cnt_1s;
assign end_cnt_s_g = add_cnt_s_g && cnt_s_g == 9;

//��ʮλ
always @(posedge clk or negedge rst_n)begin 
   if(!rst_n)begin
        cnt_s_s <= CURRENT_TIME[7:4];
    end 
    else if(add_cnt_s_s)begin 
            if(end_cnt_s_s)begin 
                cnt_s_s <= 0;
            end
            else begin 
                cnt_s_s <= cnt_s_s + 1;
            end 
    end
   else  begin
       cnt_s_s <= cnt_s_s;
    end
end 

assign add_cnt_s_s = end_cnt_s_g;
assign end_cnt_s_s = add_cnt_s_s && cnt_s_s == 5;

always @(posedge clk or negedge rst_n)begin 
   if(!rst_n)begin
        cnt_m_g <= CURRENT_TIME[11:8];
    end 
    else if(add_cnt_m_g)begin 
            if(end_cnt_m_g)begin 
                cnt_m_g <= 0;
            end
            else begin 
                cnt_m_g <= cnt_m_g + 1;
            end 
    end
   else  begin
       cnt_m_g <= cnt_m_g;
    end
end 

assign add_cnt_m_g = end_cnt_s_s;
assign end_cnt_m_g = add_cnt_m_g && cnt_m_g == 9;

always @(posedge clk or negedge rst_n)begin 
   if(!rst_n)begin
        cnt_m_s <= CURRENT_TIME[15:12];
    end 
    else if(add_cnt_m_s)begin 
            if(end_cnt_m_s)begin 
                cnt_m_s <= 0;
            end
            else begin 
                cnt_m_s <= cnt_m_s + 1;
            end 
    end
   else  begin
       cnt_m_s <= cnt_m_s;
    end
end 

assign add_cnt_m_s = end_cnt_m_g;
assign end_cnt_m_s = add_cnt_m_s && cnt_m_s == 5;

always @(posedge clk or negedge rst_n)begin 
   if(!rst_n)begin
        cnt_h_g <= CURRENT_TIME[19:16];
    end 
    else if(add_cnt_h_g)begin 
            if(end_cnt_h_g)begin 
                cnt_h_g <= 0;
            end
            else begin 
                cnt_h_g <= cnt_h_g + 1;
            end 
    end
   else  begin
       cnt_h_g <= cnt_h_g;
    end
end 

//���ʱʮλС��2�������ֵ9
//���ʱʮλ����2�������ֵ3
assign add_cnt_h_g = end_cnt_m_s;
assign end_cnt_h_g = add_cnt_h_g && (cnt_h_g == ((cnt_h_s == 2)?3:9));

//ʱʮλ
always @(posedge clk or negedge rst_n)begin 
   if(!rst_n)begin
        cnt_h_s <= CURRENT_TIME[23:20];
    end 
    else if(add_cnt_h_s)begin 
            if(end_cnt_h_s)begin 
                cnt_h_s <= 0;
            end
            else begin 
                cnt_h_s <= cnt_h_s + 1;
            end 
    end
   else  begin
       cnt_h_s <= cnt_h_s;
    end
end 

assign add_cnt_h_s = end_cnt_h_g;
assign end_cnt_h_s = add_cnt_h_s && cnt_h_s == 2;

assign   clock_data = {cnt_h_s,cnt_h_g,cnt_m_s,cnt_m_g,cnt_s_s,cnt_s_g};//ƴ��ʱ����Ϣ
                        
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        alarm_en <= 1'b0;
    end 
    else if(clock_data == ALARM_TIME)begin 
        alarm_en <= 1'b1;
    end 
    else begin 
        alarm_en <= 1'b0;
    end 
end




endmodule