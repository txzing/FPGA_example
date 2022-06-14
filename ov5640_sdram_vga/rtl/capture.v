`include "param.v"
module capture( 
    input				clk		    ,   //pclk
    input				rst_n	    ,

    input		[7:0]	cmos_din	,
    input		        cmos_vsync	,
    input		        cmos_href 	,

    input               cap_en      ,//采集使能信号
    output		[15:0]	pixel   	,
    output		    	pixel_vld	,
    output              pixel_sop   ,//数据包文头
    output              pixel_eop    //数据包文尾
);								      
    //中间信号定义		 
    reg		[11:0]	cnt_row     ;//一行1280个像素点  计数 1280<<1
    wire            add_cnt_row ;
    wire            end_cnt_row ;
    reg		[9:0]	cnt_col     ;//一列720行
    wire	    	add_cnt_col ;
    wire	    	end_cnt_col ;

    reg     [7:0]   din_r       ;
    reg             href_r      ;

    reg     [1:0]   vsync_r     ;
    reg             flag        ;//采集数据标志
    reg     [15:0]  get_data    ;//串并转换，字节拼接
    reg             get_data_vld;
    reg             sop         ;
    reg             eop         ;

//计数器设计

    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            cnt_row <= 0;
        end 
        else if(add_cnt_row)begin 
            if(end_cnt_row)begin 
                cnt_row <= 0;
            end
            else begin 
                cnt_row <= cnt_row + 1;
            end 
        end
    end 
    assign add_cnt_row = flag & href_r;
    assign end_cnt_row = add_cnt_row && cnt_row == (`IMG_W << 1)-1;
                                            
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            cnt_col <= 0;
        end 
        else if(add_cnt_col)begin 
            if(end_cnt_col)begin 
                cnt_col <= 0;
            end
            else begin 
                cnt_col <= cnt_col + 1;
            end 
        end
    end 
    assign add_cnt_col = end_cnt_row;
    assign end_cnt_col = add_cnt_col && cnt_col == `IMG_H-1;

//flag
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            flag <= 0;
        end 
        else if(cap_en & vsync_r[0] & ~vsync_r[1])begin //vsync上升沿时，拉高采集标志flag
            flag <= 1'b1;
        end 
        else if(end_cnt_col)begin 
            flag <= 1'b0;
        end 
    end

//href_r  din_r vsync_r 同步打拍
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            href_r <= 0;
            din_r <= 0;
            vsync_r <= 0;
        end 
        else begin 
            href_r <= cmos_href;
            din_r <= cmos_din;
            vsync_r <= {vsync_r[0],cmos_vsync};
        end 
    end

//get_data
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            get_data <= 0;
            get_data_vld <= 0;
            sop          <= 0;
            eop          <= 0;
        end 
        else begin 
            get_data <= {get_data[7:0],din_r};   //像素字节拼接 R-G-B
            //get_data <= (cnt_col < 240)?16'hf800:(cnt_col < 480?16'h07e0:16'h001f);
            get_data_vld <= add_cnt_row & cnt_row[0] == 1'b1;
            sop          <= cnt_row == 1 & cnt_col == 0;//第1列第0行是第一个像素点
            eop          <= end_cnt_col;            //最后一列最后一行是最后一个像素点
        end 
    end

    assign pixel     = get_data;   
    assign pixel_vld = get_data_vld;
    assign pixel_sop = sop;
    assign pixel_eop = eop;



endmodule