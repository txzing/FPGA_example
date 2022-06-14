module control (
    input                   clk            ,
    input                   rst_n          ,
    input           [2:0]   key            ,//输入的按键消抖后的信号
    output  reg     [23:0]  dout           ,
    output  reg     [5:0]   dout_mask      ,
    output  reg     [3:0]   led            ,
    output  reg             beep_en 
);

/**************************************功能介绍***********************************		
Description:运用了开发板上4个按键，4个led灯，6个数码管
开发板上电后，无现象，只有按下第二个按键即key[0](第一个按键用于复位)后，
开始选择商品操作，按下key[0]选择第一种商品，再次按下key[0]选中第二种商品，商品A,3块；商品B,8块
key[1]按下代表对应商品数量+1，数码管会有对应的显示变化
商品选择好后，按下key[2]进入投币操作，按下key[0]代表1块，再次按下key[1]代表5块
数码管会显示商品金额与已投币金额,币投好后按下key[2]进行确定
在确定过程中会进行判断，投币总金额是否大于等于所选商品总价
若大于，进入出货环节，出货过程中持续5s，流水灯左移，蜂鸣器响
若小于，进入等待环节，等待再次投币，持续5s,流水灯右移,若投币总金额仍小于所选商品总价，则返回IDLE
*********************************************************************************/
//参数定义

    localparam  IDLE   = 5'b00001,  //状态机参数
                SELECT = 5'b00010,  //选择     
                INCOIN = 5'b00100,  //投币
                OUT    = 5'b01000,  //出货
                WAIT   = 5'b10000;  //等待

    localparam  PRICE_A = 3,    //商品价格
                PRICE_B = 8;

    parameter   TIME_1S = 50_000_000;//1s定时

//定义信号

reg     [4:0]       state_c     ;
reg     [4:0]       state_n     ;

reg     [25:0]      cnt_1s      ;//1s基准时间计数器
wire                add_cnt_1s  ;
wire                end_cnt_1s  ;   

reg     [2:0]       cnt_5s      ;//对1s进行计数
wire                add_cnt_5s  ;
wire                end_cnt_5s  ;    
reg     [1:0]       sel_flag    ;//选择哪个商品 选择多个商品时只需修改位宽，目前只有两个商品

reg     [3:0]       num_a       ;//A商品的数量 3元
wire    [7:0]       sum_a       ;//商品A的总价

reg     [3:0]       num_b       ;//B商品的数量 8元
wire    [7:0]       sum_b       ;//商品B的总价

reg     [7:0]       sum         ;//所选商品的总价
wire    [3:0]       sum_0       ;//所选商品的总价的个位，，，二进制转bcd码，直接转耗费资源
wire    [3:0]       sum_1       ;//所选商品的总价的十位
wire    [3:0]       sum_2       ;//所选商品的总价的百位

reg     [7:0]       money_in    ;//投币总金额
wire    [3:0]       money_in_0  ;//投币总金额的个位
wire    [3:0]       money_in_1  ;//投币总金额的十位
wire    [3:0]       money_in_2  ;//投币总金额的百位    

wire                idle2select     ;
wire                select2incoin   ;
wire                incoin2out      ;
wire                incoin2wait     ;
wire                out2idle        ;
wire                wait2out        ;       
wire                wait2idle       ;

//状态机，第一段，描述状态转移
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        state_c <= IDLE;
    end 
    else begin 
        state_c <= state_n;
    end 
end

//第二段，描述状态转移规律
always @(*)begin 
    case (state_c)
        IDLE  :begin 
            if(idle2select)
                state_n = SELECT;
            else 
                state_n = state_c;
        end 
        SELECT:begin 
            if(select2incoin)
                state_n = INCOIN;
            else 
                state_n = state_c;
        end 
        INCOIN:begin 
            if(incoin2out)
                state_n = OUT;
            else if(incoin2wait)
                state_n = WAIT;
            else 
                state_n = state_c;
        end 
        OUT   :begin 
            if(out2idle)
                state_n = IDLE;
            else 
                state_n = state_c;
        end 
        WAIT  :begin 
            if(wait2out)
                state_n = OUT;
            else if(wait2idle)
                state_n = IDLE;
            else         
                state_n = state_c;
        end  
        default:state_n = IDLE;
    endcase
end

assign idle2select   = state_c == IDLE   && (key[0]);
assign select2incoin = state_c == SELECT && (key[2]);
assign incoin2out    = state_c == INCOIN && (key[2] && sum <= money_in);//所选商品总价小于等于投币总金额
assign incoin2wait   = state_c == INCOIN && (key[2] && sum > money_in);//投币金额不到位
assign out2idle      = state_c == OUT    && (end_cnt_5s);
assign wait2out      = state_c == WAIT   && (end_cnt_5s && sum <= money_in);
assign wait2idle     = state_c == WAIT   && (end_cnt_5s && sum > money_in);

//cnt_1s
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
    else begin 
        cnt_1s <= 0;
    end 
