/**************************************���ܽ���***********************************
Copyright:			
Date     :			
Author   :			
Version  :			
Description:��ʱ��������ģ��		
*********************************************************************************/
`include "param.v"
module timer_send( 
    input			   clk		    ,
    input			   rst_n	    ,
    input              en           ,
    input              tx_busy      ,
    output  reg [7:0]  tx_dout      ,
    output  reg        tx_dout_vld
);								 
    //��������
    parameter   BYTE_NUM = 19;//һ�η���19���ֽ�����

reg   [(BYTE_NUM*8)-1:0]    send_data;//�Ĵ淢����Ϣ
reg                         en_flag  ;//ģ�鹤������
reg                         send_flag;//���ͱ�־�ź�   

reg   [7:0]  cnt    ;//�����ֽڼ�����,�����255���ֽ�
wire         add_cnt;
wire         end_cnt;

wire  [23:0] clock_data;
wire         start_send;


//send_flag��Ϊģ�鹤������
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        en_flag <= 1'b0;
    end 
    else if(en)begin 
        en_flag <= ~en_flag; 
    end 
    else begin 
        en_flag <= en_flag;  
    end 
end

//��������115200��������1s�������Է���115200��bit,11520���ֽ�

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        send_flag <= 1'b0;
    end
    else if(en_flag && end_cnt)begin 
        send_flag <= 1'b0;
    end 
    else if(en_flag && start_send)begin 
        send_flag <= 1'b1;
    end 
    else begin 
        send_flag <= send_flag;
    end 
end

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        send_data <= 0;
    end 
    else if(start_send)begin 
        send_data <= {`CURTENT_TIME,":","0"+clock_data[23:20],"0"+clock_data[19:16],":",
                      "0"+clock_data[15:12],"0"+clock_data[11:8],":","0"+clock_data[7:4],
                      "0"+clock_data[3:0],"\r","\n" 
                    };//ƴ�ӷ���������Ϣ
    end 
    else begin 
        send_data <= send_data; 
    end 
end

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        tx_dout <= 8'd0;
    end 
    else if(send_flag && !tx_busy)begin 
        tx_dout <= send_data[((BYTE_NUM*8)-1)-(cnt*8) -:8];
    end 
    else begin 
        tx_dout <= tx_dout;
    end 
end

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        tx_dout_vld <= 1'b0;
    end  
    else if(send_flag && !tx_busy)begin //send_flag==1�ҷ���ģ�����
        tx_dout_vld <= 1'b1;
    end 
    else begin 
        tx_dout_vld <= 1'b0;
    end 
end

//�����ֽڼ�������ͳ�Ʒ��͵Ķ����ֽ�
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

assign add_cnt = tx_dout_vld;
assign end_cnt = add_cnt && cnt == BYTE_NUM - 1;   	 


clock_data  u_clock_data( 
/*input				*/.clk		 (clk),
/*input				*/.rst_n	 (rst_n),
/*output   [23:0]   */.clock_data(clock_data),
/*output   reg      */.alarm_en  (),//���ӱ�־�ź�
/*output            */.time_1s   (start_send) //1s�������ź�
);
                    
endmodule
