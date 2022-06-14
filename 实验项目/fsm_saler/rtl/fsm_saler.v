module fsm_saler( 
    input				sys_clk	  ,
    input				sys_rst_n ,
//3个按键
    input		[2:0]	key_in	  ,
//数码管接口
    output	 	[5:0]	seg_sel_n ,
    output	 	[7:0]	seg_data  ,
//led灯
    output      [3:0]   led       ,
//蜂鸣器
    output              beep_n    
);								 			 
                        
    //中间信号定义		 

    wire	[2:0]	key_down    ;
    wire	[23:0]  dout        ;
    wire    [5:0]   dout_mask   ;
    wire            beep_en     ;


key_filter #(.KEY_W(3)) 
u_key_filter(
.clk        (sys_clk  ),
.rst_n      (sys_rst_n),
.key_in     (key_in   ), //按键信号输入
.key_down   (key_down ) //输出消抖之后的检测结果
);

control  u_control(
.clk            (sys_clk        ),
.rst_n          (sys_rst_n      ),
.key            (key_down   ),
.dout           (dout       ),
.dout_mask      (dout_mask  ),
.led            (led        ),
.beep_en        (beep_en)
);

seg_driver  u_seg_driver(
.clk        (sys_clk    ),
.rst_n      (sys_rst_n  ),
.din        (dout       ),
.din_mask   (dout_mask  ),
.point_n    (6'b111111  ) ,
.seg_data   (seg_data   ),//片选信号
.seg_sel_n  (seg_sel_n  ) //段选信号
);

beep_driver #(.TIME_DELAY(2500_0000))
u_beep_driver(
.clk        (sys_clk    ),
.rst_n      (sys_rst_n  ),
.en         (beep_en    ),
.beep_n     (beep_n     )
);
    

endmodule