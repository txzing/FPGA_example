module ds18b20_driver(
//module clock
input              clk        ,         // ʱ���źţ�50MHz��
input              rst_n      ,         // ��λ�ź�
//user interface
input              enable     ,         //ʹ���ź�
inout              dq         ,         // DS18B20��DQ��������
output reg [20:0]  temp_data  ,         // ת����õ����¶�ֵ
output reg         sign       ,         // ����λ
output reg         temp_data_vld        // ָʾ�����Ч
);

//parameter define
parameter   CLK_1us      = 5'd25;
parameter   DELAY_TIME   = 20'd500000;//500ms
localparam  ROM_SKIP_CMD = 8'hcc;           // ���� ROM ����
localparam  CONVERT_CMD  = 8'h44;           // �¶�ת������
localparam  READ_TEMP    = 8'hbe;           // �� DS1820 �¶��ݴ�������
//state define��״̬��״̬����
localparam  init         = 7'b0000001;           // ��ʼ��״̬
localparam  rom_skip     = 7'b0000010;           // ��������ROM����
localparam  wr_byte      = 7'b0000100;           // д�ֽ�״̬
localparam  temp_convert = 7'b0001000;           // �����¶�ת������
localparam  delay        = 7'b0010000;           // ��ʱ�ȴ��¶�ת������
localparam  rd_temp      = 7'b0100000;           // ���ض��¶�����
localparam  rd_byte      = 7'b1000000;           // ���ֽ�״̬
/*
DS18B20�ĵ����¶ȣ���ȡ����Ϊ����ʼ��?������ROM��� CCH�� ?����ʼת����� 44H�� ?��ʱ(500ms)?��ʼ��?
��������ROM��� CCH�� ?�����洢����� BEH�� ?�������������ֽ�����(���¶�)?������ʼ��һѭ����
*/
//reg define
reg     [ 4:0]         cnt         ;        // ��Ƶ������
reg                    clk_1us     ;        // 1MHzʱ��
reg     [19:0]         cnt_1us     ;        // ΢�����
reg     [ 7:0]         state_c   ;        // ��ǰ״̬
reg     [ 7:0]         state_n  ;        // ��һ״̬
reg     [ 3:0]         flow_cnt    ;        // ��ת����
reg     [ 3:0]         wr_cnt      ;        // д����
reg     [ 4:0]         rd_cnt      ;        // ������
reg     [ 7:0]         wr_data     ;        // װ��д��DS18B20������
reg     [ 4:0]         bit_width   ;        // ��ȡ�����ݵ�λ��
reg     [15:0]         rd_data     ;        // �ɼ���������
reg     [15:0]         org_data    ;        // ��ȡ����ԭʼ�¶�����
reg     [10:0]         data_r       ;        // ��ԭ���¶Ƚ��з��Ŵ���������
reg     [ 3:0]         cmd_cnt     ;        // �����������
reg                    init_done   ;        // ��ʼ������ź�
reg                    st_done     ;        // ����ź�
reg                    cnt_1us_en  ;        // ʹ�ܼ�ʱ
reg                    dq_out      ;        // DS18B20��dq���

//wire define
wire                   add_cnt;
wire                   end_cnt;
//*****************************************************
//**                    main code
//*****************************************************

assign dq = dq_out;

//��Ƶ����1MHz��ʱ���ź�,1MHz��Ӧ1us
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        cnt <= 5'b0;
        clk_1us <= 1'b0;
    end
    else if(add_cnt)begin 
            if(end_cnt)begin 
                cnt <= 5'b0;
                clk_1us <= ~clk_1us;
            end
            else begin
                cnt <= cnt + 1'b1;
                clk_1us <= clk_1us;
            end
    end
    else  begin
        cnt <= 5'b0;
        clk_1us <= clk_1us;
    end
end

assign add_cnt = enable;
assign end_cnt = add_cnt && cnt == CLK_1us - 1'b1;

//΢���ʱ,��ʹ���ź��£�ͳһ����us����,ʹ���ź���״̬��Լ��
always @ (posedge clk_1us or negedge rst_n) begin
    if (!rst_n)
        cnt_1us <= 20'b0;
    else if (cnt_1us_en)
        cnt_1us <= cnt_1us + 1'b1;
    else
        cnt_1us <= 20'b0;
end

//״̬��ת
always @ (posedge clk_1us or negedge rst_n) begin
    if(!rst_n)
        state_c <= init;
    else 
        state_c <= state_n;
end

