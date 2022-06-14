`timescale 1ns/1ns

module controller_tb();
    
    reg             clk0    ;
    reg             clk1    ;
    reg             clk2    ;
    reg             rst_n   ;
    reg   [7:0]     din     ; 
    reg             din_vld ; 
    reg             rdy     ; //串口发送ready
    reg             rd_req  ; //读请求
    
    wire    [7:0]   dout    ;
    wire            dout_vld;
    wire            cke     ; 
    wire            csn     ; 
    wire            rasn    ; 
    wire            casn    ; 
    wire            wen     ; 
    wire    [1:0]   bank    ; 
    wire    [12:0]  addr    ; 
    wire    [15:0]  dq      ; 
    wire    [1:0]   dqm     ;  

    

sdram_controller u_controller(
    /*input           */.clk             (clk0      ),//100M 控制器主时钟
    /*input           */.clk_in          (clk1      ),//数据输入时钟
    /*input           */.clk_out         (clk1      ),//数据输出时钟
    /*input           */.rst_n           (rst_n     ),
    /*input   [7:0]   */.din             (din          ),
    /*input           */.din_vld         (din_vld      ),
    /*input           */.rdy             (rdy          ),//串口发送ready
    /*input           */.rd_req          (rd_req       ),//读请求
    /*output  [7:0]   */.dout            (dout         ),//串口发送
    /*output          */.dout_vld        (dout_vld     ),
    //sdram接口
    /*output          */.cke             (cke      ),
    /*output          */.csn             (csn      ),
    /*output          */.rasn            (rasn     ),
    /*output          */.casn            (casn     ),
    /*output          */.wen             (wen      ),
    /*output  [1:0]   */.bank            (bank     ),
    /*output  [12:0]  */.addr            (addr     ),
    /*inout   [15:0]  */.dq              (dq       ),
    /*output  [1:0]   */.dqm             (dqm      )    
);
sdr u_slave(
    .Dq     (dq     ), 
    .Addr   (addr   ), 
    .Ba     (bank   ), 
    .Clk    (clk2   ), 
    .Cke    (cke    ), 
    .Cs_n   (csn    ), 
    .Ras_n  (rasn   ), 
    .Cas_n  (casn   ), 
    .We_n   (wen    ), 
    .Dqm    (dqm    )
);

    parameter CLOCK_CYCLE = 20;

    initial clk0 = 0;
    always #(CLOCK_CYCLE/4) clk0 = ~clk0;
        
    initial clk1 = 0;
    always #(CLOCK_CYCLE/2) clk1 = ~clk1;
    
    initial begin 
        fork 
            clk2 = 0;
            #2;
            clk2 = 1;
        join
        forever begin
            #(CLOCK_CYCLE/4);
            clk2 = ~clk2;
        end    
    end 

    integer i = 0;

    initial begin 
        rst_n = 1'b0;
        #(CLOCK_CYCLE*2);
        rst_n = 1'b1; 
        #(CLOCK_CYCLE*20);
        din  = 0; 
        din_vld = 0;
        rdy = 1;  
        @(posedge u_controller.u_intf.mrs2idle);//模式寄存器设置完成开始给数据
        #(CLOCK_CYCLE*20);
        repeat(10)begin 
            for(i=0;i<20;i=i+1)begin 
                din  = {$random}; 
                din_vld = 1; 
                #(CLOCK_CYCLE*1);
            end 
            din_vld = 0; 
            #(CLOCK_CYCLE*30);
        end 
        $stop;
    end 

    initial begin 
        rd_req = 0;
        @(posedge u_controller.u_intf.mrs2idle);//模式寄存器设置完成开始读
        #(CLOCK_CYCLE*200);
        repeat(10)begin 
          rd_req = {$random};
          #(CLOCK_CYCLE*1);
          rd_req = 0;
          #(CLOCK_CYCLE*50);
        end 
    end 


endmodule   

