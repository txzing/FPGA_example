`include "param.v"
module sccb_interface(
      input                         clk        ,//时钟
      input                         rst_n      ,//复位
      input                         wr_en      ,
      input                         rd_en      ,
      input                 [15:0]  reg_addr   ,//寄存器地址
      input                 [7:0]   wr_data    ,
      input                         sio_d_r    ,
      //输出信号定义
      output        reg             sio_c      ,//串行时钟
      output        reg     [7:0]   rd_data    , 
      output        reg             rd_data_vld,
      output        reg             rdy        ,
      output        reg             sio_d_wr   ,//写出的数据
      output        reg             sio_d_wr_en //写数据使能信号

);

/********************************** 注释开始 ****************
注意：sio_d 是一个三态信号，可以通过 sio_d 向OV5640写数据，
      也可以通过 sio_d从OV5640读数据，sio_d_wr 是写出的数据，
      sio_d_wr_en 是写数据使能信号；sio_d_r 是读入的数据

********************************** 注释结束****************/

//signal define

    reg     [7:0]       sioc_cnt    ;   //产生sio_c的计数器
    wire                add_sioc_cnt;
    wire                end_sioc_cnt;

    reg     [5:0]       cnt_bit     ;   //每个phese有 30/39bit
    wire                add_cnt_bit ;
    wire                end_cnt_bit ;

    reg     [1:0]       cnt_step    ;   //写寄存器需要1个阶段
    wire                add_cnt_step;   //读寄存器需要2个阶段
    wire                end_cnt_step;

    reg     [5:0]       bit_num     ;
    reg     [1:0]       step_num    ;

    reg                 wr_flag     ;
    reg                 rd_flag     ;
    
    wire                rd_data_state;

    reg     [38:0]      out_data    ;

    wire                sio_c_l     ;
    wire                sio_c_h     ;

    wire                sio_d_wr_en_h;
    wire                sio_d_wr_en_l;
    
    wire    [7:0]       addr        ;   //读操作时，写入的地址有两种 第一个是从设备的ID 第二个是主设备的ID

    reg     [15:0]      reg_addr_ff ;   //锁存寄存器地址
    reg     [7:0]       wr_data_ff  ;   //锁存写入寄存器的数据


//reg_addr_ff       //读写使能的时候，锁存数据或地址
        
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            reg_addr_ff <= 0;
        end
        else if(wr_en || rd_en)begin
            reg_addr_ff <= reg_addr;
        end
    end

//wr_data_ff
    
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            wr_data_ff <= 0;
        end
        else if(wr_en)begin
            wr_data_ff <= wr_data;
        end
    end

//sioc_cnt
    
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            sioc_cnt <= 0;
        end
        else if(add_sioc_cnt)begin
            if(end_sioc_cnt)
                sioc_cnt <= 0;
            else
                sioc_cnt <= sioc_cnt + 1;
        end
    end

    assign add_sioc_cnt = wr_flag || rd_flag;       
    assign end_sioc_cnt = add_sioc_cnt && sioc_cnt == `SCK_MAX-1;   //`SCK_MAX=240  一个串行时钟周期

//cnt_bit
    
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_bit <= 0;
        end
        else if(add_cnt_bit)begin
            if(end_cnt_bit)
                cnt_bit <= 0;
            else
                cnt_bit <= cnt_bit + 1;
        end
    end

    assign add_cnt_bit = end_sioc_cnt;       
    assign end_cnt_bit = add_cnt_bit && cnt_bit == bit_num+2-1;   //延长2个时钟周期再发下一字节

//cnt_step
    
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt_step <= 0;
        end
        else if(add_cnt_step)begin
            if(end_cnt_step)
                cnt_step <= 0;
            else
                cnt_step <= cnt_step + 1;
        end
    end

    assign add_cnt_step = end_cnt_bit;       
    assign end_cnt_step = add_cnt_step && cnt_step == step_num-1;   

//wr_flag

    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            wr_flag <= 1'b0;
        end
        else if(!wr_flag && wr_en)begin
            wr_flag <= 1'b1;
        end
        else if(wr_flag && end_cnt_step)begin
            wr_flag <= 1'b0;
        end
    end

//rd_flag

    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            rd_flag <= 1'b0;
        end
        else if(!rd_flag && rd_en)begin
            rd_flag <= 1'b1;
        end
        else if(rd_flag && end_cnt_step)begin
            rd_flag <= 1'b0;
        end
    end

