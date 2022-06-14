/************************* 模块说明 *************************
1、DS18B20驱动模块，负责实现DS18B20温度转换和温度读取时序，
   并将读取到的二进制温度值转换为十进制温度值；
2、使用主从状态机实现DS18B20测量温度的流程，主状态机实现发：
   复位脉冲-接收存在脉冲-发ROM指令-发温度转换指令-延时-温度读取指令-读取温度；
   从状态机负责发送数据或读取数据时序：拉低总线-发送数据/采样数据-释放总线；
3、最终转换位十进制的温度值是将实际温度值放大了10000倍，如+12.3456-->+123456;

************************* 注释结束 *************************/
module ds18b20_driver(
input                   clk          ,
input                   rst_n        ,
input                   dq_in        ,
output  reg             dq_out       ,
output  reg             dq_out_en    , 
output  reg             temp_sign    ,//温度值符号位 0：正 1：负温
output  reg   [20:0]    temp_out     ,
output  reg             temp_out_vld            
);

//状态机参数

localparam  M_IDLE = 9'b0_0000_0001,
            M_REST = 9'b0_0000_0010,//主机发送复位脉冲状态
            M_RELE = 9'b0_0000_0100,//主机释放总线状态
            M_RACK = 9'b0_0000_1000,//主机接收存在脉冲状态
            M_ROMS = 9'b0_0001_0000,//主机发送跳过ROM状态
            M_CONT = 9'b0_0010_0000,//主机发送温度转换状态
            M_WAIT = 9'b0_0100_0000,//主机等待温度转换完成
            M_RCMD = 9'b0_1000_0000,//主机发送接收温度命令状态
            M_RTMP = 9'b1_0000_0000;//主机接收温度状态

localparam  S_IDLE = 6'b00_0001,
            S_LOW  = 6'b00_0010,//发数据前先拉低总线
            S_SEND = 6'b00_0100,//发送数据
            S_SAMP = 6'b00_1000,//采样数据
            S_RELE = 6'b01_0000,//释放总线
            S_DONE = 6'b10_0000;//读写完成

parameter   TIME_1US  = 20'd50,      //基本时间1us
            TIME_RST  = 20'd500,     //读写前，复位脉冲 500us
            TIME_REL  = 20'd30,      //主机释放总线 30us
            TIME_PRE  = 20'd200,     //主机接收存在脉冲 200us
            TIME_WAIT = 20'd500000,  //主机发完温度转换命令 等待500ms
            TIME_LOW  = 6'd2,       //主机读写开始前拉低总线  至少1us
            TIME_RW   = 6'd60,      //主机读、写1bit  至少60us
            TIME_REC  = 6'd2;       //主机读写完1bit释放总线  至少1us

localparam  CMD_ROMS  = 8'hCC,//跳过RAM命令
            CMD_CONT  = 8'h44,//温度转换命令
            CMD_RTMP  = 8'hBE;//接收温度命令

//信号定义

reg     [8:0]       m_state_c   ;//主状态机
reg     [8:0]       m_state_n   ;
reg     [5:0]       s_state_c   ;//从状态机
reg     [5:0]       s_state_n   ;
reg     [5:0]       cnt_1us     ;//1us计数器
wire                add_cnt_1us ;
wire                end_cnt_1us ;

//主状态机
reg     [19:0]      cnt0        ;//复位脉冲、释放、存在脉冲、等待750ms
wire                add_cnt0    ;
wire                end_cnt0    ;
reg     [19:0]      M_Delay     ;

//从状态机
reg     [5:0]       cnt1        ;//计数从状态机每个状态多少us
wire                add_cnt1    ;
wire                end_cnt1    ;
reg     [5:0]       S_Delay     ;   


reg     [4:0]       cnt_bit     ;//发送接收比特计数器
wire                add_cnt_bit ;
wire                end_cnt_bit ;

reg                 slave_ack   ;//接收存在脉冲
reg                 flag        ;//0：发温度转换命令 1：发温度读取命令

reg     [7:0]       wr_data     ;//存放发送的数据
reg     [15:0]      orign_data  ;//16bit，采样温度值寄存器
reg     [10:0]      temp_data   ;//11bit温度数据

