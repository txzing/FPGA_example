`timescale 1 ns/1 ns

module hist_tb();

    //时钟和复位
    reg             clk         ;
    reg             rst_n       ;

    //输入信号
    reg             start       ;    //开始信号
    reg     [7:0]   din         ;
    reg             din_vld     ;

    //输出信号
    wire            dout_vld    ;
    wire    [19:0]  dout        ;
    wire            cal_row_done;
    wire            init_done   ;

    parameter CYCLE    = 20;//时钟周期，单位为ns，可在此修改时钟周期。
    parameter RST_TIME = 3 ;//复位时间，此时表示复位3个时钟周期的时间。

    //待测试的模块例化
     hist hist(
      .clk         (clk         ),//时钟
      .rst_n       (rst_n       ),//复位
      .start       (start       ),//开始统计的使能信号
      .din         (din         ),//输入的待统计的数据
      .din_vld     (din_vld     ),
      .dout_vld    (dout_vld    ),
      .dout        (dout        ),//输出的统计结果
      .cal_row_done(cal_row_done),//统计一行结束
      .init_done   (init_done   ) //ram清零完成，告诉上游模块可以送数据来了

);
    integer     i = 0,j=0;
    integer     wr_file0,wr_file1;  //文件操作
	 integer     num_cnt=0;

    //生成本地时钟50M
    initial clk = 0;
    always #(CYCLE/2) clk=~clk;

    //产生复位信号
    initial begin
        rst_n = 1;
        #2;
        rst_n = 0;
        #(CYCLE*RST_TIME);
        rst_n = 1;
    end

    initial wr_file0 = $fopen("input_data.txt");     //以只写的方式打开data.txt文件 
    initial wr_file1 = $fopen("output_result.txt");  //以只写的方式打开result.txt文件 
 

    //输入信号赋值
    initial begin
        //#1;
        //赋初值
        start       = 0;    //开始信号
        din         = 0;
        din_vld     = 0;
        #(100*CYCLE);
        //开始赋值
        start = 1'b1;
        #(1*CYCLE);
        start = 1'b0;
        @(negedge hist.init_done);      //ram初始化完成后，给出数据 
        repeat(5)begin //给5行数据，每行1K
            #1;
            din         = 0;
            din_vld     = 0;
            
            for(i=0;i<256;i=i+1)begin 
                din         = {$random};     
                din_vld     = 1'b1; 
				if(din == 5)num_cnt=num_cnt+1;
                //$fwrite(wr_file0,"the input din = %d \n",din);      //将测试数据写入文件以便检查  
                $fdisplay(wr_file0,"the input din = %d ",din);      //将测试数据写入文件以便检查 自动换行 
                #(1*CYCLE);
            end 
            din         = 0;
            din_vld     = 0;
            #(100*CYCLE);    
        end 

        @(negedge hist.dout_vld);   //结果输出完成后，结束
        #(100*CYCLE);    
        $fclose(wr_file0);   //写完数据，关闭文件
        $fclose(wr_file1);
        #(100*CYCLE); 
   
        $stop;
    end

        //initial begin       //将测试数据写入文件以便检查  
        //    $fmonitor(wr_file0,"the input din = %d",din);   //不需要触发条件，数据变化就写入，自动换行
        //end 

    always @(posedge clk)begin 
        if(dout_vld)begin   
            //$fwrite(wr_file1,"the num of the data %d is %d \n",j,dout);  //将统计结果写入文件
            $fdisplay(wr_file1,"the num of the data %d is %d",j,dout);  //自动换行
            j = j + 1;    
        end 
    end


endmodule

