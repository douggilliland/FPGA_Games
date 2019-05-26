library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.vga_package.all;
use work.text_package.all;

entity VGA_Framebuffer is
	generic
	(
		SCREEN_WIDTH        : positive := 512;
		SCREEN_HEIGHT       : positive := 480;
		COLOR_DEPTH         : positive := 12
	);
	port
	(
		CLOCK               : in    std_logic;
		RESET_N             : in    std_logic;

		-- Commands
		CLEAR               : in    std_logic;
		DRAW_EMPTY_RECT     : in    std_logic;
		DRAW_FILLED_RECT    : in    std_logic;
		DRAW_TEXT           : in    std_logic;
		FLIP                : in    std_logic;
		
		-- Special commands
		CHOSEN_TEXT         : in    message;

		-- Commands parameters
		COLOR               : in    color_type;
		X0                  : in    xy_coord_type;
		Y0                  : in    xy_coord_type;
		X1                  : in    xy_coord_type;
		Y1                  : in    xy_coord_type;
		
		-- Outputs		
		READY               : out   std_logic;
		VGA_R               : out   std_logic_vector(3 downto 0);
		VGA_G               : out   std_logic_vector(3 downto 0);
		VGA_B               : out   std_logic_vector(3 downto 0);
		VGA_HS              : out   std_logic;
		VGA_VS              : out   std_logic;
		
		SRAM_ADDR           : out   std_logic_vector(17 downto 0);
		SRAM_DQ             : inout std_logic_vector(15 downto 0);
		SRAM_CE_N           : out   std_logic;
		SRAM_OE_N           : out   std_logic;
		SRAM_WE_N           : out   std_logic;
		SRAM_UB_N           : out   std_logic;
		SRAM_LB_N           : out   std_logic
	);

end;


architecture RTL of VGA_Framebuffer is	
	
	type   state_type       is (IDLE, DRAWING_FILLED_RECT, DRAWING_EMPTY_RECT, DRAWING_TEXT);
	type   substate_type    is (INIT, DRAWING, 
										WAIT_TEXT_PIXEL,
										DRAWING_HIGH_SIDE, DRAWING_LEFT_SIDE, 
										DRAWING_RIGHT_SIDE, DRAWING_LOW_SIDE);
	signal state            : state_type;
	signal substate         : substate_type;
	
	signal vga_blank        : std_logic;
	signal vga_strobe       : std_logic;
	signal vga_x            : std_logic_vector(10 downto 0);
	signal vga_y            : std_logic_vector(10 downto 0);
	signal vga_vsync        : std_logic;
	
	signal fb_buffer_idx    : std_logic;
	signal fb_wr_req        : std_logic;
	signal fb_wr_ack        : std_logic;
	signal fb_wr_x          : std_logic_vector(10 downto 0);
	signal fb_wr_y          : std_logic_vector(10 downto 0);
	signal fb_wr_color      : std_logic_vector(COLOR_DEPTH-1 downto 0);
	
	signal fb_rd_req        : std_logic;
	signal fb_rd_ack        : std_logic;
	signal fb_rd_x          : std_logic_vector(10 downto 0);
	signal fb_rd_y          : std_logic_vector(10 downto 0);
	signal fb_rd_color      : std_logic_vector(COLOR_DEPTH-1 downto 0);
	
	signal flip_on_next_vs  : std_logic;
	signal latched_color    : std_logic_vector(COLOR_DEPTH-1 downto 0);
	signal x_cursor         : integer range 0 to SCREEN_WIDTH;
	signal y_cursor         : integer range 0 to SCREEN_HEIGHT;
	signal x_start          : integer range 0 to SCREEN_WIDTH;
	signal y_start          : integer range 0 to SCREEN_HEIGHT;
	signal x_end            : integer range 0 to SCREEN_WIDTH;
	signal y_end            : integer range 0 to SCREEN_HEIGHT;
	
	signal next_bit      	: std_logic;
	signal next_line      	: std_logic;
	signal text_pixel       : std_logic;
