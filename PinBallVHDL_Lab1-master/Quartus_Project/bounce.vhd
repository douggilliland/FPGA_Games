library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity bounce is
	port(
			CLK : 					in std_logic;
			resetN : 				in std_logic;
			enable : 				in std_logic;
			end_of_frame : 		in std_logic;
			ball_draw_req : 		in std_logic;
			was_hit_in :			in std_logic;
			ballSpeedX : 			in  integer;
			ballSpeedY : 			in integer;
			bounce_data_in : 		in std_logic_vector (4 downto 0);
			was_hit_out:			out std_logic;
			bounce_enable : 		out std_logic;
			bounce_data_out : 	out std_logic_vector (4 downto 0);
			is_dead : 				out std_logic			
	);
end entity;


architecture behav of bounce is
	constant no_bounce			 		: std_logic_vector (4 downto 0) := "00000";
	constant horizontal_floor 			: std_logic_vector (4 downto 0) := "00001";
	constant left_down_slope 			: std_logic_vector (4 downto 0) := "00010";
	constant left_vertical_wall 		: std_logic_vector (4 downto 0) := "00011";
	constant left_up_slope 				: std_logic_vector (4 downto 0) := "00100";
	constant horizontal_ceiling 		: std_logic_vector (4 downto 0) := "00101";
	constant right_up_slope 			: std_logic_vector (4 downto 0) := "00110";
	constant right_vertical_wall 		: std_logic_vector (4 downto 0) := "00111";
	constant right_down_slope 			: std_logic_vector (4 downto 0) := "01000";
	constant death				 			: std_logic_vector (4 downto 0) := "01001";
	
	signal sigWasHit : std_logic;
	signal sigDataIn : std_logic_vector (4 downto 0);
	signal data_prev : std_logic_vector (4 downto 0);

begin

--	was_hit_out <= sigWasHit;
	
	process (CLK, resetN)
	
	begin
	if resetN = '0' then
		sigWasHit <= '0';
		bounce_enable <= '0';
		bounce_data_out <= no_bounce;
		is_dead <= '0';
	elsif rising_edge(CLK) then
		if (enable = '1') then
			if (ball_draw_req = '1' and bounce_data_in > 0) then
				if (sigWasHit <= '0') then
					sigWasHit <= '1';
					sigDataIn <= bounce_data_in;
				end if;
			end if;
	
			if (sigWasHit = '1' and was_hit_in = '0') or (sigWasHit = '1' and was_hit_in = '1' and sigDataIn /= data_prev) then
				case sigDataIn is
					when horizontal_floor =>
							bounce_enable <= '1';
							bounce_data_out <= sigDataIn;
							is_dead <='0';
						
					when left_down_slope =>
							bounce_enable <= '1';
							bounce_data_out <= sigDataIn;
							is_dead <='0';
					
					when left_vertical_wall =>
							bounce_enable <= '1';
							bounce_data_out <= sigDataIn;
							is_dead <='0';
					
					when left_up_slope =>
							bounce_enable <= '1';
							bounce_data_out <= sigDataIn;
							is_dead <='0';
					
					when horizontal_ceiling =>
							bounce_enable <= '1';
							bounce_data_out <= sigDataIn;
							is_dead <='0';
					
					when right_up_slope =>
							bounce_enable <= '1';
							bounce_data_out <= sigDataIn;
							is_dead <='0';
					
					when right_vertical_wall =>
							bounce_enable <= '1';
							bounce_data_out <= sigDataIn;
							is_dead <='0';
					
					when right_down_slope =>
							bounce_enable <= '1';
							bounce_data_out <= sigDataIn;
							is_dead <='0';
						
					when death =>
							bounce_enable <= '0';
							bounce_data_out <= sigDataIn;
							is_dead <='1';
					
					when others => null;
				end case;
			else
				bounce_enable <= '0';
				bounce_data_out <= no_bounce;
				is_dead <= '0';
			end if;
			
			if end_of_frame = '1' then
				was_hit_out <= sigWasHit;
				sigWasHit <= '0';
				data_prev <= sigDataIn;
				
			end if; -- end of frame
		end if; --enable
			
			
			
			
	end if;--clk
	end process;
end architecture; 