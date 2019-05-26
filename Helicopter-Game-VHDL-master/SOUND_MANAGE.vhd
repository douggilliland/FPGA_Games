library ieee ;
use ieee.std_logic_1164.all ;
use ieee.std_logic_unsigned.all ;

entity SOUND_MANAGE is
	port ( 

		resetN : in std_logic ;
		clk : in std_logic ;
		BOMB :in std_logic ;
		COIN1 :in std_logic ;
		COIN2 :in std_logic ;
		LIFE : in std_logic ;
		COIN_SND : in std_logic_vector(15 downto 0); 
		Coin_Done :  in std_logic; 
		BOMB_SND : in std_logic_vector(15 downto 0); 
		LIFE_SND : in std_logic_vector(15 downto 0);  		
		SOUND_MOD : out std_logic_vector(15 downto 0);
		Not_Trigger : out std_logic 

	   	
 );
end SOUND_MANAGE;

architecture arc_SOUND_MANAGE of SOUND_MANAGE is
	signal Trigger :  std_logic;
	signal Done :  std_logic;
	signal SOUND_MOD_sig :  std_logic_vector(15 downto 0) ;
	signal oneSec :  integer := 45000000 ;
	
	type state is ( idle,BOMBSOUND,COINSOUND,LIFESOUND ) ;  
	type state1 is ( one_sec,waiting ) ; 	
	begin
	
	
	
	 Not_Trigger <= not(Trigger);
		
		process ( resetN , clk )
			variable present_state : state;
			begin
		if resetN = '0' then
			present_state := idle;
			Trigger <= '0';
    elsif rising_edge (clk) then
			Trigger <= '0';
	     case present_state is
		
			when idle =>


				SOUND_MOD_sig<= "0000000000000000"; --helic sound;
					
				if LIFE = '1' then
					Trigger <= '1';
					oneSec <= 45000000;
					present_state := LIFESOUND;	
				elsif BOMB = '1' then
					Trigger <= '1';
					oneSec <= 60000000;
					present_state := BOMBSOUND;
				elsif COIN1 = '1' or COIN2 = '1' then
					Trigger <= '1';
					oneSec <= 30000000;
					present_state := COINSOUND;
				end if;
				
			when BOMBSOUND =>
 
			SOUND_MOD_sig<=BOMB_SND ; --explosion sound;
				if Done = '1' then
				present_state := idle;
				end if;
				
			when LIFESOUND =>

				SOUND_MOD_sig<= LIFE_SND; --gameover sound;
				if Done = '1' then
				present_state := idle;
				end if;
			when COINSOUND =>
			
--            if (Coin_Done='1') then
				SOUND_MOD_sig<= COIN_SND; --LUNCH sound;
--				end if; 
				
				if Done = '1' then
				present_state := idle;	
				end if;
		end case;
 	end if;
end process;
			SOUND_MOD <= SOUND_MOD_sig;
			
			

		process ( resetN , clk )
			variable present_state : state1;
			variable count : integer:=0;
			begin

		if resetN = '0' then
			present_state := waiting;
			Done<='0';
    elsif rising_edge (clk) then
	     case present_state is
		
			when waiting =>
					Done<='0';
					if Trigger = '1' then
					present_state := one_sec;
					 count:=0;
				end if;
				
			when one_sec =>
			
				if Trigger = '1' then
					count:=0;
				end if;
				if count = oneSec then
					Done<='1'; 
					count:=0;
					present_state := waiting;
					else
					count:=count+1;
				end if;

		end case;
 	end if;
end process;
end arc_SOUND_MANAGE;