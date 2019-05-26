library IEEE;
use IEEE.Std_logic_1164.all;
use IEEE.Numeric_Std.all;
use work.Constants.all;

entity Mechanics_tb is
end;

architecture bench of Mechanics_tb is

  component Mechanics
      Port( 
              clk: in STD_LOGIC;
              Hpos: in INTEGER range 0 to Htot - 1;
              Vpos : in INTEGER range 0 to Vtot - 1;
              buttonUR,buttonUL,buttonDR,buttonDL,buttonEnd: in STD_LOGIC;
              R,G,B: out STD_LOGIC_VECTOR (3 downto 0) );
  end component;

  signal clk: STD_LOGIC;
  signal Hpos: INTEGER range 0 to Htot - 1;
  signal Vpos: INTEGER range 0 to Vtot - 1;
  signal buttonUR,buttonUL,buttonDR,buttonDL,buttonEnd: STD_LOGIC;
  signal R,G,B: STD_LOGIC_VECTOR (3 downto 0) ;

  constant clock_period: time := 10 ns;
  signal stop_the_clock: boolean;

begin

  uut: Mechanics port map ( clk       => clk,
                            Hpos      => Hpos,
                            Vpos      => Vpos,
                            buttonUR  => buttonUR,
                            buttonUL  => buttonUL,
                            buttonDR  => buttonDR,
                            buttonDL  => buttonDL,
                            buttonEnd => buttonEnd,
                            R         => R,
                            G         => G,
                            B         => B );

  stimulus: process
  begin
    wait for 1000 ns;
    -- Put initialisation code here
    buttonUR  <= '0';
    buttonUL  <= '0';
    buttonDR  <= '0';
    buttonDL  <= '0';
    buttonEnd <= '1';
    wait for 1000 ns;
    
    buttonUR  <= '0';
    buttonUL  <= '0';
    buttonDR  <= '1';
    buttonDL  <= '0';
    buttonEnd <= '0';
  

    -- Put test bench stimulus code here

    stop_the_clock <= true;
    wait;
  end process;

  clocking: process
  begin
    while not stop_the_clock loop
      clk <= '0', '1' after clock_period / 2;
      wait for clock_period;
    end loop;
    wait;
  end process;

end;
  