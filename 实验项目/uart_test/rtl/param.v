`define  CLOCK_FRQ   50_000_000


// `define  BAUD_9600
// `define  BAUD_14400
// `define  BAUD_19200 
// `define  BAUD_38400
`define  BAUD_115200   

`ifdef BAUD_9600
    `define  BAUD_MAX 9600
`elsif BAUD_14400
    `define  BAUD_MAX 14400
`elsif BAUD_19200
    `define  BAUD_MAX 19200
`elsif BAUD_115200
    `define  BAUD_MAX 115200
`else 
    `define  BAUD_MAX 115200
`endif

/*
���ݷ��͸�ʽ��
��ǰʱ��:16:10:30+����
λ��152
19���ֽ�
*/ 

`define  CURTENT_TIME  64'hB5B1_C7B0_CAB1_BCE4    //��ǰʱ��


