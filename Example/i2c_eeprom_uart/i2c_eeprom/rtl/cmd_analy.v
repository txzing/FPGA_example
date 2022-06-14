/**************************************功能介绍***********************************

命令解析模块，使用状态机  序列检测
自定义数据帧，
    1、写数据：起始符（1B）+ 写数据指示（1B）+ 写数据（XB）+ 结束符（2B）
    2、写请求：起始符（1B）+ 写请求（1B）+ 写地址（1B）+ 结束符（2B）
    3、读请求：起始符（1B）+ 读请求（1B）+ 读地址（1B）+ 结束符（2B）

    起始符：8'h55
    写数据指示：8'haa 指示当前有效数据是写入wr_fifo
    写数据：8'hXX 写若干个字节到wr_fifo

    写请求：高4位为4'h0--写 低四位为4'h0--block0 低四位为4'h1--block1
    //写模式：8'h01：字节写 8'h10：页写
    写地址：写数据的字地址 8'hxx
在程序里见的是用第五位也即din[4]指示是读还是写  ，需上板验证
    读请求：高4位为4'h1--读 低四位为4'h0--block0 低四位为4'h1--block1
    //读模式：8'h01：随机地址读 8'h10：连续地址读，（未用）
    读地址：读数据的字地址 8'hxx
    结束符：8'h04 8'h0D


字节写、随机地址读：给的地址是读写地址；
页写、连续地址读：给的地址是首地址；

字节写：1/3  页写：16/18
随机地址读：1/4 连续地址读：x/(3+x)

举例：
    写操作：8'h55 8'haa 8'hyy 8'hyy ... 8'hyy 8'hyy 8'h04 8'h0D
    写请求：8'h55 8'h00 8'hxx 8'h04 8'h0D
    读请求：8'h55 8'h11 8'hxx 8'h04 8'h0D

*********************************************************************************/

module cmd_analy (  //命令帧解析模块
    input               clk     ,
    input               rst_n   ,

    input       [7:0]   din     ,//串口接收模块接口
    input               din_vld ,
    
    output  reg [7:0]   dout    ,//写入FIFO的数据
    output  reg         dout_vld,
    output  reg         wr_en   ,//写请求
    output  reg         rd_en   ,//读请求
    output  reg [8:0]   addr    //读写地址
); 

//状态机参数

    localparam  IDLE        = 9'b0_0000_0001,//
                FRAME_HEAD  = 9'b0_0000_0010,//接收起始符
                WRDATA_INST = 9'b0_0000_0100,//接收写指示
                WR_DATA     = 9'b0_0000_1000,//接收写数据
                FRAME_END   = 9'b0_0001_0000,//接收帧结束符
                WR_REQ      = 9'b0_0010_0000,//接收写请求
                WR_ADDR     = 9'b0_0100_0000,//接收写地址
                RD_REQ      = 9'b0_1000_0000,//接收读请求
                RD_ADDR     = 9'b1_0000_0000;//接收读地址

    localparam  SOF         = 8'h55,//start of frame 
                WR_INST     = 8'haa,//写数据指示
                EOF0        = 8'h04,//end of frame 
                EOF1        = 8'h0d;//end of frame 

/*
    1、写数据：起始符（1B）+ 写数据指示（1B）+ 写数据（XB）+ 结束符（2B）
    2、写请求：起始符（1B）+ 写请求（1B）+ 写地址（1B）+ 结束符（2B）
    3、读请求：起始符（1B）+ 读请求（1B）+ 读地址（1B）+ 结束符（2B）
*/

//信号定义

    reg     [8:0]       state_c     ;
    reg     [8:0]       state_n     ;

    reg     [7:0]       din_r0      ;//对din打拍
    reg     [7:0]       din_r1      ;//对din打拍

    wire                idle2frame_head         ;     
    wire                frame_head2wrdata_inst  ;
    wire                frame_head2wr_req       ;     
    wire                frame_head2rd_req       ; 
    wire                wrdara_inst2wr_data     ; 
    wire                wr_data2frame_end       ;     
    wire                frame_end2idle          ;  
    wire                wr_req2wr_addr          ; 
    wire                wr_addr2frame_end       ; 
    wire                rd_req2rd_addr          ; 
    wire                rd_addr2frame_end       ; 

