module i2c_eeprom (
    input               clk     ,
    input               rst_n   ,

    input               uart_rxd,
    output              uart_txd,

    output              i2c_scl ,
    inout               i2c_sda     
);
    
//信号定义

    wire    [7:0]       rx_data     ;
    wire                rx_data_vld ;
    wire    [7:0]       wr_data     ;
    wire                wr_data_vld ;
    wire                wr_en       ;
    wire                rd_en       ;
    wire    [8:0]       rw_addr     ;
    wire                req         ;
    wire    [3:0]       cmd         ;
    wire    [7:0]       data        ;
    wire                wr_fail     ;
    wire    [7:0]       rd_dout     ;
    wire                rw_done     ;
    wire                sda_in      ;
    wire                sda_out     ;
    wire                sda_out_en  ;
    wire                rdy         ;
    wire    [7:0]       tx_data     ;
    wire                tx_data_vld ;

    assign i2c_sda = sda_out_en?sda_out:1'bz;
    assign sda_in = i2c_sda;
    
//模块例化

    uart_rx u_uart_rx(
    .clk        (clk           ),
    .rst_n      (rst_n         ),

    .din        (uart_rxd      ),
    .dout       (rx_data       ),
    .dout_vld   (rx_data_vld   )
);

    cmd_analy u_cmd_analy(  //命令帧解析模块
    .clk        (clk           ),
    .rst_n      (rst_n         ),

    .din        (rx_data       ),
    .din_vld    (rx_data_vld   ),
    .dout       (wr_data       ),//写入FIFO的数据
    .dout_vld   (wr_data_vld   ),
    .wr_en      (wr_en         ),//写请求
    .rd_en      (rd_en         ),//读请求
    .addr       (rw_addr       ) //读写地址
);

    eeprom_control u_eeprom_control(
    .clk        (clk           ),
    .rst_n      (rst_n         ),
    
    //user interface
    .wr_req     (wr_en         ),
    .rd_req     (rd_en         ),
    .wr_din     (wr_data       ),
    .wr_din_vld (wr_data_vld   ),
    .rw_addr    (rw_addr       ),
    .rdy        (rdy           ),
    .tx_data    (tx_data       ),
    .tx_data_vld(tx_data_vld   ),

    //i2c interface
    .req        (req           ),
    .cmd        (cmd           ),
    .data       (data          ),
    .wr_fail    (wr_fail       ),
    .rd_din     (rd_dout       ),
    .rw_done    (rw_done       )
);

    i2c_interface u_i2c_interface(  //仅仅实现I2C协议时序
    .clk         (clk           ),//50MHz
    .rst_n       (rst_n         ),

    .req         (req           ),//传输使能
    .cmd         (cmd           ),//传输命令码
    .wr_din      (data          ),//需要传输的数据

    .sda_in      (sda_in        ),
    .sda_out     (sda_out       ),
    .sda_out_en  (sda_out_en    ),
    .scl         (i2c_scl       ),

    .wr_fail     (wr_fail       ),//从机未应答
    .rd_dout     (rd_dout       ),//从slave读取的1字节数据 
    .rw_done     (rw_done       ) //1个字节读写完成
);

    uart_tx u_uart_tx(
    .clk        (clk            ),
    .rst_n      (rst_n          ),
    .din        (tx_data        ),
    .din_vld    (tx_data_vld    ),
    .rdy        (rdy            ),//ready 表示串口发送模块可以接收数据并发送
    .dout       (uart_txd       )    
);

endmodule

