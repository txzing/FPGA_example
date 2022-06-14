module cmd_analy( 
input				clk		,
input				rst_n	,
input				din_vld	,
input	    [7:0]	din		,
output reg	[1:0]   cmd_out	                 	
);	

    //参数定义			 
parameter  FRAME_HEAD = 3'b001; 
parameter  FRAME_DATE = 3'b010;
parameter  FRAME_TAIL = 3'b100;

localparam   HEAD = 8'h55    ;
localparam   LED_ON = 8'h66  ;
localparam   LED_OFF = 8'h99 ;
localparam   BEEP_ON = 8'h77 ;
localparam   BEEP_OFF = 8'h33;
localparam   TAIL = 8'hff    ;

//中间信号定义

wire	    frame_head2data;
wire        data2frame_head;
wire        data2frame_tail;
wire	    frame_tail2frame_head; 

reg	[2:0]		state_c;//现态
reg	[2:0]		state_n;//次态

reg  [1:0]      cnt_out;

//第一段，描述状态转移
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		state_c <= FRAME_HEAD;
	end
	else begin
		state_c <= state_n;
	end
end

//第二段，描述状态转移规律
always@(*)begin
	case(state_c)
		FRAME_HEAD:begin
			if(frame_head2data)
			state_n = FRAME_DATE;
			else
			state_n = state_c;
		end
		FRAME_DATE:begin
			if(data2frame_head)
			state_n = FRAME_HEAD;
			else if(data2frame_tail)
			state_n = FRAME_TAIL;
			else 
			state_n = state_c;
		end
		FRAME_TAIL:begin
			if(frame_tail2frame_head)
			state_n = FRAME_HEAD;
			else
			state_n = state_c;
		end
		default:state_n = frame_head2data;
	endcase
end

assign  frame_head2data        = (state_c == FRAME_HEAD) && (din_vld && din == HEAD);
assign  data2frame_head        = (state_c == FRAME_DATE) && (din_vld && (!(din == LED_ON || din == LED_OFF || din == BEEP_ON || din == BEEP_OFF)));
assign  data2frame_tail        = (state_c == FRAME_DATE) && (din_vld && (din == LED_ON || din == LED_OFF || din == BEEP_ON || din == BEEP_OFF));
assign  frame_tail2frame_head  = (state_c == FRAME_TAIL) && (din_vld && din == TAIL);

//第三段，描述各个状态的输出
always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		cnt_out <= 2'b00;
	end
	else if( state_c==FRAME_DATE && din_vld && (din == LED_ON ))begin
		cnt_out <= (cnt_out | 2'b01);
	end
    else if( state_c==FRAME_DATE && din_vld && (din == LED_OFF )) begin
		cnt_out <= (cnt_out & 2'b10);
	end
    else if( state_c==FRAME_DATE && din_vld && (din == BEEP_ON )) begin
		cnt_out <= (cnt_out | 2'b10);
	end
    else if( state_c==FRAME_DATE && din_vld && (din == BEEP_OFF )) begin
		cnt_out <= (cnt_out & 2'b01);
	end
	else
		cnt_out <= cnt_out;
end

always@(posedge clk or negedge rst_n)begin
	if(!rst_n)begin
		cmd_out <= 2'b00;
	end
	else if(frame_tail2frame_head)begin
		cmd_out <= cnt_out;
	end
	else begin
		cmd_out <= cmd_out;
	end
end


endmodule

