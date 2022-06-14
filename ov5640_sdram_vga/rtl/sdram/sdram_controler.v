module sdram_controler (
    input               clk         ,
    input               clk_in      ,
    input               clk_out     ,
    input               rst_n       ,

    //用户输入
    input               rd_en       ,
    input       [15:0]  din         ,
    input               din_vld     ,
    input               din_sop     ,
    input               din_eop     ,
    output      [15:0]  dout        ,    
    output              dout_vld    , 

    //sdram接口
    output              sdram_cke   ,
    output              sdram_csn   ,
    output              sdram_rasn  ,
    output              sdram_casn  ,
    output              sdram_wen   ,
    output  [1:0]       sdram_bank  ,
    output  [12:0]      sdram_addr  ,//行地址：A0--A12 列地址：A0--A9
    inout   [15:0]      sdram_dq    ,
    output  [1:0]       sdram_dqm   
    );


//信号定义

    wire    [15:0]      dq_in       ;
    wire    [15:0]      dq_out      ;
    wire                dq_out_en   ;
    wire                wr_req      ;
    wire    [15:0]      wr_data     ;
    wire                rd_req      ;
    wire    [24:0]      rw_addr     ;//bank地址 + 行地址  +  列地址
    wire    [15:0]      rd_data     ;
    wire                rd_data_vld ;
    //wire                busy        ;
    wire                ack         ;

//模块例化

    sdram_ctrl u_rw_ctrl(       //实现sdram读写控制
    /*input               */.clk         (clk          ),
    /*input               */.clk_in      (clk_in       ),
    /*input               */.clk_out     (clk_out      ),

    /*input               */.rst_n       (rst_n        ),
    /*input               */.rd_en       (rd_en        ),
    /*input       [15:0]  */.din         (din          ),
    /*input               */.din_vld     (din_vld      ),
    /*input               */.din_sop     (din_sop      ),
    /*input               */.din_eop     (din_eop      ),
    /*output      [15:0]  */.dout        (dout         ),    
    /*output              */.dout_vld    (dout_vld     ), 

    //sdram_intf接口
    /*output               */.wr_req      (wr_req       ),
    /*output      [15:0]   */.wr_data     (wr_data      ),
    /*output               */.rd_req      (rd_req       ),
    /*output      [24:0]   */.rw_addr     (rw_addr      ),
    /*input       [15:0]   */.rd_data     (rd_data      ),
    /*input                */.rd_data_vld (rd_data_vld  ),
    /*input                */.ack         (ack          )
    );

    sdram_intf u_intf(      //实现sdram接口时序
    /*.input               */.clk         (clk          ),
    /*.input               */.rst_n       (rst_n        ),

    //sdram_ctrl接口
    /*input                */.wr_req      (wr_req       ),
    /*input       [15:0]   */.wr_data     (wr_data      ),
    /*input                */.rd_req      (rd_req       ),
    /*input       [24:0]   */.rw_addr     (rw_addr      ),
    /*output      [15:0]   */.rd_data     (rd_data      ),
    /*output               */.rd_data_vld (rd_data_vld  ),
    /*output               */.ack         (ack          ),

    //sdram存储器接口
    /*output               */.mem_cke     (sdram_cke      ),
    /*output               */.mem_csn     (sdram_csn      ),
    /*output               */.mem_rasn    (sdram_rasn     ),
    /*output               */.mem_casn    (sdram_casn     ),
    /*output               */.mem_wen     (sdram_wen      ),
    /*output  [1:0]        */.mem_bank    (sdram_bank     ),
    /*output  [12:0]       */.mem_addr    (sdram_addr     ),
    /*input   [15:0]       */.mem_dq_in   (dq_in          ),
    /*output  [15:0]       */.mem_dq_out  (dq_out         ),
    /*output               */.mem_dq_oe   (dq_out_en      ),
    /*output  [1:0]        */.mem_dqm     (sdram_dqm      )
    ); 

    assign dq_in = sdram_dq;
    assign sdram_dq = dq_out_en?dq_out:16'hzzzz;

   

endmodule 