//����߼�״̬�ж�ת��������״̬�л�
always @( * ) begin
    case(state_c)
        init: begin                             // ��ʼ��״̬
            if (init_done)
                state_n = rom_skip;
            else
                state_n = init;
        end
        rom_skip: begin                         // ��������ROM����
            if(st_done)
                state_n = wr_byte;
            else
                state_n = rom_skip;
        end
        wr_byte: begin                          // ��������
            if(st_done)
                case(cmd_cnt)                   // ����������ţ��ж��¸�״̬
                    4'b1: state_n = temp_convert;
                    4'd2: state_n = delay;
                    4'd3: state_n = rd_temp;
                    4'd4: state_n = rd_byte;
                    default: 
					      state_n = temp_convert;
                endcase
            else
                state_n = wr_byte;
        end
        temp_convert: begin                     // �����¶�ת������
            if(st_done)
                state_n = wr_byte;
            else
                state_n = temp_convert;
        end
        delay: begin                            // ��ʱ�ȴ��¶�ת������
            if(st_done)
                state_n = init;
            else
                state_n = delay;
        end
        rd_temp: begin                          // ���ض��¶�����
            if(st_done)
                state_n = wr_byte;
            else
                state_n = rd_temp;
        end
        rd_byte: begin                          // ���������ϵ�����
            if(st_done)
                state_n = init;
            else
                state_n = rd_byte;
        end
        default: state_n = init;
    endcase
end

//������������Ϊ��ʼ������������ROM������������¶�ת��ָ�
//�ٳ�ʼ�����ٷ�������ROM����ָ����Ͷ�����ָ�

