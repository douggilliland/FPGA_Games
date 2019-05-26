library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGA_Test is
	port (
		ADC_CLK_10 		: in STD_LOGIC;
		MAX10_CLK1_50	: in STD_LOGIC;
		MAX10_CLK2_50	: in STD_LOGIC;
		
		KEY				: in STD_LOGIC_VECTOR(1 downto 0);

		VGA_B				: out STD_LOGIC_VECTOR(3 downto 0);
		VGA_G				: out STD_LOGIC_VECTOR(3 downto 0);
		VGA_R				: out STD_LOGIC_VECTOR(3 downto 0);
		VGA_HS			: out STD_LOGIC;
		VGA_VS			: out STD_LOGIC;
		LEDR				: out STD_LOGIC_VECTOR(9 downto 0)
	);
end;

architecture behavioral of VGA_Test is

	component VGA_sync_generator
		port (
			clk		: in STD_LOGIC;
			rst_l		: in STD_LOGIC;
			blank_n	: out STD_LOGIC;
			hsync		: out STD_LOGIC;
			vsync		: out STD_LOGIC
		);
	end component;
	
	component VGA_PLL is
		PORT (
			areset	: IN STD_LOGIC;
			inclk0	: IN STD_LOGIC;
			c0			: OUT STD_LOGIC;
			locked	: OUT STD_LOGIC 
		);
	end component;
	
	--memory for flag colors
	--0 is France (blue, white, red)
	--1 is Italy (green, white, red)
	--2 is Ireland (green, white, orange)
	--3 is Belgium (black, yellow, red)
	--4 is Mali (green, yellow, red)
	--5 is Chad (blue, yellow, red)
	--6 is Nigeria (green, white, green)
	--7 is Ivory Coast (orange, white, green)
	type RAM is array (0 to 2) of STD_LOGIC_VECTOR(11 downto 0);
	constant lut1 : RAM := (X"F00", X"FFF", X"000");
	--constant lut2 : RAM := (X"FFF", X"FFF", X"FFF", X"FF0", X"FF0", X"FF0", X"FFF", X"FFF");
	--constant lut3 : RAM := (X"F00", X"F00", X"FA0", X"F00", X"F00", X"F00", X"0F0", X"0F0");
	
	type state_type is (IDLE, DEBOUNCE_PRESS, PUSH, WAIT_FOR_RELEASE, DEBOUNCE_RELEASE);
	signal cstate, nstate : state_type;
	signal count, ncount : natural;
	signal n, nn: integer;
	
	signal addr : UNSIGNED(18 downto 0);
	signal yCount : UNSIGNED(18 downto 0);
	signal address_offset : UNSIGNED(18 downto 0);
	signal brickOffset : STD_LOGIC := '0';
	signal blank_n : STD_LOGIC;
	signal clk_25MHz : STD_LOGIC;
	signal hs_1, hs_2, vs_1, vs_2 : STD_LOGIC;
	
begin

	u0 : VGA_sync_generator
		port map (
			clk		=> clk_25MHz,
			rst_l		=> key(0),
			blank_n	=> blank_n,
			hsync		=> hs_1,
			vsync		=> vs_1
		);
		
	u1 : VGA_PLL
		port map (
			areset	=> '0',
			inclk0	=> MAX10_CLK1_50,
			c0			=> clk_25MHz,
			locked	=> open
		);
			
	
	-- address generation
	process(clk_25MHz, key) is
	begin
		if key(0) = '0' then
			addr <= (others => '0');
			yCount <= (others => '0');
		elsif rising_edge(clk_25MHz) then
			if blank_n = '1' then
				addr <= addr + 1;
				if (addr = 639) then
					yCount <= yCount + 1;
					if (yCount = 479) then
						yCount <= (others => '0');
					end if;
				end if;
			else
				addr <= (others => '0');
			end if;
		end if;
	end process;
	
	-- pixel generation
	process(clk_25MHz, key)
	begin
		if key(0) = '0' then
			VGA_R <= "0000";
			VGA_G <= "0000";
			VGA_B <= "0000";
		
		elsif rising_edge(clk_25MHz) then
			if(yCount >= 0 AND yCount <= 240) then
				if (yCount(2 downto 0) = "000") then
					--brickOffset <= NOT brickOffset;
					if (brickOffset = '0') then
						brickOffset <= '1';
					elsif (brickOffset = '1') then
						brickOffset <= '0';
					end if;
					VGA_R <= lut1(1)(11 downto 8);
					VGA_G <= lut1(1)(7 downto 4);
					VGA_B <= lut1(1)(3 downto 0);
					
				elsif (addr > 0 AND addr <= 639) then
					if (brickOffset = '0') then
						if (addr(3 downto 0) = "0000") then
							LEDR(0) <= '1';
							VGA_R <= lut1(1)(11 downto 8);
							VGA_G <= lut1(1)(7 downto 4);
							VGA_B <= lut1(1)(3 downto 0);
						else
							VGA_R <= lut1(0)(11 downto 8);
							VGA_G <= lut1(0)(7 downto 4);
							VGA_B <= lut1(0)(3 downto 0);
						end if;
					elsif (brickOffset = '1') then
						address_offset <= addr + "0111";
						
						if (address_offset(3 downto 0) = "0000") then
							LEDR(1) <= '1';
							VGA_R <= lut1(1)(11 downto 8);
							VGA_G <= lut1(1)(7 downto 4);
							VGA_B <= lut1(1)(3 downto 0);
						else
							VGA_R <= lut1(0)(11 downto 8);
							VGA_G <= lut1(0)(7 downto 4);
							VGA_B <= lut1(0)(3 downto 0);
						end if;
					
					end if;
				else
					VGA_R <= "0000";
					VGA_G <= "0000";
					VGA_B <= "0000";
				end if;
				
			elsif (yCount > 240 AND yCount <= 480) then
				if (addr > 0 AND addr <= 639) then
					VGA_R <= "0000";
					VGA_G <= "0000";
					VGA_B <= "0000";
				end if;
			end if;
		end if;
	end process;
	
	process(clk_25MHz)
	begin
		if rising_edge(clk_25MHz) then
			VGA_HS <= hs_2;
			VGA_VS <= vs_2;
			hs_2 <= hs_1;
			vs_2 <= vs_1;
		end if;
	end process;
		
end architecture behavioral;
