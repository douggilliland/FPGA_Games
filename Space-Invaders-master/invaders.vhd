library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
entity invaders is
	Port (	clk		: in  STD_LOGIC;
		reset		: in  STD_LOGIC;
		start		: in  STD_LOGIC;
		bullet_row	: in integer range 0 to 14;
		bullet_col	: in integer range 0 to 19;
		bullet_on	: in std_logic;
		end_bullet	: out std_logic;
		row_invaders    : out  integer range 0 to 14;
		invaders	: out  STD_LOGIC_vector(19 downto 0);
		enable		: in std_logic
	     );

end invaders;

architecture c of invaders is
	signal rowinvaders: 	integer range 0 to 14;
	signal invadsig: 	std_logic_vector(19 downto 0);
	signal direction: 	std_logic:= '0';
	signal endbullet:	std_logic;
begin
	process(clk, reset)
	begin
		if reset = '1' then
			rowinvaders <= 0;
			invadsig <= "11111111110000000000";
		elsif clk'event and clk = '1' then
			if start = '1' or rowinvaders = 14 then
				rowinvaders <= 0;
				invadsig <= "11111111110000000000";
			elsif enable = '1' then
				if direction = '0' then
					if invadsig (19) = '1' then 
						rowinvaders <= rowinvaders + 1;
						direction <= '1';
					else 
						invadsig <= '0' & invadsig(18 downto 0); -- right shift	
					end if;
				else
					if invadsig (0) = '1' then
						rowinvaders <= rowinvaders + 1;
						direction <= '0';
					else 
						invadsig <= invadsig(19 downto 1) & '0'; --left shift
					end if;
				end if;
				if bullet_on = '1' then
					if invadsig(bullet_col) = '1' and rowinvaders = bullet_row then
						invadsig(bullet_col) <= '0';
						endbullet <= '1';
					end if;
				end if;
			end if;
		end if;
	end process;
end_bullet <= endbullet;
row_invaders <= rowinvaders;
invaders <= invadsig;
end c;