/**************************************功能介绍***********************************
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
    output   reg        alarm_en  ,    //闹钟标志信号
    output              time_1s         //1s的脉冲信号
);	
    //参数定义		
parameter   TIME_1S = 5000_0000;
parameter   CURRENT_TIME = 24'h10_00_00;//初始时间
parameter   ALARM_TIME   = 24'h10_02_00;//闹钟时间
    //中间信号定义		 
reg   [25:0]  cnt_1s; //1s基准时间计数器
wire          add_cnt_1s;
wire          end_cnt_1s;
 
reg   [3:0]   cnt_s_g;//秒个位计数器
wire          add_cnt_s_g;
wire          end_cnt_s_g;

reg   [3:0]   cnt_s_s;//秒十位计s数器
wire          add_cnt_s_s;
wire          end_cnt_s_s;

reg   [3:0]   cnt_m_g;//分个位计数器
wire          add_cnt_m_g;
wire          end_cnt_m_g;

reg   [3:0]   cnt_m_s;//分十位计s数器
wire          add_cnt_m_s;
wire          end_cnt_m_s;

reg   [3:0]   cnt_h_g;//时个位计数器
wire          add_cnt_h_g;
wire          end_cnt_h_g;

reg   [3:0]   cnt_h_s;//时十位计s数器
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

//秒十位
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

//如果时十位小于2，个最大值9
//如果时十位等于2，个最大值3
assign add_cnt_h_g = end_cnt_m_s;
assign end_cnt_h_g = add_cnt_h_g && (cnt_h_g == ((cnt_h_s == 2)?3:9));

//时十位
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

assign   clock_data = {cnt_h_s,cnt_h_g,cnt_m_s,cnt_m_g,cnt_s_s,cnt_s_g};//拼接时间信息
                        
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