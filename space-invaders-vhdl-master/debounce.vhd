library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity debounce is
  generic (
    counter_size  :  integer := 10); --counter size (19 bits gives 10.5ms with 50MHz clock)
  port (
    clk     : in  std_logic;  --input clock
    button  : in  std_logic;  --input signal to be debounced
    result  : out std_logic); --debounced signal
end debounce;

architecture Behavioral of debounce is
  signal flipflops   : std_logic_vector(1 downto 0); --input flip flops
  signal counter_set : std_logic;                    --sync reset to zero
  signal counter_out : std_logic_vector(counter_size downto 0) := (others => '0'); --counter output

begin
  counter_set <= flipflops(0) xor flipflops(1);   --determine when to start/reset counter
  
  process(clk)
  begin
    if (clk'event and clk = '1') then
      flipflops(0) <= button;
      flipflops(1) <= flipflops(0);
      if (counter_set = '1') then                  --reset counter because input is changing
        counter_out <= (others => '0');
      elsif (counter_out(counter_size) = '0') then --stable input time is not yet met --if the input is the same for counter_size amount of ticks then output that value
        counter_out <= counter_out + 1;                                               --this prevents errors or glitches coming from the keyboard and results with a stable input
      else                                        --stable input time is met
        result <= flipflops(1);
      end if;    
    end if;
  end process;
end Behavioral;
