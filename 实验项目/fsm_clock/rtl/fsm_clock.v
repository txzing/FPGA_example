module fsm_clock #(parameter KEY_WIDTH = 3) (
input                       sys_clk     ,
input                       sys_rst_n   ,
input   [KEY_WIDTH-1:0]     key_in  	 ,
output  [5:0]               seg_sel_n     ,
output  [7:0]               seg_data     ,
output                      beep_n 
);
    

//信号定义
wire    [KEY_WIDTH-1:0]     key_down    ;
wire    [23:0]              dout        ;
wire    [5:0]               dout_mask   ;
wire                        buzzer_en   ;

key_filter #(.KEY_W(KEY_WIDTH)) 
u_key_filter(
.clk        (sys_clk  ),
.rst_n      (sys_rst_n),
.key_in     (key_in   ), //按键信号输入
.key_down   (key_down ) //输出消抖之后的检测结果
);


clock #(
    .TIME_1S (5000_0000/10     ),
    .CURRENT_TIME (24'h10_23_56),
    .ALARM_TIME   (24'h10_25_34)
) 
u_clock(  //计时
.clk            (sys_clk        ),
.rst_n          (sys_rst_n      ),
.key            (key_down   ),
.dout           (dout       ),
.dout_mask      (dout_mask  ),
.beep_en        (beep_en  )
);

seg_driver u_seg_driver(
.clk        (sys_clk    ),
.rst_n      (sys_rst_n  ),
.din        (dout       ),
.din_mask   (dout_mask  ),
.point_n    (6'b101011  ) ,
.seg_data   (seg_data   ),//片选信号
.seg_sel_n  (seg_sel_n  ) //段选信号
);

beep_driver #(.TIME_DELAY(2500_0000)) u_beep_driver(
.clk        (sys_clk    ),
.rst_n      (sys_rst_n  ),
.en         (beep_en    ),
.beep_n     (beep_n     )
);

endmodule