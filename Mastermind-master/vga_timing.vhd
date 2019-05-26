library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vga_timing is

		generic
		(
			CLOCK_DIV       : natural := 4;
			H_DISP          : natural := 640-128;
			H_FRONT_PORCH   : natural := 16+64;
			H_SYNC_LEN      : natural := 96;
			H_BACK_PORCH    : natural := 48+64;
			V_DISP          : natural := 480;
			V_FRONT_PORCH   : natural := 11;
			V_SYNC_LEN      : natural := 2;
			V_BACK_PORCH    : natural := 34
		);
		
		port
		(
			CLOCK           : in  std_logic;
			RESET_N         : in  std_logic;
			H_SYNC          : out std_logic;
			V_SYNC          : out std_logic;
			BLANK           : out std_logic;			
			PIXEL_STROBE    : out std_logic;
			PIXEL_X         : out std_logic_vector(10 downto 0);
			PIXEL_Y         : out std_logic_vector(10 downto 0)
		);
end;

architecture RTL of vga_timing is
	constant H_LENGTH     : natural := H_DISP + H_FRONT_PORCH + H_SYNC_LEN + H_BACK_PORCH;
	constant V_LENGTH     : natural := V_DISP + V_FRONT_PORCH + V_SYNC_LEN + V_BACK_PORCH;
	
	signal   clock_count  : integer range 0 to CLOCK_DIV;
	
	type     state_type   is (FRONT_PORCH, SYNC, BACK_PORCH, DATA);
	signal   h_state      : state_type;
	signal   h_counter    : integer range 0 to H_LENGTH;
	signal   h_pixel      : integer range 0 to H_DISP;
	
	signal   v_state      : state_type;
	signal   v_counter    : integer range 0 to H_LENGTH;
	signal   v_pixel      : integer range 0 to V_DISP;
	
	signal   new_line     : std_logic;
	
begin

	h_timing : process(CLOCK, RESET_N)
	begin
		
		if (RESET_N = '0') then
			h_counter   <= 0;
			h_pixel     <= 0;
			h_state     <= FRONT_PORCH;
			new_line    <= '0';
			clock_count <= 0;
		elsif (rising_edge(CLOCK)) then
			new_line    <= '0';
			
			if (clock_count /= CLOCK_DIV-1) then
				clock_count <= clock_count + 1;
			else
				clock_count <= 0;
			
				if (h_counter = 0) then
					h_state  <= FRONT_PORCH;
					new_line <= '1';
				elsif (h_counter = (H_FRONT_PORCH - 1)) then
					h_state  <= SYNC;
				elsif (h_counter = (H_FRONT_PORCH + H_SYNC_LEN - 1)) then
					h_state  <= BACK_PORCH;
				elsif (h_counter = (H_FRONT_PORCH + H_SYNC_LEN + H_BACK_PORCH - 1)) then
					h_state  <= DATA;
				end if;
			
				if(h_state = DATA and h_counter /= 0) then
					h_pixel <= h_pixel + 1;
				else
					h_pixel <= 0;
				end if;
					
				if (h_counter = H_LENGTH-1) then
					h_counter <= 0;
				else
					h_counter <= h_counter + 1;
				end if;
			end if;
		end if;
	
	end process;


	v_timing : process(CLOCK, RESET_N)
	begin
		
		if (RESET_N = '0') then
			v_counter   <= 0;
			v_pixel     <= 0;
			v_state     <= FRONT_PORCH;
		elsif (rising_edge(CLOCK)) then
			
			if(new_line = '1') then
				if (v_counter = 0) then
					v_state <= FRONT_PORCH;
				elsif (v_counter = (V_FRONT_PORCH - 1)) then
					v_state <= SYNC;
				elsif (v_counter = (V_FRONT_PORCH + V_SYNC_LEN - 1)) then
					v_state <= BACK_PORCH;
				elsif (v_counter = (V_FRONT_PORCH + V_SYNC_LEN + V_BACK_PORCH - 1)) then
					v_state <= DATA;
				end if;
			
				if(v_state = DATA and v_counter /= 0) then
					v_pixel <= v_pixel + 1;
				else
					v_pixel <= 0;
				end if;
			
				if (v_counter = V_LENGTH-1) then
					v_counter <= 0;
				else
					v_counter <= v_counter + 1;
				end if;
			end if;
		end if;
	
	end process;

	BLANK   <= '0' when (h_state = DATA and v_state = DATA) else '1';
	H_SYNC  <= '0' when (h_state = SYNC) else '1';
	V_SYNC  <= '0' when (v_state = SYNC) else '1';
	PIXEL_X <= std_logic_vector(to_unsigned(h_pixel, PIXEL_X'LENGTH));
	PIXEL_Y <= std_logic_vector(to_unsigned(v_pixel, PIXEL_Y'LENGTH));
	PIXEL_STROBE <= '1' when (h_state = DATA and v_state = DATA and clock_count = 0) else '0';
	
	
end architecture;
