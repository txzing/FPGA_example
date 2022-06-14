/**************************************功能介绍***********************************
Copyright:FPGAer_LZ			
Date     :2021--10			
Author   :LZ			
Version  :v2.0			
Description:基于友晶DE10-Standard的摄像头采集，SDRAM存储与VGA显示系统。	

1、I2C协议时序
2、SDRAM芯片--时序、工作原理、乒乓缓存
3、VGA协议时序

4、跨时钟域处理

*********************************************************************************/

`include"param.v"

module ov5640_sdram_vga (
    input               clk         ,
    input               rst_n       ,

    //ov5640 port
    input               cmos_vsync  ,
    input               cmos_href   ,
    input       [7:0]   cmos_din    ,
    input               cmos_pclk   ,
    output              cmos_xclk   ,
    output              cmos_pwdn   ,
    output              cmos_reset  ,
    output              cmos_scl   ,
    inout               cmos_sda   ,

    //sdram port
    output      [12:0]  sdram_addr  ,//行、列地址
    output      [1:0]   sdram_bank  ,
    output              sdram_clk   ,
    output              sdram_cke   ,
    output              sdram_rasn  ,
    output              sdram_casn  ,
    output              sdram_csn   ,
    output              sdram_wen   ,
    output      [1:0]   sdram_dqm   ,
    inout       [15:0]  sdram_dq    ,

    //vga port 
    output      [7:0]   vga_r       ,//r g b 数据输出给 da芯片
    output      [7:0]   vga_g       ,
    output      [7:0]   vga_b       ,
    output              vga_blank   ,
    output              vga_sync    ,
    output              vga_clk     ,
    //output to vga 
    output              vga_hsync   ,
    output              vga_vsync   
);

//信号定义
    wire            clk_24m     ;
    wire            clk_75m     ;
    wire            locked0     ;

    wire            clk_150m    ;//150M用于 sdram控制器主时钟
    wire            clk_150m_s  ;//用于signaltap采样   150M ，相位偏移60°，用于sdram同步时钟
    wire            locked1     ;

    wire            cfg_done    ;
    wire            pclk        ;
    wire    [15:0]  pixel       ;
    wire            pixel_vld   ;
    wire            pixel_sop   ;
    wire            pixel_eop   ;
    wire    [15:0]  mem_din    	;
    wire            mem_din_vld ;
    wire            mem_din_sop ;
    wire            mem_din_eop ;
    wire            rd_mem_en   ;
    wire    [15:0]  vga_data    ;
    wire            vga_data_vld;
    wire            vga_req     ;
    wire            vga_rst     ;
    assign vga_rst = rst_n & cfg_done;

//模块例化

    pll0 u_pll0(
	/*input  wire  */.refclk    (clk        ),   //  refclk.clk
	/*input  wire  */.rst       (~rst_n     ),      //   reset.reset
	/*output wire  */.outclk_0  (clk_24m    ), // outclk0.clk
	/*output wire  */.outclk_1  (clk_75m    ), // outclk1.clk
	/*output wire  */.locked    (locked0    )    //  locked.export
	);

    pll1 u_pll1(
	/*input  wire  */.refclk    (clk        ),   //  refclk.clk
	/*input  wire  */.rst       (~rst_n     ),      //   reset.reset
	/*output wire  */.outclk_0  (clk_150m   ), // outclk0.clk
	/*output wire  */.outclk_1  (clk_150m_s ), // outclk1.clk
	/*output wire  */.locked    (locked1    )    //  locked.export
	);

    iobuf	u_iobuf(
	.datain     (cmos_pclk  ),
	.dataout    (pclk       )
	);

`ifdef ONE_SLAVE        //i2c接口和cfg模块直接握手
    ov5640_config u_cfg(
    /*input           */.clk     (clk       ),
    /*input           */.rst_n   (rst_n     ),
    //摄像头接口
    /*output          */.sio_c   (cmos_scl  ),
    /*inout           */.sio_d   (cmos_sda  ),
    /*output          */.cfg_done(cfg_done  ) //初始化配置完成
    );
`elsif 
    ov5640_cfg u_cfg(        //使用双buf模式
    /*input           */.clk     (clk       ),
    /*input           */.rst_n   (rst_n     ),
    //摄像头接口
    /*output          */.sio_c   (cmos_scl  ),
    /*inout           */.sio_d   (cmos_sda  ),
    /*output          */.cfg_done(cfg_done  ) //初始化配置完成
    );
`endif 

    capture u_capture( 
    /*input				*/.clk		    (pclk       ),   //pclk
    /*input				*/.rst_n	    (rst_n      ),
    /*input		[7:0]	*/.cmos_din	    (cmos_din   ),
    /*input		        */.cmos_vsync	(cmos_vsync ),
    /*input		        */.cmos_href 	(cmos_href  ),
    /*input             */.cap_en       (cfg_done   ),//采集使能信号
    /*output	[15:0]	*/.pixel   	    (pixel   	),
    /*output		    */.pixel_vld	(pixel_vld  ),
    /*output            */.pixel_sop    (pixel_sop  ),//数据包文头
    /*output            */.pixel_eop    (pixel_eop  )    //数据包文尾
);

