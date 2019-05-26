----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:51:53 04/21/2015 
-- Design Name: 
-- Module Name:    imm_generator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity imm_generator is
    Port ( spaceship_enable   : in  STD_LOGIC;
           obj_rgb            : in  STD_LOGIC;
			  obstacle1_rgb      : in  STD_LOGIC;
			  obstacle1_enable   : in  STD_LOGIC;
			  obstacle2_rgb      : in  STD_LOGIC;
			  obstacle2_enable   : in  STD_LOGIC;
			  obstacle3_rgb      : in  STD_LOGIC;
			  obstacle3_enable   : in  STD_LOGIC;
			  laser_on           : in  STD_LOGIC;
			  enemy_on           : in  STD_LOGIC;
			  shoot_on           : in  STD_LOGIC;
			  shoot_rgb          : in  STD_LOGIC;
			  start              : in  STD_LOGIC;
           VIDON              : in  STD_LOGIC;
			  game_over_enable   : in  STD_LOGIC;
			  game_over_on       : in  STD_LOGIC;
           game_over_rgb      : in  STD_LOGIC;
			  first_digit_on     : in  STD_LOGIC;
			  second_digit_on    : in  STD_LOGIC;
			  third_digit_on     : in  STD_LOGIC;
			  fourth_digit_on    : in  STD_LOGIC;
			  first_digit_rgb    : in  STD_LOGIC;
			  second_digit_rgb   : in  STD_LOGIC;
			  third_digit_rgb    : in  STD_LOGIC;
			  fourth_digit_rgb   : in  STD_LOGIC;
			  laser_bar_rgb      : in  STD_LOGIC;
			  laser_bar_on       : in  STD_LOGIC;
			  Rom_laser_text_rgb : in  STD_LOGIC;
			  Rom_laser_text_on  : in  STD_LOGIC;
			  SCORE_ROM_on       : in  STD_LOGIC;
			  SCORE_ROM_rgb      : in  STD_LOGIC;
			  spaceship_armor    : in  STD_LOGIC;
			  mitra_rgb          : in  STD_LOGIC_VECTOR  (3 downto 0);
           red                : out  STD_LOGIC_VECTOR (4 downto 0);
           green              : out  STD_LOGIC_VECTOR (5 downto 0);
           blue               : out  STD_LOGIC_VECTOR (4 downto 0) );
end imm_generator;

architecture Behavioral of imm_generator is
begin

