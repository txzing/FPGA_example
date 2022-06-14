`include "param.v"
module uart_rx (
    input               clk     ,
    input               rst_n   ,

    input               din     ,
    output reg  [7:0]   dout    ,
    output reg          dout_vld
);
//信号定义

    reg     [12:0]      cnt_bps     ;
    wire                add_cnt_bps ;
    wire                end_cnt_bps ;

    reg     [3:0]       cnt_bit     ;
    wire                add_cnt_bit ;
    wire                end_cnt_bit ;  
  
    reg                 din_r0      ;//同步串口输入
    reg                 din_r1      ;//打拍
    wire                nedge       ;//下降沿

    reg                 rx_flag     ;//接收标志信号
    reg     [9:0]       rx_data     ;//接收寄存器


//计数器设计

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
    end 
    assign add_cnt_bps = rx_flag;
    assign end_cnt_bps = add_cnt_bps && cnt_bps == `BAUD-1;

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
    end 
    assign add_cnt_bit = end_cnt_bps;
    assign end_cnt_bit = add_cnt_bit && cnt_bit == 10-1;

//rx_flag
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rx_flag <= 0;
        end 
        else if(nedge)begin 
            rx_flag <= 1'b1;
        end 
        else if(end_cnt_bit)begin 
            rx_flag <= 1'b0;
        end 
    end

//同步 打拍 检测边沿

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            din_r0 <= 1'b1;
            din_r1 <= 1'b1;
        end 
        else begin 
            din_r0 <= din;
            din_r1 <= din_r0;
        end 
    end

    assign nedge = ~din_r0 & din_r1;

//rx_data
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rx_data <= 0;
        end 
        else if(add_cnt_bps && cnt_bps == (`BAUD>>1))begin 
            rx_data[cnt_bit] <= din;
            //rx_data <= {din,rx_data[10:1]};//右移
        end 
    end

//dout
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout <= 0;
        end 
        else begin 
            dout <= rx_data[8:1];
        end 
    end

//dout_vld
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout_vld <= 0;
        end 
        else begin 
            dout_vld <= end_cnt_bit;
        end 
    end

endmodule
