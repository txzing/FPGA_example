module clock  (
    input                       clk        ,     
    input                       rst_n      ,     
    input       [2:0]           key        ,     
    output  reg [23:0]          dout       ,
    output  reg [5:0]           dout_mask  ,
    output  reg                 beep_en     //整点、闹铃 提示

);

/**************************************功能介绍***********************************			
Description: 数字时钟  默认状态为IDLE，正常计时
1、key[0]:进入设置时间；key[1]:选择时分秒哪位设置时间；
   key[2]:对所选的每一位设置时间；设置完成后，key[0]:退出。
2、key[1]:进入设置闹铃；key[0]:选择哪位设置闹铃时间；
   key[2]:对所选的每一位设置闹铃；设置完成后，key[1]：退出。
3、整点或闹铃时间到，蜂鸣器提示。
*********************************************************************************/

parameter   TIME_1S = 5000_0000        ;
parameter   CURRENT_TIME = 24'h10_00_00;//初始时间
parameter   ALARM_TIME   = 24'h10_02_00;//闹钟时间

//状态参数
    localparam  IDLE      = 3'b001,//正常计时
                SET_TIME  = 3'b010,//设置时间
                SET_ALARM = 3'b100;//设置闹铃

//信号定义
reg     [2:0]     state_c     ;
reg     [2:0]     state_n     ;

reg     [25:0]    cnt_1s      ;//1s计数器
wire              add_cnt_1s  ;
wire              end_cnt_1s  ;

reg   [3:0]       cnt_s_g      ;//秒个位计数器
wire              add_cnt_s_g  ;
wire              end_cnt_s_g  ;
     
reg   [3:0]       cnt_s_s      ;//秒十位计s数器
wire              add_cnt_s_s  ;
wire              end_cnt_s_s  ;
     
reg   [3:0]       cnt_m_g      ;//分个位计数器
wire              add_cnt_m_g  ;
wire              end_cnt_m_g  ;
     
reg   [3:0]       cnt_m_s      ;//分十位计s数器
wire              add_cnt_m_s  ;
wire              end_cnt_m_s  ;
     
reg   [3:0]       cnt_h_g      ;//时个位计数器
wire              add_cnt_h_g  ;
wire              end_cnt_h_g  ;
    
reg   [3:0]       cnt_h_s      ;//时十位计s数器
wire              add_cnt_h_s  ;
wire              end_cnt_h_s  ;

reg   [3:0]       set_s_g      ;//设置秒个位时间寄存器 
wire              add_set_s_g  ;
wire              end_set_s_g  ; 
reg   [3:0]       set_s_s      ;//设置秒十位时间寄存器 
wire              add_set_s_s  ;
wire              end_set_s_s  ;   
reg   [3:0]       set_m_g      ;//设置分个位时间寄存器
wire              add_set_m_g  ;
wire              end_set_m_g  ;     
reg   [3:0]       set_m_s      ;//设置分十位时间寄存器
wire              add_set_m_s  ;
wire              end_set_m_s  ;    
reg   [3:0]       set_h_g      ;//设置时个位时间寄存器
wire              add_set_h_g  ;
wire              end_set_h_g  ;    
reg   [3:0]       set_h_s      ;//设置时十位时间寄存器  
wire              add_set_h_s  ;
wire              end_set_h_s  ;  
reg   [5:0]       set_flag     ;//指示设置时间哪位数

reg   [3:0]       alarm_s_g    ;//设置闹铃秒个位时间寄存器
wire              add_alarm_s_g; 
wire              end_alarm_s_g; 
reg   [3:0]       alarm_s_s    ;//设置闹铃秒十位时间寄存器
wire              add_alarm_s_s; 
wire              end_alarm_s_s;    
reg   [3:0]       alarm_m_g    ;//设置闹铃分个位时间寄存器 
wire              add_alarm_m_g; 
wire              end_alarm_m_g;    
reg   [3:0]       alarm_m_s    ;//设置闹铃分十位时间寄存器
wire              add_alarm_m_s; 
wire              end_alarm_m_s;    
reg   [3:0]       alarm_h_g    ;//设置闹铃时个位时间寄存器
wire              add_alarm_h_g; 
wire              end_alarm_h_g;    
reg   [3:0]       alarm_h_s    ;//设置闹铃时十位时间寄存器
wire              add_alarm_h_s; 
wire              end_alarm_h_s;    
reg   [5:0]       alarm_flag   ;//设置闹钟哪位时间