end 
assign add_cnt_1s = state_c == WAIT || state_c == OUT;
assign end_cnt_1s = add_cnt_1s && cnt_1s == TIME_1S-1;

//cnt_5s   5秒计数
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        cnt_5s <= 0;
    end 
    else if(add_cnt_5s)begin 
            if(end_cnt_5s)begin 
                cnt_5s <= 0;
            end
            else begin 
                cnt_5s <= cnt_5s + 1;
            end 
    end
    else begin 
        cnt_5s <= cnt_5s ;
    end 
end 
assign add_cnt_5s = end_cnt_1s;
assign end_cnt_5s = add_cnt_5s && cnt_5s == 5-1;


//sel_flag  选择购买哪个商品，可以重复选择
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        sel_flag <= 2'b01;//初始先选择第一种商品
    end 
    else if(state_c == SELECT && key[0])begin //按下key[0]选择第一种商品，再次按下key[0]选中第二种商品
        sel_flag <= {sel_flag[0],sel_flag[1]};//左移
    end 
    else if(wait2idle | out2idle)begin 
        sel_flag <= sel_flag;
    end 
end

//num_a num_b 选择商品数量
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        num_a <= 0;
        num_b <= 0;
    end
    else if(state_c == SELECT && key[1] && sel_flag[0])begin //key[1]按下代表对应商品数量+1 
        num_a <= num_a + 1'b1; //商品A数量+1
        num_b <= num_b;
    end
    else if(state_c == SELECT && key[1] && sel_flag[1])begin 
        num_a <= num_a;
        num_b <= num_b + 1'b1;
    end 
    else if(wait2idle | out2idle)begin 
        num_a <= 0;
        num_b <= 0;
    end 
end
   

//计算每类商品的总价
assign sum_a   = num_a * PRICE_A;  //乘法组合逻辑
assign sum_b   = num_b * PRICE_B;


//sum 计算所选商品总价
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        sum <= 0;
    end 
    else begin 
        sum <= sum_a + sum_b;
    end 
end

assign sum_0 = sum%10;    //个位
assign sum_1 = sum/10%10; //十位
assign sum_2 = sum/100;   //百位

//money_in
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        money_in <= 0;
    end 
    else if((state_c == INCOIN || state_c == WAIT) && key[0])begin //在INCOIN和WAIT状态可以投币
        money_in <= money_in + 1;//投币环节，key[0]代表1块
    end 
    else if((state_c == INCOIN || state_c == WAIT) && key[1])begin 
        money_in <= money_in + 5;//投币环节，key[1]代表5块
    end 
    else if(wait2idle | out2idle)begin 
        money_in <= 0;
    end 
end

assign money_in_0 = money_in%10 ;   //投币个位
assign money_in_1 = money_in/10%10 ;//十位
assign money_in_2 = money_in/100 ;  //百位  

//dout，相应状态下的输出
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        dout      <= 0;
        dout_mask <= 6'b000_000;//数码管全灭
    end 
    else begin 
        case(state_c)
            IDLE  :begin 
                dout      <= 0;
                dout_mask <= 6'b000_000;//数码管全灭
            end 
            SELECT:begin      //指示B,选中B的数量，B的价格                 
                dout      <= {4'hB,num_b,4'd8,4'hA,num_a,4'd3};//提示A，B两种商品数量及价格
                dout_mask <= 6'b111_111;//数码管全亮
            end 
            INCOIN:begin       
                dout      <= {sum_2,sum_1,sum_0,money_in_2,money_in_1,money_in_0};//商品金额与投币金额
                dout_mask <= 6'b111_111;//数码管全亮
            end 
            OUT   :begin 
                dout      <= {4'h0,4'hD,8'd0,money_in-sum};//提示出货
                dout_mask <= 6'b110_011;//第三个第四个数码管熄灭
            end 
            WAIT  :begin  //等待继续投钱
                dout      <= {sum_2,sum_1,sum_0,money_in_2,money_in_1,money_in_0};
                dout_mask <= 6'b111_111;
            end   
            default:;              
        endcase 
    end 
end

//在出货和等待过程中，控制led灯
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        led <= 4'b0000;
    end 
    else if(wait2out)begin//出货过程要5s,流水灯左移 
        led <= 4'b0000;
    end 
    else if(state_c == OUT && end_cnt_1s)begin//出货过程要5s,流水灯左移 
        led <= {led[2:0],~led[3]};
    end 
    else if(state_c == WAIT && end_cnt_1s)begin //等待过程中,流水灯右移
        led <= {~led[0],led[3:1]};
    end
	  else if(state_c == IDLE)begin
        led <= 4'b0000;
    end  
end

//出货结束蜂鸣器响，进行提示
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        beep_en <= 1'b0;
    end 
    else if(out2idle)begin 
        beep_en <= 1'b1;
    end 
    else begin 
        beep_en <= 1'b0; 
    end 
end

endmodule 
