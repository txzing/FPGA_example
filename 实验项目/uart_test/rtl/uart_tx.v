`include "param.v"

module uart_tx( 
    input				clk		  ,
    input				rst_n	  ,
    input  [7:0]        tx_din    ,//待发送数据
    input               tx_din_vld,//指示开始发送数据
    output   reg        tx        ,//并转串
    output   reg        busy  
);								 			 

localparam    START = 1'b0;//起始位
localparam    STOP  = 1'b1;//停止位 

reg  [15:0]   cnt_bps     ;//波特率计数器
wire          add_cnt_bps ;
wire          end_cnt_bps ;

reg  [3:0]    cnt_bit     ;//比特计数器
wire          add_cnt_bit ;
wire          end_cnt_bit ;

reg           tx_flag     ;
reg  [9:0]    tx_data_r   ;//寄存发送数据

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        tx_flag <= 0;
    end 
    else if(tx_din_vld)begin 
        tx_flag <= 1'b1;
    end
    else if(end_cnt_bit)begin 
        tx_flag <= 1'b0;
    end 
    else begin 
        tx_flag <= tx_flag;  
    end 
end

//波特率计数器
always @(posedge clk or negedge rst_n)begin 
   if(!rst_n)begin
        cnt_bps <= 0;
    end 
    else if(add_cnt_bps)begin 
            if(end_cnt_bps)begin 
                cnt_bps <= 0;
            end
            else begin 
                cnt_bps <= cnt_bps + 1;
            end 
    end
   else  begin
       cnt_bps <= cnt_bps;
    end
end 

assign add_cnt_bps = tx_flag;
assign end_cnt_bps = add_cnt_bps && cnt_bps == (`CLOCK_FRQ/`BAUD_MAX) - 1'b1;

//比特计数器
always @(posedge clk or negedge rst_n)begin 
   if(!rst_n)begin
        cnt_bit <= 0;
    end 
    else if(add_cnt_bit)begin 
            if(end_cnt_bit)begin 
                cnt_bit <= 0;
            end
            else begin 
                cnt_bit <= cnt_bit + 1;
            end 
    end
   else  begin
       cnt_bit <= cnt_bit;
    end
end 

assign add_cnt_bit = end_cnt_bps;
assign end_cnt_bit = add_cnt_bit && cnt_bit == 9;


always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        tx_data_r <= 0;
    end 
    else if(tx_din_vld)begin 
        tx_data_r <= {STOP,tx_din,START};
    end 
    else begin 
        tx_data_r <= tx_data_r;
    end 
end

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        tx <= 1'b1;
    end 
    else if(tx_flag && cnt_bps == 1)begin 
        tx <= tx_data_r[cnt_bit];  
    end 
    else begin 
        tx <= tx; 
    end 
end

//busy  组合逻辑约束

//第一种方法 
// assign  busy = tx_din_vld | tx_flag;

//第二种方法
always @(*)begin 
     if(tx_din_vld | tx_flag)begin
        busy = 1'b1;
     end 
     else begin 
        busy = 1'b0;
     end 
end
                  
endmodule