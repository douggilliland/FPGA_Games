library ieee ;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity score_up_counter is
	port (
		clk : in std_logic;
		resetN : in std_logic;
		enable : in std_logic;
		score_in : in std_logic_vector (3 downto 0);
		scored : in std_logic;
		
--		score_out : out std_logic_vector (15 downto 0);
		score_out_3 : out std_logic_vector(3 downto 0);
		score_out_2 : out std_logic_vector(3 downto 0);
		score_out_1 : out std_logic_vector(3 downto 0);
		score_out_0 : out std_logic_vector(3 downto 0)
		);
end entity;

architecture score_up_counter_arch of score_up_counter is
--	signal score_keeper : std_logic_vector (15 downto 0);
	
	signal score_keeper_3 : std_logic_vector (3 downto 0);
	signal score_keeper_2 : std_logic_vector (3 downto 0);
	signal score_keeper_1 : std_logic_vector (3 downto 0);
	signal score_keeper_0 : std_logic_vector (3 downto 0);

begin
--	score_out <= score_keeper;
	process (clk, resetN)
	begin
		score_out_3 <= score_keeper_3;
		score_out_2 <= score_keeper_2;
		score_out_1 <= score_keeper_1;
		score_out_0 <= score_keeper_0;
		if (resetN = '0') then
			score_keeper_3 <= "0000";
			score_keeper_2 <= "0000";
			score_keeper_1 <= "0000";
			score_keeper_0 <= "0000";
			--score_keeper <= (others => '0');
		elsif rising_edge(clk) then
			if (enable = '1') then
				if (scored = '1' and (not(score_keeper_3 = "1001" and score_keeper_2 = "1001" and score_keeper_1 = "1001" and score_keeper_0 = "1001"))) then
				
					if (score_keeper_0 < "1010" - score_in) then
						score_keeper_0 <= score_keeper_0 + score_in;
					else
						score_keeper_0 <= score_keeper_0 + score_in - "1010";
						
						if (score_keeper_1 < "1001") then
							score_keeper_1 <= score_keeper_1 + "0001";
						else
							score_keeper_1 <= "0000";
							
							if (score_keeper_2 < "1001") then
								score_keeper_2 <= score_keeper_2 + "0001";
							else
								score_keeper_2 <= "0000";
								
								if (score_keeper_3 < "1001") then
									score_keeper_3 <= score_keeper_3 + "0001";
								else
									score_keeper_3 <= "0000";
								end if;
							end if;
						end if;
					end if;							
				end if;
			end if;
		end if;
	end process;
end architecture;
