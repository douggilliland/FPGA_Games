-------------------------------------------------------------------------------
--
-- Project					: VGA_Test
-- File name				: VGA_Test.vhd
-- Title						: VGA display test 
-- Description				:  
--								: 
-- Design library			: N/A
-- Analysis Dependency	: VGA_SYNC.vhd
-- Simulator(s)			: ModelSim-Altera version 6.1g
-- Initialization			: none
-- Notes						: This model is designed for synthesis
--								: Compile with VHDL'93
--
-------------------------------------------------------------------------------
--
-- Revisions
--			Date		Author			Revision		Comments
--		3/11/2008		W.H.Robinson	Rev A			Creation
--		3/13/2012		W.H.Robinson	Rev B			Update for DE2-115 Board
--
--			
-------------------------------------------------------------------------------

-- Always specify the IEEE library in your design


LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.all;
USE ieee.std_logic_unsigned.ALL;

-- Entity declaration
-- 		Defines the interface to the entity

ENTITY VGA_Test IS


	PORT
	(
-- 	Note: It is easier to identify individual ports and change their order
--	or types when their declarations are on separate lines.
--	This also helps the readability of your code.

    -- Clocks
    
    CLOCK_50	: IN STD_LOGIC;  -- 50 MHz
 
    -- Buttons 
    
    KEY 		: IN STD_LOGIC_VECTOR (3 downto 0);         -- Push buttons

    -- Input switches
    
    SW 			: IN STD_LOGIC_VECTOR (17 downto 0);         -- DPDT switches

    -- VGA output
    
    VGA_BLANK_N : out std_logic;            -- BLANK
    VGA_CLK 	 : out std_logic;            -- Clock
    VGA_HS 		 : out std_logic;            -- H_SYNC
    VGA_SYNC_N  : out std_logic;            -- SYNC
    VGA_VS 		 : out std_logic;            -- V_SYNC
    VGA_R 		 : out unsigned(7 downto 0); -- Red[7:0]
    VGA_G 		 : out unsigned(7 downto 0); -- Green[7:0]
    VGA_B 		 : out unsigned(7 downto 0) -- Blue[7:0]

	);
END VGA_Test;


-- Architecture body 
-- 		Describes the functionality or internal implementation of the entity

ARCHITECTURE structural OF VGA_Test IS

COMPONENT VGA_SYNC_module

	PORT(	clock_50Mhz, red, green, blue		: IN	STD_LOGIC;
			color_8bit:	IN STD_LOGIC_VECTOR(8 DOWNTO 1);
			red_out, green_out, blue_out: OUT unsigned(7 DOWNTO 0);
			horiz_sync_out, vert_sync_out, video_on, pixel_clock	: OUT	STD_LOGIC;
			pixel_row, pixel_column: OUT STD_LOGIC_VECTOR(9 DOWNTO 0));

END COMPONENT;


SIGNAL red_int : STD_LOGIC;
SIGNAL green_int : STD_LOGIC;
SIGNAL blue_int : STD_LOGIC;
SIGNAL video_on_int : STD_LOGIC; 
SIGNAL pixel_clock_int : STD_LOGIC;
SIGNAL pixel_row_int :STD_LOGIC_VECTOR(9 DOWNTO 0); 
SIGNAL pixel_column_int :STD_LOGIC_VECTOR(9 DOWNTO 0); 


BEGIN



	U1: VGA_SYNC_module PORT MAP
		(clock_50Mhz		=>	CLOCK_50,
		 red					=>	SW(17),
		 green				=>	SW(16),	
		 blue					=>	SW(15),
		 color_8bit			=> SW(7 DOWNTO 0),
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

END structural;