wire                m_idle2m_rest   ;
wire                m_rest2m_rele   ;
wire                m_rele2m_rack   ;
wire                m_rack2m_roms   ;
wire                m_roms2m_cont   ;
wire                m_roms2m_rcmd   ;
wire                m_cont2m_wait   ;
wire                m_wait2m_rest   ;
wire                m_rcmd2m_rtmp   ;
wire                m_rtmp2m_idle   ;

wire                s_idle2s_low    ;
wire                s_low2s_send    ;
wire                s_low2s_samp    ;
wire                s_send2s_rele   ;
wire                s_samp2s_rele   ;
wire                s_rele2s_low    ;
wire                s_rele2s_done   ;


//主状态机设计，控制状态的流程
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        m_state_c <= M_IDLE;
    end 
    else begin 
        m_state_c <= m_state_n;
    end 
end
always @(*)begin 
    case(m_state_c)
        M_IDLE:begin 
            if(m_idle2m_rest)
                m_state_n = M_REST;
            else 
                m_state_n = m_state_c;
        end 
        M_REST:begin 
            if(m_rest2m_rele)
                m_state_n = M_RELE;
            else 
                m_state_n = m_state_c;
        end
        M_RELE:begin 
            if(m_rele2m_rack)
                m_state_n = M_RACK;
            else 
                m_state_n = m_state_c;
        end 
        M_RACK:begin 
            if(m_rack2m_roms)
                m_state_n = M_ROMS;
            else 
                m_state_n = m_state_c;
        end 
        M_ROMS:begin 
            if(m_roms2m_cont)
                m_state_n = M_CONT;//温度转换命令
            else if(m_roms2m_rcmd)
                m_state_n = M_RCMD;//接收温度命令
            else 
                m_state_n = m_state_c;
        end 
        M_CONT:begin 
            if(m_cont2m_wait)
                m_state_n = M_WAIT;
            else 
                m_state_n = m_state_c;
        end 
        M_WAIT:begin 
            if(m_wait2m_rest)
                m_state_n = M_REST;
            else 
                m_state_n = m_state_c;
        end 
        M_RCMD:begin 
            if(m_rcmd2m_rtmp)
                m_state_n = M_RTMP;
            else 
                m_state_n = m_state_c;
        end 
        M_RTMP:begin //接收温度状态
            if(m_rtmp2m_idle)
                m_state_n = M_IDLE;
            else 
                m_state_n = m_state_c;
        end         
        default:m_state_n = M_IDLE;
    endcase 
end