begin
	
	vga_timing : entity work.VGA_Timing
		port map(
			CLOCK        => CLOCK,
			RESET_N      => RESET_N,
			H_SYNC       => VGA_HS,
			V_SYNC       => vga_vsync,
			BLANK        => vga_blank,
			PIXEL_STROBE => vga_strobe,
			PIXEL_X      => vga_x,
			PIXEL_Y      => vga_y
			);
			
	vga_fb : entity work.VGA_RAMDAC
		port map(
			CLOCK        => CLOCK,
			RESET_N      => RESET_N,
			BUFFER_INDEX => fb_buffer_idx,
			WR_REQ       => fb_wr_req,
			WR_ACK       => fb_wr_ack,
			WR_X         => fb_wr_x,
			WR_Y         => fb_wr_y,
			WR_COLOR     => fb_wr_color,

			RD_REQ       => fb_rd_req,
			RD_ACK       => fb_rd_ack,
			RD_X         => fb_rd_x,
			RD_Y         => fb_rd_y,
			RD_COLOR     => fb_rd_color,
			
			SRAM_ADDR    => SRAM_ADDR,
			SRAM_DQ      => SRAM_DQ,
			SRAM_CE_N    => SRAM_CE_N,
			SRAM_OE_N    => SRAM_OE_N,
			SRAM_WE_N    => SRAM_WE_N,
			SRAM_UB_N    => SRAM_UB_N,
			SRAM_LB_N    => SRAM_LB_N
		);
					
	text_contrl : entity work.text_controller
        port map(
		  	CLOCK => CLOCK,
			RESET_N => RESET_N,
			CHOSEN_TEXT => CHOSEN_TEXT,
			NEXT_BIT     => next_bit,
			NEXT_LINE   => next_line,
        	PIXEL => text_pixel
   );
		
	fb_rd_x   <= vga_x;
	fb_rd_y   <= vga_y;
	fb_rd_req <= not(vga_blank) and (vga_strobe or fb_rd_ack or '1'); 
	                          
	fb_wr_color <= latched_color;
	fb_wr_x     <= std_logic_vector(to_unsigned(x_cursor, fb_wr_x'length));
	fb_wr_y     <= std_logic_vector(to_unsigned(y_cursor, fb_wr_y'length));
	
	VGA_VS  <= vga_vsync;
	VGA_R   <= fb_rd_color(11 downto 8) when (vga_blank = '0') else (others => '0');
	VGA_G   <= fb_rd_color(7 downto 4)  when (vga_blank = '0') else (others => '0');
	VGA_B   <= fb_rd_color(3 downto 0)  when (vga_blank = '0') else (others => '0');
	READY   <= '1' when (state = IDLE and (CLEAR or DRAW_FILLED_RECT or DRAW_EMPTY_RECT 
	or DRAW_TEXT or FLIP) = '0') else '0';
	
	draw_logic : process(CLOCK, RESET_N)
	begin
		
		if (RESET_N = '0') then
			
			state           <= IDLE;
			next_bit     	 <= '0';
			next_line     	 <= '0';
			fb_wr_req       <= '0';
			fb_buffer_idx   <= '0';
			flip_on_next_vs <= '0';
			
		elsif (rising_edge(CLOCK)) then

			fb_wr_req <= '0';
			
			case (state) is
				when IDLE =>
					
					latched_color <= COLOR;
					
					if (CLEAR = '1') then
						x_start   <= 0;
						y_start   <= 0;
						x_end     <= SCREEN_WIDTH-1;
						y_end     <= SCREEN_HEIGHT-1;
						state     <= DRAWING_FILLED_RECT;
						substate  <= INIT;
						
					elsif (DRAW_FILLED_RECT = '1') then
						x_start   <= X0;
						y_start   <= Y0;
						x_end     <= X1;
						y_end     <= Y1;
						state     <= DRAWING_FILLED_RECT;
						substate  <= INIT;
				
					elsif (DRAW_EMPTY_RECT = '1') then
						x_start   <= X0;
						y_start   <= Y0;
						x_end     <= X1;
						y_end     <= Y1;
						state     <= DRAWING_EMPTY_RECT;
						substate  <= INIT;
					
					elsif (DRAW_TEXT = '1') then
						x_start   <= X0;
						y_start   <= Y0;
						x_end     <= X1;
						y_end     <= Y1;
						state     <= DRAWING_TEXT;
						substate  <= INIT;
			
					elsif (FLIP = '1') then
						flip_on_next_vs <= '1';
					end if;
					
					if (flip_on_next_vs = '1' and vga_vsync = '0') then
						fb_buffer_idx   <= not(fb_buffer_idx); 
						flip_on_next_vs <= '0';
					end if;
				
				when DRAWING_FILLED_RECT =>
					fb_wr_req <= '1';

					if (substate = INIT) then
						x_cursor  <=  x_start;
						y_cursor  <=  y_start;
						substate  <= DRAWING;
					else
						if (fb_wr_ack = '1') then
							if (x_cursor = x_end) then
								x_cursor <= x_start;
								if (y_cursor = y_end) then
									fb_wr_req <= '0';
									state <= IDLE;
								else
									y_cursor <= y_cursor + 1;
								end if;
							else
								x_cursor <= x_cursor + 1;
							end if;
						end if;				
					end if;
					
				when DRAWING_EMPTY_RECT =>
					fb_wr_req <= '1';

					if (substate = INIT) then
						x_cursor  <=  x_start;
						y_cursor  <=  y_start;
						substate  <= DRAWING_HIGH_SIDE;
					elsif (substate = DRAWING_HIGH_SIDE) then
						if (fb_wr_ack = '1') then
							if (x_cursor = x_end) then
								x_cursor <= x_start;
								if (y_cursor = y_start + 3) then
									fb_wr_req <= '0';
									y_cursor <= y_cursor + 1;
									substate <= DRAWING_LEFT_SIDE;
								else
									y_cursor <= y_cursor + 1;
								end if;
							else
								x_cursor <= x_cursor + 1;
							end if;
						end if;
					elsif (substate = DRAWING_LEFT_SIDE) then
						if (fb_wr_ack = '1') then
							if (x_cursor = x_start + 3) then
								x_cursor <= x_start;
								if (y_cursor = y_end - 4) then
									fb_wr_req <= '0';
									x_cursor <= x_end - 3;
									y_cursor <= y_start + 4;
									substate <= DRAWING_RIGHT_SIDE;
								else
									y_cursor <= y_cursor + 1;
								end if;
							else
								x_cursor <= x_cursor + 1;
							end if;
						end if;
					elsif (substate = DRAWING_RIGHT_SIDE) then
						if (fb_wr_ack = '1') then
							if (x_cursor = x_end) then
								x_cursor <= x_end - 3;
								if (y_cursor = y_end - 4) then
									fb_wr_req <= '0';
									x_cursor <= x_start;
									y_cursor <= y_cursor + 1;
									substate <= DRAWING_LOW_SIDE;
								else
									y_cursor <= y_cursor + 1;
								end if;
							else
								x_cursor <= x_cursor + 1;
							end if;
						end if;
					else
						if (fb_wr_ack = '1') then
							if (x_cursor = x_end) then
								x_cursor <= x_start;
								if (y_cursor = y_end) then
									fb_wr_req <= '0';
									state <= IDLE;
								else
									y_cursor <= y_cursor + 1;
								end if;
							else
								x_cursor <= x_cursor + 1;
							end if;
						end if;
					end if;
					
				when DRAWING_TEXT =>
					if (substate = INIT) then
						x_cursor  <=  x_start;
						y_cursor  <=  y_start;
						substate  <=  DRAWING;
					elsif (substate = WAIT_TEXT_PIXEL) then
						next_bit <= '0';
						next_line <= '0';
						substate <= DRAWING;
					else
						if (text_pixel = '1' and fb_wr_req = '0') then
							fb_wr_req <= '1';
						else
							if (fb_wr_req = '1' and fb_wr_ack = '1') or text_pixel = '0' then
								fb_wr_req <= '0';
								substate <= WAIT_TEXT_PIXEL;
								if (x_cursor = x_end) then
									x_cursor <= x_start;
									if (y_cursor = y_end) then
										state <= IDLE;
									else
										y_cursor <= y_cursor + 1;
										next_line <= '1';
									end if;
								else
									x_cursor <= x_cursor + 1;
									next_bit <= '1';
								end if;
							end if;
						end if;
					end if;
					
					
			
				when others =>
					assert false severity failure;
			
				end case;
			
		
		end if;
		
	end process;
	
	
	end architecture;