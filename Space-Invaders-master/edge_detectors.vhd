library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity edgedetectorleft is
      port ( clk, reset: in  STD_LOGIC;
             signal_inleft: in  STD_LOGIC;
             outputleft: out  STD_LOGIC);
end edgedetectorleft;

architecture ed of edgedetectorleft is
     signal signal_d: STD_LOGIC;
begin
    process(clk, reset)
    begin
	 if reset = '1' then
		signal_d <= '0';
         elsif clk= '1' and clk'event then
               signal_d<=signal_inleft;
         end if;
    end process;
    outputleft <= signal_d;
end ed;

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity edgedetectorright is
      port ( clk, reset: in  STD_LOGIC;
             signal_inright: in  STD_LOGIC;
             outputright: out  STD_LOGIC);
end edgedetectorright;

architecture gf of edgedetectorright is
     signal signal_d: STD_LOGIC;
begin
        process(clk, reset)
        begin
 if reset = '1' then
    signal_d <= '0';
     elsif clk= '1' and clk'event then
           signal_d<=signal_inright;
     end if;
end process;
outputright <= signal_d;
end gf;
