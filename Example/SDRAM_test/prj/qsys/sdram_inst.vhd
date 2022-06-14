	component sdram is
		port (
			avalon_sdram_address       : in    std_logic_vector(23 downto 0) := (others => 'X'); -- address
			avalon_sdram_byteenable_n  : in    std_logic_vector(1 downto 0)  := (others => 'X'); -- byteenable_n
			avalon_sdram_chipselect    : in    std_logic                     := 'X';             -- chipselect
			avalon_sdram_writedata     : in    std_logic_vector(15 downto 0) := (others => 'X'); -- writedata
			avalon_sdram_read_n        : in    std_logic                     := 'X';             -- read_n
			avalon_sdram_write_n       : in    std_logic                     := 'X';             -- write_n
			avalon_sdram_readdata      : out   std_logic_vector(15 downto 0);                    -- readdata
			avalon_sdram_readdatavalid : out   std_logic;                                        -- readdatavalid
			avalon_sdram_waitrequest   : out   std_logic;                                        -- waitrequest
			clk_clk                    : in    std_logic                     := 'X';             -- clk
			reset_reset_n              : in    std_logic                     := 'X';             -- reset_n
			sdram_addr                 : out   std_logic_vector(12 downto 0);                    -- addr
			sdram_ba                   : out   std_logic_vector(1 downto 0);                     -- ba
			sdram_cas_n                : out   std_logic;                                        -- cas_n
			sdram_cke                  : out   std_logic;                                        -- cke
			sdram_cs_n                 : out   std_logic;                                        -- cs_n
			sdram_dq                   : inout std_logic_vector(15 downto 0) := (others => 'X'); -- dq
			sdram_dqm                  : out   std_logic_vector(1 downto 0);                     -- dqm
			sdram_ras_n                : out   std_logic;                                        -- ras_n
			sdram_we_n                 : out   std_logic;                                        -- we_n
			sdram_rst_reset_n          : in    std_logic                     := 'X'              -- reset_n
		);
	end component sdram;

	u0 : component sdram
		port map (
			avalon_sdram_address       => CONNECTED_TO_avalon_sdram_address,       -- avalon_sdram.address
			avalon_sdram_byteenable_n  => CONNECTED_TO_avalon_sdram_byteenable_n,  --             .byteenable_n
			avalon_sdram_chipselect    => CONNECTED_TO_avalon_sdram_chipselect,    --             .chipselect
			avalon_sdram_writedata     => CONNECTED_TO_avalon_sdram_writedata,     --             .writedata
			avalon_sdram_read_n        => CONNECTED_TO_avalon_sdram_read_n,        --             .read_n
			avalon_sdram_write_n       => CONNECTED_TO_avalon_sdram_write_n,       --             .write_n
			avalon_sdram_readdata      => CONNECTED_TO_avalon_sdram_readdata,      --             .readdata
			avalon_sdram_readdatavalid => CONNECTED_TO_avalon_sdram_readdatavalid, --             .readdatavalid
			avalon_sdram_waitrequest   => CONNECTED_TO_avalon_sdram_waitrequest,   --             .waitrequest
			clk_clk                    => CONNECTED_TO_clk_clk,                    --          clk.clk
			reset_reset_n              => CONNECTED_TO_reset_reset_n,              --        reset.reset_n
			sdram_addr                 => CONNECTED_TO_sdram_addr,                 --        sdram.addr
			sdram_ba                   => CONNECTED_TO_sdram_ba,                   --             .ba
			sdram_cas_n                => CONNECTED_TO_sdram_cas_n,                --             .cas_n
			sdram_cke                  => CONNECTED_TO_sdram_cke,                  --             .cke
			sdram_cs_n                 => CONNECTED_TO_sdram_cs_n,                 --             .cs_n
			sdram_dq                   => CONNECTED_TO_sdram_dq,                   --             .dq
			sdram_dqm                  => CONNECTED_TO_sdram_dqm,                  --             .dqm
			sdram_ras_n                => CONNECTED_TO_sdram_ras_n,                --             .ras_n
			sdram_we_n                 => CONNECTED_TO_sdram_we_n,                 --             .we_n
			sdram_rst_reset_n          => CONNECTED_TO_sdram_rst_reset_n           --    sdram_rst.reset_n
		);

