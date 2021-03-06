module process #(
	parameter CLK_FREQ 			= 100000000,
	parameter UART_RATE 			= 1000000,
	parameter PARITY_ODD_EVEN 	= 1'b1        //0:odd, 1:even
)(
	input         			clk,
	input         			rst_n,
	input         			uart_rxd,
	output        			uart_txd,

	output reg	[23:0]	avalon_sdram_address,
	output reg	[1:0]		avalon_sdram_byteenable_n,
	output reg				avalon_sdram_chipselect,
	output reg	[15:0]	avalon_sdram_writedata,
	output reg				avalon_sdram_read_n,
	output reg				avalon_sdram_write_n,
	input	[15:0]			avalon_sdram_readdata,
	input						avalon_sdram_readdatavalid,
	input						avalon_sdram_waitrequest
	);
	
	//8字节
	localparam SDRAM_WR_CHANGE_NUM = 24'd8 / 2 - 1'b1;	//3
	
	//UART RX
   localparam RX_ST_IDLE 			 = 3'b001;
	localparam RX_ST_RECEIVE_1		 = 3'b010;
	localparam RX_ST_WR_FIFO		 = 3'b100;
	
	//UART TX
   localparam TX_ST_IDLE 			 = 3'b001;
	localparam TX_ST_SEND_1		 	 = 3'b010;
	localparam TX_ST_SEND_2		 	 = 3'b100;	

	//总线
   localparam AVALON_ST_IDLE 	 	 = 6'b00_0001;
	localparam AVALON_ST_WR_WAIT	 = 6'b00_0010;
	localparam AVALON_ST_WR_DATA	 = 6'b00_0100;
	localparam AVALON_ST_RD_START	 = 6'b00_1000;
	localparam AVALON_ST_RD_WAIT	 = 6'b01_0000;
	localparam AVALON_ST_RD_DATA	 = 6'b10_0000;
	
	reg  [15:0]		rx_fifo_wr_dat;
	reg				rx_fifo_rdreq;
	reg 				rx_fifo_wrreq;
	wire				rx_fifo_empty;
	wire				rx_fifo_full;
	wire				rx_fifo_almost_empty;
	wire				rx_fifo_almost_full;
	wire [15:0]		rx_fifo_rd_dat;
	
	reg [15:0]		tx_fifo_wr_dat;
	reg  				tx_fifo_rdreq;
	reg 				tx_fifo_wrreq;
	wire				tx_fifo_empty;
	wire				tx_fifo_full;
	wire				tx_fifo_almost_empty;
	wire				tx_fifo_almost_full;
	wire [15:0]		tx_fifo_rd_dat;	

	reg  [7:0] 		tx_data_i;
	reg  				tx_start_i;
	wire	 			tx_ready_o;
	wire [7:0]		rx_data_o;
	wire 				rx_data_vild_o;
	wire 				rx_parity_error_o;

	reg [2:0]		rx_state;
	reg [2:0]		rx_state_next;
	reg [2:0]		tx_state;
	reg [2:0]		tx_state_next;	
	reg [5:0]		avalon_state;
	reg [5:0]		avalon_state_next;
	
