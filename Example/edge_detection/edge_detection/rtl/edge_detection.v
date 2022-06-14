/**************************************功能介绍***********************************
Description:基于C4MB开发板，实现0V5640采集、SDRAM存储、VGA显示功能；
            分辨率:1280*720;SDRAM突发长度：512；VGA：RGB565；
            由于板载VGA接口使用的是电阻分压网络，且像素数据为RGB565格式，R、G、B三通道存在像素失真，
            因此显示效果不理想，颜色比较暗。

*********************************************************************************/

module edge_detection( 
    input				clk		       ,
    input				rst_n	       ,

    //按键输入
    input               key_in         ,

    //cmos
    input               cmos_vsync     ,
    input               cmos_href      ,
    input               cmos_pclk      ,
    input       [7:0]   cmos_din       ,
    output              cmos_xclk      ,
    output              cmos_pwdn      ,
    output              cmos_reset     ,
    output              cmos_sioc      ,
    inout               cmos_siod      ,

    //sdram   
    output              sdram_clk      ,
    output              sdram_csn      ,
    output              sdram_cke      ,
    output              sdram_wen      ,
    output              sdram_casn     ,
    output              sdram_rasn     ,
    output      [1:0]   sdram_dqm      ,
    inout       [15:0]  sdram_dq       ,
    output      [1:0]   sdram_bank     ,
    output      [12:0]  sdram_addr     ,

    //vga
    output              vga_hys        ,
    output              vga_vys        , 
    output      [15:0]  vga_rgb          

);								 

//信号定义

    wire                key_vld             ;

    wire                clk_65m         ;
    wire                clk_100m        ;
    wire                locked0         ;

    wire                clk_24m         ;
    wire                locked1         ;
    wire                iobuf_pclk      ;

    wire    [7:0]       wr_data         ;
    wire    [15:0]      reg_addr        ;
    wire                en_capture      ;
    wire                wr_en           ;
    wire                rd_en           ;

    wire                sio_d_r         ;
    wire    [7:0]       rd_data         ;
    wire                rd_data_vld     ;
    wire                rdy             ;
    wire                sio_d_wr        ;
    wire                sio_d_wr_en     ;

    wire    [15:0]  cmos_dout       ;        
    wire            cmos_dout_vld   ;
    wire            cmos_dout_sop   ;
    wire            cmos_dout_eop   ; 

    wire    [7:0]   gray_dout       ;
    wire            gray_dout_vld   ;
    wire            gray_dout_sop   ;
    wire            gray_dout_eop   ;

    wire    [7:0]   gs_dout         ;
    wire            gs_dout_vld     ;
    wire            gs_dout_sop     ;
    wire            gs_dout_eop     ;

    wire            bit_dout        ;
    wire            bit_dout_vld    ;
    wire            bit_dout_sop    ;
    wire            bit_dout_eop    ;

    wire            sobel_dout      ;
    wire            sobel_dout_vld  ;
    wire            sobel_dout_sop  ;
    wire            sobel_dout_eop  ;

    wire                wr_req          ;
    wire                rd_req          ;
    wire    [15:0]      wr_dout         ;
    wire                wr_dout_vld     ;
    wire    [23:0]      rw_addr	        ;
    wire    [15:0]      vga_dout        ;
    wire                vga_dout_vld    ;

    wire                busy            ;
    wire                ack             ;
    wire    [15:0]      rd_dout         ;
    wire                rd_dout_vld     ;
    wire    [15:0]      sdram_dq_out    ;
    wire                sdram_dq_out_en ;
    wire    [15:0]      sdram_dq_in     ;
    wire                initial_done    ;

    wire                req             ;

    wire                sys_rst         ;

    assign   sys_rst  = rst_n & locked0 & locked1 & initial_done;

    assign   cmos_siod = sio_d_wr_en?sio_d_wr:1'bz;
    assign   sio_d_r   = cmos_siod;
    assign   cmos_pwdn  = 1'b0;
    assign   cmos_reset = 1'b1;
    assign   cmos_xclk  = clk_24m;

    assign   sdram_dq  = sdram_dq_out_en?sdram_dq_out:16'hzz;
    assign   sdram_dq_in = sdram_dq;