wire              idle2set_time   ;
wire              idle2set_alarm  ;
wire              set_time2idle   ;
wire              set_alaram2idle ;

//状态机
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        state_c <= IDLE;
    end 
    else begin 
        state_c <= state_n;
    end 
end

always @(*)begin 
    case(state_c)
        IDLE     :begin 
            if(idle2set_time)
                state_n = SET_TIME;
            else if(idle2set_alarm)
                state_n = SET_ALARM;
            else 
                state_n = state_c;
        end 
        SET_TIME :begin 
            if(set_time2idle)
                state_n = IDLE;
            else 
                state_n = state_c;
        end 
        SET_ALARM:begin 
            if(set_alaram2idle)
                state_n = IDLE;
            else 
                state_n = state_c;
        end 
        default:state_n = IDLE;
    endcase 
end

assign idle2set_time   = state_c == IDLE      && (key[0]);  
assign idle2set_alarm  = state_c == IDLE      && (key[1]);  
assign set_time2idle   = state_c == SET_TIME  && (key[0]);  
assign set_alaram2idle = state_c == SET_ALARM && (key[1]);  

//计数器
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
end 
assign add_cnt_1s = state_c == IDLE | state_c == SET_ALARM;//在设置时间和设置闹钟时，计数不停
assign end_cnt_1s = add_cnt_1s && (cnt_1s == TIME_1S-1 | idle2set_time);//设置时间的时候将计数器清零


always @(posedge clk or negedge rst_n)begin 
   if(!rst_n)begin
        cnt_s_g <= CURRENT_TIME[3:0];
    end
    else if(set_time2idle)begin //当时间设置完必须更新时间
        cnt_s_g <= set_s_g;
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
    else if(set_time2idle)begin //当时间设置完必须更新时间
        cnt_s_s <= set_s_s;
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

//分个位
always @(posedge clk or negedge rst_n)begin 
   if(!rst_n)begin
        cnt_m_g <= CURRENT_TIME[11:8];
    end
    else if(set_time2idle)begin //当时间设置完必须更新时间
        cnt_m_g <= set_m_g;
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
    else if(set_time2idle)begin //当时间设置完必须更新时间
        cnt_m_s <= set_m_s;
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
    else if(set_time2idle)begin //当时间设置完必须更新时间
        cnt_h_g <= set_h_g;
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

assign add_cnt_h_g = end_cnt_m_s;
assign end_cnt_h_g = add_cnt_h_g && (cnt_h_g == ((cnt_h_s == 2)?3:9));

//时十位
always @(posedge clk or negedge rst_n)begin 
   if(!rst_n)begin
        cnt_h_s <= CURRENT_TIME[23:20];
    end 
    else if(set_time2idle)begin //当时间设置完必须更新时间
        cnt_h_s <= set_h_s;
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


//set_flag   ,,,设置时间时根据key[1]控制对哪一位进行设置，，，，可修改，，设置时间时将数码管改为闪烁（0.5s亮，0.5s熄灭）
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        set_flag <= 6'b00_0000;
    end                                                       //在设置时间状态下，总共有3个按键可以用
    else if(idle2set_time)begin                               //第一个按键起到设置时间状态进入和退出
        set_flag <= 6'b100_000;//起初选择对时十位设置           //第二个按键起到切换设置时间单元
    end                                                       //第三个按键起到设置时间单元数值                                                             
    else if(state_c == SET_TIME && key[1])begin  //当key[1]按下依次移位对其他时间位进行设置
        set_flag <= {set_flag[0],set_flag[5:1]};//右移
    end 

end

//set_s_g   set_s_s  set_m_g  set_m_s  set_h_g   set_h_s 

//设置时间时，根据key[2]设置秒个位数值
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        set_s_g <= 0;
    end 
    else if(idle2set_time)begin 
        set_s_g <= 0;
    end 
    else if(add_set_s_g)begin 
            if(end_set_s_g)begin 
                set_s_g <= 0;
            end
            else begin 
                set_s_g <= set_s_g + 1;
            end 
    end
    else  begin
       set_s_g <= set_s_g;
    end
end                                       
assign add_set_s_g = state_c == SET_TIME && set_flag[0] && key[2];
assign end_set_s_g = add_set_s_g && set_s_g == 9;

