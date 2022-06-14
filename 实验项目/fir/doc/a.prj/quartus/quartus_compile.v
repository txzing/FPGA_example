module quartus_compile (
	  input logic resetn
	, input logic clock
	, input logic [0:0] avg_start
	, output logic [0:0] avg_busy
	, output logic [0:0] avg_done
	, input logic [0:0] avg_stall
	, input logic [63:0] avg_x
	, input logic [63:0] avg_y
	, output logic [63:0] avg_avmm_0_rw_address
	, output logic [7:0] avg_avmm_0_rw_byteenable
	, output logic [0:0] avg_avmm_0_rw_read
	, input logic [63:0] avg_avmm_0_rw_readdata
	, output logic [0:0] avg_avmm_0_rw_write
	, output logic [63:0] avg_avmm_0_rw_writedata
	);

	logic [0:0] avg_start_reg;
	logic [0:0] avg_busy_reg;
	logic [0:0] avg_done_reg;
	logic [0:0] avg_stall_reg;
	logic [63:0] avg_x_reg;
	logic [63:0] avg_y_reg;
	logic [63:0] avg_avmm_0_rw_address_reg;
	logic [7:0] avg_avmm_0_rw_byteenable_reg;
	logic [0:0] avg_avmm_0_rw_read_reg;
	logic [63:0] avg_avmm_0_rw_readdata_reg;
	logic [0:0] avg_avmm_0_rw_write_reg;
	logic [63:0] avg_avmm_0_rw_writedata_reg;


	always @(posedge clock) begin
		avg_start_reg <= avg_start;
		avg_busy <= avg_busy_reg;
		avg_done <= avg_done_reg;
		avg_stall_reg <= avg_stall;
		avg_x_reg <= avg_x;
		avg_y_reg <= avg_y;
		avg_avmm_0_rw_address <= avg_avmm_0_rw_address_reg;
		avg_avmm_0_rw_byteenable <= avg_avmm_0_rw_byteenable_reg;
		avg_avmm_0_rw_read <= avg_avmm_0_rw_read_reg;
		avg_avmm_0_rw_readdata_reg <= avg_avmm_0_rw_readdata;
		avg_avmm_0_rw_write <= avg_avmm_0_rw_write_reg;
		avg_avmm_0_rw_writedata <= avg_avmm_0_rw_writedata_reg;
	end


	reg [2:0] sync_resetn;
	always @(posedge clock or negedge resetn) begin
		if (!resetn) begin
			sync_resetn <= 3'b0;
		end else begin
			sync_resetn <= {sync_resetn[1:0], 1'b1};
		end
	end


	avg avg_inst (
		  .resetn(sync_resetn[2])
		, .clock(clock)
		, .start(avg_start_reg)
		, .busy(avg_busy_reg)
		, .done(avg_done_reg)
		, .stall(avg_stall_reg)
		, .x(avg_x_reg)
		, .y(avg_y_reg)
		, .avmm_0_rw_address(avg_avmm_0_rw_address_reg)
		, .avmm_0_rw_byteenable(avg_avmm_0_rw_byteenable_reg)
		, .avmm_0_rw_read(avg_avmm_0_rw_read_reg)
		, .avmm_0_rw_readdata(avg_avmm_0_rw_readdata_reg)
		, .avmm_0_rw_write(avg_avmm_0_rw_write_reg)
		, .avmm_0_rw_writedata(avg_avmm_0_rw_writedata_reg)
	);



endmodule