//模块例化

    key_filter u_key (
    .clk      (iobuf_pclk   ),
    .rst_n    (rst_n        ),
    .key_in   (key_in    ),  
    .key_vld  (key_vld      )
);

    pll0	u_pll0 (
	.areset         (!rst_n       ),
	.inclk0         (clk          ),
	.c0             (clk_65m      ),
	.c1             (clk_100m     ),
	.locked         (locked0      )
	);
 
    pll1	pll1_inst (
	.areset         (!rst_n      ),
	.inclk0         (clk         ),
	.c0             (clk_24m     ),
	.locked         (locked1     )
	);


    iobuf	u_iobuf (
	.datain         (cmos_pclk   ),
	.dataout        (iobuf_pclk  )
	);

    ov5640_config u_ov5640_config(
        .clk        (clk        ),//时钟
        .rst_n      (rst_n      ),//复位
        .rdy        (rdy        ),          
        //输出信号定义
        .cfg_data   (wr_data    ),//寄存器配置数据
        .cfg_addr   (reg_addr   ),//寄存器配置地址
        .en_capture (en_capture ), 
        .wr_en      (wr_en      ),
        .rd_en      (rd_en      )
    );

    sccb_interface u_sccb_interface(
      .clk        (clk         ),//时钟
      .rst_n      (rst_n       ),//复位
      .wr_en      (wr_en       ),
      .rd_en      (rd_en       ),
      .reg_addr   (reg_addr    ),//寄存器地址
      .wr_data    (wr_data     ),
      .sio_d_r    (sio_d_r     ),
      //输出信号定义
      .sio_c      (cmos_sioc   ),
      .rd_data    (rd_data     ), 
      .rd_data_vld(rd_data_vld ),
      .rdy        (rdy         ),
      .sio_d_wr   (sio_d_wr    ),
      .sio_d_wr_en(sio_d_wr_en )
);
 
    capture u_capture(
      .clk           (iobuf_pclk    ),//时钟   pclk 经过PLL后输出的 24M
      .rst_n         (sys_rst       ),//复位
      .cmos_din      (cmos_din      ),
      .href          (cmos_href     ),//行同步
      .vsync         (cmos_vsync    ),//场同步
      .en_capture    (en_capture    ),//摄像头配置完成后，配置模块输出的采集使能信号
     
      //输出信号定义
      .dout         (cmos_dout    ), //送到rbg565_gray
      .dout_vld     (cmos_dout_vld), 
      .dout_sop     (cmos_dout_sop),
      .dout_eop     (cmos_dout_eop)     
);

      rgb565_gray u_rgb565_gray(
      .clk           (iobuf_pclk),
      .rst_n         (sys_rst),
      .din           (cmos_dout),//R:din[15:11], G:din[10:5], B:din[4:0] 
      .din_vld       (cmos_dout_vld),//输入图像数据有效指示信号
      .din_sop       (cmos_dout_sop),//输入数据帧第一个像素
      .din_eop       (cmos_dout_eop),//输入数据帧最后一个像素
      .dout          (gray_dout),//输出的灰度像素数据
      .dout_vld      (gray_dout_vld),//输出的灰度像素数据有效指示信号
      .dout_sop      (gray_dout_sop),//输出的灰度像素数据帧第一个数据
      .dout_eop      (gray_dout_eop) //输出的灰度像素数据帧最后一个数据
);

    gs_filter u_gs_filter(
      .clk          (iobuf_pclk),
      .rst_n        (sys_rst),
      .din          (gray_dout),
      .din_vld      (gray_dout_vld),
      .din_sop      (gray_dout_sop),
      .din_eop      (gray_dout_eop),
      .dout         (gs_dout),
      .dout_vld     (gs_dout_vld),
      .dout_sop     (gs_dout_sop),
      .dout_eop     (gs_dout_eop)
);

    gray_bit u_gray_bit(            //二值化  输出1 或者 0
    .clk            (iobuf_pclk),
    .rst_n          (sys_rst),
    .key            (key_vld),    //调节灰度阈值 大于value则输出1（白）
    .din            (gs_dout),    //输入像素值
    .din_vld        (gs_dout_vld),
    .din_sop        (gs_dout_sop),
    .din_eop        (gs_dout_eop),
    .dout           (bit_dout),    //1或0
    .dout_vld       (bit_dout_vld),
    .dout_sop       (bit_dout_sop),
    .dout_eop       (bit_dout_eop)
);

    sobel u_sobel(       //判断像素点是否为边缘点 边缘检测
    .clk            (iobuf_pclk),
    .rst_n          (sys_rst),
    .din            (bit_dout),
    .din_vld        (bit_dout_vld),
    .din_sop        (bit_dout_sop),
    .din_eop        (bit_dout_eop),
    .dout           (sobel_dout),
    .dout_vld       (sobel_dout_vld),
    .dout_sop       (sobel_dout_sop),
    .dout_eop       (sobel_dout_eop)
);      
    


    sdram_rw_ctrl u_sdram_rw_ctrl( 
    .clk_100m        (clk_100m      ),
    .clk_50m         (iobuf_pclk    ),
    .clk_65m         (clk_65m       ),
    .rst_n	         (sys_rst       ),

    //capture interface       
    .din		     ({16{sobel_dout}}),//输入彩条数据
    .din_vld         (sobel_dout_vld ),//输入彩条数据有效指示
    .din_sop	     (sobel_dout_sop ),//start of packet 
    .din_eop         (sobel_dout_eop ),//end of packet 

    //sdram_driver interface
    .busy	         (busy           ),//忙标志信号
    .ack  	         (ack            ),//应答信号
    .rd_din          (rd_dout        ),//读取的数据
    .rd_din_vld      (rd_dout_vld    ),//数据有效标志信号
    .wr_req       	 (wr_req         ),//写请求
    .rd_req      	 (rd_req         ),//读请求
    .wr_dout         (wr_dout        ),//数据
    .wr_dout_vld     (wr_dout_vld    ),//数据有效标志信号
    .rw_addr	     (rw_addr        ),//读、写地址 bank/行/列

    //vga interface
    .vga_rd_req      (req            ),//vga读数据请求
    .vga_dout    	 (vga_dout       ),
    .vga_dout_vld    (vga_dout_vld   )
);				


    sdram_driver u_sdram_driver( 
    .clk		        (clk_100m       ),//100MHz
    .rst_n	            (rst_n          ),
    //控制模块接口信号      
    .wr_req	            (wr_req         ),//写请求
    .rd_req             (rd_req         ),//读请求
    .wr_din             (wr_dout        ),//数据
    .wr_din_vld         (wr_dout_vld    ),//数据有效标志信号
    .rw_addr	        (rw_addr        ),//[23:22]：bank地址 [21:9]：行地址  [8:0]：列地址
    .busy	            (busy           ),//忙标志信号
    .ack  	            (ack            ),//应答信号
    .rd_dout            (rd_dout        ),//读取的数据
    .rd_dout_vld        (rd_dout_vld    ),//数据有效标志信号
    //sdram芯片接口信号
    .sdram_clk          (sdram_clk      ),
    .sdram_cke          (sdram_cke      ),
    .sdram_cs_n         (sdram_csn      ),
    .sdram_ras_n        (sdram_rasn     ),
    .sdram_cas_n        (sdram_casn     ),
    .sdram_we_n         (sdram_wen      ),
    .sdram_bank         (sdram_bank     ),
    .sdram_addr         (sdram_addr     ),
    .sdram_dq_out       (sdram_dq_out   ),
    .sdram_dq_out_en    (sdram_dq_out_en),
    .sdram_dq_in        (sdram_dq_in    ),
    .sdram_dqm          (sdram_dqm      ),
    .initial_done       (initial_done   )    
);	

    vga_interface u_vga_interface( 
    .clk		        (clk_65m        ),
    .rst_n	            (sys_rst        ),

    //ctrl interface
    .din		        (vga_dout       ),
    .din_vld            (vga_dout_vld   ),
    .req                (req            ),

    //vga
    .dout 	            (vga_rgb        ),
    .h_sync	            (vga_hys        ),
    .v_sync             (vga_vys        )	
);

endmodule

