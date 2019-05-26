library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ps2_keyboard is
  Generic(
    clk_freq              : integer := 100_000_000; --system clock frequency in Hz
    debounce_counter_size : integer := 9);         --set such that (2^size)/clk_freq = 5us (size = 8 for 50MHz)
  Port(
    clk          : in  std_logic;                     --system clock
    PS2clk      : in std_logic;                     --clock signal from PS/2 keyboard
    PS2data     : in std_logic;                     --data signal from PS/2 keyboard
--    ps2_code_new : OUT STD_LOGIC;                     --flag that new PS/2 code is available on ps2_code bus
    ps2_code     : out std_logic_vector(7 downto 0)); --code received from PS/2
end ps2_keyboard;

architecture Behavioral of ps2_keyboard is
  signal sync_ffs     : std_logic_vector(1 downto 0);       --synchronizer flip-flops for PS/2 signals
  signal ps2_clk_int  : std_logic;                          --debounced clock signal from PS/2 keyboard
  signal ps2_data_int : std_logic;                          --debounced data signal from PS/2 keyboard
  signal ps2_word     : std_logic_vector(10 downto 0);      --stores the ps2 data word
  signal error        : std_logic;                          --validate parity, start, and stop bits
  signal count_idle   : integer range 0 to clk_freq/18_000; --counter to determine PS/2 is idle
  
  --declare debounce component for debouncing PS2 input signals
  component debounce is
    generic (
      counter_size : integer); --debounce period (in seconds) = 2^counter_size/(clk freq in Hz)
    port (
      clk    : in  std_logic;  --input clock
      button : in  std_logic;  --input signal to be debounced
      result : out std_logic); --debounced signal
  end component;
begin

  --synchronizer flip-flops
  process (clk)
  begin
    if (clk'event and clk = '1') then  --rising edge of system clock
      sync_ffs(0) <= ps2clk;           --synchronize PS/2 clock signal
      sync_ffs(1) <= ps2data;          --synchronize PS/2 data signal
    end if;
  end process;

  --debounce PS2 input signals
  debounce_ps2_clk: debounce
    generic map(counter_size => debounce_counter_size)
    port map(clk => clk, button => sync_ffs(0), result => ps2_clk_int);
  debounce_ps2_data: debounce
    generic map(counter_size => debounce_counter_size)
    port map(clk => clk, button => sync_ffs(1), result => ps2_data_int);

  --input PS2 data
  process (ps2_clk_int)
  begin
    if (ps2_clk_int'event and ps2_clk_int = '0') then    --falling edge of PS2 clock
      ps2_word <= ps2_data_int & ps2_word(10 downto 1);   --shift in PS2 data bit
    end if;
  end process;
    
  --verify that parity, start, and stop bits are all correct
  error <= not (not ps2_word(0) and ps2_word(10) and (ps2_word(9) xor ps2_word(8) xor
        ps2_word(7) xor ps2_word(6) xor ps2_word(5) xor ps2_word(4) xor ps2_word(3) xor 
        ps2_word(2) xor ps2_word(1)));  

  --determine if PS2 port is idle (i.e. last transaction is finished) and output result
  process(clk)
  begin
    if (clk'event and clk = '1') then           --rising edge of system clock
    
      if (ps2_clk_int = '0') then                 --low PS2 clock, PS/2 is active
        count_idle <= 0;                           --reset idle counter
      elsif (count_idle /= clk_freq/18_000) then  --PS2 clock has been high less than a half clock period (<55us)
          count_idle <= count_idle + 1;            --continue counting
      end if;
      
      if (count_idle = clk_freq/18_000 and error = '0') then  --idle threshold reached and no errors detected
--        ps2_code_new <= '1';                                --set flag that new PS/2 code is available
           ps2_code <= ps2_word(8 downto 1);                      --output new PS/2 code                                 --PS/2 port active or error detected
--            ps2_new_temp <= '0';                             --set flag that PS/2 transaction is in progress
      end if;
        end if;
      end process;                         
end Behavioral;