//状态机 序列检测
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            state_c <= IDLE;
        end 
        else begin 
            state_c <= state_n;
        end 
    end    

    always @(*)begin 
        case (state_c)
            IDLE       :begin
                if(idle2frame_head)
                    state_n = FRAME_HEAD;
                else 
                    state_n = state_c; 
            end
            FRAME_HEAD :begin
                if(frame_head2wrdata_inst)
                    state_n = WRDATA_INST;
                else if(frame_head2wr_req)
                    state_n = WR_REQ; 
                else if(frame_head2rd_req)
                    state_n = RD_REQ; 
                else 
                    state_n = state_c; 
            end
            WRDATA_INST:begin
                if(wrdara_inst2wr_data)
                    state_n = WR_DATA;
                else 
                    state_n = state_c; 
            end
            WR_DATA    :begin
                if(wr_data2frame_end)
                    state_n = FRAME_END; 
                else 
                    state_n = state_c; 
            end
            FRAME_END  :begin
                if(frame_end2idle)
                    state_n = IDLE;
                else 
                    state_n = state_c; 
            end
            WR_REQ     :begin
                if(wr_req2wr_addr)
                    state_n = WR_ADDR;
                else 
                    state_n = state_c; 
            end
            WR_ADDR    :begin
                if(wr_addr2frame_end)
                    state_n = FRAME_END; 
                else 
                    state_n = state_c; 
            end
            RD_REQ     :begin
                if(rd_req2rd_addr)
                    state_n = RD_ADDR;
                else    
                    state_n = state_c; 
            end
            RD_ADDR    :begin
                if(rd_addr2frame_end)
                    state_n = FRAME_END; 
                else 
                    state_n = state_c; 
            end 
            default:state_n = IDLE; 
        endcase
    end

    assign  idle2frame_head        = state_c == IDLE        && (din_vld && din == SOF);     
    assign  frame_head2wrdata_inst = state_c == FRAME_HEAD  && (din_vld && din == WR_INST);
    assign  frame_head2wr_req      = state_c == FRAME_HEAD  && (din_vld && din[4] == 1'b0);//din[4]指示是读还是写     
    assign  frame_head2rd_req      = state_c == FRAME_HEAD  && (din_vld && din[4] == 1'b1); 
    assign  wrdara_inst2wr_data    = state_c == WRDATA_INST && (din_vld); 
    assign  wr_data2frame_end      = state_c == WR_DATA     && (din == EOF1 && din_r0 == EOF0);     
    assign  frame_end2idle         = state_c == FRAME_END   && (din_r0 == EOF1 && din_r1 == EOF0);  
    assign  wr_req2wr_addr         = state_c == WR_REQ      && (1'b1); 
    assign  wr_addr2frame_end      = state_c == WR_ADDR     && (din_vld);//送入写地址
    assign  rd_req2rd_addr         = state_c == RD_REQ      && (1'b1); 
    assign  rd_addr2frame_end      = state_c == RD_ADDR     && (din_vld);//送入读地址     

//din_r0    
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            din_r0 <= 0;
            din_r1 <= 0;
        end 
        else if(din_vld)begin 
            din_r0 <= din;
            din_r1 <= din_r0;
        end 
    end

//dout    ,//写入FIFO的数据
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout <= 0;
        end 
        else if(state_c == WR_DATA && din_vld && din != EOF1 && din_r0 != EOF0)begin 
            dout <= din_r0;
        end 
    end

//    dout_vld,
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            dout_vld <= 0;
        end 
        else begin 
            dout_vld <= state_c == WR_DATA && din_vld && din != EOF1 && din_r0 != EOF0;
        end 
    end

//    wr_en   ,//写请求
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            wr_en <= 0;
        end 
        else if(wr_addr2frame_end)begin 
            wr_en <= 1'b1;
        end 
        else begin 
            wr_en <= 1'b0;
        end 
    end

//  rd_en   ,//读请求
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            rd_en <= 0;
        end 
        else if(rd_addr2frame_end)begin 
            rd_en <= 1'b1;
        end 
        else begin 
            rd_en <= 0;
        end 
    end

//addr    //读写地址
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            addr <= 0;
        end 
        else if(wr_addr2frame_end | rd_addr2frame_end)begin 
            addr <= {din_r0[0],din};
        end 
    end
//din_r0为上位机发送的读写请求（1B），低四位决定是block0或block1的数据读写，高四位是读写指示，但目前在程序里只检测最低位和第5位数据


endmodule

