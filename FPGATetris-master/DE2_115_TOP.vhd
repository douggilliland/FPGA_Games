--
-- DE2-115 top-level module (entity declaration)
--
-- William H. Robinson, Vanderbilt University University
--   william.h.robinson@vanderbilt.edu
--
-- Updated from the DE2 top-level module created by 
-- Stephen A. Edwards, Columbia University, sedwards@cs.columbia.edu
--

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity DE2_115_TOP is

  port (
    -- Clocks
    
    CLOCK_50 	: in std_logic;                     -- 50 MHz
    CLOCK2_50 	: in std_logic;                     -- 50 MHz
    CLOCK3_50 	: in std_logic;                     -- 50 MHz
    SMA_CLKIN  : in std_logic;                     -- External Clock Input
    SMA_CLKOUT : out std_logic;                    -- External Clock Output

    -- Buttons and switches
    
    KEY : in std_logic_vector(3 downto 0);         -- Push buttons
    SW  : in std_logic_vector(17 downto 0);        -- DPDT switches

    -- LED displays

    HEX0 : out std_logic_vector(6 downto 0);       -- 7-segment display (active low)
    HEX1 : out std_logic_vector(6 downto 0);       -- 7-segment display (active low)
    HEX2 : out std_logic_vector(6 downto 0);       -- 7-segment display (active low)
    HEX3 : out std_logic_vector(6 downto 0);       -- 7-segment display (active low)
    HEX4 : out std_logic_vector(6 downto 0);       -- 7-segment display (active low)
    HEX5 : out std_logic_vector(6 downto 0);       -- 7-segment display (active low)
    HEX6 : out std_logic_vector(6 downto 0);       -- 7-segment display (active low)
    HEX7 : out std_logic_vector(6 downto 0);       -- 7-segment display (active low)
    LEDG : out std_logic_vector(8 downto 0);       -- Green LEDs (active high)
    LEDR : out std_logic_vector(17 downto 0);      -- Red LEDs (active high)

    -- RS-232 interface

    UART_CTS : out std_logic;                      -- UART Clear to Send   
    UART_RTS : in std_logic;                       -- UART Request to Send   
    UART_RXD : in std_logic;                       -- UART Receiver
    UART_TXD : out std_logic;                      -- UART Transmitter   

    -- 16 X 2 LCD Module
    
    LCD_BLON : out std_logic;      							-- Back Light ON/OFF
    LCD_EN   : out std_logic;      							-- Enable
    LCD_ON   : out std_logic;      							-- Power ON/OFF
    LCD_RS   : out std_logic;	   							-- Command/Data Select, 0 = Command, 1 = Data
    LCD_RW   : out std_logic; 	   						-- Read/Write Select, 0 = Write, 1 = Read
    LCD_DATA : inout std_logic_vector(7 downto 0); 	-- Data bus 8 bits

    -- PS/2 ports

    PS2_CLK : inout std_logic;     -- Clock
    PS2_DAT : inout std_logic;     -- Data

    PS2_CLK2 : inout std_logic;    -- Clock
    PS2_DAT2 : inout std_logic;    -- Data

    -- VGA output
    
    VGA_BLANK_N : out std_logic;            -- BLANK
    VGA_CLK 	 : out std_logic;            -- Clock
    VGA_HS 		 : out std_logic;            -- H_SYNC
    VGA_SYNC_N  : out std_logic;            -- SYNC
    VGA_VS 		 : out std_logic;            -- V_SYNC
    VGA_R 		 : out unsigned(7 downto 0); -- Red[9:0]
    VGA_G 		 : out unsigned(7 downto 0); -- Green[9:0]
    VGA_B 		 : out unsigned(7 downto 0); -- Blue[9:0]

    -- SRAM
    
    SRAM_ADDR : out unsigned(19 downto 0);         -- Address bus 20 Bits
    SRAM_DQ   : inout unsigned(15 downto 0);       -- Data bus 16 Bits
    SRAM_CE_N : out std_logic;                     -- Chip Enable
    SRAM_LB_N : out std_logic;                     -- Low-byte Data Mask 
    SRAM_OE_N : out std_logic;                     -- Output Enable
    SRAM_UB_N : out std_logic;                     -- High-byte Data Mask 
    SRAM_WE_N : out std_logic;                     -- Write Enable

    -- Audio CODEC
    
    AUD_ADCDAT 	: in std_logic;               -- ADC Data
    AUD_ADCLRCK 	: inout std_logic;            -- ADC LR Clock
    AUD_BCLK 		: inout std_logic;            -- Bit-Stream Clock
    AUD_DACDAT 	: out std_logic;              -- DAC Data
    AUD_DACLRCK 	: inout std_logic;            -- DAC LR Clock
    AUD_XCK 		: out std_logic               -- Chip Clock
    
    );
  
end DE2_115_TOP;

ARCHITECTURE structural OF DE2_115_TOP IS

