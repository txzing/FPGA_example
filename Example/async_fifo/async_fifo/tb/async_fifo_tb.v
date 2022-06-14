`timescale 1 ns/1 ns

module async_fifo_tb  #(parameter WIDTH = 8,DEPTH = 130)();

/************* 用取对数的方法计算地址指针的位宽 ************************/

    function integer log2b(input integer data);  //函数返回类型integer
        begin 
            for(log2b=0;data>0;log2b=log2b+1)  
                data = data>>1;
            log2b = log2b - 1;
        end  
    endfunction

/************************************************************************/
   
    localparam  ADDR_W = log2b(DEPTH),
                DATA_W = WIDTH;

    reg                           rst_n   ;//异步复位 高电平有效
    //写侧信号
    reg                           wrclk   ;//写时钟
    reg                           wrreq   ;//写请求
    reg   [DATA_W-1:0]            wrdin   ;//写数据输入
    wire                          wrfull  ;//写满标志
    wire                          wrempty ;//写空标志
    wire  [ADDR_W-1:0]            wrusedw ;//写侧可读数据量

    //读侧信号
    reg                           rdclk   ;//读时钟
    reg                           rdreq   ;//读请求
    wire  [DATA_W-1:0]            rddout  ;//读数据输出
    wire                          rdfull  ;//读满标志
    wire                          rdempty ;//读空标志
    wire  [ADDR_W-1:0]            rdusedw ;//读侧可读数据量

    //时钟周期定义
    parameter WRCYCLE = 20,RDCYCLE = 12;

    //复位周期定义
    parameter RST_TIME = 30 ;

    integer i = 0,j = 0;

    //仿真模块例化
    async_fifo #(.FIFO_WIDTH(WIDTH),.FIFO_DEPTH(DEPTH)) u_async_fifo(
    .rst_n      (rst_n      ),//异步复位 高电平有效
    //写侧信号
    .wrclk      (wrclk      ),//写时钟
    .wrreq      (wrreq      ),//写请求
    .wrdin      (wrdin      ),//写数据输入
    .wrfull     (wrfull     ),//写满标志
    .wrempty    (wrempty    ),//写空标志
    .wrusedw    (wrusedw    ),//写时钟域下的可读数据量
    //读侧信号
    .rdclk      (rdclk      ),//读时钟
    .rdreq      (rdreq      ),//读请求
    .rddout     (rddout     ),//读数据输出
    .rdfull     (rdfull     ),//读满标志
    .rdempty    (rdempty    ),//读空标志
    .rdusedw    (rdusedw    ) //读时钟域下的可读数据量           
    );

    //产生写时钟
    initial begin
        fork
            wrclk = 1;
            #2;
            wrclk = 0;
        join 
            forever
            #(WRCYCLE/2)
            wrclk = ~wrclk;
    end
    
    //产生读时钟
    initial begin
        fork
            rdclk = 1;
            #2;
            rdclk = 0;
        join 
            forever
            #(RDCYCLE/2)
            rdclk = ~rdclk;
    end
    
    //复位
    initial begin
        rst_n = 1;
        #2;
        rst_n = 0;
        #RST_TIME;
        rst_n = 1;
    end


    //写侧输入
    initial begin
        #1;
        wrreq   = 0;//写请求
        wrdin   = 0;//写数据输入
        #(10*WRCYCLE);
        repeat(5)begin 
            for(i = 0;i < 500;i = i + 1)begin 
                wrreq   = wrfull?1'b0:{$random};//写请求
                wrdin   = {$random};//写数据输入
                #(1*WRCYCLE);
            end 
            wrreq   = 0;//写请求
            wrdin   = 0;//写数据输入
            #(100*WRCYCLE);
        end  
        #(100*WRCYCLE);
        $stop;
    end

    //读侧输入
    initial begin
        #1;
        rdreq   = 0;//读请求
        #(30*RDCYCLE);
        repeat(8)begin 
            for(j = 0;j < 200;j = j + 1)begin
                rdreq = rdempty?1'b0:{$random};
                #(1*RDCYCLE);
            end
            rdreq   = 0;
            #(300*RDCYCLE);
        end
    end 

endmodule

