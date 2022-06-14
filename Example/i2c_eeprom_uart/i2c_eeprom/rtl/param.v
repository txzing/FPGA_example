//串口参数
//定义串口的波特率参数
    `define BAUD_115200 //使用 波特率为115200
    //`define BAUD_57600 //使用 波特率为57600
    //`define BAUD_38400 //使用 波特率为38400
    //`define BAUD_19200 //使用 波特率为19200
    //`define BAUD_9600  //使用 波特率为9600

//根据所选的波特率定义相应的计数周期    
    `ifdef BAUD_115200
        `define BAUD 434
    `elsif BAUD_57600
        `define BAUD 868
    `elsif BAUD_38400
        `define BAUD 1302
    `elsif BAUD_19200
        `define BAUD 2604
    `elsif BAUD_9600
        `define BAUD 5208
    `endif 


//I2C时钟参数
`define     SCL_MAX     150 //I2C时钟周期
`define     SCL_HALF    75  //I2C时钟翻转时间
`define     SEND        25  //发送数据时间
`define     SAMPLE      115 //采样数据时间

//命令码参数
`define     CMD_START   4'b0001 //发起始位命令码
`define     CMD_WRITE   4'b0010 //写1字节数据
`define     CMD_READ    4'b0100 //读1字节数据
`define     CMD_STOP    4'b1000 //发停止位

//eeprom读写模式定义
//`define     ENABLE_BYTE_WRITE   //使能字节写
`define     ENABLE_PAGE_WRITE   //使能页写

//`define     ENABLE_RANDOM_READ  //使能随机地址读
`define     ENABLE_SEQUEN_READ  //使能连续地址读

`ifdef  ENABLE_BYTE_WRITE    //单次写
    `define WR_BYTE 3        //操作的字节数，设备地址，写地址，写数据
`elsif  ENABLE_PAGE_WRITE   //连续写
    `define WR_BYTE 18     //2+16,24LC04,一页16个字节
`endif 

`ifdef  ENABLE_RANDOM_READ
    `define RD_BYTE 4     //设备地址，写入读地址，设备地址，读数据
`elsif  ENABLE_SEQUEN_READ
    `define RD_BYTE 19  //连续地址读：连续读16字节
`endif 

`define SLAVE_CODE  4'b1010 
`define WR_BIT      1'b0
`define RD_BIT      1'b1

