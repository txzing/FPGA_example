`include "param.v"
module uart_tx (
    input               clk     ,
    input               rst_n   ,
    input   [7:0]       din     ,
    input               din_vld ,
    output  reg         rdy     ,//ready 表示串口发送模块可以接收数据并发送
    output  reg         dout        
);

//信号定义
    reg     [12:0]      cnt_bps     ;
    wire                add_cnt_bps ;
    wire                end_cnt_bps ;

    reg     [3:0]       cnt_bit     ;
    wire                add_cnt_bit ;
    wire                end_cnt_bit ;  

    reg                 tx_flag     ;//发送标志信号
    reg     [9:0]      tx_data     ;//发送的数据 起始位 + 数据位 + 停止位
    
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
    assign add_cnt_bps = tx_flag;
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

//tx_flag
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            tx_flag <= 0;
        end 
        else if(din_vld)begin 
            tx_flag <= 1'b1;
        end 
        else if(end_cnt_bit)begin 
            tx_flag <= 1'b0;
        end 
    end

//tx_data
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            tx_data <= 0;
        end 
        else if(din_vld)begin 
            tx_data <= {1'b1,din,1'b0};//将停止位、数据位、起始位拼接
        end 
    end

//dout
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout <= 1'b1;
        end 
        else if(add_cnt_bps && cnt_bps == 1)begin 
            dout <= tx_data[cnt_bit];
        end 
    end    

//rdy       
/*
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rdy <= 1'b1;
        end 
        else if(din_vld | tx_flag)begin 
            rdy <= 1'b0;
        end 
        else begin 
            rdy <= 1'b1;
        end 
    end
*/
    always @(*)begin 
        if(din_vld | tx_flag)begin
            rdy = 0;
        end 
        else begin 
            rdy = 1;
        end 
    end

endmodule

