-- generated with romgen v3.03 by MikeJ
library ieee;
	use ieee.std_logic_1164.all;
	use ieee.std_logic_unsigned.all;
	use ieee.numeric_std.all;

library UNISIM;
	use UNISIM.Vcomponents.all;

entity ROM_A9 is
port (
	CLK  : in  std_logic;
	ADDR : in  std_logic_vector(9 downto 0);
	DATA : out std_logic_vector(7 downto 0)
	);
end;

architecture RTL of ROM_A9 is


	type ROM_ARRAY is array(0 to 1023) of std_logic_vector(7 downto 0);
	constant ROM : ROM_ARRAY := (
		x"3C",x"3D",x"3E",x"3F",x"3C",x"7E",x"7C",x"7C", -- 0x0000
		x"7C",x"7C",x"7C",x"7F",x"3C",x"3D",x"3E",x"3F", -- 0x0008
		x"87",x"87",x"87",x"87",x"87",x"4E",x"0E",x"0E", -- 0x0010
		x"0E",x"0E",x"0E",x"0E",x"87",x"87",x"87",x"87", -- 0x0018
		x"3D",x"3C",x"3F",x"3E",x"3C",x"BE",x"B7",x"B7", -- 0x0020
		x"B7",x"B7",x"BF",x"79",x"78",x"3D",x"3C",x"3D", -- 0x0028
		x"87",x"87",x"87",x"87",x"87",x"8E",x"8E",x"8E", -- 0x0030
		x"8E",x"8E",x"8E",x"0E",x"0E",x"A7",x"A7",x"A7", -- 0x0038
		x"3E",x"3F",x"3C",x"3D",x"3D",x"BD",x"EC",x"BC", -- 0x0040
		x"BC",x"74",x"C1",x"7A",x"77",x"3C",x"3D",x"3C", -- 0x0048
		x"87",x"87",x"87",x"87",x"87",x"8E",x"00",x"8E", -- 0x0050
		x"CE",x"00",x"8E",x"0E",x"0E",x"87",x"87",x"8E", -- 0x0058
		x"3F",x"3E",x"3D",x"3C",x"3C",x"B5",x"E4",x"BC", -- 0x0060
		x"BC",x"73",x"C0",x"AF",x"76",x"3C",x"3D",x"3C", -- 0x0068
		x"87",x"87",x"87",x"87",x"87",x"8E",x"00",x"8E", -- 0x0070
		x"CE",x"00",x"8E",x"8E",x"0E",x"87",x"C7",x"87", -- 0x0078
		x"3C",x"3D",x"3E",x"3F",x"AC",x"AD",x"FF",x"AE", -- 0x0080
		x"AE",x"DE",x"AD",x"CF",x"75",x"3C",x"3D",x"3C", -- 0x0088
		x"87",x"87",x"87",x"87",x"8F",x"8E",x"00",x"8E", -- 0x0090
		x"CE",x"00",x"CE",x"8B",x"0E",x"87",x"87",x"8E", -- 0x0098
		x"3D",x"3C",x"3F",x"3E",x"A4",x"A5",x"D7",x"BC", -- 0x00A0
		x"BC",x"74",x"A5",x"C7",x"79",x"78",x"3C",x"3D", -- 0x00A8
		x"87",x"87",x"87",x"87",x"8F",x"8E",x"80",x"8E", -- 0x00B0
		x"CE",x"00",x"CE",x"8B",x"0E",x"0E",x"87",x"87", -- 0x00B8
		x"3E",x"3F",x"3C",x"3D",x"B8",x"BB",x"EC",x"BC", -- 0x00C0
		x"BC",x"73",x"DF",x"C3",x"7A",x"77",x"3D",x"3C", -- 0x00C8
		x"87",x"87",x"87",x"87",x"8E",x"8E",x"00",x"8E", -- 0x00D0
		x"CE",x"00",x"00",x"8E",x"0E",x"0E",x"87",x"87", -- 0x00D8
		x"3F",x"3E",x"3D",x"3C",x"B0",x"A3",x"E4",x"BC", -- 0x00E0
		x"BC",x"ED",x"EE",x"EF",x"7A",x"76",x"3C",x"3D", -- 0x00E8
		x"87",x"87",x"87",x"87",x"8E",x"80",x"00",x"8E", -- 0x00F0
		x"CE",x"00",x"00",x"00",x"0E",x"0E",x"87",x"87", -- 0x00F8
		x"3C",x"3D",x"3E",x"3F",x"A8",x"BB",x"EC",x"BC", -- 0x0100
		x"E0",x"E5",x"E6",x"E7",x"7A",x"75",x"3D",x"3C", -- 0x0108
		x"87",x"87",x"87",x"87",x"8E",x"8E",x"00",x"8E", -- 0x0110
		x"0E",x"00",x"00",x"00",x"0E",x"0E",x"87",x"87", -- 0x0118
		x"3D",x"3C",x"3F",x"3E",x"A0",x"A3",x"E4",x"BC", -- 0x0120
		x"F0",x"F1",x"F2",x"FE",x"7A",x"75",x"3C",x"3D", -- 0x0128
		x"87",x"87",x"87",x"87",x"8E",x"80",x"00",x"8E", -- 0x0130
		x"0E",x"00",x"00",x"00",x"0E",x"2E",x"87",x"87", -- 0x0138
		x"3E",x"3F",x"3C",x"3D",x"B9",x"AA",x"FF",x"AE", -- 0x0140
		x"E8",x"E9",x"EA",x"EB",x"7A",x"76",x"3D",x"3D", -- 0x0148
		x"87",x"87",x"87",x"87",x"8E",x"8E",x"00",x"8E", -- 0x0150
		x"0E",x"00",x"00",x"00",x"0E",x"2E",x"87",x"87", -- 0x0158
		x"3F",x"3E",x"3D",x"3C",x"B1",x"BB",x"EC",x"A2", -- 0x0160
		x"BC",x"E1",x"E2",x"E3",x"7A",x"77",x"3D",x"3C", -- 0x0168
		x"87",x"87",x"87",x"87",x"8E",x"8E",x"00",x"8E", -- 0x0170
		x"CE",x"00",x"00",x"00",x"0E",x"2E",x"87",x"87", -- 0x0178
		x"3C",x"3D",x"3E",x"3F",x"A9",x"A3",x"E4",x"A2", -- 0x0180
		x"BC",x"DC",x"DD",x"DE",x"79",x"78",x"3D",x"3C", -- 0x0188
		x"87",x"87",x"87",x"87",x"8E",x"80",x"00",x"8E", -- 0x0190
		x"CE",x"80",x"80",x"8B",x"2E",x"0E",x"87",x"87", -- 0x0198
		x"3D",x"3C",x"3F",x"3E",x"A1",x"BB",x"EC",x"A2", -- 0x01A0
		x"BC",x"D4",x"D5",x"D6",x"7D",x"3C",x"3D",x"3C", -- 0x01A8
		x"87",x"87",x"87",x"87",x"8E",x"8E",x"00",x"8E", -- 0x01B0
		x"CE",x"80",x"80",x"8B",x"2E",x"87",x"87",x"87", -- 0x01B8
		x"3E",x"3F",x"3C",x"3D",x"BA",x"A3",x"E4",x"A2", -- 0x01C0
		x"BC",x"CC",x"CD",x"CE",x"75",x"3D",x"3C",x"3D", -- 0x01C8
		x"87",x"87",x"87",x"87",x"8E",x"80",x"00",x"8E", -- 0x01D0
		x"CE",x"80",x"80",x"8B",x"2E",x"87",x"87",x"87", -- 0x01D8
		x"3F",x"3E",x"3D",x"3C",x"3C",x"B3",x"FF",x"AE", -- 0x01E0
		x"AE",x"C4",x"C5",x"7A",x"77",x"3C",x"3D",x"3C", -- 0x01E8
		x"87",x"87",x"87",x"87",x"87",x"8E",x"00",x"8E", -- 0x01F0
		x"CE",x"8E",x"80",x"0E",x"2E",x"87",x"87",x"87", -- 0x01F8
		x"3C",x"3D",x"3E",x"3F",x"3D",x"AB",x"D7",x"BC", -- 0x0200
		x"BC",x"DF",x"C2",x"79",x"78",x"3D",x"3C",x"3D", -- 0x0208
		x"87",x"87",x"87",x"87",x"87",x"8E",x"80",x"8E", -- 0x0210
		x"CE",x"00",x"8E",x"2E",x"2E",x"87",x"87",x"87", -- 0x0218
		x"3D",x"3C",x"3F",x"3E",x"3C",x"D8",x"D9",x"DA", -- 0x0220
		x"DA",x"D9",x"DB",x"7B",x"3F",x"3E",x"3D",x"3C", -- 0x0228
		x"87",x"87",x"87",x"87",x"87",x"8E",x"8E",x"8E", -- 0x0230
		x"CE",x"CE",x"8E",x"0E",x"87",x"87",x"87",x"87", -- 0x0238
		x"3E",x"3F",x"3C",x"3D",x"3D",x"D0",x"D1",x"D2", -- 0x0240
		x"D2",x"D1",x"D3",x"7E",x"3C",x"3D",x"3E",x"3F", -- 0x0248
		x"87",x"87",x"87",x"87",x"87",x"8E",x"8E",x"8E", -- 0x0250
		x"CE",x"CE",x"8E",x"2E",x"87",x"87",x"87",x"87", -- 0x0258
		x"3F",x"3E",x"3D",x"3C",x"3C",x"C8",x"C9",x"CA", -- 0x0260
		x"CA",x"C9",x"CB",x"3D",x"3D",x"3C",x"3F",x"3E", -- 0x0268
		x"87",x"87",x"87",x"87",x"87",x"8E",x"8E",x"8E", -- 0x0270
		x"CE",x"CE",x"8E",x"87",x"87",x"87",x"87",x"87", -- 0x0278
		x"3C",x"3D",x"3E",x"3F",x"3D",x"3C",x"A6",x"A7", -- 0x0280
		x"A7",x"A6",x"3D",x"3C",x"3E",x"3F",x"3C",x"3D", -- 0x0288
		x"87",x"87",x"87",x"87",x"87",x"87",x"8B",x"8B", -- 0x0290
		x"CB",x"CB",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x0298
		x"3D",x"3C",x"3F",x"3E",x"3E",x"3F",x"3C",x"3D", -- 0x02A0
		x"3C",x"3D",x"3E",x"3F",x"3F",x"3E",x"3D",x"3C", -- 0x02A8
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x02B0
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x02B8
		x"3E",x"3F",x"3C",x"3D",x"3D",x"3C",x"3F",x"3E", -- 0x02C0
		x"3F",x"3E",x"3D",x"3C",x"3C",x"3D",x"3E",x"3F", -- 0x02C8
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x02D0
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x02D8
		x"3F",x"3E",x"3D",x"3C",x"3C",x"3D",x"3E",x"3F", -- 0x02E0
		x"3E",x"3F",x"3C",x"3D",x"3D",x"3C",x"3F",x"3E", -- 0x02E8
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x02F0
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x02F8
		x"3C",x"3D",x"3E",x"3F",x"3F",x"3E",x"3D",x"3C", -- 0x0300
		x"3D",x"3C",x"3F",x"3E",x"3E",x"3F",x"3C",x"3D", -- 0x0308
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x0310
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x0318
		x"3D",x"3C",x"3F",x"3E",x"3E",x"3F",x"3C",x"3D", -- 0x0320
		x"3C",x"3D",x"3E",x"3F",x"3F",x"3E",x"3D",x"3C", -- 0x0328
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x0330
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x0338
		x"3E",x"3F",x"3C",x"3D",x"3D",x"3C",x"3F",x"3E", -- 0x0340
		x"3F",x"3E",x"3D",x"3C",x"3C",x"3D",x"3E",x"3F", -- 0x0348
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x0350
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x0358
		x"3F",x"3E",x"3D",x"3C",x"3C",x"3D",x"3E",x"3F", -- 0x0360
		x"3E",x"3F",x"3C",x"3D",x"3D",x"3C",x"3F",x"3E", -- 0x0368
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x0370
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x0378
		x"3C",x"3D",x"3E",x"3F",x"3F",x"3E",x"3D",x"3C", -- 0x0380
		x"3D",x"3C",x"3F",x"3E",x"3E",x"3F",x"3C",x"3D", -- 0x0388
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x0390
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x0398
		x"3D",x"3C",x"3F",x"3E",x"3E",x"3F",x"3C",x"3D", -- 0x03A0
		x"3C",x"3D",x"3E",x"3F",x"3F",x"3E",x"3D",x"3C", -- 0x03A8
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x03B0
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x03B8
		x"3E",x"3F",x"3C",x"3D",x"3D",x"3C",x"3F",x"3E", -- 0x03C0
		x"3F",x"3E",x"3D",x"3C",x"3C",x"3D",x"3E",x"3F", -- 0x03C8
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x03D0
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x03D8
		x"3F",x"3E",x"3D",x"3C",x"3C",x"3D",x"3E",x"3F", -- 0x03E0
		x"3E",x"3F",x"3C",x"3D",x"3D",x"3C",x"3F",x"3E", -- 0x03E8
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87", -- 0x03F0
		x"87",x"87",x"87",x"87",x"87",x"87",x"87",x"87"  -- 0x03F8
	);

begin

	p_rom : process
	begin
		wait until rising_edge(CLK);
		DATA <= ROM(to_integer(unsigned(ADDR)));
	end process;
end RTL;
