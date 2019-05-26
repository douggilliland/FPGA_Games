-- generated with romgen v3.03 by MikeJ
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.numeric_std.all;

library UNISIM;
	use UNISIM.Vcomponents.all;

entity ROM_H9_H10 is
port (
	CLK  : in  std_logic;
	ADDR : in  std_logic_vector(6 downto 0);
	DATA : out std_logic_vector(7 downto 0)
	);
end;

architecture RTL of ROM_H9_H10 is

	-- Sprite RAM CC00-CC7F
	--	Low  ROMs first  half sprites, first byte x"00",...,x"7C", second byte x"86", third byte XPOS, fourth byte YPOS
	--	Low  ROMs second half sprites, first byte x"80",...,x"FC", second byte x"86", third byte XPOS, fourth byte YPOS 
	--	High ROMs first  half sprites, first byte x"00",...,x"7C", second byte x"A6", third byte XPOS, fourth byte YPOS
	--	High ROMs second half sprites, first byte x"80",...,x"FC", second byte x"A6", third byte XPOS, fourth byte YPOS

	-- Example sprites:
	--	 Capcom block logo bottom, center
	--		x"64",x"A6",x"61",x"20"
	--	Large plane
	--		x"80",x"4F",x"61",x"20"
	--	Two adjacent sprites to create main plane
	--		x"C8",x"4E",x"70",x"45"
	--		x"C0",x"4E",x"70",x"55"
	--	Normal plane
	--		x"00",x"00",x"40",x"40"
	--	Large bomb
	--		x"F3",x"00",x"70",x"80"

	type ROM_ARRAY is array(0 to 127) of std_logic_vector(7 downto 0);
	constant ROM : ROM_ARRAY := (
		-- these sprites can display anywhere on the screen
		x"88",x"4F",x"2C",x"28",	-- CC00
		x"BA",x"00",x"00",x"63",
		x"BA",x"00",x"00",x"FF",
		x"00",x"00",x"00",x"00",

		x"DA",x"0E",x"59",x"62",	-- CC10
		x"BB",x"0E",x"91",x"54",
		x"21",x"03",x"52",x"7C",
		x"32",x"05",x"6C",x"D0",

		x"30",x"05",x"4C",x"D0",	-- CC20
		x"30",x"05",x"2C",x"D0",
		x"30",x"05",x"0C",x"D0",
		x"00",x"00",x"00",x"00",

		x"BB",x"0E",x"7E",x"83",	-- CC30
		x"20",x"02",x"53",x"98",
		x"BB",x"0E",x"74",x"9B",
		x"20",x"03",x"34",x"C4",

		-- these sprites can display on the left half of screen only
		x"00",x"00",x"00",x"00",	-- CC40
		x"00",x"00",x"00",x"00",
		x"00",x"00",x"00",x"00",
		x"00",x"00",x"00",x"00",

		x"00",x"00",x"00",x"00",	-- CC50
		x"00",x"00",x"00",x"00",
		x"00",x"00",x"00",x"00",
		x"00",x"00",x"00",x"00",

		-- these sprites can display on the right half of screen only
		x"00",x"00",x"00",x"00",	-- CC60
		x"00",x"00",x"00",x"00",
		x"00",x"00",x"00",x"00",
		x"00",x"00",x"00",x"00",

		x"00",x"00",x"00",x"00",	-- CC70
		x"00",x"00",x"00",x"00",
		x"00",x"00",x"00",x"00",
		x"00",x"00",x"00",x"00" 

--		--	Low ROMs first half
--		-- whole screen sprites
--		x"00",x"86",x"50",x"00",
--		x"04",x"86",x"50",x"10", -- 0x0000
--		x"08",x"86",x"50",x"20",
--		x"0C",x"86",x"50",x"30", -- 0x0008
--		x"10",x"86",x"50",x"40",
--		x"14",x"86",x"50",x"50", -- 0x0010
--		x"18",x"86",x"50",x"60",
--		x"1C",x"86",x"50",x"70", -- 0x0018
--		x"20",x"86",x"50",x"80",
--		x"24",x"86",x"50",x"90", -- 0x0020
--		x"28",x"86",x"50",x"A0",
--		x"2C",x"86",x"50",x"B0", -- 0x0028
--		x"30",x"86",x"50",x"C0",
--		x"34",x"86",x"50",x"D0", -- 0x0030
--		x"38",x"86",x"50",x"E0",
--		x"3C",x"86",x"50",x"F0", -- 0x0038
--
--		-- left screen sprites
--		x"40",x"86",x"10",x"00",
--		x"44",x"86",x"10",x"10", -- 0x0040
--		x"48",x"86",x"10",x"20",
--		x"4C",x"86",x"10",x"30", -- 0x0048
--		x"50",x"86",x"10",x"40",
--		x"54",x"86",x"10",x"50", -- 0x0050
--		x"58",x"86",x"10",x"60",
--		x"5C",x"86",x"10",x"70", -- 0x0058
--
--		-- right screen sprites
--		x"60",x"86",x"90",x"80",
--		x"64",x"86",x"90",x"90", -- 0x0060
--		x"68",x"86",x"90",x"A0",
--		x"6C",x"86",x"90",x"B0", -- 0x0068
--		x"70",x"86",x"90",x"C0",
--		x"74",x"86",x"90",x"D0", -- 0x0070
--		x"78",x"86",x"90",x"E0",
--		x"7C",x"86",x"90",x"F0"  -- 0x0078
--
--		--	Low ROMs second half
--		-- whole screen sprites
--		x"80",x"86",x"50",x"00",
--		x"84",x"86",x"50",x"10", -- 0x0000
--		x"88",x"86",x"50",x"20",
--		x"8C",x"86",x"50",x"30", -- 0x0008
--		x"90",x"86",x"50",x"40",
--		x"94",x"86",x"50",x"50", -- 0x0010
--		x"98",x"86",x"50",x"60",
--		x"9C",x"86",x"50",x"70", -- 0x0018
--		x"A0",x"86",x"50",x"80",
--		x"A4",x"86",x"50",x"90", -- 0x0020
--		x"A8",x"86",x"50",x"A0",
--		x"AC",x"86",x"50",x"B0", -- 0x0028
--		x"B0",x"86",x"50",x"C0",
--		x"B4",x"86",x"50",x"D0", -- 0x0030
--		x"B8",x"86",x"50",x"E0",
--		x"BC",x"86",x"50",x"F0", -- 0x0038
--
--		-- left screen sprites
--		x"C0",x"86",x"10",x"00",
--		x"C4",x"86",x"10",x"10", -- 0x0040
--		x"C8",x"86",x"10",x"20",
--		x"CC",x"86",x"10",x"30", -- 0x0048
--		x"D0",x"86",x"10",x"40",
--		x"D4",x"86",x"10",x"50", -- 0x0050
--		x"D8",x"86",x"10",x"60",
--		x"DC",x"86",x"10",x"70", -- 0x0058
--
--		-- right screen sprites
--		x"E0",x"86",x"90",x"80",
--		x"E4",x"86",x"90",x"90", -- 0x0060
--		x"E8",x"86",x"90",x"A0",
--		x"EC",x"86",x"90",x"B0", -- 0x0068
--		x"F0",x"86",x"90",x"C0",
--		x"F4",x"86",x"90",x"D0", -- 0x0070
--		x"F8",x"86",x"90",x"E0",
--		x"FC",x"86",x"90",x"F0"  -- 0x0078
--
--		--	High ROMs first half
--		-- whole screen sprites
--		x"00",x"A6",x"50",x"00",
--		x"04",x"A6",x"50",x"10", -- 0x0000
--		x"08",x"A6",x"50",x"20",
--		x"0C",x"A6",x"50",x"30", -- 0x0008
--		x"10",x"A6",x"50",x"40",
--		x"14",x"A6",x"50",x"50", -- 0x0010
--		x"18",x"A6",x"50",x"60",
--		x"1C",x"A6",x"50",x"70", -- 0x0018
--		x"20",x"A6",x"50",x"80",
--		x"24",x"A6",x"50",x"90", -- 0x0020
--		x"28",x"A6",x"50",x"A0",
--		x"2C",x"A6",x"50",x"B0", -- 0x0028
--		x"30",x"A6",x"50",x"C0",
--		x"34",x"A6",x"50",x"D0", -- 0x0030
--		x"38",x"A6",x"50",x"E0",
--		x"3C",x"A6",x"50",x"F0", -- 0x0038
--
--		-- left screen sprites
--		x"40",x"A6",x"10",x"00",
--		x"44",x"A6",x"10",x"10", -- 0x0040
--		x"48",x"A6",x"10",x"20",
--		x"4C",x"A6",x"10",x"30", -- 0x0048
--		x"50",x"A6",x"10",x"40",
--		x"54",x"A6",x"10",x"50", -- 0x0050
--		x"58",x"A6",x"10",x"60",
--		x"5C",x"A6",x"10",x"70", -- 0x0058
--
--		-- right screen sprites
--		x"60",x"A6",x"90",x"80",
--		x"64",x"A6",x"90",x"90", -- 0x0060
--		x"68",x"A6",x"90",x"A0",
--		x"6C",x"A6",x"90",x"B0", -- 0x0068
--		x"70",x"A6",x"90",x"C0",
--		x"74",x"A6",x"90",x"D0", -- 0x0070
--		x"78",x"A6",x"90",x"E0",
--		x"7C",x"A6",x"90",x"F0"  -- 0x0078
--
--		--	High ROMs second half
--		-- whole screen sprites
--		x"80",x"A6",x"50",x"00",
--		x"84",x"A6",x"50",x"10", -- 0x0000
--		x"88",x"A6",x"50",x"20",
--		x"8C",x"A6",x"50",x"30", -- 0x0008
--		x"90",x"A6",x"50",x"40",
--		x"94",x"A6",x"50",x"50", -- 0x0010
--		x"98",x"A6",x"50",x"60",
--		x"9C",x"A6",x"50",x"70", -- 0x0018
--		x"A0",x"A6",x"50",x"80",
--		x"A4",x"A6",x"50",x"90", -- 0x0020
--		x"A8",x"A6",x"50",x"A0",
--		x"AC",x"A6",x"50",x"B0", -- 0x0028
--		x"B0",x"A6",x"50",x"C0",
--		x"B4",x"A6",x"50",x"D0", -- 0x0030
--		x"B8",x"A6",x"50",x"E0",
--		x"BC",x"A6",x"50",x"F0", -- 0x0038
--
--		-- left screen sprites
--		x"C0",x"A6",x"10",x"00",
--		x"C4",x"A6",x"10",x"10", -- 0x0040
--		x"C8",x"A6",x"10",x"20",
--		x"CC",x"A6",x"10",x"30", -- 0x0048
--		x"D0",x"A6",x"10",x"40",
--		x"D4",x"A6",x"10",x"50", -- 0x0050
--		x"D8",x"A6",x"10",x"60",
--		x"DC",x"A6",x"10",x"70", -- 0x0058
--
--		-- right screen sprites
--		x"E0",x"A6",x"90",x"80",
--		x"E4",x"A6",x"90",x"90", -- 0x0060
--		x"E8",x"A6",x"90",x"A0",
--		x"EC",x"A6",x"90",x"B0", -- 0x0068
--		x"F0",x"A6",x"90",x"C0",
--		x"F4",x"A6",x"90",x"D0", -- 0x0070
--		x"F8",x"A6",x"90",x"E0",
--		x"FC",x"A6",x"90",x"F0"  -- 0x0078
	);

begin
	p_rom : process
	begin
		wait until rising_edge(CLK);
		DATA <= ROM(to_integer(unsigned(ADDR)));
	end process;
end RTL;