//设置时间时，根据key[2]设置秒十位数值
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        set_s_s <= 0;
    end 
    else if(idle2set_time)begin 
        set_s_s <= 0;
    end 
    else if(add_set_s_s)begin 
            if(end_set_s_s)begin 
                set_s_s <= 0;
            end
            else begin 
                set_s_s <= set_s_s + 1;
            end 
    end
    else  begin
       set_s_s <= set_s_s;
    end
end 
assign add_set_s_s = state_c == SET_TIME && set_flag[1] && key[2];
assign end_set_s_s = add_set_s_s && set_s_s == 5;

//设置时间时，根据key[2]设置分个位数值
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        set_m_g <= 0;
    end 
    else if(idle2set_time)begin 
        set_m_g <= 0;
    end 
    else if(add_set_m_g)begin 
            if(end_set_m_g)begin 
                set_m_g <= 0;
            end
            else begin 
                set_m_g <= set_m_g + 1;
            end 
    end
    else  begin
       set_m_g <= set_m_g;
    end
end 
assign add_set_m_g = state_c == SET_TIME && set_flag[2] && key[2];
assign end_set_m_g = add_set_m_g && set_m_g == 9;

//设置时间时，根据key[2]设置分十位数值
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        set_m_s <= 0;
    end 
    else if(idle2set_time)begin 
        set_m_s <= 0;
    end 
    else if(add_set_m_s)begin 
            if(end_set_m_s)begin 
                set_m_s <= 0;
            end
            else begin 
                set_m_s <= set_m_s + 1;
            end 
    end
    else  begin
       set_m_s <= set_m_s;
    end
end 
assign add_set_m_s = state_c == SET_TIME && set_flag[3] && key[2];
assign end_set_m_s = add_set_m_s && set_m_s == 5;

//设置时间时，根据key[2]设置时个位数值
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        set_h_g <= 0;
    end 
    else if(idle2set_time)begin 
        set_h_g <= 0;
    end 
    else if(add_set_h_g)begin 
            if(end_set_h_g)begin 
                set_h_g <= 0;
            end
            else begin 
                set_h_g <= set_h_g + 1;
            end 
    end
    else  begin
       set_h_g <= set_h_g;
    end
end 
assign add_set_h_g = state_c == SET_TIME && set_flag[4] && key[2];
assign end_set_h_g = add_set_h_g && (set_h_g == ((set_h_s == 2)?3:9)) ;


//设置时间时，根据key[2]设置时十位数值
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        set_h_s <= 0;
    end 
    else if(idle2set_time)begin 
        set_h_s <= 0;
    end 
    else if(add_set_h_s)begin 
            if(end_set_h_s)begin 
                set_h_s <= 0;
            end
            else begin 
                set_h_s <= set_h_s + 1;
            end 
    end
    else  begin
       set_h_s <= set_h_s;
    end
end 
assign add_set_h_s = state_c == SET_TIME && set_flag[5] && key[2];
assign end_set_h_s  = add_set_h_s && set_h_s == 2;

//alarm_flag
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            alarm_flag <= 0;
        end 
        else if(idle2set_alarm)begin 
            alarm_flag <= 6'b100_000;
        end 
        else if(state_c == SET_ALARM && key[0])begin 
            alarm_flag <= {alarm_flag[0],alarm_flag[5:1]};
        end 
    end

//设置闹钟时，根据key[2]设置分个位数值
//alarm_s_g
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        alarm_s_g <= ALARM_TIME[3:0];
    end 
    else if(idle2set_alarm)begin //进入设置闹钟状态，闹钟信息就全部清零了
        alarm_s_g <= 0;
    end 
    else if(add_alarm_s_g)begin 
            if(end_alarm_s_g)begin 
                alarm_s_g <= 0;
            end
            else begin 
                alarm_s_g <= alarm_s_g + 1;
            end 
    end
    else  begin
       alarm_s_g <= alarm_s_g;
    end
end 
assign add_alarm_s_g = state_c == SET_ALARM && alarm_flag[0] && key[2];
assign end_alarm_s_g = add_alarm_s_g && alarm_s_g == 9;

                                            
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        alarm_s_s <= ALARM_TIME[7:4];
    end 
    else if(idle2set_alarm)begin 
        alarm_s_s <= 0;
    end
    else if(add_alarm_s_s)begin 
            if(end_alarm_s_s)begin 
                alarm_s_s <= 0;
            end
            else begin 
                alarm_s_s <= alarm_s_s + 1;
            end 
    end
    else  begin
       alarm_s_s <= alarm_s_s;
    end
