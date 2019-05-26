library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



entity keyboard is							-- This is the register that will hold the value of the key as it comes in. 
	Port(Clk, psClk, psData, Reset: in std_logic;
			KeyCode : out std_logic_vector(7 downto 0);
			keyfordisplay : out std_logic_vector(7 downto 0);
			break : out std_logic);
end keyboard;
	
	
	architecture Behavioral of keyboard is 
	
		component Dflipflop is
			Port(D, clk, rs: in std_logic;
					Q: out std_logic);
			end component;
			
			
		signal reg_value : std_logic_vector(21 downto 0);
		signal Clockby512: std_logic_vector (8 downto 0);
		signal Q1: std_logic;
		signal Q2: std_logic;
		signal Shift_En: std_logic;
		signal key: std_logic_vector(7 downto 0);
	begin
	
		Division_512: process (Clk)
		begin
			if (Reset='1') then --asyn reset
				Clockby512 <= "000000000"; --reset all down to 0
			elsif (rising_edge(Clk)) then
				Clockby512<=Clockby512+'1';
			end if;
		end process;
		
		DFF1: Dflipflop
		Port map( 
					D=>psClk,
					clk=>Clockby512(8),
					rs=> Reset,
					Q=>Q1);
--					
		DFF2: Dflipflop
		Port map(
					D=>Q1,
					clk=>Clk,
					rs=>Reset,
					Q=>Q2);

					
		Enable_Maker : process (Q1, Q2)	
		begin		
		if((Q1='0')AND(Q2='1'))
			then Shift_En<='1';
			else
			Shift_En<='0';
		end if;
		end process;
		
		operate_reg : process (psClk, Reset, Shift_En, psData)
		begin 
			if (Reset='1') then --asyn reset
				reg_value <= "0000000000000000000000"; --reset all down to 0
				key<= "00000000";
			elsif (rising_edge(Clk)) then
				if (Shift_En='1') then
					reg_value <= psData & reg_value(21 downto 1);
				else
					reg_value<= reg_value;
				end if;
			end if;
			
		if	reg_value(8 downto 1) = "11110000"			--Generate output as long as break code is not detected
			then
			keyCode(7 downto 0)<="00000000";
			break<= '1';
			else
			keyCode(7 downto 0) <= reg_value(19 downto 12);
			break<='0';
			
			
		end if;
		
			if( (reg_value(19 downto 12) /= x"1D") OR
				(reg_value(19 downto 12) /= x"1B") OR 
				(reg_value(19 downto 12) /= x"1C") OR 
				(reg_value(19 downto 12) /= x"23") )
				then
				key <= key;
			else
				key <= reg_value(19 downto 12);
			end if;
		
			keyfordisplay<= key; 
	end process;
	end Behavioral;


