/*******************************************************************************/
module osd_display(
	input                       rst_n,   
	input                       pclk,
	input                       i_hs,    
	input                       i_vs,    
	input                       i_de,	
	input[23:0]                 i_data,  
	output                      o_hs,    
	output                      o_vs,    
	output                      o_de,    
	output[23:0]                o_data
);
/**********************************************/
//修改此处，与取字符软件的宽与高相对应
parameter OSD_WIDTH   =  12'd344;//字符宽度  48*344=16512，，，，，，，
parameter OSD_HEGIHT  =  12'd48;//字符高度   总共16512个像素点
parameter TOTAL_POINT= 16'd16512;
//4.3寸屏幕是480*272
//修改此处即修改在屏幕中的显示位置
parameter SHOW_WIDTH   =  12'd77;//在屏幕中显示的宽度
parameter SHOW_HEGIHT  =  12'd77;//在屏幕中显示的高度
/***********************************************/
wire[11:0] pos_x;
wire[11:0] pos_y;
wire       pos_hs;
wire       pos_vs;
wire       pos_de;
wire[23:0] pos_data;
reg[23:0]  v_data;
reg[2:0]   xy_bit;
reg[15:0]  osd_ram_addr;//16-3=13, 2的13次方8192
wire[7:0]  q;
reg        region_active;
reg        region_active_d0;

assign o_data = v_data;
assign o_hs = pos_hs;
assign o_vs = pos_vs;
assign o_de = pos_de;

always@(posedge pclk or negedge rst_n)
begin
	if(rst_n == 1'b0)
		region_active <= 1'b0;
	else if( pos_y >= SHOW_HEGIHT && pos_y <= SHOW_HEGIHT + OSD_HEGIHT - 12'd1 && 
				pos_x >= SHOW_WIDTH && pos_x  <= SHOW_WIDTH + OSD_WIDTH - 12'd1)
				region_active <= 1'b1;//有效代表在显示区域
	else
		region_active <= 1'b0;
end

//delay 1 clock
//延迟一拍，在时钟下从ROM中取数据 
//即当前时刻给出地址，下一个时钟周期得到该地址中的数据
always@(posedge pclk or negedge rst_n)
begin
	if(rst_n == 1'b0)
		region_active_d0 <= 1'b0;
	else 
		region_active_d0 <= region_active;
end

//通过xy_bit计数器将在ROM读出的8 bit中像素点依次单个取出
always@(posedge pclk or negedge rst_n)
begin
	if(rst_n == 1'b0)
		xy_bit <= 3'd0;
	else if(xy_bit == 3'd7)
		xy_bit <= 3'd0;
	else if(region_active_d0 == 1'b1)
		xy_bit <= xy_bit + 3'd1;
	else
		xy_bit <= 3'd0;
end

always@(posedge pclk)
begin
	if(rst_n == 1'b0)
		osd_ram_addr <= 16'd0;
	else if( osd_ram_addr==TOTAL_POINT-1 )//显示完总共点数
		osd_ram_addr <= 16'd0;
	else if(region_active == 1'b1)//在显示的行列区域中
		osd_ram_addr <= osd_ram_addr + 16'd1;
end

always@(posedge pclk)
begin
	if(rst_n == 1'b0)
		v_data <= 24'h000000;//黑色
	else if(region_active_d0 == 1'b1)
		if(q[xy_bit] == 1'b1)//q[0],q[1],q[2],q[3].....依次比较，若为1，则代表该点需要显示
			v_data <= 24'h000000;//显示像素点黑色
		else
			v_data <= pos_data;
	else
		v_data <= pos_data;
end

osd_rom osd_rom_m0
(
	.address(osd_ram_addr[15:3]),//在rom中地址宽度8位，故8个点位判断完后再更换下一个地址
	.clock(pclk),              
	.q(q)
);

//该模块产生X,Y坐标
timing_gen_xy timing_gen_xy_m0(
	.rst_n    (rst_n    ),
	.clk      (pclk     ),
	.i_hs     (i_hs     ),
	.i_vs     (i_vs     ),
	.i_de     (i_de     ),
	.i_data   (i_data   ),
	.o_hs     (pos_hs   ),
	.o_vs     (pos_vs   ),
	.o_de     (pos_de   ),
	.o_data   (pos_data ),
	.x        (pos_x    ),
	.y        (pos_y    )
);
endmodule