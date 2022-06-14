/*******************************************************************************/
module top(
	input                       clk,
	input                       rst_n,
	//LCD驱动接口
	output                      lcd_dclk,    //lcd驱动时钟
	output                      lcd_hs,      //lcd行同步信号
	output                      lcd_vs,      //lcd场同步信号 
	output                      lcd_de,      //lcd数据使能信号
	output[7:0]                 lcd_r,       //lcd red
	output[7:0]                 lcd_g,       //lcd green
	output[7:0]                 lcd_b        //lcd blue

);

wire                            video_clk;
wire                            video_hs;
wire                            video_vs;
wire                            video_de;
wire[7:0]                       video_r;
wire[7:0]                       video_g;
wire[7:0]                       video_b;

wire                            osd_hs;
wire                            osd_vs;
wire                            osd_de;
wire[7:0]                       osd_r;
wire[7:0]                       osd_g;
wire[7:0]                       osd_b;


assign lcd_hs       = osd_hs;
assign lcd_vs       = osd_vs;
assign lcd_de       = osd_de;
assign lcd_dclk     = ~video_clk; //满足时序要求，时钟反转
assign lcd_r        = osd_r[7:0];
assign lcd_g        = osd_g[7:0];
assign lcd_b        = osd_b[7:0];

//generate video pixel clock 通过PLL分频产生显示屏驱动时钟
video_pll video_pll_m0(
	.inclk0                (clk                        ), //开发板50MHz
	.c0                    (video_clk                  )  //显示屏驱动时钟9MHz
);

color_bar color_bar_m0(      //产生显示屏时序以及彩条背景
	.clk                   (video_clk                  ),
	.rst                   (~rst_n                     ),
	.hs                    (video_hs                   ),
	.vs                    (video_vs                   ),
	.de                    (video_de                   ),
	.rgb_r                 (video_r                    ),
	.rgb_g                 (video_g                    ),
	.rgb_b                 (video_b                    )
);

osd_display  osd_display_m0(  //产生根据传入的时序信号产生像素数据     
	.rst_n                 (rst_n                      ),
	.pclk                  (video_clk                  ),
	.i_hs                  (video_hs                   ),
	.i_vs                  (video_vs                   ),
	.i_de                  (video_de                   ),
	.i_data                ({video_r,video_g,video_b}  ),
	.o_hs                  (osd_hs                     ),//行场同步信号在DE模式下无用
	.o_vs                  (osd_vs                     ),//但在一些特定图像数据处理过程中需要行场同步信号
	.o_de                  (osd_de                     ),
	.o_data                ({osd_r,osd_g,osd_b}        )
);

endmodule