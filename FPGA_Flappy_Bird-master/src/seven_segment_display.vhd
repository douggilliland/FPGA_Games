library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;  --need to use for unsigned

entity seven_segment_display is
generic(COUNTER_BITS: natural := 15);  --Indicates number of bits on segment counter to count up to (determines speed)
	port(
	clk: in std_logic;
	data_in: in std_logic_vector(15 downto 0);  --Data to display
	dp_in: in std_logic_vector(3 downto 0);  --Value of 4 decimal points
	blank: in std_logic_vector(3 downto 0);  --Tells which digits are blank
	seg: out std_logic_vector(6 downto 0);  --Segment control signals
	dp: out std_logic;  --Digit point control signal
	an: out std_logic_vector(3 downto 0)  --Segment anode control signals
	);
end seven_segment_display;

architecture arch of seven_segment_display is
	signal counter_value: std_logic_vector(COUNTER_BITS-1 downto 0) := (others=>'0');  --sets the initial value to 0
	signal anode_select: std_logic_vector(1 downto 0);
	signal decode: std_logic_vector(3 downto 0);
begin
	process(clk)
	begin
		if (clk'event and clk='1') then
			counter_value <= std_logic_vector(unsigned(counter_value) + 1);
		end if;
	end process;
			
	anode_select <= counter_value(COUNTER_BITS-1 downto COUNTER_BITS-2);
	
	with anode_select select
		an <=
			"111" & blank(0) when "00",  --Determines when the display should be blank (1 is blank)
			"11" & blank(1) & '1' when "01",
			'1' & blank(2) & "11" when "10",
			blank(3) & "111" when others;
	
	with anode_select select  --Determines which data set to send to the seven segment decoder
		decode <=
			data_in(3 downto 0) when "00",
			data_in(7 downto 4) when "01",
			data_in(11 downto 8) when "10",
			data_in(15 downto 12) when others;
	
	with anode_select select  --Determines which decimal point to light up
		dp <=
			not dp_in(0) when "00",
			not dp_in(1) when "01",
			not dp_in(2) when "10",
			not dp_in(3) when others;
			
	with decode select  --determines which parts to light up
	seg <= 	"1000000" when "0000",  -- 0
				"1111001" when "0001",  -- 1
				"0100100" when "0010",  -- 2
				"0110000" when "0011",  -- 3
				"0011001" when "0100",  -- 4
				"0010010" when "0101",  -- 5
				"0000010" when "0110",  -- 6
				"1111000" when "0111",  -- 7
				"0000000" when "1000",  -- 8
				"0010000" when "1001",  -- 9
				"0001000" when "1010",  -- A
				"0000011" when "1011",  -- B
				"1000110" when "1100",  -- C
				"0100001" when "1101",  -- D
				"0000110" when "1110",  -- E
				"0001110" when others;  -- F
	
end arch;