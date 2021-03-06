`timescale 1 ns / 100 ps

module uart_tx
#(
	parameter CLK_FREQ 			= 100000000,
	parameter UART_RATE 			= 1000000,
	parameter PARITY_ODD_EVEN 	= 1'b1        //0:odd, 1:even
)(
	input 			clk, 
	input 			rst_n,
	input[7:0] 		data_i,
	input 			start_i,
   output reg		uart_txd,
   output reg		ready_o
	);
      
	localparam [23:0] BIT_LENGTH = CLK_FREQ / UART_RATE - 1'b1;//15
	localparam [23:0] STOP_LENGTH = CLK_FREQ / UART_RATE - 1'b1;//15
	
   localparam ST_IDLE 			  = 5'b0_0001;
   localparam ST_SEND_START     = 5'b0_0010;
   localparam ST_SEND_BIT       = 5'b0_0100;
   localparam ST_SEND_PARITY    = 5'b0_1000;
   localparam ST_SEND_STOP      = 5'b1_0000;
	   
   reg [4:0]	state;
	reg [4:0]	state_next;
	reg [23:0]	bit_cnt;
	reg [2:0]	shift_cnt;
	reg [7:0]	shift_buf;
	reg			parity_bit;
	
	always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			state <= ST_IDLE;
		end else begin
			state <= state_next;
		end
	end
        
   always @(*) begin
			case(state)
				ST_IDLE        : begin
					if(start_i)
						state_next = ST_SEND_START;
					else
						state_next = ST_IDLE;
				end
				ST_SEND_START  : begin
					if(~|bit_cnt)
						state_next = ST_SEND_BIT;
					else
						state_next = ST_SEND_START;
				end
				ST_SEND_BIT    : begin
					if((~|bit_cnt) && (&shift_cnt))
						state_next = ST_SEND_PARITY;
					else
						state_next = ST_SEND_BIT;				
				end
				ST_SEND_PARITY : begin
					if(~|bit_cnt)
						state_next = ST_SEND_STOP;
					else
						state_next = ST_SEND_PARITY;				
				end
				ST_SEND_STOP   : begin
					if(~|bit_cnt)
						state_next = ST_IDLE;
					else
						state_next = ST_SEND_STOP;				
				end
				default: state_next = ST_IDLE;
			endcase
	end
    
   always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			bit_cnt <= 0;
		end else begin
			case(state)
				ST_IDLE: begin
					bit_cnt <= BIT_LENGTH;
				end
				ST_SEND_START: begin
					if(~|bit_cnt)
						bit_cnt <= BIT_LENGTH;
					else
						bit_cnt <= bit_cnt - 1'b1;
				end
				ST_SEND_BIT: begin
					if(~|bit_cnt)
						bit_cnt <= BIT_LENGTH;
					else
						bit_cnt <= bit_cnt - 1'b1;				
				end
				ST_SEND_PARITY: begin
					if(~|bit_cnt)
						bit_cnt <= STOP_LENGTH;
					else
						bit_cnt <= bit_cnt - 1'b1;					
				end
				ST_SEND_STOP: begin
					if(~|bit_cnt)
						bit_cnt <= 0;
					else
						bit_cnt <= bit_cnt - 1'b1;						
				end
				default: ;
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
				ST_SEND_BIT: begin
					if(~|bit_cnt)
						shift_cnt <= shift_cnt + 1'b1;
				end
				default:;
			endcase
		end
	end
		
   always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			shift_buf <= 0;
		end else begin
			case(state)
				ST_IDLE: begin
					if(start_i)
						shift_buf <= data_i;
				end
				ST_SEND_BIT: begin
					if(~|bit_cnt)
						shift_buf <= shift_buf >> 1; 
				end
				default:;
			endcase
		end
	end

   always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			parity_bit <= 1'b0;
		end else begin
			if(start_i)
				parity_bit <= (^data_i) ^ PARITY_ODD_EVEN;
		end
	end
			
   always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
				uart_txd <= 1'b1;
		  end else begin
				case(state)
					ST_IDLE: begin
					uart_txd <= 1'b1;
					end
					ST_SEND_START: begin
						uart_txd <= 1'b0;
					end
					ST_SEND_BIT: begin
						uart_txd <= shift_buf[0];
					end
					ST_SEND_PARITY: begin
						uart_txd <= parity_bit;
					end
					ST_SEND_STOP: begin
						uart_txd <= 1'b1;
					end
					default: uart_txd <= 1'b1;
				endcase
		end
	end

   always @(*) begin
		case(state)
			ST_IDLE: begin
				if(start_i)
					ready_o = 1'b0;
				else
					ready_o = 1'b1;
			end			
			default: ready_o = 1'b0;
		endcase
	end	
	
endmodule 

