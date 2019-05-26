library ieee;
use ieee.std_logic_1164.all;

package board_pkg is
	type board_type is array(30 downto 0, 10 downto 0) of std_logic;
end package;

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.board_pkg.all;

entity game_logic is
	port(rotate_cw, rotate_ccw, move_left, move_right, clk_50, reset : in std_logic;
		  output_matrix : out board_type;
		  game_over : out std_logic;
		  score: out integer);
end game_logic;

architecture behavioral of game_logic is

type state_type is (H, V, A, B, C, D);
type board_type is array(30 downto 0, 10 downto 0) of std_logic;
signal state : state_type;
signal key, move: std_logic;
signal col, row : integer;
signal offL, offR: integer := 0;
signal lf_start: integer;
signal gameboard : board_type;
signal displayboard : board_type;
signal new_block : std_logic;
signal clk_1Hz : std_logic;
signal lefty: std_logic;
signal righty: std_logic;
signal count : std_logic_vector(27 downto 0);
signal lfsr : std_logic_vector(2 downto 0);
signal w_poly : std_logic_vector(2 downto 0) := "111";
signal w_mask : std_logic_vector(2 downto 0);


begin
	
	-- Create a mask
	g_mask: for k in 2 downto 0 generate
		w_mask(k) <= w_poly(k) and lfsr(0);
	end generate g_mask;
	
	-- This process uses a lfsr to create a random 3 bit number used to generate new block states
	process(new_block, reset)
	begin
		if reset = '1' then
			lfsr <= (others => '1');
		elsif rising_edge(new_block) then
			lfsr <= '0'&lfsr(2 downto 1) xor w_mask;
		end if;
	end process;



	--This process creates a 1Hz clock
	process(clk_50)
	begin
		if rising_edge(clk_50) then
			if count < X"7d7840" then
				count <= count + 1;
				clk_1Hz <= '0';
			else 
				count <= X"0000000";
				clk_1Hz <= '1';
			end if;
		end if;
		
	end process;
	
	-- This process represents a state machine which handles the rotation of the blocks 
	--based on user input
	process(rotate_cw, new_block)
	begin
	
		if new_block = '1' then
			if lfsr = "000" then
				state <= H;
			elsif lfsr = "001" then
				state <= V;
			elsif lfsr = "010" then
				state <= A;
			elsif lfsr <= "011" then
				state <= B;
			elsif lfsr <= "100" then
				state <= C;
			elsif lfsr <= "101" then
				state <= D;
			elsif LFSR <= "110" then
				state <= V;
			else
				state <= H;
			end if;
			
		elsif rising_edge(rotate_cw) then
			case state is
				--State H represents horizontal line
				when H =>
					if (gameboard(row+1, col) = '0' and gameboard(row-1, col) = '0') then
						state <= V;
					else
						state <= H;
					end if;
				--State V represents a vertical line	
				when V =>
					if (gameboard(row, col+1) = '0' and gameboard(row, col-1) = '0') then
						state <= H;
					else
						state <= V;
					end if;
			   --State A represents :*
				when A =>
					if (gameboard(row+1, col+1) = '0') then
						state <= B;
					else
						state <= A;
					end if;
				--State B represents *:		
				when B =>
					if (gameboard(row+1, col) = '0') then
						state <= C;
					else
						state <= B;
					end if;
				--State C represents .:	
				when C =>
					if (gameboard(row, col) = '0') then
						state <= D;
					else
						state <= C;
					end if;
				--State D represent :.		
				when D =>
					if (gameboard(row, col+1) = '0') then
						state <= A;
					else
						state <= C;
					end if;
				when others => 
					state <= H;
			end case;
		end if;
		
	end process;
	
	
	
	process (offR, offL)
	begin
	
		col <= offR - offL + 4;
			
	end process;

	
	process(move_left, reset, new_block) -- move, new_block
	begin
	
		if reset = '1' or new_block = '1' then
			offL <= 0;
			
		elsif (falling_edge(move_left)) then
			if (offR - offL + 4) > 0 then
				if state = A or state = D then
					if (gameboard(row, col-1) = '0' and gameboard(row+1, col-1) = '0') then
						offL <= offL + 1;
					end if;
				elsif state = B then
					if (gameboard(row, col-1) = '0' and gameboard(row+1, col) = '0') then
						offL <= offL + 1;
					end if;
				elsif state = C then
					if (gameboard(row, col) = '0' and gameboard(row+1, col-1) = '0') then
						offL <= offL + 1;
					end if;
				elsif state = H then
					if (gameboard(row, col-2) = '0' and (offR - offL + 4) > 1) then
						offL <= offL + 1;
					end if;
				elsif state = V then
					if (gameboard(row, col-1) = '0' and gameboard(row-1, col-1) = '0' and gameboard(row+1, col-1) = '0') then
						offL <= offL + 1;
					end if;
				end if;
			end if;
		end if;
		
	end process;
	
	
	process(move_right, reset, new_block)
	begin
	
	   if reset = '1' or new_block = '1' then
			offR <= 0;
			
		elsif (falling_edge(move_right)) then
		
			if state = V and (offR - offL + 4) < 9 then
				if (gameboard(row, col+1) = '0' and gameboard(row-1, col+1) = '0' and gameboard(row+1, col+1) = '0') then
					offR <= offR + 1;
				end if;
				
			elsif state = H and (offR - offL + 4) < 8 then
				if (gameboard(row, col+2) = '0') then
					offR <= offR + 1;
				end if;
				
			elsif (offR - offL + 4) < 8 then
				if state = B or state = C then
					if (gameboard(row, col+2) = '0' and gameboard(row+1, col+2) = '0') then
						offR <= offR + 1;
					end if;
				elsif state = A then
					if (gameboard(row, col+2) = '0' and gameboard(row+1, col+1) = '0') then
						offR <= offR + 1;
					end if;
				elsif state = D then
					if (gameboard(row, col+1) = '0' and gameboard(row+1, col+2) = '0') then
						offR <= offR + 1;
					end if;
				elsif state = H then
					if (gameboard(row, col+2) = '0') then
						offR <= offR + 1;
					end if;
				elsif state=V then
					if (gameboard(row, col+1) = '0' and gameboard(row-1, col+1) = '0' and gameboard(row+1, col+1) = '0') then
						offR <= offR + 1;
					end if;
				end if;
			end if;
		end if;
		
	end process;
	
				
					
		--Checks whether block can continue moving down the grid or if new block should be generated	process(clk_1Hz, state, col)
	process(clk_1Hz, state, col, new_block, reset)
		variable fullrow: integer :=-1;
		variable rowcleared: integer:=0;
		variable tempboard: board_type;
	begin
		if reset = '1' then
			fullrow:=-1;
			new_block <= '1';
			game_over <= '0';
			for i in 30 downto 0 loop
				for j in 10 downto 0 loop
					gameboard(i, j) <= '0';
				end loop;
			end loop;
		-- Sets row of new block back to 0 
		elsif (fullrow /= -1 and rowcleared=0) then
			new_block <= '1';
			rowcleared := 1;
			for i in 30 downto 0 loop
				
					if (i = 0) then
						tempboard(i, 0) := '0';
						tempboard(i, 1) := '0';
						tempboard(i, 2) := '0';
						tempboard(i, 3) := '0';
						tempboard(i, 4) := '0';
						tempboard(i, 5) := '0';
						tempboard(i, 6) := '0';
						tempboard(i, 7) := '0';
						tempboard(i, 8) := '0';
						tempboard(i, 9) := '0';
					elsif (i <= fullrow) then
						tempboard(i, 0) := gameboard(i-1, 0);
						tempboard(i, 1) := gameboard(i-1, 1);
						tempboard(i, 2) := gameboard(i-1, 2);
						tempboard(i, 3) := gameboard(i-1, 3);
						tempboard(i, 4) := gameboard(i-1, 4);
						tempboard(i, 5) := gameboard(i-1, 5);
						tempboard(i, 6) := gameboard(i-1, 6);
						tempboard(i, 7) := gameboard(i-1, 7);
						tempboard(i, 8) := gameboard(i-1, 8);
						tempboard(i, 9) := gameboard(i-1, 9);
					else
						tempboard(i, 0) := gameboard(i, 0);
						tempboard(i, 1) := gameboard(i, 1);
						tempboard(i, 2) := gameboard(i, 2);
						tempboard(i, 3) := gameboard(i, 3);
						tempboard(i, 4) := gameboard(i, 4);
						tempboard(i, 5) := gameboard(i, 5);
						tempboard(i, 6) := gameboard(i, 6);
						tempboard(i, 7) := gameboard(i, 7);
						tempboard(i, 8) := gameboard(i, 8);
						tempboard(i, 9) := gameboard(i, 9);
					end if;
				
			end loop;
		elsif new_block = '1' then
			row <= 0;
			new_block <= '0';
		
		elsif rising_edge(clk_1Hz) then
			for i in 30 downto 0 loop
				if (gameboard(i, 0) = '1' and 
						gameboard(i, 1) = '1' and 
						gameboard(i, 2) = '1' and
						gameboard(i, 3) = '1' and 
						gameboard(i, 4) = '1' and 
						gameboard(i, 5) = '1' and 
						gameboard(i, 6) = '1' and 
						gameboard(i, 7) = '1' and
						gameboard(i, 8) = '1' and 
						gameboard(i, 9) = '1') then
					fullrow:=i;
				end if;	
			end loop;
			if rowcleared = 1 then
				fullrow := -1;
				rowcleared:=0;
				gameboard <= tempboard;
			elsif state = V then
				if gameboard(row+2, col) = '0' and row < 28 then
					row <= row + 1;
				else 
					if row = 0 then
						game_over <= '1';
					else 
						new_block <= '1';
					end if;
					gameboard(row-1, col) <= '1';
					gameboard(row, col) <= '1';
					gameboard(row+1, col) <= '1';
				end if;
			elsif state = H then
				if gameboard(row+1, col-1) = '0' and gameboard(row+1, col) = '0' and gameboard(row+1, col+1) = '0' and row < 29 then
					row <= row + 1;
				else
					if row = 0 then
						game_over <= '1';
					else 
						new_block <= '1';
					end if;
					gameboard(row, col-1) <= '1';
					gameboard(row, col) <= '1';
					gameboard(row, col+1) <= '1';
				end if;
			elsif state = D then
				if gameboard(row+2, col) = '0' and gameboard(row+2, col+1) = '0' and row < 28 then
					row <= row + 1;
				else
					if row = 0 then
						game_over <= '1';
					else 
						new_block <= '1';
					end if;
					gameboard(row, col) <= '1';
					gameboard(row+1, col) <= '1';
					gameboard(row+1, col+1) <= '1';
				end if;
			elsif state = C then
				if gameboard(row+2, col) = '0' and gameboard(row+2, col+1) = '0' and row < 28 then
					row <= row + 1;
				else 
					if row = 0 then
						game_over <= '1';
					else 
						new_block <= '1';
					end if;
					gameboard(row+1, col) <= '1';
					gameboard(row, col+1) <= '1';
					gameboard(row+1, col+1) <= '1';
				end if;
			elsif state = A then
				if gameboard(row+2, col) = '0' and gameboard(row+1, col+1) = '0' and row < 28 then
					row <= row + 1;
				else 
					if row = 0 then
						game_over <= '1';
					else 
						new_block <= '1';
					end if;
					gameboard(row, col) <= '1';
					gameboard(row+1, col) <= '1';
					gameboard(row, col+1) <= '1';
				end if;
			elsif state = B then
				if gameboard(row+1, col) = '0' and gameboard(row+2, col+1) = '0' and row < 28 then
					row <= row + 1;
				else 
					if row = 0 then
						game_over <= '1';
					else 
						new_block <= '1';
					end if;
					gameboard(row, col) <= '1';
					gameboard(row, col+1) <= '1';
					gameboard(row+1, col+1) <= '1';
				end if;
			end if;
