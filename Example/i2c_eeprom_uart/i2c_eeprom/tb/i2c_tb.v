`timescale 1ns/1ns
                
module i2c_tb();
//激励信号定义 
    reg				clk  	;
    reg				rst_n	;
    reg				req		;
    reg     [3:0]	cmd		;
    reg		[7:0]	wr_din  ;
    
//输出信号定义	 

    wire            sda_in      ;
    wire            sda_out     ;
    wire            sda_out_en  ;
    wire            scl         ;
    wire            wr_fail     ;
    wire    [7:0]   rd_dout     ;
    wire            rw_done     ;
    wire            sda         ;

    assign sda = sda_out_en?sda_out:1'bz;
    assign sda_in = sda;

//时钟周期参数定义					        
    parameter		CLOCK_CYCLE = 20;    
                                          
i2c_interface u_i2c_interface(  //仅仅实现I2C协议时序
    .clk         (clk       ),//50MHz
    .rst_n       (rst_n     ),

    .req         (req       ),//传输使能
    .cmd         (cmd       ),//传输命令码
    .wr_din      (wr_din    ),//需要传输的数据

    .sda_in      (sda_in    ),
    .sda_out     (sda_out   ),
    .sda_out_en  (sda_out_en),
    .scl         (scl       ),

    .wr_fail     (wr_fail   ),//从机未应答
    .rd_dout     (rd_dout   ),//从slave读取的1字节数据 
    .rw_done     (rw_done   ) //1个字节读写完成
);

    i2c_slave_model u_i2c_slave(
    .scl        (scl       ), 
    .sda        (sda       )
);

//产生时钟							       		
    initial 		clk = 1'b0;		       		
    always #(CLOCK_CYCLE/2) clk = ~clk;  		

    integer i = 0;

//产生激励	
/*						       		
    initial  begin						       		
        rst_n  = 0;								
        req	   = 0;
        cmd	   = 0;
        wr_din = 0;
        #3;
        #(CLOCK_CYCLE*20);				            
        rst_n = 1'b1;							
        #(CLOCK_CYCLE*20);
        for(i=0;i<10;i=i+1)begin	    //写测试
            #3;
            req	   = 1'b1;
            cmd	   = (i==0)?4'b0011:((i==9)?4'b1010:4'b0010);   
            wr_din = (i==0)?8'b1010_0000:{$random}; //写控制字
            #(CLOCK_CYCLE*1);
            req	   = 1'b0;
            @(negedge rw_done);
        end 

        #(CLOCK_CYCLE*200);
        for(i=0;i<10;i=i+1)begin	    //读测试
            #3;
            req	   = 1'b1;
            cmd	   = (i==0 || i == 2)?4'b0011:((i==1)?4'b0010:((i==9)?4'b1100:4'b0100));   
            wr_din = (i==0)?8'b1010_0000:((i==2)?8'b1010_0001:{$random}); //读控制字
            #(CLOCK_CYCLE*1);
            req	   = 1'b0;
            @(negedge rw_done);
        end

        #(CLOCK_CYCLE*200);
        $stop;

    end 
*/

    task SEND;  
        input   [3:0]   command ;   //命令
        input   [7:0]   wr_data ;   //写数据
        begin
            # 1; 
            req = 1'b1;
            wr_din = wr_data;
            cmd = command;

            #(CLOCK_CYCLE);
            req = 0;
            @(negedge rw_done);
        end 
    endtask

    initial begin
        rst_n  = 0;								
        req	   = 0;
        cmd	   = 0;
        wr_din = 0;
        #(CLOCK_CYCLE*20);				            
        rst_n = 1'b1;							
        #(CLOCK_CYCLE*20);

        //字节写
        SEND(4'b0011,8'ha0);//发起始位 + 写控制字
        SEND(4'b0010,8'h3d);//写地址
        SEND(4'b1010,8'hbe);//写数据 + 发停止位

        //@(negedge rw_done);
        #(CLOCK_CYCLE*200);

        //随机地址读
        SEND(4'b0011,8'ha0);//发起始位 + 写控制字
        SEND(4'b0010,8'h3d);//写地址
        SEND(4'b0011,8'ha1);//发起始位 + 读控制字
        SEND(4'b1100,8'h00);//读数据 + 发停止位
        #(CLOCK_CYCLE*20);
        $stop;
    end




endmodule 									       	







