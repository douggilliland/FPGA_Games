library ieee;
use ieee.numeric_std.all;
use ieee.std_logic_1164.all;
use work.base_package.all;


entity datapath is
	port
	(
		CLOCK         	: in  std_logic;
		RESET_N       	: in  std_logic;
		
		-- Connections for the Controller
		CHANGE_SQUARE 	: in  std_logic;	--segnale utile a cambiare il qudrato selezionato
		CHANGE_COLOR  	: in  std_logic;	--segnale usato per cambiare il colore del quadrato selezionato
		CONFIRM_GUESS 	: in  std_logic;	--segnale che conferma la sequenzanza
		
		-- Connections for the View
		QUERY_GUESS   	: in  natural range 0 to (GUESSES_NUMBER - 1);
		GUESS_CONTENT	: out guess;
		QUERY_HINT		: in  natural range 0 to (GUESSES_NUMBER - 1);
		HINT_CONTENT 	: out hint;
		CURRENT_GUESS 	: out natural range 0 to (GUESSES_NUMBER - 1);
		CURRENT_SQUARE : out natural range 0 to (SQUARES_NUMBER - 1);
		CURRENT_COLOR 	: out guess_peg;
		CHECK          : out guess;
		GAME_WON      	: out std_logic;
		GAME_LOST     	: out std_logic;
		COUNTDOWN      : out natural
		
	);
end entity;


architecture RTL of datapath is

	-- inizializzo il generatore di valori random che mi servirà per creare la sequenza di colori da indovinare 
	component randomgen
		port(clk:in std_logic;
				a:out std_logic_vector(11 downto 0));
   end component;
	
	 
	-- definisco i 5 stati macchina del progetto
	Type StateM is (Title, Initial, Play, SubAns, Finished);
	signal State : StateM;
    
	-- numeri generati in modo random che mi rappresentano i 4 valori da ricercare (verranno associati a un colore)
	signal RandNum : std_logic_vector(11 downto 0);
	 	 
	shared variable current_guess_r		: integer;			-- tentativo corrente
	shared variable current_square_r    : integer;			-- quadrato corrente associato al tentativo
	shared variable current_color_r     : guess_peg;		-- colore corrente associato al quadrato
	
	signal check_r            	: guess;
	 
	signal guess_board			: guess_board;
	 
	signal hint_board				: hint_board;
	
	signal countdown_r : natural range 0 to GUESSES_NUMBER;

	function rand_vector_to_guess_peg(x : std_logic_vector)
		return guess_peg is
	begin
		return to_integer(unsigned(x));
	end function;
	
	
