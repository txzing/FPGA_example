`timescale 1 ns/1 ns
`include"../rtl/param.v"

module vga_tb();

    reg             clk     ;
    reg             rst_n   ;

    reg     [15:0]  din     ;
    reg             din_vld ;


    wire            rdy     ;
    wire    [15:0]  rgb     ;
    wire            hsync   ;
    wire            vsync   ;

    parameter CYCLE    = 20;
    parameter RST_TIME = 3 ;

 vga_interface u_vga(    //1280*720
    /*input           */.clk      (clk      ),//75MHz
    /*input           */.rst_n    (rst_n    ),
    /*input   [15:0]  */.din      (din      ),
    /*input           */.din_vld  (din_vld  ),
    /*output          */.rdy      (rdy      ),
    /*output  [15:0]  */.vga_rgb  (rgb      ),
    /*output          */.vga_hsync(hsync    ),
    /*output          */.vga_vsync(vsync    )
);

    integer i = 0 , j = 0 ;

    initial begin
        clk = 1;
        forever
        #(CYCLE/2)
        clk=~clk;
    end

    initial begin 
        rst_n = 1;
        #2;
        rst_n = 0;
        #(CYCLE*RST_TIME);
        rst_n = 1;
    end

    //???????
    initial begin
        #1;
        din = 0;
        din_vld = 0;
        #(100*CYCLE);
        repeat(3)begin 
            @(posedge u_vga.v_vld);
            for(i=0;i<`V_AP;i=i+1)begin     //计720行
                @(posedge u_vga.h_vld);     //计1280列
                for(j = 0; j < `H_AP;j = j + 1)begin
                    din = {$random};
                    din_vld = (rdy==1)?1'b1:1'b0;
                    #(1*CYCLE);
                end 
                din_vld = 0;
            end
            #(100*CYCLE);
            $stop;
        end
    end 


endmodule

