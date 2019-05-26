
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

entity log_routine is
   Port ( 
        Reset : in std_logic;
        frame_clk : in std_logic;
        CounterPeriod: in std_logic_vector(9 downto 0);
        logX : out std_logic_vector(29 downto 0);
        logY : out std_logic_vector(9 downto 0));
end log_routine;

architecture Behavioral of log_routine is

signal log_X_pos, log_X_motion, log_Y_pos, log_Y_motion : std_logic_vector(9 downto 0);
signal log2_X_pos, log2_X_motion : std_logic_vector(9 downto 0);
signal log3_X_pos, log3_X_motion : std_logic_vector(9 downto 0);

signal counter : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(20, 10);  --Step size on the X axis


signal log_Size : std_logic_vector(9 downto 0);
--signal frame_clk_div : std_logic_vector(5 downto 0);

constant log_X_start : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(20, 10);  --start position on the X axis
constant log2_X_start : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(220, 10);  --start position on the X axis
constant log3_X_start : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(420, 10);  --start position on the X axis


constant log_Y_start : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(220, 10);  --start position on the Y axis                             
constant log_X_Step   : std_logic_vector(9 downto 0) := CONV_STD_LOGIC_VECTOR(40, 10);  --Step size on the X axis

signal PeriodSig: std_logic_vector(9 downto 0);

begin
  log_Size <= CONV_STD_LOGIC_VECTOR(20, 10); -- assigns the value 4 as a 10-digit binary number, ie "0000000100"
  PeriodSig<=CounterPeriod;
-------------------------------------------------


  Move_log: process(Reset, frame_clk, log_Size,log_X_motion,log_Y_motion)
  begin
    if(Reset = '1') then   --Asynchronous Reset
      log_X_Motion <= CONV_STD_LOGIC_VECTOR(0, 10);
      log_Y_Motion <= CONV_STD_LOGIC_VECTOR(0, 10);
      log_X_pos <= log_X_start;
      log_Y_Pos <= log_Y_start;
      counter <= CONV_STD_LOGIC_VECTOR(0, 10);
      
      log2_X_Motion <= CONV_STD_LOGIC_VECTOR(0, 10);
      log2_X_pos <= log2_X_start;
     
      log3_X_Motion <= CONV_STD_LOGIC_VECTOR(0, 10);
      log3_X_pos <= log3_X_start;
      
       elsif(rising_edge(frame_clk)) then
			
					counter<=counter+'1';
					if(counter=PeriodSig)then --if the counter reaches the period signal, change log position
						log_X_pos <= log_X_pos + log_X_Step;
						log2_X_pos <= log2_X_pos + log_X_Step;					
						log3_X_pos <= log3_X_pos + log_X_Step;
						counter<= CONV_STD_LOGIC_VECTOR(0, 10);
					end if;
					
					if (log_X_pos= (CONV_STD_LOGIC_VECTOR(700, 10)) )then --reset log if it gets the edge of the screen
						log_X_pos<=CONV_STD_LOGIC_VECTOR(20, 10);
					end if;

					if (log2_X_pos= (CONV_STD_LOGIC_VECTOR(700, 10)) )then
						log2_X_pos<=CONV_STD_LOGIC_VECTOR(20, 10);
					end if;
										
					if (log3_X_pos= (CONV_STD_LOGIC_VECTOR(700, 10)) )then
						log3_X_pos<=CONV_STD_LOGIC_VECTOR(20, 10);
					end if;					
      
	end if; 
	
end process Move_log;

  logX <= log_X_Pos & log2_X_pos & log3_X_pos;
  logY <= log_Y_Pos;
--  carS <= car_Size;
 
end Behavioral;      
	