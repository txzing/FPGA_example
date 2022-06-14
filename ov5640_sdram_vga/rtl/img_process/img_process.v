module img_process( 
    input				clk		,
    input				rst_n	,

    input		[15:0]  din		,
    input		    	din_vld	,
    input               din_sop ,
    input               din_eop ,

    output	    [15:0]	dout	,
    output	        	dout_vld,
    output              dout_sop,
    output              dout_eop
);								 
               
    //中间信号定义		 
    wire    [7:0]       gray_dout       ;
    wire                gray_dout_vld   ;
    wire                gray_dout_sop   ;
    wire                gray_dout_eop   ;
    wire    [7:0]       gs_dout         ;
    wire                gs_dout_sop     ;
    wire                gs_dout_eop     ;
    wire                gs_dout_vld     ;
    wire                bin_dout_sop    ;
    wire                bin_dout_eop    ;
    wire                bin_dout_vld    ;
    wire                bin_dout        ;
    wire                sobel_dout_sop  ;
    wire                sobel_dout_eop  ;
    wire                sobel_dout_vld  ;
    wire                sobel_dout      ;

//模块例化

    rgb565_gray u_rgb2gray( 
    /*input				    */.clk		(clk            ),
    /*input				    */.rst_n	(rst_n          ),
    /*input		[15:0]	    */.din		(din		    ),//rgb565格式输入
    /*input		            */.din_vld  (din_vld        ),
    /*input		    	    */.din_sop	(din_sop        ),
    /*input                 */.din_eop  (din_eop        ),
    /*output	[7:0]	    */.dout	    (gray_dout      ),//灰度输出
    /*output		    	*/.dout_vld (gray_dout_vld  ),
    /*output                */.dout_sop (gray_dout_sop  ),
    /*output                */.dout_eop (gray_dout_eop  )
);					

gs_filter u_gs_f(
    /*input               */.clk        (clk            ),
    /*input               */.rst_n      (rst_n          ),
    /*input               */.din_sop    (gray_dout_sop  ),
    /*input               */.din_eop    (gray_dout_eop  ),
    /*input               */.din_vld    (gray_dout_vld  ),
    /*input       [7:0]   */.din        (gray_dout      ),//灰度输入
    /*output              */.dout_sop   (gs_dout_sop    ),
    /*output              */.dout_eop   (gs_dout_eop    ),
    /*output              */.dout_vld   (gs_dout_vld    ),
    /*output      [7:0]   */.dout       (gs_dout        ) //灰度输出
);

gray2bin  u_gray2bin (
    /*input               */.clk         (clk           ),
    /*input               */.rst_n       (rst_n         ),
    /*input               */.din_sop     (gs_dout_sop   ),
    /*input               */.din_eop     (gs_dout_eop   ),
    /*input               */.din_vld     (gs_dout_vld   ),
    /*input       [7:0]   */.din         (gs_dout       ),//灰度图像输入
    /*output  reg         */.dout_sop    (bin_dout_sop  ),
    /*output  reg         */.dout_eop    (bin_dout_eop  ),
    /*output  reg         */.dout_vld    (bin_dout_vld  ),
    /*output  reg         */.dout        (bin_dout      ) //二值图像输出 0 1
);

 sobel u_sobel(
    /*input           */.clk         (clk           ),
    /*input           */.rst_n       (rst_n         ),
    /*input           */.din_sop     (bin_dout_sop  ),
    /*input           */.din_eop     (bin_dout_eop  ),
    /*input           */.din_vld     (bin_dout_vld  ),
    /*input           */.din         (bin_dout      ),
    /*output  reg     */.dout_sop    (sobel_dout_sop),
    /*output  reg     */.dout_eop    (sobel_dout_eop),
    /*output  reg     */.dout_vld    (sobel_dout_vld),
    /*output  reg     */.dout        (sobel_dout    )   
);

    assign dout_sop = sobel_dout_sop;
    assign dout_eop = sobel_dout_eop;
    assign dout_vld = sobel_dout_vld;
    assign dout     = {16{sobel_dout}};

endmodule