--			row <= row + 1;
		end if;
	end process;
	
	-- This process updates the gameboard 
	process(row, col, state, reset)
	begin
		displayboard<=gameboard;
		
		case state is
			when H =>
				if new_block = '0' then
					displayboard(row, col-1) <= '1';
					displayboard(row, col) <= '1';
					displayboard(row, col+1) <= '1';
				end if;
			
			when V =>
				if new_block = '0' then
					displayboard(row-1, col) <= '1';
					displayboard(row, col) <= '1';
					displayboard(row+1, col) <= '1';
				end if;
				
			when A =>
				if new_block = '0' then
					displayboard(row, col) <= '1';
					displayboard(row+1, col) <= '1';
					displayboard(row, col+1) <= '1';
				end if;
				
			when B =>
				if new_block = '0' then
					displayboard(row, col) <= '1';
					displayboard(row+1, col+1) <= '1';
					displayboard(row, col+1) <= '1';
				end if;
				
			when C =>
				if new_block = '0' then
					displayboard(row, col+1) <= '1';
					displayboard(row+1, col) <= '1';
					displayboard(row+1, col+1) <= '1';
				end if;

			when D =>
				if new_block = '0' then
					displayboard(row, col) <= '1';
					displayboard(row+1, col) <= '1';
					displayboard(row+1, col+1) <= '1';
				end if;
		end case;
	end process;
	
	-- This process writes the updated matrix to the output to be displayed by the display module
	process(displayboard)
	begin
		for i in 30 downto 0 loop
			for j in 10 downto 0 loop
				output_matrix(i, j) <= displayboard(i, j);
			end loop;
		end loop;
	end process;
		
end architecture behavioral;
			