process(VIDON, spaceship_enable, obstacle1_enable, obstacle1_rgb, obstacle2_enable, obstacle2_rgb, obstacle3_enable, obstacle3_rgb, laser_on, enemy_on, shoot_rgb, game_over_enable, game_over_rgb, laser_bar_rgb, Rom_laser_text_rgb, SCORE_ROM_rgb)
begin

    red <= (others => '0');
	 green <= (others => '0');
	 blue <= (others => '0');
	 

		  if VIDON = '1' then
		  
		      red <= (others => '0');
				blue <= "00111";
			   green <= (others => '0');
				
				if start = '1' then
				    red <= (others => '0');
				    blue <= "00111";
			       green <= (others => '0');
					 
				elsif game_over_on = '0' then
					 
					 if spaceship_enable = '1' then
		  
		             if obj_rgb = '1' then
				           red <= (others => '1');
						     green <= (others => '0');
						     blue <= (others => '0');
						 elsif spaceship_armor = '1' then
						     red <= (others => '1');
						     green <= (others => '1');
						     blue <= (others => '0');
					    end if;
					 
					end if;
					
				  if obstacle1_enable = '1' then
					
					 if obstacle1_rgb = '1' then
							  red <= "00011";
							  blue <= "11111";
							  green <= "011111";
					 end if;
					end if;
					
					if obstacle2_enable = '1' then
					
						 if obstacle2_rgb = '1' then
							  red <= "01111";
							  blue <= "00011";
							  green <= "011111";
						end if;
					end if;

			  
					if obstacle3_enable = '1' then
					
						 if obstacle3_rgb = '1' then
							  red <= "01111";
							  blue <= "11111";
							  green <= "011111";
						end if;
					end if;
			  
					if laser_on = '1' then
						 red <= (others => '1');
						 green <= (others => '1');
						 blue <= (others => '1');
					end if;
					
					if enemy_on = '1' then
						 red <= (others => '0');
						 green <= (others => '1');
						 blue <= (others => '1');
					end if;
					
					if shoot_on = '1' then
					    if shoot_rgb = '1' then
						     red <= (others => '1');
						     green <= (others => '1');
						     blue <= (others => '0');
						 end if;
					end if;
				   
					
					if first_digit_on = '1'  and first_digit_rgb = '1' then
				  
				     red <=(others=>'0');
				     green <= "111111";
				     blue <= (others=>'0');
				  end if;
				  
				  
				  if second_digit_on = '1'  and second_digit_rgb = '1' then
				  
				     red <=(others=>'0');
				     green <= "111111";
				     blue <= (others=>'0');
				  end if;
				  
				  if third_digit_on = '1'  and third_digit_rgb = '1' then
				  
				     red <=(others=>'0');
				     green <= "111111";
				     blue <= (others=>'0');
				  end if;
					 
					 
				 if fourth_digit_on = '1'  and fourth_digit_rgb = '1' then
				  
				     red <=(others=>'0');
				     green <= "111111";
				     blue <= (others=>'0');
				  end if;
				  
				  if Rom_laser_text_on = '1' then
				      
						if Rom_laser_text_rgb = '1' then
						    red <=(others=>'0');
				          green <= "111111";
				          blue <= (others=>'0');
						end if;
						
				  end if;
				  
				  if SCORE_ROM_on = '1' then
				      
						if SCORE_ROM_rgb = '1' then
						    red <=(others=>'0');
				          green <= "111111";
				          blue <= (others=>'0');
						end if;
						
				  end if;
				  
				  if laser_bar_on = '1' then
				      if laser_bar_rgb = '1' then
				          red <= "11111";
				          green <= (others=>'0');
				          blue <= (others=>'0');
						else
						    red <= (others=>'0');
				          green <= "111111";
				          blue <= (others=>'0');
				      end if;
				  end if;
				  
				  if mitra_rgb(0) = '1' then
				      	 red <= "11111";
				          green <= (others=>'0');
				          blue <= (others=>'0');
				  end if;
				  
				  if mitra_rgb(1) = '1' then
				      	 red <= "11111";
				          green <= (others=>'0');
				          blue <= (others=>'0');
				  end if;
				  
				  if mitra_rgb(2) = '1' then
				      	 red <= "11111";
				          green <= (others=>'0');
				          blue <= (others=>'0');
				  end if;
				  
				  if mitra_rgb(3) = '1' then
				      	 red <= "11111";
				          green <= (others=>'0');
				          blue <= (others=>'0');
				  end if;
				
				elsif game_over_enable = '1' then
			        	
						 red <= (others => '0');
				       blue <= "00111";
			          green <= (others => '0');	
					     if game_over_rgb = '1' then
					      red <= (others => '1');
						   green <= (others => '0');
						   blue <= (others => '0');
						  end if;
                    			  
				 if first_digit_on = '1'  and first_digit_rgb = '1' then
				  
				     red <= "11111";
				     green <=(others=>'0');
				     blue <= (others=>'0');
			
   			end if;
				  
				  
				  if second_digit_on = '1'  and second_digit_rgb = '1' then
				  
				     red <=(others=>'0');
				     green <= "111111";
				     blue <= (others=>'0');
				  end if;
				  
				  if third_digit_on = '1'  and third_digit_rgb = '1' then
				  
				     red <=(others=>'0');
				     green <= "111111";
				     blue <= (others=>'0');
				  end if;
					 
					 
				 if fourth_digit_on = '1'  and fourth_digit_rgb = '1' then
				  
				     red <=(others=>'0');
				     green <= "111111";
				     blue <= (others=>'0');
				  end if;
				  
					 
			   end if;
				
			
				
	     end if;
		  
end process;

end Behavioral;








