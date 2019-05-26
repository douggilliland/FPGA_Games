-- generated with romgen v3.03 by MikeJ
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.numeric_std.all;

library UNISIM;
	use UNISIM.Vcomponents.all;

entity PROM_E10 is
port (
	CLK  : in  std_logic;
	ADDR : in  std_logic_vector(7 downto 0);
	DATA : out std_logic_vector(3 downto 0)
	);
end;

architecture RTL of PROM_E10 is


	type ROM_ARRAY is array(0 to 255) of std_logic_vector(3 downto 0);
	constant ROM : ROM_ARRAY := (
		x"0",x"0",x"0",x"0",x"4",x"5",x"0",x"8", -- 0x0000
		x"3",x"0",x"6",x"8",x"7",x"7",x"8",x"9", -- 0x0008
		x"0",x"0",x"0",x"0",x"4",x"5",x"0",x"8", -- 0x0010
		x"5",x"6",x"6",x"7",x"5",x"6",x"8",x"9", -- 0x0018
		x"0",x"9",x"8",x"7",x"6",x"5",x"5",x"6", -- 0x0020
		x"8",x"9",x"7",x"0",x"0",x"0",x"8",x"9", -- 0x0028
		x"0",x"0",x"0",x"5",x"4",x"5",x"0",x"8", -- 0x0030
		x"3",x"4",x"6",x"8",x"7",x"7",x"8",x"9", -- 0x0038
		x"0",x"0",x"0",x"0",x"0",x"0",x"9",x"7", -- 0x0040
		x"5",x"3",x"1",x"0",x"0",x"0",x"0",x"0", -- 0x0048
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x0050
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x0058
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x0060
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x0068
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x0070
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x0078
		x"0",x"D",x"B",x"B",x"8",x"F",x"0",x"0", -- 0x0080
		x"0",x"E",x"0",x"0",x"B",x"0",x"0",x"0", -- 0x0088
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x0090
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x0098
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x00A0
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x00A8
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x00B0
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x00B8
		x"0",x"D",x"B",x"B",x"8",x"F",x"0",x"0", -- 0x00C0
		x"0",x"E",x"0",x"0",x"B",x"0",x"0",x"0", -- 0x00C8
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x00D0
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x00D8
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x00E0
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x00E8
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0", -- 0x00F0
		x"0",x"0",x"0",x"0",x"0",x"0",x"0",x"0"  -- 0x00F8
	);

begin

	p_rom : process
	begin
		wait until rising_edge(CLK);
			DATA <= ROM(to_integer(unsigned(ADDR)));
	end process;
end RTL;