//����ʽ״̬�������Σ�����Ӧ״̬�½������
always @ (posedge clk_1us or negedge rst_n) begin
    if(!rst_n) begin
        flow_cnt     <=  4'b0;
        init_done    <=  1'b0;
        cnt_1us_en   <=  1'b1;
        dq_out       <=  1'bZ;
        st_done      <=  1'b0;
        rd_data      <= 16'b0;
        rd_cnt       <=  5'd0;
        wr_cnt       <=  4'd0;
        cmd_cnt      <=  3'd0;
    end
    else begin
        st_done <= 1'b0;
        case (state_n)
            init:begin                              //��ʼ����������λ����
                init_done <= 1'b0;
                case(flow_cnt)
                    4'd0:
						flow_cnt <= flow_cnt + 1'b1;
					4'd1: begin					//����500us��λ����
                        cnt_1us_en <= 1'b1; //��ʼ����        
                        if(cnt_1us < 20'd500)
                            dq_out <= 1'b0; //���ֵ͵�ƽ       
                        else begin
                            cnt_1us_en <= 1'b0;//��cnt_1us����
                            dq_out <= 1'bz; //�ͷ�����
                            flow_cnt <= flow_cnt + 1'b1;//������һ����
                        end
                    end
                    4'd2:begin						//�ͷ����ߣ��ȴ�15-60us������ȡ30us
                        cnt_1us_en <= 1'b1;//��ʼ���¼��� 
                        if(cnt_1us == 20'd30)                            
                            flow_cnt <= flow_cnt + 1'b1;
                        else
                            dq_out <= 1'bz;
                    end
                    4'd3: begin	
                        if(cnt_1us <= 20'd300) begin  //�ӻ���������60-240us������Ӧ���壬�Լ��޼�����60+240				
                            if(!dq) //������߳��ֵ͵�ƽ��˵���ִӻ�Ӧ��
                                flow_cnt <= flow_cnt + 1'b1;
                            else
                                flow_cnt <= flow_cnt;
                            end
                        else//û�����¿�ʼ��ʼ������
                            flow_cnt <= 4'd0;                      
                    end
                    4'd4: begin						//�ȴ���ʼ������
                        if(cnt_1us == 20'd500) begin  //��ʱ�ȴ�һ��ʱ��
                            cnt_1us_en <= 1'b0;//��cnt_1us����
                            init_done  <= 1'b1;		//��ʼ����ɣ���־���Խ�����һ״̬
                            flow_cnt   <= 4'd0;
                        end
                        else
                            flow_cnt <= flow_cnt;
                    end
                    default: flow_cnt <= 4'd0;
                endcase
            end
            rom_skip: begin                         //��������ROM����ָ��
                wr_data  <= ROM_SKIP_CMD;
                flow_cnt <= 4'd0;
                st_done  <= 1'b1;
            end
            wr_byte: begin                          //д�ֽ�״̬������ָ������������wr_data��������
                if(wr_cnt <= 4'd7) begin//�ܹ�����8bit      
                    case (flow_cnt)
                        4'd0: begin
                            dq_out <= 1'b0;			//���������ߣ���ʼд����
                            cnt_1us_en <= 1'b1;		//������ʱ��
                            flow_cnt <= flow_cnt + 1'b1;
                        end
                        4'd1: begin					//����������1us
                            flow_cnt <= flow_cnt + 1'b1;
                        end
                        4'd2: begin
                            if(cnt_1us < 20'd60)	//�������ݣ����ٳ���60us
                                dq_out <= wr_data[wr_cnt];
                            else if(cnt_1us < 20'd63) 	
                                dq_out <= 1'bz;		//�ͷ����ߣ����ͼ����
                            else
                                flow_cnt <= flow_cnt + 1'b1;
                        end
                        4'd3: begin					//����1bit�������
                            flow_cnt <= 0;
                            cnt_1us_en <= 1'b0;
                            wr_cnt <= wr_cnt + 1'b1;//д��������1
                        end
                        default : flow_cnt <= 0;
                    endcase
                end
                else begin							//����ָ�1Byte������
                    st_done <= 1'b1;
                    wr_cnt <= 4'b0;
                    cmd_cnt <= (cmd_cnt == 3'd4) ?  //��ǵ�ǰ���͵�ָ�����
					           3'd1 : (cmd_cnt+ 1'b1);
                end
            end
            temp_convert: begin                     //�����¶�ת������
                wr_data <= CONVERT_CMD;
                st_done <= 1'b1;
            end
            delay: begin                            //��ʱ�ȴ��¶�ת������
                cnt_1us_en <= 1'b1;
                if(cnt_1us == DELAY_TIME) begin
                    st_done <= 1'b1;
                    cnt_1us_en <= 1'b0;
                end 
            end 
            rd_temp: begin                          //���ض��¶�����
                wr_data <= READ_TEMP;
                bit_width <= 5'd16;					//ָ�������ݸ���
                st_done <= 1'b1;
            end
            rd_byte: begin                          //����16λ�¶�����
                if(rd_cnt < bit_width) begin
                    case(flow_cnt)
                        4'd0: begin
                            cnt_1us_en <= 1'b1;
                            dq_out <= 1'b0;			//���������ߣ���ʼ������
                            flow_cnt <= flow_cnt + 1'b1;
                        end
                        4'd1: begin
                            dq_out <= 1'bz;			//�ͷ����߲���15us�ڽ�������
                            if(cnt_1us == 20'd14) begin
                                rd_data <= {dq,rd_data[15:1]};//�������ݣ��������ƣ��ȷ������λ
                                flow_cnt <= flow_cnt + 1'b1 ;
                            end
                        end
                        4'd2: begin
                            if (cnt_1us <= 20'd64)	//��1bit���ݽ���
                                dq_out <= 1'bz;
                            else begin
                                flow_cnt <= 4'd0;	
                                rd_cnt <= rd_cnt + 1'b1;//����������1
                                cnt_1us_en <= 1'b0;
                            end
                        end
                        default : flow_cnt <= 4'd0;
                    endcase
                end
                else begin  //16bit���ݽ�����
                    st_done <= 1'b1;
                    org_data  <= rd_data;
                    rd_cnt <= 5'b0;
                end
            end
            default: ;
        endcase
    end 
end

//�жϷ���λ
always @(posedge clk_1us or negedge rst_n) begin
    if(!rst_n) begin
        sign  <=  1'b0;
        data_r <= 11'b0;
    end
    else if(org_data[15] == 1'b0) begin
        sign  <= 1'b0;
        data_r <= org_data[10:0];
    end
    else if(org_data[15] == 1'b1) begin//�жϷ���λ����Ϊ1�������Ϊ����
        sign  <= 1'b1;
        data_r <= ~org_data[10:0] + 1'b1;//������ʽΪ���룬ȡ����1
    end
end


//�¶����
always @(posedge clk_1us or negedge rst_n) begin
    if(!rst_n)begin
        temp_data <= 21'b0;
        temp_data_vld <= 1'b0;     
    end
    else if(state_c == rd_byte & st_done)begin
        temp_data <= data_r * 11'd625;//���ݷŴ�1��
        temp_data_vld <= 1'b1;    
    end
    else begin
        temp_data <= temp_data;//���ݷŴ�1��
        temp_data_vld <= 1'b0;         
    end
end

endmodule 