//bit_num step_num

    always  @(*)begin
        if(wr_flag)begin
            bit_num  = 39;
            step_num = 1;
        end
        else if(rd_flag)begin
            bit_num  = 30;
            step_num = 2;
        end
        else begin
            bit_num  = 1;
            step_num = 1;
        end
    end

//sio_c
    
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            sio_c <= 1'b1;
        end
        else if(sio_c_l)begin
            sio_c <= 1'b0;
        end
        else if(sio_c_h)begin
            sio_c <= 1'b1;
        end
    end

    //sio_c在第 0bit 和最后1bit 的时候一直为高电平，从第1bit开始才高低翻转直到倒数第2bit
    assign  sio_c_l = cnt_bit >= 0 && cnt_bit < (bit_num-2) && sioc_cnt == `SIOC_L-1;
    assign  sio_c_h = cnt_bit >= 1 && cnt_bit < bit_num && add_sioc_cnt && sioc_cnt == `SIOC_H-1;

//addr  out_data
    
    assign  addr = ((wr_flag || rd_flag) && cnt_step == 1-1)?`IDWADD:`IDRADD;
    
    always  @(*)begin
        if(wr_flag)begin
            out_data = {1'b0,addr,1'b1,reg_addr_ff[15:8],1'b1,reg_addr_ff[7:0],1'b1,wr_data_ff,1'b1,1'b0,1'b1};
        end
        else if(rd_flag)begin
            out_data = {1'b0,addr,1'b1,reg_addr_ff[15:8],1'b1,reg_addr_ff[7:0],1'b1,1'b0,1'b1,9'd0};
        end
        else begin 
            out_data = 0;
        end 
    end

//sio_d_wr  sio_d_wr_en

    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            sio_d_wr <= 1'b1;
        end
        else if(add_sioc_cnt && cnt_bit < bit_num)begin
            sio_d_wr <= out_data[39-1-cnt_bit];
        end
        else begin 
            sio_d_wr <= 1'b1;
        end 
    end

    always  @(posedge clk or negedge rst_n)begin        //读数据的第二阶段 读一个字节，但是读完之后需要发停止位
        if(!rst_n)begin                                 //这里读数据时间持续了两个字节，但是只接收了第一个字节  不知道会不会有问题
            sio_d_wr_en <= 1'b0;
        end
        else if(wr_en || rd_en)begin    //读写使能的时候要开始写起始位
            sio_d_wr_en <= 1'b1;
        end
        else if(end_sioc_cnt && cnt_bit == bit_num-1)begin      //读、写一个阶段结束时，释放总线
            sio_d_wr_en <= 1'b0;
        end
        else if(sio_d_wr_en_h)begin     //读数据的第二阶段结束的时候要占用总线 发送结束位
            sio_d_wr_en <= 1'b1;
        end
        else if(sio_d_wr_en_l)begin     //读数据的第二阶段写完地址，读数据的时候需要释放总线
            sio_d_wr_en <= 1'b0;
        end 
    end

    assign sio_d_wr_en_h = rd_flag && cnt_step == 2-1 && cnt_bit == 28 && add_sioc_cnt && sioc_cnt == 1-1;
    assign sio_d_wr_en_l = rd_flag && cnt_step == 2-1 && cnt_bit == 9 && add_sioc_cnt && sioc_cnt == 1-1;

//rd_data

    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            rd_data <= 0;
        end
        else if(rd_data_state)begin
            rd_data[17-cnt_bit] <= sio_d_r;
        end
    end
    
//rd_data_vld
    
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            rd_data_vld <= 1'b0;
        end
        else if(rd_flag && end_cnt_step) begin
            rd_data_vld <= 1'b1; //读第二阶段结束时，读出的数据有效
        end
        else begin 
            rd_data_vld <= 1'b0;    
        end 
    end

//rd_data_state
    
    assign  rd_data_state = rd_flag && cnt_step == 2-1 && cnt_bit >= 10 && cnt_bit < 18 
                            && add_sioc_cnt && sioc_cnt == ((`SCK_MAX >> 1))-1;

//rdy

    always  @(*)begin
        if(wr_en || rd_en || wr_flag || rd_flag)begin
            rdy = 1'b0;
        end
        else begin
            rdy = 1'b1;
        end
    end


endmodule

