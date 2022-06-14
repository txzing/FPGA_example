module adv7123_driver (
    input               clk         ,
    input               rst_n       ,
    input       [15:0]  din         ,
    input               din_vld     ,
    output              req         ,
    
    //output to ADV7123
    output      [7:0]   vga_r       ,//r g b 数据输出给 da芯片
    output      [7:0]   vga_g       ,
    output      [7:0]   vga_b       ,
    output              vga_blank   ,
    output              vga_sync    ,
    output              vga_clk     ,
    //output to vga 
    output              vsync       ,
    output              hsync       
);


/********************************* 注释开始 *********************************
 VGA显示时序：行同步脉冲（H_SYNC个clk） + 显示后沿（H_BP个clk） + 显示时段（H_ACTIVE个clk） + 显示前沿（H_FP个clk）
              场同步脉冲（V_SYNC个行周期） + 显示后沿（H_BP个行周期） + 显示时段（V_ACTIVE个行周期） + 显示前沿（V_FP个行周期）
********************************** 注释结束 *********************************/


//signal define

    reg     [10:0]      hys_cnt    ;   //行同步计数器
    wire                add_hys_cnt;
    wire                end_hys_cnt;

    reg     [10:0]      vys_cnt    ;    //帧同步计数器
    wire                add_vys_cnt;
    wire                end_vys_cnt;
    
    wire                hys_vld    ;
    wire                vys_vld    ;
    
    reg                 hys_ff     ;
    reg                 vys_ff     ;
    

    //hys_cnt
    always @(posedge clk or negedge rst_n)begin     
        if(!rst_n)begin
            hys_cnt <= 0;
        end
        else if(add_hys_cnt)begin
            if(end_hys_cnt)
                hys_cnt <= 0;
            else
                hys_cnt <= hys_cnt + 1;
        end
    end

    assign add_hys_cnt = 1'b1;
    assign end_hys_cnt = add_hys_cnt && hys_cnt == `H_TOTAL-1;

    //vys_cnt
    always @(posedge clk or negedge rst_n)begin 
        if(!rst_n)begin
            vys_cnt <= 0;
        end
        else if(add_vys_cnt)begin
            if(end_vys_cnt)
                vys_cnt <= 0;
            else
                vys_cnt <= vys_cnt + 1;
        end
    end

    assign add_vys_cnt = end_hys_cnt;
    assign end_vys_cnt = add_vys_cnt && vys_cnt == `V_TOTAL-1;

    //valid_area
    assign  hys_vld    = (hys_cnt >= `H_VLD_MIN) && (hys_cnt < `H_VLD_MAX);
    assign  vys_vld    = (vys_cnt >= `V_VLD_MIN) && (vys_cnt < `V_VLD_MAX);

 
    //hys_ff
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            hys_ff <= 1'b0;
        end
        else if(add_hys_cnt && hys_cnt == `H_SYNC-1)begin
            hys_ff <= 1'b1;
        end
        else if(end_hys_cnt)begin
            hys_ff <= 1'b0;
        end
    end

    //vys_ff
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            vys_ff <= 1'b0;
        end
        else if(add_vys_cnt && vys_cnt == `V_SYNC-1)begin
            vys_ff <= 1'b1;
        end
        else if(end_vys_cnt)begin
            vys_ff <= 1'b0;
        end
    end
    
    //vga_hys
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            vga_hys <= 1'b0;
        end
        else begin
            vga_hys <= ~hys_ff;
        end
    end
    
    //vga_vys
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            vga_vys <= 1'b0;
        end
        else begin
            vga_vys <= ~vys_ff;
        end
    end

    //vga_r
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            vga_r <= 0;
        end
        else if(hys_vld && vys_vld && pixel_din_vld)begin   //r  5
            vga_r <= {pixel_din[15:11],3'b000};
        end
        else begin
            vga_r <= 0;
        end
    end

    //vga_g
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            vga_g <= 0;
        end
        else if(hys_vld && vys_vld && pixel_din_vld)begin   //g  6
            vga_g <= {pixel_din[10:5],2'b00};
        end
        else begin
            vga_g <= 0;
        end
    end

    //vga_b
    always  @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            vga_b <= 0;
        end 
        else if(hys_vld && vys_vld && pixel_din_vld)begin       //b  5
            vga_b <= {pixel_din[4:0],3'b000};         
        end
        else begin
            vga_b <= 0;
        end
    end

    //vga_blank_n
    assign  vga_blank_n = (hys_vld && vys_vld)?1'b1:1'b0;
    
    //vga_clk
    assign  vga_clk     = ~clk;

    //vga_sync_n
    assign  vga_sync_n  = 1'b0;
    
    assign  led[0] = (pixel_din_vld && (pixel_din == 16'b11111_000000_00000 || pixel_din == 16'b00000_111111_00000 || pixel_din == 16'b00000_000000_11111 || pixel_din == 16'b11111_000000_11111))?1'b1:1'b0;

    assign  led[1] = (pixel_din_vld && (pixel_din != 16'b11111_000000_00000 || pixel_din != 16'b00000_111111_00000 || pixel_din != 16'b00000_000000_11111 || pixel_din != 16'b11111_000000_11111))?1'b1:1'b0;
    //vga_rd_req 
    always  @(*)begin
        if(hys_vld && vys_vld)begin 
            vga_rd_req = 1'b1;
        end 
        else begin 
            vga_rd_req = 1'b0;
        end 
    end

endmodule

