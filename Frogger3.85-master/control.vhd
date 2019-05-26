library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity control is
	Port ( value_in: 	in STD_LOGIC_VECTOR (2 downto 0);
			Clk, Reset, break: in STD_LOGIC; --clocked by frame clk
			value_out:	out STD_LOGIC_VECTOR (2 downto 0));
end control;

architecture Behavioral of control is 
	
	type control_state is (READ_IN_1, NO_READ_IN);
	
	signal state, next_state : control_state;
	
begin
	
	control_reg: process(Reset,Clk)
	begin
		if (Reset='1') then --asyn reset
			--START is the reset/start state
			state<=READ_IN_1;
		elsif (rising_edge(Clk)) then
			state <= next_state;
		end if;
	end process;
			
get_next_state: process(value_in, state)
begin
	case state is

	when READ_IN_1 =>
		if (value_in(2) = '1') then	--set next state to 'no read' if a valid key is pressed
			next_state <= NO_READ_IN;
		else
			next_state <= READ_IN_1;
		end if;
	when NO_READ_IN =>
		if (break = '1') then		--keep 'no read' until the break code is received, meaning the key has released
			next_state <= READ_IN_1;
		else
			next_state <= NO_READ_IN;
		end if;
	end case;
end process; 

get_ctrl_out: process(state, value_in)
begin
case state is

when READ_IN_1 =>	--output the valid key value
value_out<=value_in;

when NO_READ_IN=>
value_out<="000";	--output a meaning less key value
end case;



end process;

end Behavioral;