begin

	-- Genero random i 4 "colori" della combinazione segreta da indovinare (questi colori possono anche essere uguali)
	RandomGenerator : randomgen port map (clk => CLOCK, a => RandNum);
	  
	CURRENT_GUESS  <= current_guess_r;
	CURRENT_SQUARE <= current_square_r;
	CURRENT_COLOR  <= current_color_r;
	  
	GUESS_CONTENT <= guess_board(QUERY_GUESS);
	HINT_CONTENT  <= hint_board(QUERY_HINT);
	CHECK         <= check_r;
	COUNTDOWN     <= countdown_r;
	
	
	statemachine : process (CLOCK, RESET_N) is	-- CLOCK: clock della scheda, RESET_N: reset button fisico
		variable r_spot_count  : natural range 0 to SQUARES_NUMBER;
		variable r_color_count : natural range 0 to SQUARES_NUMBER;
		variable spot_checked       : std_logic_vector((SQUARES_NUMBER - 1) downto 0);
		variable color_checked       : std_logic_vector((SQUARES_NUMBER - 1) downto 0);
	begin
			
			-- Ogni volta che viene premuto il RESET_N vado nello stato "Title"
			if (RESET_N = '0') then
				countdown_r <= 9;
				r_spot_count := 0;
				r_color_count := 0;
				current_guess_r := 0;
				current_square_r := 0;
				current_color_r := 0;
				GAME_WON <= '0';
				GAME_LOST <= '0';
				guess_board <= ((others => (others => 0)));
				hint_board <= (others => (others => hint_peg'VAL(2)));
				spot_checked := (others => '0');
				color_checked := (others => '0');
				State <= Title;
						
			elsif (rising_edge(CLOCK)) then
				case State is
					when Title   =>
						if (CHANGE_COLOR = '1' or CHANGE_SQUARE = '1' or CONFIRM_GUESS = '1') then
							state <= Initial;
						end if;
					
					
					when Initial =>
						check_r(0) <= rand_vector_to_guess_peg(RandNum(11 downto 9));
						check_r(1) <= rand_vector_to_guess_peg(RandNum(8 downto 6));
						check_r(2) <= rand_vector_to_guess_peg(RandNum(5 downto 3));
						check_r(3) <= rand_vector_to_guess_peg(RandNum(2 downto 0));
						State <= Play;

							
						when Play =>
							if(CHANGE_SQUARE = '1') then
								if current_square_r + 1 = SQUARES_NUMBER then
									current_square_r := 0;
								else
									current_square_r := (current_square_r + 1);
								end if;
								current_color_r := guess_board(current_guess_r)(current_square_r);
							end if;
							
							if(CHANGE_COLOR = '1') then
								if (current_color_r + 1 = COLORS_NUMBER) then
									current_color_r := 0;
								else
									current_color_r := current_color_r + 1;
								end if;
								guess_board(current_guess_r)(current_square_r) <= current_color_r;
							end if;
							
							-- Una volta che premo il tasto fisico di "ok_combinazione" passo allo stato "SubAns"
							if (CONFIRM_GUESS = '1') then
								countdown_r <= countdown_r - 1;
								current_square_r := 0;
								current_color_r := 0;
								State <= SubAns;
							end if;
							
						when SubAns =>
						
							for i in 0 to SQUARES_NUMBER - 1 loop
								if check_r(i) = guess_board(current_guess_r)(i) then
									r_spot_count := r_spot_count + 1;
									spot_checked(i) := '1';
								end if;
							end loop;
							for i in 0 to SQUARES_NUMBER - 1 loop
								if spot_checked(i) = '0' then
									for j in 0 to SQUARES_NUMBER - 1 loop
										if check_r(i) = guess_board(current_guess_r)(j) and (spot_checked(j) = '0' and color_checked(j) = '0') then
											r_color_count := r_color_count + 1;
											color_checked(j) := '1';
											exit;
										end if;
									end loop;
								end if;
							end loop;
							
							spot_checked := (others => '0');
							color_checked := (others => '0');
																					
							for i in 0 to SQUARES_NUMBER - 1 loop
								if i < r_spot_count then
									hint_board(current_guess_r)(i) <= PLACE;
								elsif i < r_spot_count + r_color_count then 
									hint_board(current_guess_r)(i) <= COLOR;
								else
									hint_board(current_guess_r)(i) <= NOTHING;
								end if;
							end loop;
							
							current_guess_r := current_guess_r + 1;
					
							if (r_spot_count = 4) then
								GAME_WON <= '1';
								State <= Finished;
							elsif (countdown_r = 0) then
								GAME_LOST <= '1';
								State <= Finished;
							else
								r_spot_count  := 0;
								r_color_count := 0;
								State <= Play;
							end if;
						
						when Finished =>
							-- Stato vuoto raggiunto quando il gioco finisce, altrimenti si rimarrebbe
							-- nello stato di Finished e ad ogni colpo di clock si dovrebbe controllare
							-- una risposta già controllata!
							
						-- qualsiasi altra cosa accada riporto lo stato a "Initial"
						when others =>
							State <= Initial;
							
				end case;  
			end if;
end process statemachine;    
    

end architecture;