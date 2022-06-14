module key_filter(
      input             clk    ,    
      input             rst_n  ,
      input             key_in ,  
      output    reg     key_vld
);
    parameter   TIME_20MS = 1_680_000;  //clk:84MHz  20ms*84Mhz/1s


    reg           [20:0]        cnt    ;
    wire                        add_cnt;
    wire                        end_cnt;

    reg                         key_in_ff0;
    reg                         key_in_ff1;
    
    reg                         flag      ;


    
    always @(posedge clk or negedge rst_n)begin
        if(!rst_n)begin
            cnt <= 0;
        end
        else if(add_cnt)begin 
            if(end_cnt)
                cnt <= 0;
            else
                cnt <= cnt + 1;
        end
    end

    assign add_cnt = flag == 1'b0 && key_in_ff1 != 1'b1;       
    assign end_cnt = add_cnt && cnt== TIME_20MS - 1;   

 //flag
    
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            flag <= 1'b0;
        end
        else if(end_cnt)begin
            flag <= 1'b1;        
        end
        else if(key_in_ff1 == 1'b1)begin
            flag <= 1'b0;
        end
    end

//key_in
    
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            key_in_ff0 <= 0;
            key_in_ff1 <= 0;
        end
        else begin
            key_in_ff0 <= key_in;
            key_in_ff1 <= key_in_ff0;
        end
    end

//key_vld
    
    always  @(posedge clk or negedge rst_n)begin
        if(rst_n==1'b0)begin
            key_vld <= 0;
        end
        else if(end_cnt)begin
            key_vld <= ~key_in_ff1;
        end
        else begin
            key_vld <= 0;
        end
    end

endmodule

