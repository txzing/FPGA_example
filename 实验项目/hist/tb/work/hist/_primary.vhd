library verilog;
use verilog.vl_types.all;
entity hist is
    generic(
        IDLE            : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi0, Hi1);
        CLEAR           : vl_logic_vector(0 to 3) := (Hi0, Hi0, Hi1, Hi0);
        CALCU           : vl_logic_vector(0 to 3) := (Hi0, Hi1, Hi0, Hi0);
        OUTPUT          : vl_logic_vector(0 to 3) := (Hi1, Hi0, Hi0, Hi0);
        ROW             : integer := 5;
        COL             : integer := 1024;
        SCALE           : integer := 256
    );
    port(
        clk             : in     vl_logic;
        rst_n           : in     vl_logic;
        start           : in     vl_logic;
        din             : in     vl_logic_vector(7 downto 0);
        din_vld         : in     vl_logic;
        dout_vld        : out    vl_logic;
        dout            : out    vl_logic_vector(19 downto 0);
        cal_row_done    : out    vl_logic;
        init_done       : out    vl_logic
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of IDLE : constant is 1;
    attribute mti_svvh_generic_type of CLEAR : constant is 1;
    attribute mti_svvh_generic_type of CALCU : constant is 1;
    attribute mti_svvh_generic_type of OUTPUT : constant is 1;
    attribute mti_svvh_generic_type of ROW : constant is 1;
    attribute mti_svvh_generic_type of COL : constant is 1;
    attribute mti_svvh_generic_type of SCALE : constant is 1;
end hist;
