/******************************** 模块注释 *********************************

Description：本模块使用Verilog实现异步FIFO的功能，能够任意指定FIFO的深度与宽度。
Author：LZ

****************************************************************************/



`define AHEAD_MODE //前显模式
//`define NOMAL_MODE //正常模式
module async_fifo #(parameter FIFO_WIDTH = 8,FIFO_DEPTH = 512)(
    rst_n       ,//异步复位 低电平有效
    //写侧信号
    wrclk       ,//写时钟
    wrreq       ,//写请求
    wrdin       ,//写数据输入
    wrfull      ,//写满标志
    wrempty     ,//写空标志
    wrusedw     ,//写时钟域下的可读数据量
    //读侧信号
    rdclk       ,//读时钟
    rdreq       ,//读请求
    rddout      ,//读数据输出
    rdfull      ,//读满标志
    rdempty     ,//读空标志
    rdusedw      //读时钟域下的可读数据量           
);

//参数声明
    localparam  ADDR_W = log2b(FIFO_DEPTH),
                DATA_W = FIFO_WIDTH;

//function声明
/************* 用取对数的方法计算地址指针的位宽 ************************/

    function integer log2b(input integer data);
        begin 
            for(log2b=0;data>0;log2b=log2b+1)  
                data = data>>1;
            log2b = log2b - 1;
        end  
    endfunction

/************************************************************************/

/**********************  格雷码与二进制互转  ****************************/
//输入的op_code为0，代表二进制转格雷码
//输入的op_code为1，代表格雷码转二进制
    function [ADDR_W:0] BIN_GRAY(input op_code,input [ADDR_W:0] data);
        integer i;
        begin 
            if(~op_code)begin 		//二进制转格雷码
               BIN_GRAY = (data >>1) ^ data;
            end 
            else if(op_code)begin 	//格雷码转二进制
                BIN_GRAY[ADDR_W] = data[ADDR_W];
                for(i = ADDR_W-1;i >= 0; i = i - 1)begin 
                    BIN_GRAY[i] = BIN_GRAY[i+1] ^ data[i];
                end 
            end 
         end 
    endfunction

/***********************************************************************/


//端口信号定义   
    input                           rst_n   ;//异步复位 高电平有效
    //写侧信号
    input                           wrclk   ;//写时钟
    input                           wrreq   ;//写请求
    input   [DATA_W-1:0]            wrdin   ;//写数据输入
    output                          wrfull  ;//写满标志
    output                          wrempty ;//写空标志
    output  [ADDR_W-1:0]            wrusedw ;//写侧可读数据量

    //读侧信号
    input                           rdclk   ;//读时钟
    input                           rdreq   ;//读请求
    output  [DATA_W-1:0]            rddout  ;//读数据输出
    output                          rdfull  ;//读满标志
    output                          rdempty ;//读空标志
    output  [ADDR_W-1:0]            rdusedw ;//读侧可读数据量

//内部信号定义
    reg     [DATA_W-1:0]            mem[FIFO_DEPTH-1:0] ;//FIFO存储器阵列

    reg     [ADDR_W  :0]            wr_pointer          ;//写地址指针
    reg     [ADDR_W  :0]            rd_pointer          ;//读地址指针

    wire    [ADDR_W-1:0]            wr_addr_bin         ;//写地址二进制码
    wire    [ADDR_W-1:0]            rd_addr_bin         ;//读地址二进制码

    wire    [ADDR_W  :0]            wr_pointer_g        ;//写指针格雷码
    wire    [ADDR_W  :0]            rd_pointer_g        ;//读指针格雷码

    reg     [ADDR_W  :0]            rd_wrptr_sync_r0    ;//写指针雷码同步寄存器
    reg     [ADDR_W  :0]            rd_wrptr_sync_r1    ;//写地址格雷码同步寄存器
    reg     [ADDR_W  :0]            wr_rdptr_sync_r0    ;//读地址格雷码同步寄存器
    reg     [ADDR_W  :0]            wr_rdptr_sync_r1    ;//读地址格雷码同步寄存器

    wire    [ADDR_W  :0]            rd_wrptr_bin_next   ;//同步到读时钟域下的格雷码写指针的二进制
    reg     [ADDR_W  :0]            rd_wrptr_bin        ;
    wire    [ADDR_W  :0]            wr_rdptr_bin_next   ;//同步到写时钟域下的格雷码读指针的二进制
    reg     [ADDR_W  :0]            wr_rdptr_bin        ;

    //输出寄存器
    reg     [DATA_W-1:0]            rddata              ;//读数据输出
    wire                            wr_full             ;
    wire                            wr_empty            ;
    reg     [ADDR_W-1:0]            wr_usedw            ;//写侧可读数据量
    reg     [ADDR_W-1:0]            rd_usedw            ;//读侧可读数据量
    wire                            rd_full             ;
    wire                            rd_empty            ;
    
//数据写入地址
    
    always  @(posedge wrclk or negedge rst_n)begin
        if(~rst_n)begin
            wr_pointer <= 0;
        end
        else if(wrreq & ~wr_full)begin      //非满的时候才写入
            wr_pointer <= wr_pointer +1;
        end
    end
	 
    assign wr_addr_bin = wr_pointer[ADDR_W-1:0];
    
    //写入数据
    always  @(posedge wrclk)begin
        if(wrreq)begin
            mem[wr_addr_bin] <= wrdin;
        end
    end

