library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity counterblockslow is
  
  port (
    CLK_50MHz : in  std_logic;          -- clock signal
    LED       : out std_logic);         -- LED to blink

end counterblockslow;

architecture Behavior of counterblockslow is

  signal counter : std_logic_vector(24 downto 0);  -- signal that does the counting
  signal CLK_1HZ : std_logic;           -- to drive the LED
  
begin  -- Behavior

  -- purpose: LED blinking
  -- type   : sequential
  -- inputs : CLK_50MHz, <reset>
  -- outputs:
  
  Prescaler: process (CLK_50MHz)
  begin  -- process Prescaler
  
    if CLK_50MHz'event and CLK_50MHz = '1' then  -- rising clock edge --bigger the number slower the clock
      if counter < "0011111010111100001000000" then --10011000100101101000
															  --01001100010010110100
															  --1011111010111100001000000
        counter <= counter + 1;
      else
        CLK_1Hz <= not CLK_1Hz;
        counter <= (others => '0');        
      end if;
    end if;
  end process Prescaler;
  
  LED <= CLK_1Hz;
  
end Behavior;
