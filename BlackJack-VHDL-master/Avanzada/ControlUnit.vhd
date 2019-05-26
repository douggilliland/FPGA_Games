----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:57:39 12/12/2015 
-- Design Name: 
-- Module Name:    ControlUnit - Behavioral 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlUnit is
 port (
    clk                   : in  std_logic;                             -- clock
    rst_n                 : in  std_logic;                             -- reset
	 inicio                : in  std_logic;                             -- señal de inicio
	 otra_carta            : in  std_logic;                             -- otra carta
	 plantarse             : in  std_logic;                             -- plantarse
	 status                : in  std_logic;
	 maquina_lista         : out std_logic;                             -- maquina lista
	 ctrl                  : out std_logic_vector(8 downto 0));         -- Control

end ControlUnit;

architecture arch_ControlUnit of ControlUnit is

  -- señal estados
  type t_st is (s0, s1, s2, s3);
  signal current_state, next_state : t_st;
  
  -- señales control
  	signal control_aux : std_logic_vector (8 downto 0);
	alias we_ram  : std_logic is control_aux (0);
	alias ld_acc  : std_logic is control_aux (1);
	alias ld_per  : std_logic is control_aux (2);
	alias rst_per : std_logic is control_aux (3);
	alias rst_acc : std_logic is control_aux (4);
	alias rst_zer : std_logic is control_aux (5);
	alias rst_con : std_logic is control_aux (6);
	alias ld_zero : std_logic is control_aux (7);
	alias ce_cont : std_logic is control_aux (8);
	
	-- señales status
	
	signal perdida : std_logic;

begin
		
	perdida <= status;
	ctrl <= control_aux;



	p_next_state : process (current_state, inicio, plantarse, otra_carta, perdida) is
		begin  -- process p_next_state

		control_aux <= (others => '0');
		maquina_lista <= '0';
			
			case current_state is
			
				when s0 =>
				
					maquina_lista <= '1';
					rst_con <= '1';
					rst_acc <= '1';
					rst_zer <= '1';
					
					if inicio = '1' then
						next_state <= s1;
					else
						next_state <= s0;
					end if;
					
				when s1 =>
				
					rst_per <= '1';
					ce_cont <= '1';
						if plantarse = '0' then
							next_state <= s0;
						else
							if otra_carta = '0' then
								next_state <= s2;
							else
								next_state <= s1;
							end if;
						end if;
			
					
				when s2 => -- mantengo el estado s2 
					if(otra_carta = '0') then
						next_state <= s2;
					else
						next_state <= s3;
					end if;
					
				when s3 =>
				
					ld_acc  <= '1';
					ld_zero <= '1';
					ld_per <= '1';
					we_ram <= '1';
					if perdida = '1' then
						next_state <= s0;
					else
						next_state <= s1;
					end if;
					
				when others => null;
			end case;
		end process p_next_state;




 p_status_reg : process (clk, rst_n) is
  begin
    if rst_n = '1' then
      current_state <= s0;
    elsif rising_edge(clk) then
      current_state <= next_state;
    end if;
  end process p_status_reg;



end arch_ControlUnit;