`ifdef ENABLE_EDGE_DETECT
    wire    [15:0]  img_din         ;
    wire            img_din_vld     ;
    wire            img_din_sop     ;
    wire            img_din_eop     ;
    wire    [15:0]  imp_dout        ;
    wire            imp_dout_vld    ;
    wire            imp_dout_sop    ;
    wire            imp_dout_eop    ;

    assign img_din     = pixel      ;
    assign img_din_vld = pixel_vld  ;
    assign img_din_sop = pixel_sop  ;
    assign img_din_eop = pixel_eop  ;

    assign mem_din     = imp_dout    ;
    assign mem_din_vld = imp_dout_vld;
    assign mem_din_sop = imp_dout_sop;
    assign mem_din_eop = imp_dout_eop;

    img_process u_img_process( 
   /*input			 	*/.clk		(pclk           ),
   /*input				*/.rst_n	(rst_n          ),
   /*input		[15:0]  */.din		(img_din        ),
   /*input		    	*/.din_vld	(img_din_vld    ),
   /*input              */.din_sop  (img_din_sop    ),
   /*input              */.din_eop  (img_din_eop    ),
   /*output	[15:0]	    */.dout	    (imp_dout       ),
   /*output	            */.dout_vld (imp_dout_vld   ),
   /*output             */.dout_sop (imp_dout_sop   ),
   /*output             */.dout_eop (imp_dout_eop   )
);		
`elsif 
    assign mem_din     = pixel    ;
    assign mem_din_vld = pixel_vld;
    assign mem_din_sop = pixel_sop;
    assign mem_din_eop = pixel_eop;
`endif 

    sdram_controler u_sdram_ctrl(
    /*input               */.clk         (clk_150m      ),
    /*input               */.clk_in      (pclk          ),
    /*input               */.clk_out     (clk_75m       ),
    /*input               */.rst_n       (rst_n         ),

    //用户输入
    /*input               */.rd_en       (vga_req       ),
    /*input       [15:0]  */.din         (mem_din       ),
    /*input               */.din_vld     (mem_din_vld   ),
    /*input               */.din_sop     (mem_din_sop   ),
    /*input               */.din_eop     (mem_din_eop   ),
    /*output      [15:0]  */.dout        (vga_data      ),    
    /*output              */.dout_vld    (vga_data_vld  ), 
    
    //sdram接口
    /*output              */.sdram_cke   (sdram_cke     ),
    /*output              */.sdram_csn   (sdram_csn     ),
    /*output              */.sdram_rasn  (sdram_rasn    ),
    /*output              */.sdram_casn  (sdram_casn    ),
    /*output              */.sdram_wen   (sdram_wen     ),
    /*output  [1:0]       */.sdram_bank  (sdram_bank    ),
    /*output  [12:0]      */.sdram_addr  (sdram_addr    ),
    /*inout   [15:0]      */.sdram_dq    (sdram_dq      ),
    /*output  [1:0]       */.sdram_dqm   (sdram_dqm     )
    );


    adv7123_driver u_vga_intf(
    /*input               */.clk         (clk_75m       ),
    /*input               */.rst_n       (vga_rst       ),

    /*input       [15:0]  */.din         (vga_data      ),
    /*input               */.din_vld     (vga_data_vld  ),
    /*output              */.req         (vga_req       ),
    
    //output to ADV7123
    /*output      [7:0]   */.vga_r       (vga_r         ),//r g b 数据输出给 da芯片
    /*output      [7:0]   */.vga_g       (vga_g         ),
    /*output      [7:0]   */.vga_b       (vga_b         ),
    /*output              */.vga_blank   (vga_blank     ),
    /*output              */.vga_sync    (vga_sync      ),
    /*output              */.vga_clk     (vga_clk       ),
    //output to vga 
    /*output              */.vsync       (vga_vsync     ),
    /*output              */.hsync       (vga_hsync     )
    );



    assign cmos_pwdn = 1'b0; 
    assign cmos_reset = 1'b1;
    assign cmos_xclk = clk_24m;
    assign sdram_clk = clk_150m_s;

endmodule