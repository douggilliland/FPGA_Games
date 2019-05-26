library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_arith.all ;
use ieee.std_logic_unsigned.all ;
entity NUM_LOCK is
	port ( resetN : in std_logic ;
	 clk : in std_logic ;
	 din : in std_logic_vector (7 downto 0);
	 make : in std_logic ;
	 break : in std_logic ;
	 key : in std_logic_vector (7 downto 0);
	 dout : out std_logic );
end NUM_LOCK;

architecture behavior of NUM_LOCK is
	 signal pressed: std_logic;
	 signal out_led: std_logic;
	 type state is (Unlocked, Locked);
-- constant key: std_logic_vector := "01110111";
begin
	process ( resetN , clk)
		variable present_state : state;
	begin
		 if resetN = '0' then
			 out_led <= '0';
			 pressed <= '0';
			 present_state := Unlocked;
		 elsif rising_edge(clk) then
			 out_led <= '0';
			 case present_state is
				 when Unlocked =>
				 out_led <= '0';
					 if ((din = key) and (make = '1') and (pressed = '0'))
					then
						 pressed <= '1';
						 out_led <= '1';
						 present_state := Locked;
					 end if ;
				 when Locked =>
					 out_led <= '1';
					 if ((din = key) and (break = '1') and (pressed = '1'))
					then
						 pressed <= '0';
						 out_led <= '0';
						 present_state := Unlocked;
				 end if ;
			 end case ;
		 end if;
		 dout <= out_led;
		end process;
end architecture;