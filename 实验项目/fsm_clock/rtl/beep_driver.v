/**************************************功能介绍***********************************
Copyright:			
Date     :			
Author   :			
Version  :			
Description:实现蜂鸣器滴答响，也即响0.5s，停0.5s,持续5s		
*********************************************************************************/
module beep_driver #(parameter TIME_DELAY = 2500_0000)(
    input               clk     ,
    input               rst_n   ,
    input               en      ,
    output  reg         beep_n        
);

    reg     [25:0]      cnt_delay      ;
    wire                add_cnt_delay  ;
    wire                end_cnt_delay  ;

    reg     [3:0]       cnt_10            ;//持续次数计数器
    wire                add_cnt_10     ;
    wire                end_cnt_10     ;

    reg                 add_flag       ;

//1s基准计数器
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            cnt_delay <= 0;
        end 
        else if(add_cnt_delay)begin 
                if(end_cnt_delay)begin 
                    cnt_delay <= 0;
                end
                else begin 
                    cnt_delay <= cnt_delay + 1;
                end 
        end
        else begin 
                cnt_delay <= 0;
        end         
    end 

    assign add_cnt_delay = add_flag;
    assign end_cnt_delay = add_cnt_delay && cnt_delay == TIME_DELAY - 1'b1;

//对0.5s的基准计数器进行计数，也即计数多少秒                                            
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            cnt_10 <= 0;
        end 
        else if(add_cnt_10)begin 
                if(end_cnt_10)begin 
                    cnt_10 <= 0;
                end
                else begin 
                    cnt_10 <= cnt_10 + 1;
                end 
        end
        else begin 
            cnt_10 <= cnt_10;//一定要保持，而不是清零
        end 
    end 
    assign add_cnt_10 = end_cnt_delay;
    assign end_cnt_10 = add_cnt_10 && cnt_10 == 10-1;//滴答持续5s,,,对500ms计数10次

//计数器计数开始计数标志信号
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            add_flag <= 1'b0;
        end 
        else if(add_flag == 1'b0 && en)begin 
            add_flag <= 1;
        end 
        else if(add_flag == 1'b1 &&end_cnt_10)begin 
            add_flag <= 0;
        end 
    end

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            beep_n <= 1'b1;
        end 
        else if(add_flag)begin //在10s的滴答时间内
                if(end_cnt_delay)begin //每1s计数完 
                    beep_n <= ~beep_n;
                end 
        end
        else begin 
            beep_n <= 1'b1;
        end 
    end

endmodule   