COMPONENT VGA_SYNC_module

	PORT(	clock_50Mhz, red, green, blue		: IN	STD_LOGIC;
			color_8bit:	IN STD_LOGIC_VECTOR(8 DOWNTO 1);
			red_out, green_out, blue_out: OUT unsigned(7 DOWNTO 0);
			horiz_sync_out, vert_sync_out, video_on, pixel_clock	: OUT	STD_LOGIC;
			pixel_row, pixel_column: OUT STD_LOGIC_VECTOR(9 DOWNTO 0));

END COMPONENT;

type board_type is array(30 downto 0, 10 downto 0) of std_logic;

component game_logic 
	port(rotate_cw, rotate_ccw, move_left, move_right, clk_50, reset : in std_logic;
		  output_matrix : out board_type;
		  game_over : out std_logic;
		  score: out integer);
end component;

component bcd_seven is
	port(bcd: in STD_LOGIC_VECTOR(3 downto 0);
		  seven: out STD_LOGIC_VECTOR(7 downto 1));
end component;

SIGNAL red_int : STD_LOGIC;
SIGNAL green_int : STD_LOGIC;
SIGNAL blue_int : STD_LOGIC;
SIGNAL video_on_int : STD_LOGIC; 
SIGNAL pixel_clock_int : STD_LOGIC;
SIGNAL pixel_row_int :STD_LOGIC_VECTOR(9 DOWNTO 0); 
SIGNAL pixel_column_int :STD_LOGIC_VECTOR(9 DOWNTO 0); 
SIGNAL color :STD_LOGIC_VECTOR(7 DOWNTO 0);
--type board is array (10 downto 0, 30 downto 0) of std_logic;
SIGNAL gameboard: board_type;
SIGNAL pixel_column_intd16:STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL pixel_row_intd16:STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL gover: STD_LOGIC;
SIGNAL score: integer;
SIGNAL Hex0n,Hex1n,Hex2n,Hex3n: STD_LOGIC_VECTOR(7 downto 1);

BEGIN
	HEX0 <= not Hex0n;
	HEX1 <= not Hex1n;
	HEX2 <= not Hex2n;
	HEX3 <= not Hex3n;
	HEX4 <= "1111111";
	HEX5 <= "1111111";
	HEX6 <= "1111111";
	HEX7 <= "1111111";
	--gameboard(0,0) <= '1';
	--gameboard(2,3) <= '1';
	--gameboard(8,8) <= '1';
	PROCESS (pixel_column_int, pixel_row_int)
	BEGIN
		pixel_column_intd16 <= ("0000"& pixel_column_int(9 downto 4));
		pixel_row_intd16 <= ("0000"& pixel_row_int(9 downto 4));
		if (unsigned(pixel_column_int) > 240) and (unsigned(pixel_column_int) < 400) then
			if ((unsigned(pixel_column_int) rem 16) = 0) or ((unsigned(pixel_row_int) rem 16) = 0) then
				color <= "11111111";
			else
				if gameboard(to_integer(unsigned(pixel_row_intd16)), to_integer(unsigned(pixel_column_intd16))-15) = '1' then
					color <= "00000000";
				else
					color <= "10000000";
				end if;
			end if;
		else
			color <= "00000000";
		END IF;
	END PROCESS;
	U1: VGA_SYNC_module PORT MAP
		(clock_50Mhz		=>	CLOCK_50,
		 red					=>	'1',
		 green				=>	not gover,	
		 blue					=>	not gover,
		 color_8bit			=> color,
		 red_out				=>	VGA_R(7 DOWNTO 0),
		 green_out			=>	VGA_G(7 DOWNTO 0),
		 blue_out			=>	VGA_B(7 DOWNTO 0),
		 horiz_sync_out	=>	VGA_HS,
		 vert_sync_out		=>	VGA_VS,
		 video_on			=>	VGA_BLANK_N,
		 pixel_clock		=>	VGA_CLK,
		 pixel_row			=>	pixel_row_int,
		 pixel_column		=>	pixel_column_int
		);
		
		U2: game_logic port map
		(rotate_cw			=> KEY(0),
		 rotate_ccw			=> KEY(1),
		 move_left			=> KEY(3),
		 move_right			=> KEY(2),
		 clk_50				=> CLOCK_50,
		 reset				=> SW(0),
		 output_matrix		=> gameboard,
		 game_over        => gover,
		 score 				=> score);
	U3: bcd_seven port map
	(
		bcd					=> std_logic_vector(to_unsigned(score, 16))(3 downto 0),
		seven					=> Hex0n
	);
	U4: bcd_seven port map
	(
		bcd					=> std_logic_vector(to_unsigned(score, 16))(7 downto 4),
		seven					=> Hex1n
	);
	U5: bcd_seven port map
	(
		bcd					=> std_logic_vector(to_unsigned(score, 16))(11 downto 8),
		seven					=> Hex2n
	);
	U6: bcd_seven port map
	(
		bcd					=> std_logic_vector(to_unsigned(score, 16))(15 downto 12),
		seven					=> Hex3n
	);
	--LEDG(3 downto 0) <= not KEY;
END structural;