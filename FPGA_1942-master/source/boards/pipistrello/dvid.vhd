--------------------------------------------------------------------------------
-- Engineer:      Mike Field <hamster@snap.net.nz>
-- Description:   Converts VGA signals into DVID bitstreams.
--
--                'clk_p' and 'clk_n' should be 5x clk_pixel.
--
--                'blank' should be asserted during the non-display
--                portions of the frame
--------------------------------------------------------------------------------
library ieee;
	use ieee.std_logic_1164.all;
library unisim;
	use unisim.vcomponents.all;

entity dvid is
port (
	clk			: in	std_logic;
	clk_pixel	: in	std_logic;
	red_p			: in	std_logic_vector (7 downto 0);
	green_p		: in	std_logic_vector (7 downto 0);
	blue_p		: in	std_logic_vector (7 downto 0);
	blank			: in	std_logic;
	hsync			: in	std_logic;
	vsync			: in	std_logic;
	tmds_p		: out	std_logic_vector (3 downto 0);
	tmds_n		: out	std_logic_vector (3 downto 0)
);
end dvid;

architecture Behavioral of dvid is
	signal encoded_red, encoded_green, encoded_blue : std_logic_vector(9 downto 0);
	signal latched_red, latched_green, latched_blue : std_logic_vector(9 downto 0) := (others => '0');
	signal shift_red,   shift_green,   shift_blue   : std_logic_vector(9 downto 0) := (others => '0');

	signal shift_clock	: std_logic_vector(9 downto 0) := "0000011111";

	constant c_red			: std_logic_vector(1 downto 0) := (others => '0');
	constant c_green		: std_logic_vector(1 downto 0) := (others => '0');
	signal   c_blue		: std_logic_vector(1 downto 0);
	signal clk_s, red_s, grn_s, blu_s, clk_p, clk_n :std_logic;

begin
	inst_dcm : DCM_SP
	generic map (
		CLKFX_MULTIPLY => 12,
		CLKFX_DIVIDE   => 5,
		CLKIN_PERIOD   => 20.0
	)
	port map (
		CLKIN    => clk,
		CLKFX    => clk_p,
		CLKFX180 => clk_n
	);

	OBUFDS_clk : OBUFDS port map ( O => tmds_p(3), OB => tmds_n(3), I => clk_s );
	OBUFDS_grn : OBUFDS port map ( O => tmds_p(2), OB => tmds_n(2), I => red_s );
	OBUFDS_red : OBUFDS port map ( O => tmds_p(1), OB => tmds_n(1), I => grn_s );
	OBUFDS_blu : OBUFDS port map ( O => tmds_p(0), OB => tmds_n(0), I => blu_s );

	c_blue <= vsync & hsync;

	TMDS_encoder_red:   entity work.TMDS_encoder PORT MAP(clk => clk_pixel, data => red_p,   c => c_red,   blank => blank, encoded => encoded_red);
	TMDS_encoder_green: entity work.TMDS_encoder PORT MAP(clk => clk_pixel, data => green_p, c => c_green, blank => blank, encoded => encoded_green);
	TMDS_encoder_blue:  entity work.TMDS_encoder PORT MAP(clk => clk_pixel, data => blue_p,  c => c_blue,  blank => blank, encoded => encoded_blue);

	ODDR2_red   : ODDR2 generic map( DDR_ALIGNMENT => "C0", INIT => '0', SRTYPE => "ASYNC") 
		port map (Q => red_s,   D0 => shift_red(0),   D1 => shift_red(1),   C0 => clk_p, C1 => clk_n, CE => '1', R => '0', S => '0');

	ODDR2_green : ODDR2 generic map( DDR_ALIGNMENT => "C0", INIT => '0', SRTYPE => "ASYNC") 
		port map (Q => grn_s, D0 => shift_green(0), D1 => shift_green(1), C0 => clk_p, C1 => clk_n, CE => '1', R => '0', S => '0');

	ODDR2_blue  : ODDR2 generic map( DDR_ALIGNMENT => "C0", INIT => '0', SRTYPE => "ASYNC") 
		port map (Q => blu_s,  D0 => shift_blue(0),  D1 => shift_blue(1),  C0 => clk_p, C1 => clk_n, CE => '1', R => '0', S => '0');

	ODDR2_clock : ODDR2 generic map( DDR_ALIGNMENT => "C0", INIT => '0', SRTYPE => "ASYNC") 
		port map (Q => clk_s, D0 => shift_clock(0), D1 => shift_clock(1), C0 => clk_p, C1 => clk_n, CE => '1', R => '0', S => '0');

	process
	begin
		wait until rising_edge(clk_pixel);
		latched_red   <= encoded_red;
		latched_green <= encoded_green;
		latched_blue  <= encoded_blue;
	end process;

	process
	begin
		wait until rising_edge(clk_p);
		if shift_clock = "0000011111" then
			shift_red   <= latched_red;
			shift_green <= latched_green;
			shift_blue  <= latched_blue;
		else
			shift_red   <= "00" & shift_red  (9 downto 2);
			shift_green <= "00" & shift_green(9 downto 2);
			shift_blue  <= "00" & shift_blue (9 downto 2);
		end if;
		shift_clock <= shift_clock(1 downto 0) & shift_clock(9 downto 2);
	end process;

end Behavioral;