//------------------------------------------------------------------
// receive uart data write fifo process
//------------------------------------------------------------------	
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			rx_state <= RX_ST_IDLE;
		end else begin
			rx_state <= rx_state_next;
		end
	end
		
    always @(*) begin
		case(rx_state)
			RX_ST_IDLE: begin
				if(rx_data_vild_o && (~rx_fifo_full))
					rx_state_next = RX_ST_RECEIVE_1;
				else
					rx_state_next = RX_ST_IDLE;
			end
			RX_ST_RECEIVE_1: begin
				if(rx_data_vild_o)
					rx_state_next = RX_ST_WR_FIFO;//接受2byte
				else
					rx_state_next = RX_ST_RECEIVE_1;
			end
			RX_ST_WR_FIFO: begin
					rx_state_next = RX_ST_IDLE;
			end
			default: rx_state_next = RX_ST_IDLE;
		endcase
	end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			rx_fifo_wr_dat <= 0;
		end else begin
			if(rx_data_vild_o)
				if(rx_parity_error_o)
					rx_fifo_wr_dat <= {rx_fifo_wr_dat[7:0], 8'hEE};
				else
					rx_fifo_wr_dat <= {rx_fifo_wr_dat[7:0], rx_data_o}; 
		end
	end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			rx_fifo_wrreq <= 0;
		end else begin
			if(rx_state == RX_ST_WR_FIFO)
				rx_fifo_wrreq <= 1'b1;
			else
				rx_fifo_wrreq <= 1'b0;
		end
	end

//end---------------------------------------------------------------

//------------------------------------------------------------------
// uart tx data read fifo process
//------------------------------------------------------------------
	always @(posedge clk or negedge rst_n) begin
		if(!rst_n) begin
			tx_state <= TX_ST_IDLE;
		end else begin
			tx_state <= tx_state_next;
		end
	end

	always @(*) begin
		case(tx_state)
			TX_ST_IDLE: begin
				if(!tx_fifo_empty)
					tx_state_next = TX_ST_SEND_1;
				else
					tx_state_next = TX_ST_IDLE;
			end
			TX_ST_SEND_1: begin
				if(tx_ready_o)
					tx_state_next = TX_ST_SEND_2;
				else
					tx_state_next = TX_ST_SEND_1;
			end
			TX_ST_SEND_2: begin
				if(tx_ready_o)
					tx_state_next = TX_ST_IDLE;
				else
					tx_state_next = TX_ST_SEND_2;
			end			
			default: tx_state_next = TX_ST_IDLE;
		endcase
	end

    always @(*) begin
		if((tx_state == TX_ST_IDLE) && (!tx_fifo_empty))
			tx_fifo_rdreq <= 1'b1;
		else
			tx_fifo_rdreq <= 1'b0;
	end
	
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			tx_start_i <= 0;
		end else begin
			tx_start_i <= 0;
			case(tx_state)
				TX_ST_SEND_1: begin
					if(tx_ready_o)
						tx_start_i <= 1'b1;
				end
				TX_ST_SEND_2: begin
					if(tx_ready_o)
						tx_start_i <= 1'b1;
				end
				default: ;
			endcase			
		end
	end
	
	always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			tx_data_i <= 0;
		end else begin
			case(tx_state)
				TX_ST_SEND_1: begin
					tx_data_i <= tx_fifo_rd_dat[15:8];
				end
				TX_ST_SEND_2: begin
					tx_data_i <= tx_fifo_rd_dat[7:0];
				end
				default: ;
			endcase			
		end
	end	
	
//end---------------------------------------------------------------

//------------------------------------------------------------------
// sdram read and write process
//------------------------------------------------------------------	
	always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			avalon_sdram_byteenable_n <= 0;
		end else begin
			avalon_sdram_byteenable_n <= 2'b00;
		end
	end

	always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			avalon_state <= AVALON_ST_IDLE;
		end else begin
			avalon_state <= avalon_state_next; 
		end
	end

	always @(*) begin
		case(avalon_state)
			AVALON_ST_IDLE: begin
				if(!rx_fifo_empty)
					avalon_state_next = AVALON_ST_WR_WAIT;
				else
					avalon_state_next = AVALON_ST_IDLE;
			end
			AVALON_ST_WR_WAIT: begin
				if((!avalon_sdram_waitrequest) && (!rx_fifo_empty))
					avalon_state_next = AVALON_ST_WR_DATA;
				else
					avalon_state_next = AVALON_ST_WR_WAIT;
			end
			AVALON_ST_WR_DATA: begin
				if(avalon_sdram_waitrequest)
					avalon_state_next = AVALON_ST_WR_DATA;
				else if(avalon_sdram_address >= SDRAM_WR_CHANGE_NUM)
					avalon_state_next = AVALON_ST_RD_START;
				else
					avalon_state_next = AVALON_ST_WR_WAIT;
			end
			AVALON_ST_RD_START: begin
				avalon_state_next = AVALON_ST_RD_WAIT;
			end
			AVALON_ST_RD_WAIT: begin
				if((!avalon_sdram_waitrequest) && (!tx_fifo_almost_full))
					avalon_state_next = AVALON_ST_RD_DATA;
				else
					avalon_state_next = AVALON_ST_RD_WAIT;
			end
			AVALON_ST_RD_DATA: begin
				if(avalon_sdram_waitrequest)
					avalon_state_next = AVALON_ST_RD_DATA;
				else if(avalon_sdram_address >= SDRAM_WR_CHANGE_NUM)
					avalon_state_next = AVALON_ST_IDLE;
				else
					avalon_state_next = AVALON_ST_RD_WAIT;
			end
			default: avalon_state_next = AVALON_ST_IDLE;
		endcase
	end

	always @(*) begin
		case(avalon_state)
			AVALON_ST_WR_WAIT: begin
				if((!avalon_sdram_waitrequest) && (!rx_fifo_empty))
					rx_fifo_rdreq = 1'b1;
				else
					rx_fifo_rdreq = 1'b0;
			end
			default: rx_fifo_rdreq = 1'b0;
		endcase
	end

	always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			avalon_sdram_address    <= 0;
			avalon_sdram_writedata  <= 0;
			avalon_sdram_chipselect <= 1'b0;
			avalon_sdram_read_n     <= 1'b1;
			avalon_sdram_write_n    <= 1'b1;
		end else begin
			avalon_sdram_chipselect <= 1'b0;
			avalon_sdram_read_n     <= 1'b1;
			avalon_sdram_write_n    <= 1'b1;
			case(avalon_state)
				AVALON_ST_IDLE: begin
					avalon_sdram_address    <= -1;
				end
				AVALON_ST_WR_WAIT: begin
					if((!avalon_sdram_waitrequest) && (!rx_fifo_empty))
						avalon_sdram_address <= avalon_sdram_address + 1'b1;
				end
				AVALON_ST_WR_DATA: begin
					avalon_sdram_chipselect <= 1'b1;
					avalon_sdram_write_n 	<= 1'b0;
					avalon_sdram_writedata  <= rx_fifo_rd_dat;
					avalon_sdram_address    <= avalon_sdram_address;
				end
				AVALON_ST_RD_START: begin
					avalon_sdram_address    <= -1;
				end				
				AVALON_ST_RD_WAIT: begin
					if((!avalon_sdram_waitrequest) && (!tx_fifo_almost_full))
						avalon_sdram_address <= avalon_sdram_address + 1'b1;
				end
				AVALON_ST_RD_DATA: begin
					avalon_sdram_chipselect <= 1'b1;
					avalon_sdram_read_n     <= 1'b0;					
					avalon_sdram_address    <= avalon_sdram_address;					
				end
				default: ;
			endcase			
		end
	end


	always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
			tx_fifo_wr_dat <= 0;
			tx_fifo_wrreq  <= 0;
		end else begin
			if(rx_fifo_full) begin
				tx_fifo_wrreq <= 0;
			end else begin
				if(avalon_sdram_readdatavalid) begin
					tx_fifo_wrreq <= 1'b1;
					tx_fifo_wr_dat <= avalon_sdram_readdata;
				end else begin
					tx_fifo_wrreq <= 1'b0;
				end
			end
		end
	end

//end---------------------------------------------------------------
	
	fifo rx_fifo(
	.clock	(clk),
	.data	(rx_fifo_wr_dat),
	.rdreq	(rx_fifo_rdreq),
	.wrreq	(rx_fifo_wrreq),
	.empty	(rx_fifo_empty),
	.full	(rx_fifo_full),
	.almost_empty		(rx_fifo_almost_empty),
	.almost_full		(rx_fifo_almost_full),
	.q		(rx_fifo_rd_dat)
	);

	fifo tx_fifo(
	.clock	(clk),
	.data	(tx_fifo_wr_dat),
	.rdreq	(tx_fifo_rdreq),
	.wrreq	(tx_fifo_wrreq),
	.empty	(tx_fifo_empty),
	.full	(tx_fifo_full),
	.almost_empty		(tx_fifo_almost_empty),
	.almost_full		(tx_fifo_almost_full),
	.q		(tx_fifo_rd_dat)
	);

uart_tx  
#(
  .CLK_FREQ			( CLK_FREQ			),
  .UART_RATE		( UART_RATE			),
  .PARITY_ODD_EVEN 	( PARITY_ODD_EVEN	)        //0:odd, 1:even
)
	uart_tx_u0(
    .clk		(clk), 
    .rst_n		(rst_n),
    .data_i		(tx_data_i),
    .start_i	(tx_start_i),
    .uart_txd	(uart_txd),
    .ready_o	(tx_ready_o)
	);

uart_rx 
#(
  .CLK_FREQ			( CLK_FREQ			),
  .UART_RATE		( UART_RATE			),
  .PARITY_ODD_EVEN 	( PARITY_ODD_EVEN	)        //0:odd, 1:even
)
	uart_rx_u0(
    .clk				(clk), 
    .rst_n				(rst_n), 
    .uart_rxd			(uart_rxd), 
    .data_o				(rx_data_o), 
    .data_vild_o		(rx_data_vild_o), 
    .parity_error_o		(rx_parity_error_o)
);


endmodule

