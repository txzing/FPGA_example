
`timescale 1 ns / 100 ps

module uart_rx
#(
	parameter CLK_FREQ 			= 100000000,
	parameter UART_RATE 			= 1000000,
	parameter PARITY_ODD_EVEN 	= 1'b1       //0:odd, 1:even
)(
    input 					clk, 
    input 					rst_n, 
    input 					uart_rxd, 
    output reg [7:0]		data_o, 
    output reg 			data_vild_o, 
    output reg 			parity_error_o
);
    
	localparam [23:0] BIT_LENGTH = CLK_FREQ / UART_RATE - 1'b1;//15
	localparam [23:0] STOP_LENGTH = CLK_FREQ / UART_RATE - 1'b1;//15
 
	localparam ST_IDLE  		  = 6'b00_0001;
	localparam ST_START_PREPARE   = 6'b00_0010;  
	localparam ST_WAIT_FOR_BIT    = 6'b00_0100;
	localparam ST_WAIT_FOR_STOP   = 6'b00_1000;
	localparam ST_WAIT_FOR_PARITY = 6'b01_0000;
	localparam ST_FRAME_ERROR     = 6'b10_0000;

	reg 			rxd_dly1;
	reg			rxd_dly2;
	reg [5:0]	state;
	reg [5:0]	state_next;
	reg [23:0]	bit_cnt;
	reg [2:0]	shift_cnt;
	reg 			parity;
      
	//输入信号打两拍 使用rxd_dly2  
	always @(posedge clk) begin 
		rxd_dly1 <= uart_rxd;
		rxd_dly2 <= rxd_dly1;	 
	end

	always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			state <= ST_IDLE;
		end else begin
			state <= state_next;
		end
	end

	always @(*) begin
		case(state)
			ST_IDLE: begin
				if(!rxd_dly2)//起始位
					state_next = ST_START_PREPARE;
				else
					state_next = ST_IDLE;
			end
			ST_START_PREPARE: begin
				if(rxd_dly2)//不到时长就来高电平，错误
					state_next = ST_IDLE;
				else
				if(~|bit_cnt)//按位或， 每个bit都为0； 资源少
					state_next = ST_WAIT_FOR_BIT;
				else
					state_next = ST_START_PREPARE;
			end
			ST_WAIT_FOR_BIT: begin
				if((~|bit_cnt) && (&shift_cnt))//按位与， 每个bit都为1 3'b111,8个数据
					state_next = ST_WAIT_FOR_PARITY;
				else
					state_next = ST_WAIT_FOR_BIT;
			end
			ST_WAIT_FOR_PARITY: begin
				if(~|bit_cnt)
					state_next = ST_WAIT_FOR_STOP;
				else
					state_next = ST_WAIT_FOR_PARITY;
			end
			ST_WAIT_FOR_STOP: begin
				if(~|bit_cnt)
					state_next = ST_IDLE;
				else
					state_next = ST_WAIT_FOR_STOP;
			end			
			default:;
		endcase	
	end		
	 
	always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			bit_cnt <= 0;
		end else begin
			case(state)
				ST_IDLE: begin
					bit_cnt <= BIT_LENGTH >> 1;//查看中间电平，起始位计数半,7 0111
				end
				ST_START_PREPARE: begin
					if(~|bit_cnt)
						bit_cnt <= BIT_LENGTH;//之后就是完整周期,15
					else
						bit_cnt <= bit_cnt - 1'b1;
				end
				ST_WAIT_FOR_BIT: begin
					if(~|bit_cnt)
						bit_cnt <= BIT_LENGTH;
					else
						bit_cnt <= bit_cnt - 1'b1;				
				end
				ST_WAIT_FOR_PARITY: begin
					if(~|bit_cnt)
						bit_cnt <= STOP_LENGTH;
					else
						bit_cnt <= bit_cnt - 1'b1;				
				end
				ST_WAIT_FOR_STOP: begin
						bit_cnt <= bit_cnt - 1'b1;				
				end				
				default:;
			endcase					
		end
	end

	always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			shift_cnt <= 0;
		end else begin
			case(state)
				ST_IDLE: begin
					shift_cnt <= 0;
				end
				ST_WAIT_FOR_BIT: begin
					if(~|bit_cnt)
						shift_cnt <= shift_cnt + 1'b1;
				end
				default:;
			endcase									
		end
	end
		
	always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin		
			data_o <= 0;
		end else begin
			case(state)
				ST_WAIT_FOR_BIT: begin
					if(~|bit_cnt)
						data_o <= {rxd_dly2, data_o[7:1]};//右移，最先接收LSB
				end
				default:;
			endcase					
		end
	end
	
	always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin		
			data_vild_o <= 0;
		end else begin
			case(state)
				ST_WAIT_FOR_STOP: begin
					if((~|bit_cnt) && rxd_dly2)
						data_vild_o <= 1'b1;
					else
						data_vild_o <= 1'b0;
				end
				default: data_vild_o <= 1'b0;
			endcase					
		end
	end
		
	always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin		
			parity_error_o <= 0;
		end else begin
			case(state)
				ST_IDLE: begin
					parity_error_o <= 1'b0;
				end
				ST_WAIT_FOR_PARITY: begin
					if(~|bit_cnt)
						parity_error_o <= (^data_o) ^ rxd_dly2 ^ (!PARITY_ODD_EVEN);//按位异或 异或校验位 异或校验取反
				end
				default: ;
			endcase					
		end
	end		
//奇校验，9比特数中1的个数恒为奇数，故按位异或值为1，再异或上(!PARITY_ODD_EVEN)，即异或上1
//偶校验，9比特数中1的个数恒为偶数，故按位异或值为0，再异或上(!PARITY_ODD_EVEN)，即异或上0
//故若奇偶校验正确，则parity_error_o为0	

endmodule 
