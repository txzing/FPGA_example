`include "param.v"

module lcd12864(
input	            clk, 
input	            rst_n,
input             din_sign,
input  [23:0]     din,							//传入要显示的数据
output            lcd_rw, 		//读、写操作选择信号，1：读数据，0：写数据
output            lcd_psb, //1:并行，0：串行
output reg        lcd_e, 
output reg        lcd_rs, 		//选择输出命令还是数据										
output reg [7:0]  lcd_data
); 				
//状态机参数
reg  [8:0]   state_cnt;//操作计数器	

parameter     CLK_3KHz = 8332;
reg  [13:0]   cnt_lcd_clk; 										
wire          add_cnt_lcd_clk;
wire          end_cnt_lcd_clk;

/****************************************************************/
assign   lcd_rw = 1'b0; //仅对LCD12864进行写数据操作
assign   lcd_psb = 1'b1;//并行通信方式
/**************************产生lcd时钟信号*************************/
always @(posedge clk or negedge rst_n)begin 
if(!rst_n)begin
    cnt_lcd_clk <= 0;
    lcd_e <= 1'b1;
  end 
  else if(add_cnt_lcd_clk)begin 
         if(end_cnt_lcd_clk)begin 
           cnt_lcd_clk <= 0;
           lcd_e <= ~lcd_e;
         end
         else begin 
           cnt_lcd_clk <= cnt_lcd_clk + 1;
           lcd_e <= lcd_e;
         end 
  end
   else  begin
       cnt_lcd_clk <= cnt_lcd_clk;
       lcd_e <= lcd_e;
  end
end 

assign add_cnt_lcd_clk = 1'b1;
assign end_cnt_lcd_clk = add_cnt_lcd_clk && cnt_lcd_clk == (CLK_3KHz/2)-1;

//****************************lcd12806控制信号*****************************************/                          
always @(posedge lcd_e or negedge rst_n)begin
if(!rst_n)begin
    lcd_rs <= 1'b0;
    lcd_data <= 8'h01;//如果复位按键按下，显示开关关闭
    state_cnt <= 8'd0;
end
  else case (state_cnt)
//命令参数设置
		8'd1:  begin lcd_rs <= 1'b0; lcd_data <= 8'h30; state_cnt <= state_cnt+1'b1; end //8位数据口
//延时30ms		
		8'd101:  begin lcd_rs <= 1'b0; lcd_data <= 8'h30; state_cnt <= state_cnt+1'b1; end //基本指令集，同一指令之动作不可同时改变 RE 及 DL，需先改变 DL 后在改变 RE 才可确保 FLAG 正确设定
		8'd102:  begin lcd_rs <= 1'b0; lcd_data <= 8'h0c; state_cnt <= state_cnt+1'b1; end // 关光标
		8'd103:  begin lcd_rs <= 1'b0; lcd_data <= 8'h01; state_cnt <= state_cnt+1'b1; end //清屏
		8'd104:  begin lcd_rs <= 1'b0; lcd_data <= 8'h06; state_cnt <= state_cnt+1'b1; end //进入点设定
//显示设置
//第一行
		8'd105: begin lcd_rs <= 1'b0; lcd_data <= 8'h80; state_cnt <= state_cnt+1'b1; end 
		8'd106: begin lcd_rs <= 1'b1; lcd_data <= `string_1_L; state_cnt <= state_cnt+1'b1; end
		8'd107: begin lcd_rs <= 1'b1; lcd_data <= `string_1_H; state_cnt <= state_cnt+1'b1; end
		8'd108: begin lcd_rs <= 1'b1; lcd_data <= `string_2_L; state_cnt <= state_cnt+1'b1; end
		8'd109: begin lcd_rs <= 1'b1; lcd_data <= `string_2_H; state_cnt <= state_cnt+1'b1; end
		8'd110: begin lcd_rs <= 1'b1; lcd_data <= `string_3_L; state_cnt <= state_cnt+1'b1; end
		8'd111: begin lcd_rs <= 1'b1; lcd_data <= `string_3_H; state_cnt <= state_cnt+1'b1; end
		8'd112: begin lcd_rs <= 1'b1; lcd_data <= `string_4_L; state_cnt <= state_cnt+1'b1; end
		8'd113: begin lcd_rs <= 1'b1; lcd_data <= `string_4_H; state_cnt <= state_cnt+1'b1; end
		8'd114: begin lcd_rs <= 1'b1; lcd_data <= ":"; state_cnt <= state_cnt+1'b1; end
		8'd115: begin lcd_rs <= 1'b1; lcd_data <= din_sign == 0?"+":"-"; state_cnt <= state_cnt+1'b1; end//符号位	
		8'd116: begin lcd_rs <= 1'b1; lcd_data <= "0"+din[23:20]; state_cnt <= state_cnt+1'b1; end
		8'd117: begin lcd_rs <= 1'b1; lcd_data <= "0"+din[19:16]; state_cnt <= state_cnt+1'b1; end
		8'd118: begin lcd_rs <= 1'b1; lcd_data <= "."; state_cnt <= state_cnt+1'b1; end//如果显示数字，需要加0'd48,例如data_buff <= num+8'd48
		8'd119: begin lcd_rs <= 1'b1; lcd_data <= "0"+din[15:12]; state_cnt <= state_cnt+1'b1; end
		8'd120: begin lcd_rs <= 1'b1; lcd_data <= "0"+din[11:8]; state_cnt <= state_cnt+1'b1; end
		8'd121: begin lcd_rs <= 1'b1; lcd_data <= "0"+din[7:4]; state_cnt <= state_cnt+1'b1; end
//第二行
		8'd122: begin lcd_rs <= 1'b0; lcd_data <= 8'h90; state_cnt <= state_cnt+1'b1; end 
		8'd123: begin lcd_rs <= 1'b1; lcd_data <= `string_5_L; state_cnt <= state_cnt+1'b1; end
		8'd124: begin lcd_rs <= 1'b1; lcd_data <= `string_5_H; state_cnt <= state_cnt+1'b1; end
		8'd125: begin lcd_rs <= 1'b1; lcd_data <= `string_3_L; state_cnt <= state_cnt+1'b1; end
		8'd126: begin lcd_rs <= 1'b1; lcd_data <= `string_3_H; state_cnt <= state_cnt+1'b1; end
		8'd127: begin lcd_rs <= 1'b1; lcd_data <= `string_7_L; state_cnt <= state_cnt+1'b1; end
		8'd128: begin lcd_rs <= 1'b1; lcd_data <= `string_7_H; state_cnt <= state_cnt+1'b1; end
		8'd129: begin lcd_rs <= 1'b1; lcd_data <= `string_8_L; state_cnt <= state_cnt+1'b1; end
		8'd130: begin lcd_rs <= 1'b1; lcd_data <= `string_8_H; state_cnt <= state_cnt+1'b1; end
		8'd131: begin lcd_rs <= 1'b1; lcd_data <= ":"; state_cnt <= state_cnt+1'b1; end	
		8'd132: begin lcd_rs <= 1'b1; lcd_data <= "2"; state_cnt <= state_cnt+1'b1; end
		8'd133: begin lcd_rs <= 1'b1; lcd_data <= "2"; state_cnt <= state_cnt+1'b1; end
		8'd134: begin lcd_rs <= 1'b1; lcd_data <= "`"; state_cnt <= state_cnt+1'b1; end
		8'd135: begin lcd_rs <= 1'b1; lcd_data <= "C"; state_cnt <= state_cnt+1'b1; end
		8'd136: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd137: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd138: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
//第三行 
		8'd139: begin lcd_rs <= 1'b0; lcd_data <= 8'h88; state_cnt <= state_cnt+1'b1; end
		8'd140: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd141: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd142: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd143: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd144: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd145: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd146: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd147: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end  
		8'd148: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd149: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd150: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd151: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end                     
		8'd152: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd153: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd154: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd155: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
//第四行
		8'd156: begin lcd_rs <= 1'b0; lcd_data <= 8'h98; state_cnt <= state_cnt+1'b1; end
		8'd157: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd158: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd159: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd160: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd161: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd162: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd163: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
        8'd164: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd165: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd166: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd167: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd168: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd169: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd170: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
        8'd171: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= state_cnt+1'b1; end
		8'd172: begin lcd_rs <= 1'b1; lcd_data <= 8'h20; state_cnt <= 8'd105; end
		default : begin lcd_rs <= 1'b0; lcd_data <= lcd_data; state_cnt <= state_cnt + 1'b1; end
		endcase
	end
	
endmodule
