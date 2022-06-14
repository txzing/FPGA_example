//sccb
`define IDWADD   8'h78      //从设备地址  设备地址 7'h3c     写寄存器时发    {设备地址 7'h3c ，写控制位 1'b0} 8'h78
`define IDRADD   8'h79      //                              读寄存器时发     {设备地址 7'h3c ，读控制位 1'b1} 8'h79
`define SCK_MAX  8'd240     //sio_c为200KHz
`define SIOC_H   8'd60      //sio_c拉高时间
`define SIOC_L   8'd180     //sio_c拉低时间

//capture
`define COL         1280            //一行1280个像素点
`define ROW         720             //一帧720行

//sdram_driver状态机参数定义

`define WAIT        8'b0000_0001    //等待200us
`define PRECHARGE   8'b0000_0010    //预充电
`define REFRESH     8'b0000_0100    //刷新
`define MODESET     8'b0000_1000    //模式寄存器设置
`define IDLE        8'b0001_0000    //初始化之后，IDLE
`define ACTIVE      8'b0010_0000    //行激活
`define READ        8'b0100_0000    //列读
`define WRITE       8'b1000_0000    //列写

//sdram_driver模式设置参数定义
`define BL      3'b111      //突发长度 全页突发
`define BT      1'b0        //突发类型 连续突发
`define CASL    3'b011      //列选通延时
`define OP_CODE 1'b0        //读写模式 突发读写

//sdram_driver时间参数定义

`define TIME_200US  20000           //上电等待200us
`define TIME_RP     3               //发出预充电指令后等待时间
`define TIME_MRD    3               //发出模式寄存器设置命令后等待时间
`define TIME_RRC    8               //发出刷新指令后等待时间
`define TIME_RCD    3               //发出激活命令后等待时间
`define TIME_REF    780             //刷新时间间隔
`define TIME_WR     512 + 2         //发出写数据命令后等待时间
`define TIME_RD     512             //发出读数据命令后等待时间?????????????????????

//sdram_driver命令参数定义
`define CMD_MRS     4'b0000     //模式寄存器设置命令
`define CMD_NOP     4'b0111     //空操作命令
`define CMD_ACT     4'b0011     //激活命令
`define CMD_RD      4'b0101     //读数据命令
`define CMD_WR      4'b0100     //写数据命令
`define CMD_PR      4'b0010     //预充电命令
`define CMD_REF     4'b0001     //刷新命令

//sdram_rw_ctrl状态机参数
`define C_IDLE      5'b0_0001     //IDLE
`define WR_REQ      5'b0_0010     //发送写请求
`define SEND_DATA   5'b0_0100     //发送数据
`define RD_REQ      5'b0_1000     //发送读请求
`define READ_DATA   5'b1_0000     //读取数据

`define SDRAM_BL    512           //SDRAM突发长度
`define WR_FIFO_MIN 512
`define RD_FIFO_MIN 1024
`define RD_FIFO_MAX 1500
`define RESOLUTION  1280*720      //显示器分辨率 

//VGA参数   
`define H_ACTIVE   11'd1280           //horizontal active time (pixels)    
`define H_FP       11'd110            //horizontal front porch (pixels)
`define H_SYNC     11'd40             //horizontal sync time(pixels)
`define H_BP       11'd220            //horizontal back porch (pixels)
`define H_TOTAL    1650

`define V_ACTIVE   11'd720            //vertical active Time (lines)
`define V_FP       11'd5              //vertical front porch (lines)
`define V_SYNC     11'd5              //vertical sync time (lines)
`define V_BP       11'd20             //vertical back porch (lines)
`define V_TOTAL    750
              
              
              
