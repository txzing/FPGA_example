module ov5640_config(
      input                         clk        ,//50M时钟
      input                         rst_n      ,//复位
      input                         rdy        ,          
      //输出信号定义
      output        reg     [7:0]   cfg_data   ,//寄存器配置数据
      output        reg     [15:0]  cfg_addr   ,//寄存器配置地址
      output        reg             en_capture ,//采集模块开始采集条件 
      output        reg             wr_en      ,
      output        reg             rd_en      
);

//参数定义
    parameter      WAIT_TIME =   2000_000,//复位后等待40ms，然后开始配置摄像头
                   RW_CTRL   =   2'b01, //2'b01:只写不读  2'b11:先写后读
                   RW_NUM    =   (RW_CTRL == 2'b01)?1:2,    //读、写次数，只写为1，先写后读为2
                   REG_NUM   =   252;
                  
                                     
//signal define
   
    reg     [1:0]   rw_cnt      ;   //读写计数器 0写1读
    wire            add_rw_cnt  ;
    wire            end_rw_cnt  ;

    reg     [8:0]   reg_cnt     ;   //配置寄存器计数器
    wire            add_reg_cnt ;
    wire            end_reg_cnt ;
    reg             config_done ;   //配置完成标志信号

    reg     [20:0]  wait_cnt    ;   //上电后等待40ms，然后开始配置摄像头 
    wire            add_wait_cnt;
    wire            end_wait_cnt;
    reg             flag_wait   ;

    reg     [25:0]  lut_data    ;   //寄存器配置表

//wait_cnt
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            wait_cnt <= 0;
        end
        else if(add_wait_cnt)begin
            if(end_wait_cnt)
                wait_cnt <= 0;
            else
                wait_cnt <= wait_cnt + 1;
        end
    end

    assign add_wait_cnt = flag_wait == 1'b0;       
    assign end_wait_cnt = add_wait_cnt && wait_cnt == WAIT_TIME-1;   

//flag_wait
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            flag_wait <= 1'b0;
        end
        else if(end_wait_cnt)begin
            flag_wait <= 1'b1;  //40ms等待时间结束，拉高 flag_wait，开始配置摄像头
        end
    end

//rw_cnt
    
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            rw_cnt <= 0;
        end
        else if(add_rw_cnt)begin
            if(end_rw_cnt)
                rw_cnt <= 0;
            else
                rw_cnt <= rw_cnt + 1;
        end
    end

    assign add_rw_cnt = flag_wait && rdy && config_done == 1'b0;        //摄像头配置使能信号flag和rdy都有效时
    assign end_rw_cnt = add_rw_cnt && rw_cnt == RW_NUM-1;   

//reg_cnt

    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            reg_cnt <= 0;
        end
        else if(add_reg_cnt)begin
            if(end_reg_cnt)
                reg_cnt <= 0;
            else
                reg_cnt <= reg_cnt + 1;
        end
    end

    assign add_reg_cnt = end_rw_cnt;     //对某一个寄存器写、读操作完成后，寄存器计数器加1  再写下一个寄存器 
    assign end_reg_cnt = add_reg_cnt && reg_cnt == REG_NUM-1;   

//cfg_data

    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cfg_data <= 0;
        end
        else begin
            cfg_data <= lut_data[7:0];
        end
    end

//cfg_addr
    
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cfg_addr <= 0;
        end
        else begin
            cfg_addr <= lut_data[23:8];
        end
    end

//config_done
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            config_done <= 1'b0;
        end
        else if(end_reg_cnt)begin
            config_done <= 1'b1;
        end
    end

//en_capture
    
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            en_capture <= 1'b0;
        end
        else if(config_done && rdy)begin
            en_capture <= 1'b1;
        end
    end

//wr_en

    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            wr_en <= 1'b0;
        end
        else if(add_rw_cnt && rw_cnt == 1-1)begin
            wr_en <= lut_data[24];
        end
        else begin 
            wr_en <= 1'b0;
        end 
    end

//rd_en
    
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            rd_en <= 1'b0;
        end
        else if(add_rw_cnt && rw_cnt == 2-1)begin
            rd_en <= lut_data[25];
        end
        else begin
            rd_en <= 1'b0;
        end
    end

//lut_data

    always@(*)begin
	    case(reg_cnt)			  
		 //30fps VGA YUV output
		 // 24MHz input clock, 84MHz PCLK

		 0  :   	 lut_data	= 	{RW_CTRL,24'h3103_11}; // system clock from pad, bit[1]
		 1  :   	 lut_data	= 	{RW_CTRL,24'h3008_82}; // software reset, bit[7]
		 2  :   	 lut_data	= 	{RW_CTRL,24'h3008_42}; // software power down, bit[6]
		 3  :   	 lut_data	= 	{RW_CTRL,24'h3103_03}; // system clock from PLL, bit[1]
		 4  :   	 lut_data	= 	{RW_CTRL,24'h3017_ff}; // FREX, Vsync, HREF, PCLK, D[9:6] output enable
		 5  :   	 lut_data	= 	{RW_CTRL,24'h3018_ff}; // D[5:0], GPIO[1:0] output enable
		 6  :   	 lut_data	= 	{RW_CTRL,24'h3034_1a}; // MIPI 10-bit
		 7  :   	 lut_data	= 	{RW_CTRL,24'h3037_13}; // PLL root divider, bit[4], PLL pre-divider, bit[3:0]
		 8  :   	 lut_data	= 	{RW_CTRL,24'h3108_01}; // PCLK root divider, bit[5:4], SCLK2x root divider, bit[3:2]
		 9  :   	 lut_data	= 	{RW_CTRL,24'h3630_36};// SCLK root divider, bit[1:0]
		 10 :   	 lut_data	= 	{RW_CTRL,24'h3631_0e};
		 11 :   	 lut_data	= 	{RW_CTRL,24'h3632_e2};
		 12 :   	 lut_data	= 	{RW_CTRL,24'h3633_12};
		 13 :   	 lut_data	= 	{RW_CTRL,24'h3621_e0};
		 14 :   	 lut_data	= 	{RW_CTRL,24'h3704_a0};
		 15 :   	 lut_data	= 	{RW_CTRL,24'h3703_5a};
		 16 :   	 lut_data	= 	{RW_CTRL,24'h3715_78};
		 17 :   	 lut_data	= 	{RW_CTRL,24'h3717_01};
		 18 :   	 lut_data	= 	{RW_CTRL,24'h370b_60};
		 19 :   	 lut_data	= 	{RW_CTRL,24'h3705_1a};
		 20 :   	 lut_data	= 	{RW_CTRL,24'h3905_02};
		 21 :   	 lut_data	= 	{RW_CTRL,24'h3906_10};
		 22 :   	 lut_data	= 	{RW_CTRL,24'h3901_0a};
		 23 :   	 lut_data	= 	{RW_CTRL,24'h3731_12};
		 24 :   	 lut_data	= 	{RW_CTRL,24'h3600_08}; // VCM control
		 25 :   	 lut_data	= 	{RW_CTRL,24'h3601_33}; // VCM control
		 26 :   	 lut_data	= 	{RW_CTRL,24'h302d_60}; // system control
		 27 :   	 lut_data	= 	{RW_CTRL,24'h3620_52};
		 28 :   	 lut_data	= 	{RW_CTRL,24'h371b_20};
		 29 :   	 lut_data	= 	{RW_CTRL,24'h471c_50};
		 30 :   	 lut_data	= 	{RW_CTRL,24'h3a13_43}; // pre-gain = 1.047x
		 31 :   	 lut_data	= 	{RW_CTRL,24'h3a18_00}; // gain ceiling
		 32 :   	 lut_data	= 	{RW_CTRL,24'h3a19_f8}; // gain ceiling = 15.5x
		 33 :   	 lut_data	= 	{RW_CTRL,24'h3635_13};
		 34 :   	 lut_data	= 	{RW_CTRL,24'h3636_03};
		 35 :   	 lut_data	= 	{RW_CTRL,24'h3634_40};
		 36 :   	 lut_data	= 	{RW_CTRL,24'h3622_01};
		// 50/60Hz detection 50/60Hz 灯光条纹过滤
		 37 :   	 lut_data	= 	{RW_CTRL,24'h3c01_34}; // Band auto, bit[7]
		 38 :   	 lut_data	= 	{RW_CTRL,24'h3c04_28}; // threshold low sum
		 39 :   	 lut_data	= 	{RW_CTRL,24'h3c05_98}; // threshold high sum
		 40 :   	 lut_data	= 	{RW_CTRL,24'h3c06_00}; // light meter 1 threshold[15:8]
		 41 :   	 lut_data	= 	{RW_CTRL,24'h3c07_08}; // light meter 1 threshold[7:0]
		 42 :   	 lut_data	= 	{RW_CTRL,24'h3c08_00}; // light meter 2 threshold[15:8]
		 43 :   	 lut_data	= 	{RW_CTRL,24'h3c09_1c}; // light meter 2 threshold[7:0]
		 44 :   	 lut_data	= 	{RW_CTRL,24'h3c0a_9c}; // sample number[15:8]
		 45 :   	 lut_data	= 	{RW_CTRL,24'h3c0b_40}; // sample number[7:0]
		 46 :   	 lut_data	= 	{RW_CTRL,24'h3810_00}; // Timing Hoffset[11:8]
		 47 :   	 lut_data	= 	{RW_CTRL,24'h3811_10}; // Timing Hoffset[7:0]
		 48 :   	 lut_data	= 	{RW_CTRL,24'h3812_00}; // Timing Voffset[10:8]
		 49 :   	 lut_data	= 	{RW_CTRL,24'h3708_64};
		 50 :   	 lut_data	= 	{RW_CTRL,24'h4001_02}; // BLC start from line 2
		 51 :   	 lut_data	= 	{RW_CTRL,24'h4005_1a}; // BLC always update
		 52 :   	 lut_data	= 	{RW_CTRL,24'h3000_00}; // enable blocks
		 53 :   	 lut_data	= 	{RW_CTRL,24'h3004_ff}; // enable clocks
		 54 :   	 lut_data	= 	{RW_CTRL,24'h300e_58}; // MIPI power down, DVP enable
		 55 :   	 lut_data	= 	{RW_CTRL,24'h302e_00};
		 56 :   	 lut_data	= 	{RW_CTRL,24'h4300_61}; // RGB,
		 57 :   	 lut_data	= 	{RW_CTRL,24'h501f_01}; // ISP RGB
		 58 :   	 lut_data	= 	{RW_CTRL,24'h440e_00};
		 59 :   	 lut_data	= 	{RW_CTRL,24'h5000_a7}; // Lenc on, raw gamma on, BPC on, WPC on, CIP on
		// AEC target 自动曝光控制
		 60 :   	 lut_data	= 	{RW_CTRL,24'h3a0f_30}; // stable range in high
		 61 :   	 lut_data	= 	{RW_CTRL,24'h3a10_28}; // stable range in low
		 62 :   	 lut_data	= 	{RW_CTRL,24'h3a1b_30}; // stable range out high
		 63 :   	 lut_data	= 	{RW_CTRL,24'h3a1e_26}; // stable range out low
		 64 :   	 lut_data	= 	{RW_CTRL,24'h3a11_60}; // fast zone high
		 65 :   	 lut_data	= 	{RW_CTRL,24'h3a1f_14}; // fast zone low
		// Lens correction for ? 镜头补偿
		 66 :   	 lut_data	= 	{RW_CTRL,24'h5800_23};
		 67 :   	 lut_data	= 	{RW_CTRL,24'h5801_14};
		 68 :   	 lut_data	= 	{RW_CTRL,24'h5802_0f};
		 69 :   	 lut_data	= 	{RW_CTRL,24'h5803_0f};
		 70 :   	 lut_data	= 	{RW_CTRL,24'h5804_12};
		 71 :   	 lut_data	= 	{RW_CTRL,24'h5805_26};
		 72 :   	 lut_data	= 	{RW_CTRL,24'h5806_0c};
		 73 :   	 lut_data	= 	{RW_CTRL,24'h5807_08};
		 74 :   	 lut_data	= 	{RW_CTRL,24'h5808_05};
		 75 :   	 lut_data	= 	{RW_CTRL,24'h5809_05};
		 76 :   	 lut_data	= 	{RW_CTRL,24'h580a_08};
		 77 :   	 lut_data	= 	{RW_CTRL,24'h580b_0d};
		 78 :   	 lut_data	= 	{RW_CTRL,24'h580c_08};
		 79 :   	 lut_data	= 	{RW_CTRL,24'h580d_03};
		 80 :   	 lut_data	= 	{RW_CTRL,24'h580e_00};
		 81 :   	 lut_data	= 	{RW_CTRL,24'h580f_00};
		 82 :   	 lut_data	= 	{RW_CTRL,24'h5810_03};
		 83 :   	 lut_data	= 	{RW_CTRL,24'h5811_09};
		 84 :   	 lut_data	= 	{RW_CTRL,24'h5812_07};
		 85 :   	 lut_data	= 	{RW_CTRL,24'h5813_03};
		 86 :   	 lut_data	= 	{RW_CTRL,24'h5814_00};
		 87 :   	 lut_data	= 	{RW_CTRL,24'h5815_01};
		 88 :   	 lut_data	= 	{RW_CTRL,24'h5816_03};
		 89 :   	 lut_data	= 	{RW_CTRL,24'h5817_08};
		 90 :   	 lut_data	= 	{RW_CTRL,24'h5818_0d};
		 91 :   	 lut_data	= 	{RW_CTRL,24'h5819_08};
		 92 :   	 lut_data	= 	{RW_CTRL,24'h581a_05};
		 93 :   	 lut_data	= 	{RW_CTRL,24'h581b_06};
		 94 :   	 lut_data	= 	{RW_CTRL,24'h581c_08};
		 95 :   	 lut_data	= 	{RW_CTRL,24'h581d_0e};
		 96 :   	 lut_data	= 	{RW_CTRL,24'h581e_29};
		 97 :   	 lut_data	= 	{RW_CTRL,24'h581f_17};
		 98 :   	 lut_data	= 	{RW_CTRL,24'h5820_11};
		 99 :   	 lut_data	= 	{RW_CTRL,24'h5821_11};
		 100:   	 lut_data	= 	{RW_CTRL,24'h5822_15};
		 101:   	 lut_data	= 	{RW_CTRL,24'h5823_28};
		 102:   	 lut_data	= 	{RW_CTRL,24'h5824_46};
		 103:   	 lut_data	= 	{RW_CTRL,24'h5825_26};
		 104:   	 lut_data	= 	{RW_CTRL,24'h5826_08};
		 105:   	 lut_data	= 	{RW_CTRL,24'h5827_26};
		 106:   	 lut_data	= 	{RW_CTRL,24'h5828_64};
		 107:   	 lut_data	= 	{RW_CTRL,24'h5829_26};
		 108:   	 lut_data	= 	{RW_CTRL,24'h582a_24};
		 109:   	 lut_data	= 	{RW_CTRL,24'h582b_22};
		 110:   	 lut_data	= 	{RW_CTRL,24'h582c_24};
		 111:   	 lut_data	= 	{RW_CTRL,24'h582d_24};
		 112:   	 lut_data	= 	{RW_CTRL,24'h582e_06};
		 113:   	 lut_data	= 	{RW_CTRL,24'h582f_22};
		 114:   	 lut_data	= 	{RW_CTRL,24'h5830_40};
		 115:   	 lut_data	= 	{RW_CTRL,24'h5831_42};
		 116:   	 lut_data	= 	{RW_CTRL,24'h5832_24};
		 117:   	 lut_data	= 	{RW_CTRL,24'h5833_26};
		 118:   	 lut_data	= 	{RW_CTRL,24'h5834_24};
		 119:   	 lut_data	= 	{RW_CTRL,24'h5835_22};
		 120:   	 lut_data	= 	{RW_CTRL,24'h5836_22};
		 121:   	 lut_data	= 	{RW_CTRL,24'h5837_26};
		 122:   	 lut_data	= 	{RW_CTRL,24'h5838_44};
		 123:   	 lut_data	= 	{RW_CTRL,24'h5839_24};
		 124:   	 lut_data	= 	{RW_CTRL,24'h583a_26};
		 125:   	 lut_data	= 	{RW_CTRL,24'h583b_28};
		 126:   	 lut_data	= 	{RW_CTRL,24'h583c_42};
		 127:   	 lut_data	= 	{RW_CTRL,24'h583d_ce}; // lenc BR offset
		// AWB 自动白平衡
		 128:   	 lut_data	= 	{RW_CTRL,24'h5180_ff}; // AWB B block
		 129:   	 lut_data	= 	{RW_CTRL,24'h5181_f2}; // AWB control
		 130:   	 lut_data	= 	{RW_CTRL,24'h5182_00}; // [7:4] max local counter, [3:0] max fast counter
		 131:   	 lut_data	= 	{RW_CTRL,24'h5183_14}; // AWB advanced
		 132:   	 lut_data	= 	{RW_CTRL,24'h5184_25};
		 133:   	 lut_data	= 	{RW_CTRL,24'h5185_24};
		 134:   	 lut_data	= 	{RW_CTRL,24'h5186_09};
		 135:   	 lut_data	= 	{RW_CTRL,24'h5187_09};
		 136:   	 lut_data	= 	{RW_CTRL,24'h5188_09};
		 137:   	 lut_data	= 	{RW_CTRL,24'h5189_75};
		 138:   	 lut_data	= 	{RW_CTRL,24'h518a_54};
		 139:   	 lut_data	= 	{RW_CTRL,24'h518b_e0};
		 140:   	 lut_data	= 	{RW_CTRL,24'h518c_b2};
		 141:   	 lut_data	= 	{RW_CTRL,24'h518d_42};
		 142:   	 lut_data	= 	{RW_CTRL,24'h518e_3d};
		 143:   	 lut_data	= 	{RW_CTRL,24'h518f_56};
		 144:   	 lut_data	= 	{RW_CTRL,24'h5190_46};
		 145:   	 lut_data	= 	{RW_CTRL,24'h5191_f8}; // AWB top limit
		 146:   	 lut_data	= 	{RW_CTRL,24'h5192_04}; // AWB bottom limit
		 147:   	 lut_data	= 	{RW_CTRL,24'h5193_70}; // red limit
		 148:   	 lut_data	= 	{RW_CTRL,24'h5194_f0}; // green limit
		 149:   	 lut_data	= 	{RW_CTRL,24'h5195_f0}; // blue limit
		 150:   	 lut_data	= 	{RW_CTRL,24'h5196_03}; // AWB control
		 151:   	 lut_data	= 	{RW_CTRL,24'h5197_01}; // local limit
		 152:   	 lut_data	= 	{RW_CTRL,24'h5198_04};
		 153:   	 lut_data	= 	{RW_CTRL,24'h5199_12};
		 154:   	 lut_data	= 	{RW_CTRL,24'h519a_04};
		 155:   	 lut_data	= 	{RW_CTRL,24'h519b_00};
		 156:   	 lut_data	= 	{RW_CTRL,24'h519c_06};
		 157:   	 lut_data	= 	{RW_CTRL,24'h519d_82};
		 158:   	 lut_data	= 	{RW_CTRL,24'h519e_38}; // AWB control
		// Gamma 伽玛曲线
		 159:   	 lut_data	= 	{RW_CTRL,24'h5480_01}; // Gamma bias plus on, bit[0]
		 160:   	 lut_data	= 	{RW_CTRL,24'h5481_08};
		 161:   	 lut_data	= 	{RW_CTRL,24'h5482_14};
		 162:   	 lut_data	= 	{RW_CTRL,24'h5483_28};
		 163:   	 lut_data	= 	{RW_CTRL,24'h5484_51};
		 164:   	 lut_data	= 	{RW_CTRL,24'h5485_65};
		 165:   	 lut_data	= 	{RW_CTRL,24'h5486_71};
		 166:   	 lut_data	= 	{RW_CTRL,24'h5487_7d};
		 167:   	 lut_data	= 	{RW_CTRL,24'h5488_87};
		 168:   	 lut_data	= 	{RW_CTRL,24'h5489_91};
		 169:   	 lut_data	= 	{RW_CTRL,24'h548a_9a};
		 170:   	 lut_data	= 	{RW_CTRL,24'h548b_aa};
		 171:   	 lut_data	= 	{RW_CTRL,24'h548c_b8};
		 172:   	 lut_data	= 	{RW_CTRL,24'h548d_cd};
		 173:   	 lut_data	= 	{RW_CTRL,24'h548e_dd};
		 174:   	 lut_data	= 	{RW_CTRL,24'h548f_ea};
		 175:   	 lut_data	= 	{RW_CTRL,24'h5490_1d};
		// color matrix 色彩矩阵
		 176:   	 lut_data	= 	{RW_CTRL,24'h5381_1e}; // CMX1 for Y
		 177:   	 lut_data	= 	{RW_CTRL,24'h5382_5b}; // CMX2 for Y
		 178:   	 lut_data	= 	{RW_CTRL,24'h5383_08}; // CMX3 for Y
		 179:   	 lut_data	= 	{RW_CTRL,24'h5384_0a}; // CMX4 for U
		 180:   	 lut_data	= 	{RW_CTRL,24'h5385_7e}; // CMX5 for U
		 181:   	 lut_data	= 	{RW_CTRL,24'h5386_88}; // CMX6 for U
		 182:   	 lut_data	= 	{RW_CTRL,24'h5387_7c}; // CMX7 for V
		 183:   	 lut_data	= 	{RW_CTRL,24'h5388_6c}; // CMX8 for V
		 184:   	 lut_data	= 	{RW_CTRL,24'h5389_10}; // CMX9 for V
		 185:   	 lut_data	= 	{RW_CTRL,24'h538a_01}; // sign[9]
		 186:   	 lut_data	= 	{RW_CTRL,24'h538b_98}; // sign[8:1]
		// UV adjust UV 色彩饱和度调整
		 187:   	 lut_data	= 	{RW_CTRL,24'h5580_06}; // saturation on, bit[1]
		 188:   	 lut_data	= 	{RW_CTRL,24'h5583_40};
		 189:   	 lut_data	= 	{RW_CTRL,24'h5584_10};
		 190:   	 lut_data	= 	{RW_CTRL,24'h5589_10};
		 191:   	 lut_data	= 	{RW_CTRL,24'h558a_00};
		 192:   	 lut_data	= 	{RW_CTRL,24'h558b_f8};
		 193:   	 lut_data	= 	{RW_CTRL,24'h501d_40}; // enable manual offset of contrast
		// CIP 锐化和降噪
		 194:   	 lut_data	= 	{RW_CTRL,24'h5300_08}; // CIP sharpen MT threshold 1
		 195:   	 lut_data	= 	{RW_CTRL,24'h5301_30}; // CIP sharpen MT threshold 2
		 196:   	 lut_data	= 	{RW_CTRL,24'h5302_10}; // CIP sharpen MT offset 1
		 197:   	 lut_data	= 	{RW_CTRL,24'h5303_00}; // CIP sharpen MT offset 2
		 198:   	 lut_data	= 	{RW_CTRL,24'h5304_08}; // CIP DNS threshold 1
		 199:   	 lut_data	= 	{RW_CTRL,24'h5305_30}; // CIP DNS threshold 2
		 200:   	 lut_data	= 	{RW_CTRL,24'h5306_08}; // CIP DNS offset 1
		 201:   	 lut_data	= 	{RW_CTRL,24'h5307_16}; // CIP DNS offset 2
		 202:   	 lut_data	= 	{RW_CTRL,24'h5309_08}; // CIP sharpen TH threshold 1
		 203:   	 lut_data	= 	{RW_CTRL,24'h530a_30}; // CIP sharpen TH threshold 2
		 204:   	 lut_data	= 	{RW_CTRL,24'h530b_04}; // CIP sharpen TH offset 1
		 205:   	 lut_data	= 	{RW_CTRL,24'h530c_06}; // CIP sharpen TH offset 2
		 206:   	 lut_data	= 	{RW_CTRL,24'h5025_00};
		 207:   	 lut_data	= 	{RW_CTRL,24'h3008_02}; // wake up from standby, bit[6]
        // 128{RW_CTRL,24'h720, 30fps
		// input clock 24Mhz, PCLK 84Mhz
		 208:   	 lut_data	= 	{RW_CTRL,24'h3035_21}; // PLL
		 209:   	 lut_data	= 	{RW_CTRL,24'h3036_69}; // PLL
		 210:   	 lut_data	= 	{RW_CTRL,24'h3c07_07}; // lightmeter 1 threshold[7:0]
		 211:   	 lut_data	= 	{RW_CTRL,24'h3820_47}; // flip
		 212:   	 lut_data	= 	{RW_CTRL,24'h3821_01}; // no mirror
		 213:   	 lut_data	= 	{RW_CTRL,24'h3814_31}; // timing X inc
		 214:   	 lut_data	= 	{RW_CTRL,24'h3815_31}; // timing Y inc
		 215:   	 lut_data	= 	{RW_CTRL,24'h3800_00}; // HS
		 216:   	 lut_data	= 	{RW_CTRL,24'h3801_00}; // HS
		 217:   	 lut_data	= 	{RW_CTRL,24'h3802_00}; // VS
		 218:   	 lut_data	= 	{RW_CTRL,24'h3803_fa}; // VS
		 219:   	 lut_data	= 	{RW_CTRL,24'h3804_0a}; // HW  :   	 lut_data	= 	HE}
		 220:   	 lut_data	= 	{RW_CTRL,24'h3805_3f}; // HW  :   	 lut_data	= 	HE}
		 221:   	 lut_data	= 	{RW_CTRL,24'h3806_06}; // VH  :   	 lut_data	= 	VE}
		 222:   	 lut_data	= 	{RW_CTRL,24'h3807_a9}; // VH  :   	 lut_data	= 	VE}
		 223:   	 lut_data	= 	{RW_CTRL,24'h3808_05}; // DVPHO 1280
		 224:   	 lut_data	= 	{RW_CTRL,24'h3809_00}; // DVPHO
		 225:   	 lut_data	= 	{RW_CTRL,24'h380a_02}; // DVPVO 720
		 226:   	 lut_data	= 	{RW_CTRL,24'h380b_d0}; // DVPVO
		 227:   	 lut_data	= 	{RW_CTRL,24'h380c_07}; // HTS
		 228:   	 lut_data	= 	{RW_CTRL,24'h380d_64}; // HTS     1892
		 229:   	 lut_data	= 	{RW_CTRL,24'h380e_02}; // VTS
		 230:   	 lut_data	= 	{RW_CTRL,24'h380f_e4}; // VTS     740
		 231:   	 lut_data	= 	{RW_CTRL,24'h3813_04}; // timing V offset
		 232:   	 lut_data	= 	{RW_CTRL,24'h3618_00};
		 233:   	 lut_data	= 	{RW_CTRL,24'h3612_29};
		 234:   	 lut_data	= 	{RW_CTRL,24'h3709_52};
		 235:   	 lut_data	= 	{RW_CTRL,24'h370c_03};
		 236:   	 lut_data	= 	{RW_CTRL,24'h3a02_02}; // 60Hz max exposure
		 237:   	 lut_data	= 	{RW_CTRL,24'h3a03_e0}; // 60Hz max exposure
		 238:   	 lut_data	= 	{RW_CTRL,24'h3a14_02}; // 50Hz max exposure
		 239:   	 lut_data	= 	{RW_CTRL,24'h3a15_e0}; // 50Hz max exposure
		 240:   	 lut_data	= 	{RW_CTRL,24'h4004_02}; // BLC line number
		 241:   	 lut_data	= 	{RW_CTRL,24'h3002_1c}; // reset JFIFO, SFIFO, JPG
		 242:   	 lut_data	= 	{RW_CTRL,24'h3006_c3}; // disable clock of JPEG2x, JPEG
		 243:   	 lut_data	= 	{RW_CTRL,24'h4713_03}; // JPEG mode 3
		 244:   	 lut_data	= 	{RW_CTRL,24'h4407_04}; // Quantization scale
		 245:   	 lut_data	= 	{RW_CTRL,24'h460b_37};
		 246:   	 lut_data	= 	{RW_CTRL,24'h460c_20};
		 247:   	 lut_data	= 	{RW_CTRL,24'h4837_16}; // MIPI global timing
		 248:   	 lut_data	= 	{RW_CTRL,24'h3824_04}; // PCLK manual divider
		 249:   	 lut_data	= 	{RW_CTRL,24'h5001_83}; // SDE on, CMX on, AWB on
		 250:   	 lut_data	= 	{RW_CTRL,24'h3503_00}; // AEC/AGC on                  
		 251:   	 lut_data	= 	{RW_CTRL,24'h4740_20}; // VS 1
		 //252:   	 lut_data	= 	{RW_CTRL,24'h503d_80}; // color bar
		 //253:   	 lut_data	= 	{RW_CTRL,24'h4741_00}; //
		default	:	 lut_data	=	0;
	    endcase
    end
   
endmodule