assign      m_idle2m_rest = m_state_c == M_IDLE && (end_cnt_1us);
assign      m_rest2m_rele = m_state_c == M_REST && (end_cnt0);
assign      m_rele2m_rack = m_state_c == M_RELE && (end_cnt0);
assign      m_rack2m_roms = m_state_c == M_RACK && (end_cnt0 && slave_ack == 1'b0);//低电平应答成功
assign      m_roms2m_cont = m_state_c == M_ROMS && (s_state_c == S_DONE && flag == 1'b0);
assign      m_roms2m_rcmd = m_state_c == M_ROMS && (s_state_c == S_DONE && flag == 1'b1);
assign      m_cont2m_wait = m_state_c == M_CONT && (s_state_c == S_DONE);
assign      m_wait2m_rest = m_state_c == M_WAIT && (end_cnt0);
assign      m_rcmd2m_rtmp = m_state_c == M_RCMD && (s_state_c == S_DONE);
assign      m_rtmp2m_idle = m_state_c == M_RTMP && (s_state_c == S_DONE);

//从状态机，用于指示总线数据的发送和读取
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        s_state_c <= S_IDLE;
    end 
    else begin 
        s_state_c <= s_state_n;
    end 
end
always @(*)begin 
    case(s_state_c)
        S_IDLE:begin 
            if(s_idle2s_low)
                s_state_n = S_LOW;
            else 
                s_state_n = s_state_c;
        end  
        S_LOW :begin 
            if(s_low2s_send)
                s_state_n = S_SEND;
            else if(s_low2s_samp)
                s_state_n = S_SAMP;
            else 
                s_state_n = s_state_c;
        end  
        S_SEND:begin 
            if(s_send2s_rele)
                s_state_n = S_RELE;//写完1bit释放总线至少1us
            else 
                s_state_n = s_state_c;
        end  
        S_SAMP:begin 
            if(s_samp2s_rele)
                s_state_n = S_RELE; //读完1bit释放总线至少1us
            else 
                s_state_n = s_state_c;
        end  
        S_RELE:begin 
            if(s_rele2s_done)
                s_state_n = S_DONE; //8bit或者16bit数据，写/读完成后，释放总线之后，回到IDLE 
            else if(s_rele2s_low)
                s_state_n = S_LOW;//写、读完1bit再写下一bit
            else 
                s_state_n = s_state_c;
        end  
        S_DONE:begin 
                s_state_n = S_IDLE;
        end  
        default:s_state_n = S_IDLE;
    endcase 
end
assign      s_idle2s_low  = s_state_c == S_IDLE && (m_state_c == M_ROMS || m_state_c == M_CONT || m_state_c == M_RCMD || m_state_c == M_RTMP);//在这些状态下，从机开始发送和接收数据       
assign      s_low2s_send  = s_state_c == S_LOW  && (m_state_c == M_ROMS || m_state_c == M_CONT || m_state_c == M_RCMD) && end_cnt1;   
assign      s_low2s_samp  = s_state_c == S_LOW  && (m_state_c == M_RTMP && end_cnt1);   
assign      s_send2s_rele = s_state_c == S_SEND && (end_cnt1);       
assign      s_samp2s_rele = s_state_c == S_SAMP && (end_cnt1);       
assign      s_rele2s_low  = s_state_c == S_RELE && (end_cnt1 && end_cnt_bit == 1'b0);//在S_RELE状态且end_cnt1时，cnt_bit才累加 
assign      s_rele2s_done = s_state_c == S_RELE && (end_cnt_bit);       

reg enable;



//1us基准计数器
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        cnt_1us <= 0;
    end 
    else if(add_cnt_1us)begin 
            if(end_cnt_1us)begin 
                cnt_1us <= 0;
            end
            else begin 
                cnt_1us <= cnt_1us + 1'b1;
            end 
    end
end 
assign add_cnt_1us = enable;
assign end_cnt_1us = add_cnt_1us && cnt_1us == TIME_1US-1;

	 
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        cnt0 <= 0;
    end 
    else if(add_cnt0)begin 
            if(end_cnt0)begin 
                cnt0 <= 0;
            end
            else begin 
                cnt0 <= cnt0 + 1'b1;
            end 
    end
end 
assign add_cnt0 = (m_state_c == M_REST || m_state_c == M_RELE || m_state_c == M_RACK || m_state_c == M_WAIT) && end_cnt_1us;
assign end_cnt0 = add_cnt0 && cnt0 == M_Delay-1;


always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        M_Delay <= 0;
    end 
    else if(m_state_c == M_REST)begin 
	    M_Delay <= TIME_RST;//主机发送复位脉冲
    end 
    else if(m_state_c == M_RELE)begin 
        M_Delay <= TIME_REL;//主机释放总线
    end 
    else if(m_state_c == M_RACK)begin 
        M_Delay <= TIME_PRE;//主机接收存在脉冲
    end 
    else if(m_state_c == M_WAIT)begin 
        M_Delay <= TIME_WAIT;//主机等待
    end
end

	 
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        cnt1 <= 0;
    end 
    else if(add_cnt1)begin 
            if(end_cnt1)begin 
                cnt1 <= 0;
            end
            else begin 
                cnt1 <= cnt1 + 1'b1;
            end 
    end
end 
assign add_cnt1 = (s_state_c == S_LOW || s_state_c == S_SEND || s_state_c == S_SAMP || s_state_c == S_RELE) && end_cnt_1us;
assign end_cnt1 = add_cnt1 && cnt1 == S_Delay-1;

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        S_Delay <= 0;
    end 
    else if(s_state_c == S_LOW)begin 
        S_Delay <= TIME_LOW;//接收和读取数据前先拉低总线
    end
    else if(s_state_c == S_SEND || s_state_c == S_SAMP)begin 
        S_Delay <= TIME_RW;//主机读写总时间
    end 
    else begin 
        S_Delay <= TIME_REC;//读写完后，释放总线时间
    end 
end

//发送接收比特计数器
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
assign add_cnt_bit = s_state_c == S_RELE && end_cnt1;//读写完成后，释放总线,从而1bit数据累加
assign end_cnt_bit = add_cnt_bit && cnt_bit == ((m_state_c == M_RTMP)?16-1:8-1);

//slave_ack  采样传感器的存在脉冲
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        slave_ack <= 1'b1;
    end 
    else if(m_state_c == M_RACK && cnt0 == 60 && end_cnt_1us)begin 
        slave_ack <= dq_in;
    end 
end

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        flag <= 0;//0：发温度转换命令 1：发温度读取命令
    end 
    else if(m_wait2m_rest)begin
        flag <= 1'b1;
    end 
    else if(m_rtmp2m_idle)begin//温度接收完后，置为0 
        flag <= 1'b0;
    end 
end

//输出信号

//dq_out
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        dq_out <= 0;
    end 
    else if(m_idle2m_rest | s_idle2s_low | m_wait2m_rest | s_rele2s_low)begin 
        dq_out <= 1'b0;//在这些状态下将总线拉低
    end 
    else if(s_low2s_send)begin 
        dq_out <= wr_data[cnt_bit];//发送数据
    end 
end
//dq_out_en
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        dq_out_en <= 0;
    end 
    else if(m_idle2m_rest | s_idle2s_low | s_rele2s_low | m_wait2m_rest)begin 
        dq_out_en <= 1'b1;      //输出 dq_out
    end 
    else if(m_rest2m_rele | s_send2s_rele | s_low2s_samp)begin 
        dq_out_en <= 1'b0;      //不输出 dq_out
    end 
end

/*
    注意: 
         在主机发完复位脉冲后要释放总线；
         发完1bit数据后要释放总线；
         在继续发下一bit的时候，仍然要先拉低总线；
         在读数据时，拉低总线1us后要释放总线；       
*/

//wr_data 
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        wr_data <= 0;
    end 
    else if(m_rack2m_roms)begin 
        wr_data <= CMD_ROMS;
    end 
    else if(m_roms2m_cont)begin 
        wr_data <= CMD_CONT;
    end
    else if(m_roms2m_rcmd)begin 
        wr_data <= CMD_RTMP;
    end 
end

//orign_data
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        orign_data <= 0;
    end 
    else if(s_state_c == S_SAMP && cnt1 == 15 && end_cnt_1us)begin 
        orign_data[cnt_bit] <= dq_in; 
    end 
end

//temp_data
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        temp_data <= 0;
    end 
    else if(s_state_c == S_SAMP && cnt_bit == 15 && s_samp2s_rele)begin 
        if(orign_data[15])
            temp_data <= ~orign_data[10:0] + 1'b1;  //负温 则取反加1 
        else 
            temp_data <= orign_data[10:0];          //正温
    end 
end

/*
实际的温度值为 temp_data * 0.0625;
为了保留4位小数精度，将实际温度值放大了10000倍，
即 temp_data * 625；
*/
//temp_out
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        temp_out <= 0;
    end 
    else if(m_state_c == M_RTMP && s_rele2s_done)begin 
        temp_out <= temp_data * 625;
    end 
end

//temp_out_vld
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            temp_out_vld <= 0;
        end 
        else if(m_rtmp2m_idle) begin 
            temp_out_vld <= m_state_c == M_RTMP && s_rele2s_done;
        end
        else begin
        temp_out_vld <= 1'b0;   
        end
    end

//temp_sign
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            temp_sign <= 0;
        end 
        else if(s_state_c == S_SAMP && cnt_bit == 15 && s_samp2s_rele)begin 
            temp_sign <= orign_data[15];//1:负，0：正
        end
        else begin
        temp_sign <= temp_sign;//1:负，0：正      
    end 
    end

endmodule

