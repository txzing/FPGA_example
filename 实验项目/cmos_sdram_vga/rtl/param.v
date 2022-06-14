//sdram参数定义
`define     USER_BL     512
`define     RD_UT       1500
`define     RD_LT       600
`define     BURST_MAX   `H_AP * `V_AP

//时间参数定义
`define     TWAIT   20000
`define     TRRC    7 
`define     TRCD    3 
`define     TRP     3
`define     TMRS    3
`define     TREF    780
`define     TRECOV  2

//命令参数
`define     CMD_PRECH 4'b0010  
`define     CMD_AREF  4'b0001      
`define     CMD_MRS   4'b0000  
`define     CMD_ACTI  4'b0011      
`define     CMD_WR    4'b0100      
`define     CMD_RD    4'b0101      
`define     CMD_NOP   4'b0111  
`define     CMD_BST   4'b0110 

//摄像头参数

//i2c时钟参数                200KHz时钟频率
`define  SCL_PERIOD  250
`define  SCL_HALF    125 //翻转时间
`define  LOW_HLAF    65 
`define  HIGH_HALF   190

//i2c命令参数
`define CMD_START   4'b0001
`define CMD_WRITE   4'b0010
`define CMD_READ    4'b0100
`define CMD_STOP    4'b1000

//从机ID定义
`define WR_ID 8'h78
`define RD_ID 8'h79

//配置寄存器个数
//`define REG_NUM     254
`define REG_NUM     252

//vga时序参数

`define     H_SW    40      //行同步脉冲
`define     H_BP    220     //行后沿
`define     H_AP    1280    //行有效显示区域
`define     H_FP    110     //行前沿
`define     H_START `H_SW + `H_BP 
`define     H_END   `H_TP - `H_FP
`define     H_TP    1650


`define     V_SW    5       //场同步脉冲
`define     V_BP    20      //场后沿
`define     V_AP    720     //场有效显示区域
`define     V_FP    5       //场前沿
`define     V_START `V_SW + `V_BP 
`define     V_END   `V_TP - `V_FP
`define     V_TP    750
