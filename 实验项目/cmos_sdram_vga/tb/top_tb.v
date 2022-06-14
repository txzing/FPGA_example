`timescale 1ns/1ns

module top_tb();

    reg               clk           ;
    reg               rst_n         ;

    //摄像头接口
    reg               cmos_vsync    ; 
    reg               cmos_href     ; 
    reg   [7:0]       cmos_din      ; 
    reg               pclk          ;
  
    //sdram 
    wire              sdram_cke     ;    
    wire              sdram_csn     ;    
    wire              sdram_rasn    ;    
    wire              sdram_casn    ;    
    wire              sdram_wen     ;    
    wire  [1:0]       sdram_bank    ;    
    wire  [12:0]      sdram_addr    ;    
    wire  [15:0]      sdram_dq      ;    
    wire  [1:0]       sdram_dqm     ; 
    wire  [15:0]      vga_rgb       ;  
    wire              vga_hsync     ; 
    wire              vga_vsync     ;

//信号定义  
    wire            clk_cmos        ;
    wire    [15:0]  pixel           ; 
    wire            pixel_vld       ; 
    wire            pixel_sop       ; 
    wire            pixel_eop       ; 
    wire            clk_100m        ;
    wire            clk_100m_s      ;
    wire            clk_vga         ;
    wire            rd_req          ; 
    wire    [15:0]  dout            ; 
    wire            dout_vld        ; 


//模块例化
    pll0 u_pll0(
	.areset (~rst_n     ),
	.inclk0 (clk        ),
	.c0     (clk_cmos   ),
    .c1     (clk_vga    )
   );
    
    pll1 u_pll1(
	.areset (~rst_n     ),
	.inclk0 (clk        ),
	.c0     (clk_100m   ),
	.c1     (clk_100m_s ),
	.locked ()
    );

    capture u_capture(
    /*input           */.clk     (pclk      ),
    /*input           */.rst_n   (rst_n     ),
    /*input           */.vsync   (cmos_vsync),
    /*input           */.href    (cmos_href ),
    /*input   [7:0]   */.din     (cmos_din  ),
    /*input           */.enable  (1'b1      ),
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
    /*input           */.rst_n    (rst_n     ),
    /*input   [15:0]  */.din      (dout      ),
    /*input           */.din_vld  (dout_vld  ),
    /*output          */.rdy      (rd_req    ),
    /*output  [15:0]  */.vga_rgb  (vga_rgb   ),
    /*output          */.vga_hsync(vga_hsync ),
    /*output          */.vga_vsync(vga_vsync )
    );

sdr u_slave(
    .Dq     (sdram_dq     ), 
    .Addr   (sdram_addr   ), 
    .Ba     (sdram_bank   ), 
    .Clk    (clk_100m_s   ), 
    .Cke    (sdram_cke    ), 
    .Cs_n   (sdram_csn    ), 
    .Ras_n  (sdram_rasn   ), 
    .Cas_n  (sdram_casn   ), 
    .We_n   (sdram_wen    ), 
    .Dqm    (sdram_dqm    )
);

//参数定义
    
    parameter   CLOCK_CYCLE = 20,
                PCLK_CYCLE  = 12;

    initial clk = 0;
    always #(CLOCK_CYCLE/2) clk = ~clk;

    initial pclk = 1'b0;
    always #(PCLK_CYCLE/2) pclk = ~pclk;

    integer i = 0,j = 0;

    initial begin
        rst_n = 0; 
        #(PCLK_CYCLE*20);
        rst_n = 1; 
        #(PCLK_CYCLE*2000);
        repeat(5)begin 
            cmos_vsync  = 1'b1  ; 
            #(PCLK_CYCLE*2000);
            cmos_vsync  = 1'b0  ; 
            #(PCLK_CYCLE*2000);
            for(i=0;i<720;i=i+1)begin //720行
                for(j=0;j<2560;j=j+1)begin //1280列
                    cmos_href   = 1'b1  ; 
                    cmos_din    = {$random};
                    #(PCLK_CYCLE*1); 
                end 
                 cmos_href   = 1'b0  ; 
                #(PCLK_CYCLE*1000); 
            end  
            #(PCLK_CYCLE*2000);
        end 
        #(PCLK_CYCLE*200);
        $stop;
    end 
    
endmodule





