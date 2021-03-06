//定义一个摄像头
`define     ONE_SLAVE   

//定义是否使用边缘检测模式
//`define ENABLE_EDGE_DETECT

//OV5640配置部分参数
//`define REG_NUM 306 //定义需要配置的寄存器个数     输出内置彩条
`define REG_NUM 304 //定义需要配置的寄存器个数      输出采集的数据

`define WRITE_ONLY  //定义只写寄存器
//`define WRITE_READ  //定义先写再读寄存器

`ifdef WRITE_ONLY
    `define RD_FLAG 1'b0    //读寄存器标志参数
`elsif WRITE_READ
    `define RD_FLAG 1'b1 
`endif 

`define WR_ID 8'h78 //写摄像头ID
`define RD_ID 8'h79 //读摄像头ID

//I2C时钟参数
`define     SCL_MAX     150 //I2C时钟周期
`define     SCL_HALF    75  //I2C时钟翻转时间
`define     SEND        25  //发送数据时间
`define     SAMPLE      115 //采样数据时间

//i2c_intf命令
`define     CMD_START   4'b0001 //发起始位命令码
`define     CMD_WR      4'b0010 //写1字节数据
`define     CMD_RD      4'b0100 //读1字节数据
`define     CMD_STOP    4'b1000 //发停止位

//定义图像分辨率
`define IMG_W   1280//1280
`define IMG_H   720//720

//sdram参数
//`define     BL_1   
//`define     BL_2   
//`define     BL_4   
//`define     BL_8   
`define     BL_FULL   //1024

`ifdef  BL_1        //定义模式寄存器的突发长度
    `define     BL   3'b000
    `define     BURST_LEN 1
`elsif  BL_2
    `define     BL   3'b001
    `define     BURST_LEN 2
`elsif  BL_4
    `define     BL   3'b010
    `define     BURST_LEN 4
`elsif  BL_8
    `define     BL   3'b011
    `define     BURST_LEN 8
`elsif  BL_FULL
    `define     BL   3'b111
    `define     BURST_LEN 1024
`endif 

`define BURST_MAX `IMG_W*`IMG_H       //定义最大突发地址

`define     SEQ_BURST       //定义连续突发
//`define     INT_BURST
`ifdef  SEQ_BURST        //定义模式寄存器的突发类型  
    `define     BT   1'b0
`elsif  INT_BURST
    `define     BT   1'b1
`endif 

`define CASL_2
//`define CASL_3

`ifdef  CASL_2        //定义模式寄存器的列选通延时
    `define     CASL   3'b010
`elsif  CASL_3
    `define     CASL   3'b011
`endif 

`define OP_MODE 2'b00   //定义工作模式 标准模式

`define WB_MODE_0       //定义写突发模式 是可编程突发长度还是单地址突发
//`define WB_MODE_1

`ifdef  WB_MODE_0        //定义模式寄存器的突发模式
    `define     WB_MODE   1'b0
`elsif  WB_MODE_1
    `define     WB_MODE   1'b1
`endif 

//时间参数定义
`define     TWAIT   20000
`define     TRRC    7 
`define     TRCD    3 
`define     TRP     3
`define     TMRS    3
`define     TREF    1170

//命令参数
`define     CMD_PRECH 4'b0010  
`define     CMD_AREF  4'b0001      
`define     CMD_MRS   4'b0000  
`define     CMD_ACTI  4'b0011      
`define     CMD_WRITE 4'b0100      
`define     CMD_READ  4'b0101      
`define     CMD_NOP   4'b0111  
`define     CMD_BST   4'b0110 

`define     WR_TH     1024
`define     RD_TH_L   600
`define     RD_TH_U   3000

//VGA时序参数
    //行同步时序    单位：vga像素时钟周期

`define     H_SYNC      40
`define     H_BP        220
`define     H_ACT       `IMG_W
`define     H_FP        110
`define     H_TOTAL     `H_FP + `H_SYNC + `H_BP + `H_ACT //1650

    //场同步时序    单位：一行
`define     V_SYNC      5   
`define     V_BP        20
`define     V_ACT       `IMG_H
`define     V_FP        5
`define     V_TOTAL     `V_FP + `V_SYNC + `V_BP + `V_ACT    //750

