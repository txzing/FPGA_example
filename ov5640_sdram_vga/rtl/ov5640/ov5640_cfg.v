/**************************************功能介绍***********************************			
Description:	OV5640摄像头配置，使用I2C接口配置摄像头寄存器。	
				I2C接口模块使用命令队列+数据队列的模式。
*********************************************************************************/

module ov5640_cfg (
    input           clk     ,
    input           rst_n   ,

    //摄像头接口
    output          sio_c   ,
    inout           sio_d   ,
    output          cfg_done //初始化配置完成
  
);

//信号定义

    wire            req         ;
    wire    [3:0]   cmd         ;
    wire            cmd_vld     ;
    wire    [7:0]   wr_dout     ;
    wire            wr_dout_vld ;
    wire            slave_busy  ;
    wire            sda_in      ;
    wire            sda_out     ;
    wire            sda_out_en  ;
    wire            scl         ;
    wire    [7:0]   rd_dout     ;
    wire            rd_dout_vld ;


//模块例化
    i2c_cfg u_cfg(
    /*input            */.clk         (clk           ),
    /*input            */.rst_n       (rst_n         ),

    //i2c_intf
    /*output reg [7:0] */.wr_dout     (wr_dout       ),
    /*output reg       */.wr_dout_vld (wr_dout_vld   ),  
    /*output reg [3:0] */.cmd         (cmd           ),
    /*output reg       */.cmd_vld     (cmd_vld       ),
    /*output reg       */.req         (req           ),
    /*input            */.slave_busy  (slave_busy    ),
    /*output reg       */.config_done (cfg_done      )//配置完成标志
    );

    i2c_intf u_i2c(
    /*input               */.clk              (clk          ),
    /*input               */.rst_n            (rst_n        ),
    //eeprom_ctrl接口
    /*input               */.req              (req          ),
    /*input       [3:0]   */.cmd              (cmd          ),
    /*input               */.cmd_vld          (cmd_vld      ),
    /*input       [7:0]   */.wr_din           (wr_dout      ),
    /*input               */.wr_din_vld       (wr_dout_vld  ),
    /*output  reg         */.slave_busy       (slave_busy   ),
    /*output  reg         */.fail             (),

    //eeprom接口
    /*input               */.sda_in           (sda_in       ),
    /*output  reg         */.sda_out          (sda_out      ),
    /*output  reg         */.sda_out_en       (sda_out_en   ),
    /*output  reg         */.scl              (scl          ),
    /*output  reg [7:0]   */.rd_dout          (rd_dout      ),
    /*output  reg         */.rd_dout_vld      (rd_dout_vld  )
    );



    assign sio_c = scl;
    assign sio_d = sda_out_en?sda_out:1'bz;
    assign sda_in = sio_d;




endmodule 