//数据读地出址  
    
    always  @(posedge rdclk or negedge rst_n)begin
        if(~rst_n)begin
            rd_pointer <= 0;
        end
        else if(rdreq & ~rd_empty)begin
            rd_pointer <= rd_pointer + 1;
        end
    end
    
    assign rd_addr_bin = rd_pointer[ADDR_W-1:0];

    //读出数据   
    always  @(posedge rdclk or negedge rst_n)begin
        if(~rst_n)begin
            rddata <= 0;
        end
        else if(~rd_empty)begin
            rddata <= mem[rd_addr_bin];
        end
    end
    
//格雷码转换

    assign wr_pointer_g = BIN_GRAY(0,wr_pointer);//写地址格雷码
    assign rd_pointer_g = BIN_GRAY(0,rd_pointer);//读地址格雷码

//格雷码同步 将写指针格雷码同步到读时钟域 
    always  @(posedge rdclk or negedge rst_n)begin
        if(~rst_n)begin
            rd_wrptr_sync_r0 <= 0;
            rd_wrptr_sync_r1 <= 0;
        end
        else begin
            rd_wrptr_sync_r0 <= wr_pointer_g;
            rd_wrptr_sync_r1 <= rd_wrptr_sync_r0;
        end
    end

//格雷码同步 将读指针格雷码同步到写时钟域
    always  @(posedge wrclk or negedge rst_n)begin
        if(~rst_n)begin
            wr_rdptr_sync_r0 <= 0;
            wr_rdptr_sync_r1 <= 0;
        end
        else begin
            wr_rdptr_sync_r0 <= rd_pointer_g;
            wr_rdptr_sync_r1 <= wr_rdptr_sync_r0;
        end
    end

    always  @(posedge rdclk or negedge rst_n)begin
        if(~rst_n)begin
            rd_wrptr_bin <= 0;
        end
        else begin
            rd_wrptr_bin <= rd_wrptr_bin_next;//将同步到读时钟域下的格雷码写地址转为二进制
        end
    end

    always  @(posedge wrclk or negedge rst_n)begin
        if(~rst_n)begin
            wr_rdptr_bin <= 0;
        end
        else begin
            wr_rdptr_bin <= wr_rdptr_bin_next;//将同步到写时钟域下的格雷码读地址转为二进制
        end
    end

    assign rd_wrptr_bin_next = BIN_GRAY(1,rd_wrptr_sync_r1);//将同步到读时钟域下的格雷码写地址转为二进制
    assign wr_rdptr_bin_next = BIN_GRAY(1,wr_rdptr_sync_r1);//将同步到写时钟域下的格雷码读地址转为二进制

//空满标志
/*
    always  @(posedge wrclk or negedge rst_n)begin
        if(~rst_n)begin
            wr_full  <= 1'b0;
            wr_empty <= 1'b1;
        end
        else begin
            wr_full  <= wr_pointer_g == {~rd_addr_sync_r1[ADDR_W -:2],rd_addr_sync_r1[ADDR_W-2:0]};//写侧满标志
            wr_empty <= wr_rdaddr_bin_next == wr_pointer;
        end
    end

    always  @(posedge rdclk or negedge rst_n)begin
        if(~rst_n)begin
            rd_full  <= 0;
            rd_empty <= 1'b1;
        end
        else begin
            rd_full  <= rd_pointer_g == {~wr_addr_sync_r1[ADDR_W -:2],wr_addr_sync_r1[ADDR_W-2:0]};//读侧满标志
            rd_empty <= rd_wraddr_bin_next == rd_pointer;
        endwrfull
    end
*/

    assign wr_full = wr_pointer_g == {~wr_rdptr_sync_r1[ADDR_W -:2],wr_rdptr_sync_r1[ADDR_W-2:0]};//写侧满标志
    assign rd_full = rd_pointer_g == {~rd_wrptr_sync_r1[ADDR_W -:2],rd_wrptr_sync_r1[ADDR_W-2:0]};//读侧满标志

    assign wr_empty = wr_rdptr_bin == wr_pointer;
    assign rd_empty = rd_wrptr_bin == rd_pointer;


    //wr_usedw  写侧可读数据量
    always  @(posedge wrclk or negedge rst_n)begin
        if(~rst_n)begin
            wr_usedw <= 0;
        end
        else begin
            wr_usedw <= wr_pointer - wr_rdptr_bin;//写侧的写指针-同步到写侧的读指针
        end
    end
    
    //rd_usedw  读侧可读数据量
    always  @(posedge rdclk or negedge rst_n)begin
        if(~rst_n)begin
            rd_usedw <= 0;
        end
        else begin
            rd_usedw <= rd_wrptr_bin - rd_pointer;//同步到读侧的写指针-读侧的读指针
        end
    end

//输出

    assign wrfull  = wr_full    ;//写满标志
    assign wrempty = wr_empty   ;//写空标志
    assign wrusedw = wr_usedw   ;//写侧可读数据量

    assign rddout  = rddata     ;//读数据输出
    assign rdfull  = rd_full    ;//读满标志
    assign rdempty = rd_empty   ;//读空标志
    assign rdusedw = rd_usedw   ;//读侧可读数据量

endmodule 

