library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGA_sync_generator is
	port (
		clk		: in STD_LOGIC;
		rst_l		: in STD_LOGIC;
		blank_n	: out STD_LOGIC;
		hsync		: out STD_LOGIC;
		vsync		: out STD_LOGIC
	);
end;

architecture rtl of VGA_sync_generator is

	constant hori_line : integer := 800;
	constant hori_back : integer := 144;
	constant hori_front : integer := 16;	--16 cycles for front porch
	constant vert_line : integer := 525;
	constant vert_back : integer := 34;
	constant vert_front : integer := 11;
	constant h_sync_cycle : integer := 96;	-- 96 cycles for horizontal sync
	constant v_sync_cycle : integer := 2;
	constant h_blank : integer := hori_front + h_sync_cycle;
	
	signal h_cnt : integer range 0 to hori_line;
	signal v_cnt : integer range 0 to vert_line;
	
	signal cHD : STD_LOGIC;
	signal cVD : STD_LOGIC;
	signal cDEN : STD_LOGIC;
	signal hori_valid : STD_LOGIC;
	signal vert_valid : STD_LOGIC;

begin
	process(clk, rst_l) is
	begin
		if rst_l = '0' then
			h_cnt <= 0;
			v_cnt <= 0;
		elsif rising_edge(clk) then
			if h_cnt = hori_line-1 then
				h_cnt <= 0;
				if v_cnt = vert_line-1 then
					v_cnt <= 0;
				else
					v_cnt <= v_cnt + 1;
				end if;
			else
				h_cnt <= h_cnt + 1;
			end if;
		end if;
	end process;
	
	cHD <= '0' when h_cnt < h_sync_cycle else '1';
	cVD <= '0' when v_cnt < v_sync_cycle else '1';
	
	hori_valid <= '1' when (h_cnt < (hori_line-hori_front)) and (h_cnt >= hori_back) else '0';
	vert_valid <= '1' when (v_cnt < (vert_line-vert_front)) and (v_cnt >= vert_back) else '0';
	
	cDEN <= hori_valid and vert_valid;
	
	process(clk, rst_l) is
	begin
		if rst_l = '0' then
			hsync <= '0';
			vsync <= '0';
			blank_n <= '0';
		elsif rising_edge(clk) then
			hsync <= cHD;
			vsync <= cVD;
			blank_n <= cDEN;
		end if;
	end process;
	
end architecture;
			
			
	