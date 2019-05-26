-- generated with romgen v3.03 by MikeJ
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.numeric_std.all;

library UNISIM;
	use UNISIM.Vcomponents.all;

entity PROM_D1_D2 is
port (
	CLK  : in  std_logic;
	ADDR : in  std_logic_vector(6 downto 0);
	DATA : out std_logic_vector(7 downto 0)
	);
end;

architecture RTL of PROM_D1_D2 is

	type ROM_ARRAY is array(0 to 127) of std_logic_vector(7 downto 0);
	constant ROM : ROM_ARRAY := (
		x"00",x"01",x"02",x"03",x"04",x"05",x"06",x"07", -- 0x0000
		x"08",x"09",x"0A",x"0B",x"0C",x"0D",x"0E",x"0F", -- 0x0008
		x"10",x"11",x"12",x"13",x"14",x"15",x"16",x"17", -- 0x0010
		x"18",x"19",x"1A",x"1B",x"1C",x"1D",x"1E",x"1F", -- 0x0018
		x"20",x"21",x"22",x"23",x"24",x"25",x"26",x"27", -- 0x0020
		x"28",x"29",x"2A",x"2B",x"2C",x"2D",x"2E",x"2F", -- 0x0028
		x"30",x"31",x"32",x"33",x"34",x"35",x"36",x"37", -- 0x0030
		x"38",x"39",x"3A",x"3B",x"3C",x"3D",x"3E",x"3F", -- 0x0038
		x"30",x"31",x"32",x"33",x"34",x"35",x"36",x"37", -- 0x0040
		x"38",x"39",x"3A",x"3B",x"3C",x"3D",x"3E",x"3F", -- 0x0048
		x"20",x"21",x"22",x"23",x"24",x"25",x"26",x"27", -- 0x0050
		x"28",x"29",x"2A",x"2B",x"2C",x"2D",x"2E",x"2F", -- 0x0058
		x"10",x"11",x"12",x"13",x"14",x"15",x"16",x"17", -- 0x0060
		x"18",x"19",x"1A",x"1B",x"1C",x"1D",x"1E",x"1F", -- 0x0068
		x"00",x"01",x"02",x"03",x"04",x"05",x"06",x"07", -- 0x0070
		x"08",x"09",x"0A",x"0B",x"0C",x"0D",x"0E",x"0F" -- 0x0078
	);

begin

	p_rom : process
	begin
		wait until rising_edge(CLK);
			DATA <= ROM(to_integer(unsigned(ADDR)));
	end process;
end RTL;