end 
assign add_alarm_s_s = state_c == SET_ALARM && alarm_flag[1] && key[2];
assign end_alarm_s_s = add_alarm_s_s && alarm_s_s == 5;

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        alarm_m_g <= ALARM_TIME[11:8];
    end 
    else if(idle2set_alarm)begin 
        alarm_m_g <= 0;
    end
    else if(add_alarm_m_g)begin 
            if(end_alarm_m_g)begin 
                alarm_m_g <= 0;
            end
            else begin 
                alarm_m_g <= alarm_m_g + 1;
            end 
    end
    else  begin
       alarm_m_g <= alarm_m_g;
    end    
end 
assign add_alarm_m_g = state_c == SET_ALARM && alarm_flag[2] && key[2];
assign end_alarm_m_g = add_alarm_m_g && alarm_m_g == 9;
                                        
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        alarm_m_s <= ALARM_TIME[15:12];
    end 
    else if(idle2set_alarm)begin 
        alarm_m_s <= 0;
    end
    else if(add_alarm_m_s)begin 
            if(end_alarm_m_s)begin 
                alarm_m_s <= 0;
            end
            else begin 
                alarm_m_s <= alarm_m_s + 1;
            end 
    end
    else  begin
       alarm_m_s <= alarm_m_s;
    end 
end 
assign add_alarm_m_s = state_c == SET_ALARM && alarm_flag[3] && key[2];
assign end_alarm_m_s = add_alarm_m_s && alarm_m_s == 5;

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        alarm_h_g <= ALARM_TIME[19:16];
    end 
    else if(idle2set_alarm)begin 
        alarm_h_g <= 0;
    end
    else if(add_alarm_h_g)begin 
            if(end_alarm_h_g)begin 
                alarm_h_g <= 0;
            end
            else begin 
                alarm_h_g <= alarm_h_g + 1;
            end 
    end
    else  begin
       alarm_h_g <= alarm_h_g;
    end 
end 
assign add_alarm_h_g = state_c == SET_ALARM && alarm_flag[4] && key[2];
assign end_alarm_h_g = add_alarm_h_g && alarm_h_g == ((alarm_h_s == 2)?3:9);              
//如果时十位小于2，个最大值9
//如果时十位等于2，个最大值3


always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        alarm_h_s <= ALARM_TIME[23:20];
    end 
    else if(idle2set_alarm)begin 
        alarm_h_s <= 0;
    end
    else if(add_alarm_h_s)begin 
            if(end_alarm_h_s)begin 
                alarm_h_s <= 0;
            end
            else begin 
                alarm_h_s <= alarm_h_s + 1;
            end 
    end
    else  begin
       alarm_h_s <= alarm_h_s;
    end 
end 
assign add_alarm_h_s = state_c == SET_ALARM && alarm_flag[5] && key[2];
assign end_alarm_h_s = add_alarm_h_s && alarm_h_s == 2;

//dout   dout_mask 
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        dout      <= 0;
        dout_mask <= 6'b000_000;//全灭
    end 
    else begin 
        case(state_c)
            IDLE     :begin 
                dout      <= {cnt_h_s,cnt_h_g,cnt_m_s,cnt_m_g,cnt_s_s,cnt_s_g};//拼接时间信息
                dout_mask <= 6'b111_111;//全亮
            end 
            SET_TIME :begin   
                dout      <= {set_h_s,set_h_g,set_m_s,set_m_g,set_s_s,set_s_g};//在设置时间状态，拼接设置要显示的时间信息
                dout_mask <= set_flag;//指示对哪位进行设置
            end 
            SET_ALARM:begin 
                dout      <= {alarm_h_s,alarm_h_g,alarm_m_s,alarm_m_g,alarm_s_s,alarm_s_g};
                dout_mask <= alarm_flag;
            end 
            default:;
        endcase 
    end 
end

//beep_en  整点 、 闹铃
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        beep_en <= 0;
    end 
    else if(end_cnt_s_g & end_cnt_s_s & end_cnt_m_g & end_cnt_m_s)begin 
        beep_en <= 1'b1;      //整点
    end 
    else if(alarm_s_g == cnt_s_g & alarm_s_s == cnt_s_s & alarm_m_g == cnt_m_g & alarm_m_s == cnt_m_s & alarm_h_g == cnt_h_g & alarm_h_s == cnt_h_s)begin 
        beep_en <= 1'b1;      //闹铃
    end 
    else begin 
        beep_en <= 1'b0;
    end 
end



endmodule