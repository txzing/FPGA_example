`include "param.v"
module uart_rx(
    input             clk         ,
    input             rst_n       ,
    input             rx          ,//串转并
    output reg [7:0]  rx_dout     ,
    output reg        rx_dout_vld
);

//中间信号
reg  [2:0]    rx_r        ;//打拍信号     
 
reg  [15:0]   cnt_bps     ;//波特率计数器
wire          add_cnt_bps ;
wire          end_cnt_bps ;

reg  [3:0]    cnt_bit     ;//比特计数器
wire          add_cnt_bit ;
wire          end_cnt_bit ;

reg  [9:0]    rx_data_r   ;//寄存接收的10bit数据
reg           rx_flag     ;

wire          start_edge  ;//数据接收开始边沿，下降沿

//打拍，边沿检测
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        rx_r <= 3'b111;
    end 
    else begin 
        rx_r <= {rx_r[1:0],rx};
    end 
end

assign    start_edge = ~rx_r[1] && rx_r[2]; 

//定义rx_flag
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        rx_flag <= 1'b0;
    end 
    else if(start_edge)begin 
        rx_flag <= 1'b1;
    end 
    else if(end_cnt_bit)begin 
        rx_flag <= 1'b0;
    end
    else begin 
        rx_flag <= rx_flag;  
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

assign add_cnt_bps = rx_flag;
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

//接收10bit数据
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        rx_data_r <= 10'd0;
    end 
    else if(rx_flag && (cnt_bps == (`CLOCK_FRQ/`BAUD_MAX)>>1))begin 
        rx_data_r[cnt_bit] <= rx_r[2];//第一种
    //    rx_data_r <= {rx_r[2],rx_data_r[9:1]};//第二种，移位
    end 
    else begin 
        rx_data_r <= rx_data_r; 
    end 
end
 
//{STOP,tx_din,START};

//rx_dout
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        rx_dout <= 0;
    end 
    else if(end_cnt_bit)begin 
        rx_dout <= rx_data_r[8:1];
    end 
    else begin 
        rx_dout <= rx_dout; 
    end 
end

//rx_dout_vld
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        rx_dout_vld <= 1'b0;
    end 
    else if(end_cnt_bit)begin 
        rx_dout_vld <= 1'b1;
    end 
    else begin 
        rx_dout_vld <= 1'b0; 
    end 
end

endmodule