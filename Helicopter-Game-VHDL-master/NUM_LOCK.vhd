library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_signed.all;
use ieee.std_logic_arith.all;
use ieee.numeric_std.all;

entity NUM_LOCK is
port ( resetN : in std_logic ;
 clk : in std_logic ;
 din : in std_logic_vector (8 downto 0);
 make : in std_logic ;
 break : in std_logic ;
 dout : out std_logic );
end NUM_LOCK;
architecture behavior of NUM_LOCK is
 signal pressed: std_logic;
 signal out_led: std_logic;
begin
 dout <= out_led;
 process ( resetN , clk)
 begin
 if resetN = '0' then
 out_led <= '0';
 pressed <= '0';
 elsif rising_edge(clk) then
 if (din = "001110101") and (make = '1') and (pressed ='0')
then
 pressed <= '1';
 out_led <= '1';
 elsif (din = "001110101") and (break = '1') then
 out_led <= '0';
 pressed <= '0';
 end if;
 end if;
 end process;
end architecture;