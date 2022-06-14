/**************************************功能介绍***********************************
Copyright:			
Date     :			
Author   :			
Version  :			
Description:定时发送数据模块		
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
    //参数定义
    parameter   BYTE_NUM = 19;//一次发送19个字节数据

reg   [(BYTE_NUM*8)-1:0]    send_data;//寄存发送信息
reg                         en_flag  ;//模块工作开关
reg                         send_flag;//发送标志信号   

reg   [7:0]  cnt    ;//发送字节计数器,最大发送255个字节
wire         add_cnt;
wire         end_cnt;

wire  [23:0] clock_data;
wire         start_send;


//send_flag作为模块工作开关
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

//波特率是115200，，，，1s内最大可以发送115200个bit,11520个字节

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
                    };//拼接发送数据信息
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
    else if(send_flag && !tx_busy)begin //send_flag==1且发送模块空闲
        tx_dout_vld <= 1'b1;
    end 
    else begin 
        tx_dout_vld <= 1'b0;
    end 
end

//发送字节计数器，统计发送的多少字节
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
/*output   reg      */.alarm_en  (),//闹钟标志信号
/*output            */.time_1s   (start_send) //1s的脉冲信号
);
                    
endmodule
