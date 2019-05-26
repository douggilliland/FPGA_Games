--lol



--lol



--lol...



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity score is
    Port ( ref_clk      : in  STD_LOGIC;
	        reset        : in  STD_LOGIC;
			  enemy_out    : in  STD_LOGIC;
           first_digit  : out  STD_LOGIC_VECTOR (3 downto 0);
			  second_digit : out  STD_LOGIC_VECTOR (3 downto 0);
			  third_digit  : out  STD_LOGIC_VECTOR (3 downto 0);
			  fourth_digit : out  STD_LOGIC_VECTOR (3 downto 0)
--			  first_digit_f  : out  STD_LOGIC_VECTOR (3 downto 0);
--			  second_digit_f: out  STD_LOGIC_VECTOR (3 downto 0);
--			  third_digit_f  : out  STD_LOGIC_VECTOR (3 downto 0);
--			  fourth_digit_f : out  STD_LOGIC_VECTOR (3 downto 0)
			  );
end score;

architecture Behavioral of score is
signal counter : STD_LOGIC_VECTOR (6 downto 0):="0000000";
signal score : STD_LOGIC_VECTOR (13 downto 0):="00000000000000";
signal score2 : STD_LOGIC_VECTOR(13 downto 0);
signal enemy_out_flag : STD_LOGIC := '0';
signal first_digit_s : std_logic_vector(3 downto 0);
signal second_digit_s : std_logic_vector(3 downto 0);
signal third_digit_s : std_logic_vector(3 downto 0);
signal fourth_digit_s : std_logic_vector(3 downto 0);
--signal first_digit_fs : std_logic_vector(3 downto 0);
--signal second_digit_fs : std_logic_vector(3 downto 0);
--signal third_digit_fs : std_logic_vector(3 downto 0);
--signal fourth_digit_fs : std_logic_vector(3 downto 0);
signal state : std_logic ;
signal new_state : std_logic := '0';

begin

process(ref_clk,reset,enemy_out) 
    variable score_int : integer := 0;
	 variable resto1    : integer := 0;
	 variable resto2    : integer := 0;
    variable resto3    : integer := 0;
begin
	
	 

	 score2 <= "00000000000000";
	 
	 state<=new_state;
	 
	 case state is 
	 
	    when '0' =>
		 
			 score_int := conv_integer(score2);
			 fourth_digit_s<=std_logic_vector(to_unsigned(score_int/1000 ,4));
			 resto1 := score_int rem 1000;
			 third_digit_s <=  std_logic_vector(to_unsigned (resto1/100,4));
			 resto2 := resto1 rem 100;
			 second_digit_s <= std_logic_vector(to_unsigned (resto2/10,4));
			 resto3 := resto2 rem 10;
			 first_digit_s<= std_logic_vector(to_unsigned (resto3/1,4));
			 
			 if rising_edge(reset) then
			   new_state<= '1';
			 end if;
			 
		when '1' =>
		
		 if rising_edge(ref_clk) then
					 if counter < "0001111" then
						  counter <= counter + 1;
					 else
						  counter <= (others => '0');
						  score <= score + 1;
					 end if;
					 if enemy_out_flag = '1' then
						  score <= score + 20;
						  enemy_out_flag <= '0';
					 end if;
				end if;
				if enemy_out = '1' then
				  enemy_out_flag <= '1';
				end if;
				
				score2 <= score;
				
			 score_int := conv_integer(score2);
			 fourth_digit_s<=std_logic_vector(to_unsigned(score_int/1000 ,4));
			 resto1 := score_int rem 1000;
			 third_digit_s <=  std_logic_vector(to_unsigned (resto1/100,4));
			 resto2 := resto1 rem 100;
			 second_digit_s <= std_logic_vector(to_unsigned (resto2/10,4));
			 resto3 := resto2 rem 10;
			 first_digit_s<= std_logic_vector(to_unsigned (resto3/1,4));
			 
			 if falling_edge(reset) then 
			 score <= (others=>'0');
			 new_state<='0';
				
			end if;
			
			
			when others =>
			
				 score_int := conv_integer(score2);
			 fourth_digit_s<=std_logic_vector(to_unsigned(score_int/1000 ,4));
			 resto1 := score_int rem 1000;
			 third_digit_s <=  std_logic_vector(to_unsigned (resto1/100,4));
			 resto2 := resto1 rem 100;
			 second_digit_s <= std_logic_vector(to_unsigned (resto2/10,4));
			 resto3 := resto2 rem 10;
			 first_digit_s<= std_logic_vector(to_unsigned (resto3/1,4));
			 
			 if rising_edge(reset) then
			   new_state<= '1';
			 end if;
			 
		end case;
			
			
	  
	 
	 
	 
--     if reset ='1' then
--	  
--	    --B
--        if rising_edge(ref_clk) then
--				 if counter < "0001111" then
--					  counter <= counter + 1;
--				 else
--					  counter <= (others => '0');
--					  score <= score + 1;
--				 end if;
--				 if enemy_out_flag = '1' then
--				     score <= score + 20;
--					  enemy_out_flag <= '0';
--			    end if;
--         end if;
--		   if enemy_out = '1' then
--		     enemy_out_flag <= '1';
--	      end if;
--			
--		   score2 <= score;
--			
--			--
--    end if;
--	
--	 
--	 if reset = '0' then
--	 
--	   score2<= score;
--	   --counter <= (others=> '0'); 
--	   --score <= (others=> '0');
--		 
--	 end if;
--	 
--	 
--	
--   --A
--    score_int := conv_integer(score2);
--    fourth_digit_s<=std_logic_vector(to_unsigned(score_int/1000 ,4));
--    resto1 := score_int rem 1000;
--    third_digit_s <=  std_logic_vector(to_unsigned (resto1/100,4));
--    resto2 := resto1 rem 100;
--    second_digit_s <= std_logic_vector(to_unsigned (resto2/10,4));
--    resto3 := resto2 rem 10;
--    first_digit_s<= std_logic_vector(to_unsigned (resto3/1,4));
--  
end process;
first_digit<= first_digit_s;
second_digit<= second_digit_s;
third_digit<= third_digit_s;
fourth_digit<= fourth_digit_s;

--
--first_digit_f<= first_digit_fs;
--second_digit_f<= second_digit_fs;
--third_digit_f<= third_digit_fs;
--fourth_digit_f<= fourth_digit_fs;



end Behavioral;

