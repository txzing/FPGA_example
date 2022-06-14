module uart_test(
    input         sys_clk   ,
    input         sys_rst_n ,
    input         key       ,
    input         rx        ,
    output        tx        ,
    output [3:0]  led       ,
    output        beep_n
);

wire  [7:0]  rx_dout    ;
wire         rx_dout_vld;
wire         busy;

wire [7:0]   tx_din  ;  
wire         tx_din_vld;
 
wire         key_down;
wire [1:0]   cmd     ;

key_filter #(
            .KEY_W(1)
) 
u_key_filter(
/*input				      */.clk	  (sys_clk  ),
/*input				      */.rst_n	  (sys_rst_n), 
/*input      [KEY_W-1:0]  */.key_in   (key      ),  
/*output reg [KEY_W-1:0]  */.key_down (key_down )       
);

uart_rx  u_uart_rx(
/*input             */.clk         (sys_clk     ),
/*input             */.rst_n       (sys_rst_n   ),
/*input             */.rx          (rx          ),//串转并
/*output reg [7:0]  */.rx_dout     (rx_dout     ),
/*output reg        */.rx_dout_vld (rx_dout_vld )
);

// control  u_control( 
// /*input				    */.clk	   (sys_clk    ),
// /*input				    */.rst_n   (sys_rst_n  ),
// /*input				    */.din_vld (rx_dout_vld),
// /*input		[7:0]       */.din	   (rx_dout    ),
// /*input		     	    */.busy    (busy       ),
// /*output	reg	[7:0]	*/.dout	   (tx_din     ),
// /*output	reg	    	*/.dout_vld(tx_din_vld )
// );

cmd_analy  u_cmd_analy( 
/*input				 */.clk    (sys_clk),
/*input				 */.rst_n  (sys_rst_n),
/*input				 */.din_vld	(rx_dout_vld),
/*input	    [7:0]	 */.din		(rx_dout),
/*output reg	[1:0]*/.cmd_out	(cmd)                 	
);

beep_led  u_beep_led( 
/*input				*/.clk	    (sys_clk),
/*input				*/.rst_n	(sys_rst_n),
/*input	[1:0]	    */.cmd	    (cmd),
/*output reg [3:0]  */.led      (led),
/*output reg        */.beep_n	(beep_n)
);	

timer_send  u_timer_send( 
/*input			     */.clk		    (sys_clk    ),
/*input			     */.rst_n	    (sys_rst_n  ),
/*input              */.en          (key_down   ),
/*input              */.tx_busy     (busy       ),
/*output  reg [7:0]  */.tx_dout     (tx_din     ),
/*output  reg        */.tx_dout_vld (tx_din_vld )
);	

uart_tx  u_uart_tx( 
/*input				*/.clk		 (sys_clk   ),
/*input				*/.rst_n	 (sys_rst_n ),
/*input  [7:0]      */.tx_din    (tx_din    ),//待发送数据
/*input             */.tx_din_vld(tx_din_vld),//指示开始发送数据
/*output   reg      */.tx        (tx        ),//并转串
/*output   reg      */.busy      (busy      )
);	


endmodule
