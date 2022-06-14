module control( 
    input				clk		,
    input				rst_n	,
    input				din_vld ,
    input		[7:0]   din	    ,
    input		 	    busy    ,
    output	reg	[7:0]	dout	,
    output	reg		    dout_vld
);								 
    //参数定义	
    parameter   LENFTH = 8;//FIFO中字节数大于8就发送出去


reg         rdreq  ;
reg         rd_flag;

wire [7:0]  data  ;  
wire        wrreq ; 
wire        empty ;
wire        full  ;
wire [7:0]  q     ;
wire [7:0]  usedw ;

assign  data  = din;
assign  wrreq = din_vld && !full;

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        rd_flag <= 1'b0;
    end 
    else if( rd_flag == 1'b0 && usedw >= LENFTH )begin 
        rd_flag <= 1'b1;    
    end 
    else if( rd_flag == 1'b1 && empty )begin 
        rd_flag <= 1'b0;    
    end 
    else begin 
        rd_flag <= rd_flag;  
    end 
end


//时序逻辑电路产生rdreq会导致数据丢失
// always @(posedge clk or negedge rst_n)begin 
//     if(!rst_n)begin
//         rdreq <= 1'b0;
//     end 
//     else if(rd_flag && !busy)begin 
//         rdreq <= 1'b1;
//     end 
//     else begin 
//         rdreq <= 1'b0; 
//     end 
// end


// rdreq 组合逻辑产生FIFO 读请求信号，避免 rdreq 与 busy 形成死锁，连续读取FIFO，造成数据丢失
 always @(*)begin 
    if(empty == 1'b0 && rd_flag == 1'b1 && busy == 1'b0)begin 
        rdreq = 1'b1;       
    end 
    else begin 
        rdreq = 1'b0;
    end 
end


always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        dout <= 8'd0;
    end 
    else if(rdreq)begin 
        dout <= q;
    end 
    else begin 
        dout <= dout;
    end 
end

always @(posedge clk or negedge rst_n)begin 
    if(!rst_n)begin
        dout_vld <= 1'b0;
    end 
    else if(rdreq)begin 
        dout_vld <= 1'b1;
    end 
    else begin 
        dout_vld <= 1'b0;
    end 
end

    //中间信号定义		 
sync_fifo  u_sync_fifo(
/*input	          */.aclr   (~rst_n),
/*input	          */.clock  (clk),
/*input	[7:0]     */.data   (data),
/*input	          */.rdreq  (rdreq),
/*input	          */.wrreq  (wrreq), 
/*output	      */.empty  (empty),
/*output	      */.full   (full),
/*output	[7:0] */.q      (q),
/*output	[7:0] */.usedw  (usedw));
                        
endmodule
