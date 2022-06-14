`timescale 1ns/1ns
`include "../rtl/param.v"   

module top_tb();
//激励信号定义 
    reg				clk  	    ;
    reg				rst_n	    ;
    reg     [7:0]	cmos_din    ;
    reg				cmos_vsync	;
    reg				cmos_href   ;
    reg             cfg_done    ;
    reg             pclk        ;

//输出信号定义	 

    wire    [7:0]   vga_r       ;//r g b 数据输出给 da芯片
    wire    [7:0]   vga_g       ;
    wire    [7:0]   vga_b       ;
    wire            vga_blank   ;
    wire            vga_sync    ;
    wire            vga_clk     ;
    //output to vga 
    wire            vga_hsync   ;
    wire            vga_vsync   ;


    wire            clk_24m     ;
    wire            clk_75m     ;
    wire            locked0     ;

    wire            clk_150m    ;
    wire            clk_150_s   ;
    wire            locked1     ;

    wire    [15:0]  pixel       ;
    wire            pixel_vld   ;
    wire            pixel_sop   ;
    wire            pixel_eop   ;
    wire    [12:0]  sdram_addr  ;
    wire    [15:0]  sdram_dq    ;
    wire    [1:0]   sdram_bank  ;
    wire            sdram_cke   ;
    wire            sdram_csn   ;
    wire            sdram_rasn  ;
    wire            sdram_casn  ;
    wire            sdram_wen   ;
    wire    [1:0]   sdram_dqm   ;
    wire    [15:0]  mem_din    	;
    wire            mem_din_vld ;
    wire            mem_din_sop ;
    wire            mem_din_eop ;
    wire    [15:0]  vga_data    ;
    wire            vga_data_vld;
    wire            vga_req     ;
    wire            vga_rst     ;
    wire            rd_mem_en   ;
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
	/*output wire  */.outclk_1  (clk_150_s  ), // outclk1.clk
	/*output wire  */.locked    (locked1    )    //  locked.export
	);

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

    img_process u_img_process( 
   /*input			 	*/.clk		(pclk           ),
   /*input				*/.rst_n	(rst_n          ),
   /*input		[15:0]  */.din		(pixel          ),
   /*input		    	*/.din_vld	(pixel_vld      ),
   /*input              */.din_sop  (pixel_sop      ),
   /*input              */.din_eop  (pixel_eop      ),
   /*output	[15:0]	    */.dout	    (mem_din        ),
   /*output	            */.dout_vld (mem_din_vld    ),
   /*output             */.dout_sop (mem_din_sop    ),
   /*output             */.dout_eop (mem_din_eop    )
);		

`else       //注意不能用`elsif
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

    sdr u_sdr(
    .Dq     (sdram_dq         )  , 
    .Addr   (sdram_addr       )  , 
    .Ba     (sdram_bank       )  ,
    .Clk    (~clk_150m        )  , 
    .Cke    (sdram_cke        )  , 
    .Cs_n   (sdram_csn        )  , 
    .Ras_n  (sdram_rasn       )  , 
    .Cas_n  (sdram_casn       )  , 
    .We_n   (sdram_wen        )  , 
    .Dqm    (sdram_dqm        )  
    );

//时钟周期参数定义					          
    

//产生时钟							       		
initial clk = 1'b0;		       		
always #10 clk = ~clk;  		

initial pclk = 1'b0;
always #6 pclk = ~pclk;

integer i = 0, j = 0;

//产生激励							       		
initial  begin						       		
    rst_n = 1'b0;								
    cmos_din   = 0;
    cmos_vsync = 0;
    cmos_href  = 0;
    cfg_done = 1'b0;
    #200;				            
    rst_n = 1'b1  ;						
    @(negedge u_sdram_ctrl.u_intf.init_flag);//SDRAM初始化完成后开始输入数据
    #20000;	
    cfg_done = 1'b1;
    #200;		
    repeat(5)begin 
        cmos_vsync = 1'b1;
        #2000;	
        cmos_vsync = 1'b0;
        for(i=0;i<`IMG_H;i=i+1)begin 
            #3000;	
            for(j=0;j<(`IMG_W<<1);j=j+1)begin 
                cmos_href  = 1'b1;
                cmos_din   = {$random};
                #12;
            end 
            cmos_href  = 1'b0;
            cmos_href  = 0;
            cmos_din   = 0;
            #2000;
        end 
        #5000;
    end 
    #2000;
    $stop;                                                
                                                   
end 									       	
endmodule 	
