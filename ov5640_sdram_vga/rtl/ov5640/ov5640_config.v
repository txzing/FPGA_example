/**************************************功能介绍***********************************			
Description:	OV5640摄像头配置，使用I2C接口配置摄像头寄存器。	
				I2C接口模块使用请求--应答直接握手模式。
*********************************************************************************/

module ov5640_config (
    input           clk     ,
    input           rst_n   ,

    //摄像头接口
    output          sio_c   ,
    inout           sio_d   ,
    output          cfg_done //初始化配置完成
);

//信号定义

    wire    [3:0]       trans_cmd       ;
    wire                trans_done      ;
    wire                trans_req       ;
    wire    [7:0]       trans_dout      ;
    wire                i2c_sda_in      ;
    wire                i2c_scl         ;
    wire                i2c_sda_out     ;
    wire                i2c_sda_out_en  ;

//模块例化
 i2c_config u_i2c_cfg (
    /*input				      */.clk		 (clk       ),
    /*input				      */.rst_n	     (rst_n     ),
    /*input                   */.rw_done     (trans_done),
    /*output    reg           */.trans_req   (trans_req ),
    /*output    reg [3:0]     */.trans_cmd   (trans_cmd ),
    /*output    reg [7:0]     */.trans_dout  (trans_dout),
    /*output    reg           */.config_done (cfg_done  ) //摄像头配置完成
);							 

i2c_interface u_i2c_interface( 
    /*input				  */.clk		     (clk           ),
    /*input				  */.rst_n	         (rst_n         ),
    /*input               */.trans_req       (trans_req     ),//传输请求  
    /*input         [3:0] */.trans_cmd       (trans_cmd     ),//命令码、操作码  
    /*input         [7:0] */.wr_din          (trans_dout    ),//待发送给从机的数据     
    /*output  reg   [7:0] */.rd_dout         (              ),//从slave读取的一字节数据   
    /*output  reg         */.rd_dout_vld     (              ),
    /*output  reg         */.trans_done      (trans_done    ),//i2c_interface 传输一字节完成
    /*input               */.i2c_sda_in      (i2c_sda_in    ),
    /*output  reg         */.i2c_scl         (i2c_scl       ),
    /*output  reg         */.i2c_sda_out     (i2c_sda_out   ),
    /*output  reg         */.i2c_sda_out_en  (i2c_sda_out_en)
    ///*output  reg         */.i2c_wr_faile    ()
);

    assign sio_c = i2c_scl;
    assign sio_d = i2c_sda_out_en?i2c_sda_out:1'bz;
    assign i2c_sda_in = sio_d;
    
endmodule


