----------------------------------
-- Generic Low Pass Filter -------
-- With shift register    --------
----------------------------------
library ieee ;
use ieee.std_logic_1164.all ;
use ieee.STD_LOGIC_arith.all;
use ieee.STD_LOGIC_UNSIGNED.all;

entity lpf is
generic ( width : integer := 4 ) ;
port ( resetN,clk,din : in std_logic ;
         dout : out std_logic ) ;
end lpf ;

architecture arc_lpf of lpf is
signal shiftreg : std_logic_vector ((width-1) downto 0);

begin
process(clk, resetN)
   begin
       if resetN = '0' then
                shiftreg <= (others => '0');
       elsif rising_edge(clk) then
	shiftreg ((width-1) downto 1) <=shiftreg((width-2) downto 0);
                 shiftreg(0) <= din;
      end if;
end process;

process(clk, resetN)
    variable count : integer range 0 to width;
begin
        if resetN = '0' then
                  dout <= '0';
                  count := 0;
        elsif rising_edge(clk) then
                  count := 0;
                  for i in (width-1) downto 0 loop
                        if (shiftreg(i) = '1') then
                             count := count + 1;
                        end if;
                 end loop;
                 if (count = 0) then
                        dout <= '0';
                 elsif (count = width) then
                        dout <= '1';
                 end if;
         end if;
end process;

end	arc_lpf;
