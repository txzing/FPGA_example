module key_filter #(
    parameter   DELAY_20MS =  20'd100_0000,
                KEY_W      =  1 
) (
    input				            clk		,
    input				            rst_n	, 
    input      [KEY_W-1:0]  key_in  ,  
    output reg [KEY_W-1:0]  key_down        
);

//独热码
localparam     IDLE        = 4'b0001; 
localparam     FILTER_DOWN = 4'b0010; 
localparam     HOLD_DOWN   = 4'b0100; 
localparam     FILTER_UP   = 4'b1000;  

wire       idle2filter_down     ;
wire       filter_down2idle     ;
wire       filter_down2hold_down;
wire       hold_down2filter_up  ;
wire       filter_up2idle       ;


reg  [3:0]        state_c    ;//现态
reg  [3:0]        state_n    ;//次态

reg  [19:0]       cnt        ;//20ms计数器定义
wire              add_cnt    ;
wire              end_cnt    ;

reg  [KEY_W-1:0]  key_in_r0;
reg  [KEY_W-1:0]  key_in_r1;
reg  [KEY_W-1:0]  key_in_r2;


wire [KEY_W-1:0]  n_edge    ;
wire [KEY_W-1:0]  p_edge    ;

//边沿检测模块
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        key_in_r0 <= {KEY_W{1'b1}};
        key_in_r1 <= {KEY_W{1'b1}};
        key_in_r2 <= {KEY_W{1'b1}};
    end 
    else begin 
        key_in_r0 <= key_in;
        key_in_r1 <= key_in_r0;
        key_in_r2 <= key_in_r1;
    end 
end

assign     n_edge = ~key_in_r1 & key_in_r2 ;
assign     p_edge = key_in_r1 & ~key_in_r2 ; 

//3段式状态机
//第一段，描述状态转移,时序逻辑
always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        state_c <= IDLE;
    end 
    else begin 
        state_c <= state_n;
    end 
end

//第二段，描述状态转移规律，组合逻辑
always @(*)begin 
    case(state_c)
        IDLE : begin
          if(idle2filter_down)begin
            state_n = FILTER_DOWN;
          end
          else begin
            state_n = state_c;
          end
        end
        FILTER_DOWN : begin
          if(filter_down2idle)begin
            state_n = IDLE;
          end
          else if(filter_down2hold_down) begin
            state_n = HOLD_DOWN;
          end
          else begin
            state_n = state_c;
          end
        end
        HOLD_DOWN : begin
          if(hold_down2filter_up)begin
            state_n = FILTER_UP;
          end
          else begin
            state_n = state_c;
          end
        end
        FILTER_UP : begin
          if(filter_up2idle)begin
            state_n = IDLE;
          end
          else begin
            state_n = state_c;
          end
        end
        default : state_n = IDLE;
    endcase
end

assign       idle2filter_down      = (state_c == IDLE       ) && (n_edge            );
assign       filter_down2idle      = (state_c == FILTER_DOWN) && (p_edge            );
assign       filter_down2hold_down = (state_c == FILTER_DOWN) && end_cnt && (!p_edge);
assign       hold_down2filter_up   = (state_c == HOLD_DOWN  ) && (p_edge            );
assign       filter_up2idle        = (state_c == FILTER_UP  ) && (end_cnt           );

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
       cnt <= 0;
    end
end 

assign add_cnt = (state_c == FILTER_DOWN) || (state_c == FILTER_UP);
assign end_cnt = add_cnt && cnt == DELAY_20MS - 1'b1;

//第三段，描述状态输出，时序逻辑
always @(posedge clk or negedge rst_n)begin 
  if(!rst_n)begin
    key_down <= {KEY_W{1'b0}};
  end 
  else if(hold_down2filter_up)begin //当按键抬起时输出按键有效
    key_down <= ~key_in_r2; 
  end 
  else begin 
    key_down <= {KEY_W{1'b0}};
  end 
end

endmodule