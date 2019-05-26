library ieee ;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity hp_down_counter is
	port(
		clk : 					in std_logic;
		resetN : 				in std_logic;
		lives_num_start : 	in std_logic_vector(3 downto 0);
		died : 					in std_logic;
		enable : 				in std_logic;
		lives_num_current : 	out std_logic_vector(3 downto 0);
		game_over : 			out std_logic);
end hp_down_counter;

architecture hp_down_counter_arch of hp_down_counter is
	signal current_lives_sig : std_logic_vector(3 downto 0);
begin
	
	process (clk, resetN, died)
	begin
		lives_num_current <= current_lives_sig;
		if (resetN = '0') then
			current_lives_sig <= lives_num_start;
			game_over <= '0';
		elsif rising_edge(clk) then
			if (enable = '1') then
				if (died = '1') then
					if (current_lives_sig /= "0000") then
						game_over <= '0';
						current_lives_sig <= current_lives_sig - 1;
					end if;
				end if;
			end if;
			if (current_lives_sig = "0000") then	
				game_over <= '1';
			end if;

		end if;

--		if (current_lives_sig = "0000") then	
--			game_over <= '1';
--		end if;

	end process;
end hp_down_counter_arch;