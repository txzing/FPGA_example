module top(
    input               clk     ,
    input               rst_n   ,

    //摄像头接口
    input               cmos_vsync      ,
    input               cmos_pclk       ,
    input               cmos_href       ,
    input   [7:0]       cmos_din        ,
    
    output              cmos_xclk       ,
    output              cmos_pwdn       ,
    output              cmos_reset      ,
    output              cmos_scl        ,
    inout               cmos_sda        ,
    //sdram
    output              sdram_clk       ,
    output              sdram_cke       ,   
    output              sdram_csn       ,   
    output              sdram_rasn      ,   
    output              sdram_casn      ,   
    output              sdram_wen       ,   
    output  [1:0]       sdram_bank      ,   
    output  [12:0]      sdram_addr      ,   
    inout   [15:0]      sdram_dq        ,   
    output  [1:0]       sdram_dqm       ,
    output  [15:0]      vga_rgb         , 
    output              vga_hsync       ,
    output              vga_vsync

);

//信号定义  
    wire            cfg_done        ;
    wire            clk_cmos        ;
    wire    [15:0]  pixel           ; 
    wire            pixel_vld       ; 
    wire            pixel_sop       ; 
    wire            pixel_eop       ; 
    wire            clk_100m        ;
    wire            clk_100m_s      ;
    wire            clk_vga         ;
    wire            pclk            ;
    wire            rd_req          ; 
    wire    [15:0]  dout            ; 
    wire            dout_vld        ; 
    
    wire            sys_rst_n       ;
    
    assign sys_rst_n = rst_n & cfg_done;
    assign cmos_xclk = clk_cmos;
    assign sdram_clk = clk_100m_s;

//模块例化
    pll0 u_pll0(
	.areset (~rst_n     ),
	.inclk0 (clk        ),
	.c0     (clk_cmos   ),//24MHz
    .c1     (clk_vga    ) //75MHz
   );
    
    pll1 u_pll1(
	.areset (~rst_n     ),
	.inclk0 (clk        ),
	.c0     (clk_100m   ),//100M,sdram控制器时钟
	.c1     (clk_100m_s ),//100M,sdram相位偏移时钟他,偏移5ns
	.locked ()
    );


    iobuf u_iobuf(
	.datain     (cmos_pclk  ),
    .dataout    (pclk       )
    );

    cmos_top u_cmos(
    /*input           */.clk     (clk       ),
    /*input           */.rst_n   (rst_n     ),
    /*output          */.scl     (cmos_scl  ),
    /*inout           */.sda     (cmos_sda  ),
    /*output          */.pwdn    (cmos_pwdn ),
    /*output          */.reset   (cmos_reset),
    /*output          */.cfg_done(cfg_done  )//标志摄像头寄存器配置完成信号
);

    capture u_capture(
    /*input           */.clk     (pclk      ),
    /*input           */.rst_n   (rst_n     ),
    /*input           */.vsync   (cmos_vsync),
    /*input           */.href    (cmos_href ),
    /*input   [7:0]   */.din     (cmos_din  ),
    /*input           */.enable  (cfg_done  ),
    /*output  [15:0]  */.dout    (pixel     ),
    /*output          */.dout_vld(pixel_vld ),
    /*output          */.dout_sop(pixel_sop ),
    /*output          */.dout_eop(pixel_eop )
    );

    sdram_controller u_meme_controller(
    /*input           */.clk     (clk_100m  ),//100M 控制器主时钟
    /*input           */.clk_in  (pclk      ),//数据输入时钟
    /*input           */.clk_out (clk_vga   ),//数据输出时钟
    /*input           */.rst_n   (rst_n     ),
    /*input   [15:0]  */.din     (pixel     ),
    /*input           */.din_vld (pixel_vld ),
    /*input           */.din_sop (pixel_sop ),
    /*input           */.din_eop (pixel_eop ),
    /*input           */.rd_req  (rd_req    ),//读请求
    /*output  [15:0]  */.dout    (dout      ),//
    /*output          */.dout_vld(dout_vld  ),
    //sdram接口
    /*output          */.cke     (sdram_cke ),
    /*output          */.csn     (sdram_csn ),
    /*output          */.rasn    (sdram_rasn),
    /*output          */.casn    (sdram_casn),
    /*output          */.wen     (sdram_wen ),
    /*output  [1:0]   */.bank    (sdram_bank),
    /*output  [12:0]  */.addr    (sdram_addr),
    /*inout   [15:0]  */.dq      (sdram_dq  ),
    /*output  [1:0]   */.dqm     (sdram_dqm )    
);

    vga_interface u_vga(
    /*input           */.clk      (clk_vga   ),
    /*input           */.rst_n    (sys_rst_n ),
    /*input   [15:0]  */.din      (dout      ),
    /*input           */.din_vld  (dout_vld  ),
    /*output          */.rdy      (rd_req    ),
    /*output  [15:0]  */.vga_rgb  (vga_rgb   ),
    /*output          */.vga_hsync(vga_hsync ),
    /*output          */.vga_vsync(vga_vsync )
    );

endmodule




