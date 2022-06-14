module temp_detect (
input               sys_clk     ,
input               sys_rst_n   ,
//DS18B20
inout               dq      ,//传感器总线
//数码管
output      [7:0]   seg_sel ,
output      [7:0]   seg_sig ,
//LCD12864
output            	lcd_rw, 		//读、写操作选择信号，1：读数据，0：写数据
output            	lcd_psb, //1:并行，0：串行
output         		lcd_e, 
output         		lcd_rs, 		//选择输出命令还是数据										
output  [7:0]  		lcd_data    
);

//信号定义

wire            dq_in       ; 
wire            dq_out      ; 
wire            dq_out_en   ; 
wire            temp_sign   ;   
wire    [20:0]  temp_data    ;
wire            temp_data_vld;
wire    [27:0]  dout        ;
wire            dout_vld    ;


//模块例化
//ds18b20驱动模块
ds18b20_driver ds18b20_driver(
/*input            */.clk        	(sys_clk),    // 时钟信号（50MHz）
/*input            */.rst_n      	(sys_rst_n),  // 复位信号
/*input            */.enable     	(1'b1),       //使能信号
/*inout            */.dq         	(dq),         // DS18B20的DQ引脚数据
/*output reg [20:0]*/.temp_data  	(temp_data),   // 转换后得到的温度值
/*output reg       */.sign       	(temp_sign),  // 符号位
/*output reg       */.temp_data_vld	(temp_data_vld)// 指示输出有效         
);
//二进制转bcd模块
binary2bcd #(.DIN_W(21),.DOUT_W(28)) u_binary2bcd(
/*input                   */.clk         (sys_clk),//时钟
/*input                   */.rst_n       (sys_rst_n),//复位
/*input                   */.en          (temp_data_vld),
/*input       [DIN_W-1:0] */.binary_din  (temp_data),//输入二进制数据
/*output reg  [DOUT_W-1:0]*/.bcd_dout    (dout),   //输出BCD码数据
/*output reg              */.bcd_dout_vld(dout_vld) 
);
//数码管驱动模块
seg_driver u_seg_driver(
/*input           */.clk      (sys_clk),
/*input           */.rst_n    (sys_rst_n),
/*input           */.din_sign (temp_sign),
/*input   [31:0]  */.din      ({4'b0,dout}),//数码管数据输入，8个数码管，
/*input           */.din_vld  (dout_vld),
/*input      [7:0]*/.seg_point(8'b11110111),//数码管小数点
/*output reg [7:0]*/.seg_sel  (seg_sel),//数码管位选，8个数码管
/*output reg [7:0]*/.seg_dig  (seg_sig) //数码管段选
); 
//LCD12864显示模块
lcd12864 u_lcd12864(
/*input	          */.clk      (sys_clk), 
/*input	          */.rst_n    (sys_rst_n),
/*input  [n:0]    */.din      (dout),//传入要显示的数据
/*input           */.din_sign (temp_sign),
/*output          */.lcd_rw   (lcd_rw), 		//读、写操作选择信号，1：读数据，0：写数据
/*output          */.lcd_psb  (lcd_psb), //1:并行，0：串行	
/*output reg      */.lcd_e    (lcd_e), 
/*output reg      */.lcd_rs   (lcd_rs), 		//选择输出命令还是数据										
/*output reg [7:0]*/.lcd_data (lcd_data)
);
 
endmodule