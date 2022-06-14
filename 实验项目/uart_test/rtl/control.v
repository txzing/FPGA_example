module control( 
    input				clk		,
    input				rst_n	,
    input				din_vld ,
    input		[7:0]   din	    ,
    input		 	    busy    ,
    output	reg	[7:0]	dout	,
    output	reg		    dout_vld
);								 
    //��������	
    parameter   LENFTH = 8;//FIFO���ֽ�������8�ͷ��ͳ�ȥ


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


//ʱ���߼���·����rdreq�ᵼ�����ݶ�ʧ
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


// rdreq ����߼�����FIFO �������źţ����� rdreq �� busy �γ�������������ȡFIFO��������ݶ�ʧ
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

    //�м��źŶ���		 
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
