library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity TetrisCar_VGA is
port (CLK_DE2: in std_logic;
		Rbutton:in std_logic;
		Lbutton: in std_logic;
		Restart: in std_logic;
		PSH: out std_logic;
		PSV: out std_logic;
		Blank: out std_logic;
		Sync: out std_logic;
		Clock_VGA: out std_logic;
		R: out std_logic_vector(9 downto 0);
		G: out std_logic_vector(9 downto 0);
		B: out std_logic_vector(9 downto 0));
end TetrisCar_VGA;
	
architecture RTL of TetrisCar_VGA is

component div_frec is
PORT(CLK: in std_logic;
	  LVL: in std_logic_vector(2 downto 0);
	  CLK_GAME: out std_logic;
     CLK_Prima: out std_logic);  
END component;
 
component debouncer is
port( clk		 : in	std_logic;
		input	 : in	std_logic;
		reset	 : in	std_logic;
		output	 : out	std_logic);
end component;

component random is
port (clk : in std_logic;
      random_num : out std_logic_vector (6 downto 0));
end component;

component Position is
port(	clk		 : in	std_logic;
		crash: in std_logic;
		input_R	: in	std_logic;
		input_L: in std_logic;
		reset	 : in	std_logic;
		output	 : out	std_logic_vector(1 downto 0));
end component;
 
 
component PSH_Block is
PORT(CLK: in std_logic;
     PSH: out std_logic;  
	  PosHor: out std_logic_vector(9 downto 0));
END component;

component PSV_Block is
PORT(CLK: in std_logic;
     PSV: out std_logic;  
	  PosVer: out std_logic_vector(9 downto 0));
END component;

component graphics is
PORT(PosHor: in std_logic_vector(9 downto 0);  
	  PosVer: in std_logic_vector(9 downto 0);
	  Player: in std_logic_vector(1 downto 0);
	  PosCar1: in std_logic_vector(4 downto 0);
	  PosCar2: in std_logic_vector(4 downto 0);
	  PosCar3: in std_logic_vector(4 downto 0);
	  PosCalle: in std_logic_vector(1 downto 0);
	  LVL: in std_logic_vector(2 downto 0);
	  LIVES: in std_logic_vector(1 downto 0);
	  score_U: in std_logic_vector(3 downto 0);
	  score_D:in std_logic_vector(3 downto 0);
	  score_M:in std_logic_vector(3 downto 0);
	  respawn: in std_logic_vector(4 downto 0);
	  R:out std_logic_vector(9 downto 0);
	  G:out std_logic_vector(9 downto 0);
	  B:out std_logic_vector(9 downto 0));
END component;


signal CLK_cable: std_logic;
signal PosHor_cable: std_logic_vector(9 downto 0);
signal PosVer_cable: std_logic_vector(9 downto 0);
signal PSH_cable: std_logic;
signal PosPlayer: std_logic_vector(1 downto 0):="00";
signal CLK_GAME: STD_LOGIC;
signal LVL: std_logic_vector(2 downto 0):="000";
signal PosCar1:std_logic_vector(4 downto 0):="00000";
signal PosCar2:std_logic_vector(4 downto 0):="00000";
signal PosCar3:std_logic_vector(4 downto 0):="00000";
signal PosCalle:std_logic_vector(1 downto 0):="00";
signal LIVES: std_logic_vector(1 downto 0):="11";
signal Rdebounced: std_logic;
signal Ldebounced:std_logic;
signal rst: std_logic;
SIGNAL Obstacle_selector: std_logic_vector(6 downto 0);
signal crash: std_logic:='0';
signal count: std_logic_vector(2 downto 0);
signal go: std_logic:='0';
signal actual_obstacle: std_logic_vector(2 downto 0);
signal score_U: std_logic_vector(3 downto 0);
signal score_D: std_logic_vector(3 downto 0);
signal score_M: std_logic_vector(3 downto 0);
signal respawn: std_logic_vector(4 downto 0);

begin
PSH<=PSH_cable;
Blank<='1';
Sync<='0';
Clock_VGA<=CLK_cable;



elemento_1: div_frec port map(CLK_DE2,LVL,CLK_GAME,CLK_cable);
elemento_2: PSH_Block port map(CLK_cable,PSH_cable,PosHor_cable);
elemento_3: PSV_Block port map(PSH_cable,PSV,PosVer_cable );
elemento_4: graphics port map(PosHor_cable,PosVer_Cable,PosPlayer,PosCar1,PosCar2, PosCar3,PosCalle,LVL,LIVES,score_U,score_D,score_M,respawn,R,G,B);
elemento_5: debouncer port map(CLK_DE2,Rbutton,rst,Rdebounced);
elemento_6: debouncer port map(CLK_DE2,Lbutton,rst,Ldebounced);
elemento_7: Position port map(CLK_DE2,crash,Rdebounced,Ldebounced,rst,PosPlayer);
elemento_8: random port map (CLK_DE2, Obstacle_selector);


Process(CLK_GAME)
begin
if(rising_edge(CLK_GAME)) then
		
	if(LIVES>"00")then
		if(crash='0') then
			
			
			
			
			if(PosCalle>="10") then
				PosCalle<="00";
			else
				if(go='1')then
					PosCalle<=PosCalle+"01";
				else null;
				end if;
					
			end if;
			
			if(go='1' and (actual_obstacle="000" or actual_obstacle="011" or actual_obstacle="101" or actual_obstacle="110") )then
				if(PosCar1>="10011") then
					PosCar1<="00000";
					count<=count+"001";
					score_U<=score_U+"0001";
					if(score_U>="1001")then
						score_U<="0000";
						score_D<=score_D+"0001";
						if(score_D>="1001")then
							score_D<="0000";
							if(score_M<"1001")then
								score_M<=score_M+"0001";
							else null;
							end if;
						else null;
						end if;
					else null;
					end if;
					actual_obstacle<=obstacle_selector(6 downto 4);
				else
					PosCar1<=PosCar1+"00001";
				end if;
			else null;
			end if;
			
			if(go='1' and (actual_obstacle="001" or actual_obstacle="100"or actual_obstacle="101" or actual_obstacle="111" ) )then
				if(PosCar2>="10011") then
					PosCar2<="00000";
					actual_obstacle<=obstacle_selector(4 downto 2);
					count<=count+"001";
					score_U<=score_U+"0001";
					if(score_U>="1001")then
						score_U<="0000";
						score_D<=score_D+"0001";
						if(score_D>="1001")then
							score_D<="0000";
							if(score_M<"1001")then
								score_M<=score_M+"0001";
							else null;
							end if;
						else null;
						end if;
					else null;
					end if;
				else
					PosCar2<=PosCar2+"00001";
				end if;
			else null;
			end if;
			
			if(go='1' and (actual_obstacle="010" or actual_obstacle="110" or actual_obstacle="111") )then
				if(PosCar3>="10011") then
					PosCar3<="00000";
					actual_obstacle<=obstacle_selector(2 downto 0);
					count<=count+"001";
					score_U<=score_U+"0001";
					if(score_U>="1001")then
						score_U<="0000";
						score_D<=score_D+"0001";
						if(score_D>="1001")then
							score_D<="0000";
							if(score_M<"1001")then
								score_M<=score_M+"0001";
							else null;
							end if;
						else null;
						end if;
					else null;
					end if;
				else
					PosCar3<=PosCar3+"00001";
				end if;
			else null;
			end if;
			
			if(count>="111")then
				count<="000";
				if(LVL<"111")then
					LVL<=LVL+"001";
				else null;
				end if;
			else null;
			end if;
			
			if((PosPlayer="00" and PosCar1>="01100")or(PosPlayer="01" and PosCar2>="01100")or(PosPlayer="10" and PosCar3>="01100"))then
				crash<='1';
				count<="000";
			else null;
			end if;
			
		else
			if(count="000")then
				LIVES<=LIVES-"01";
			else null;
			end if;
			
			if(count>"110" and go='1')then
					if(respawn="00110")then	
						PosCar1<="00000";
						PosCar2<="00000";
						PosCar3<="00000";
					else null;
					end if;
					if(respawn>="11111")then
						respawn<="00000";
						crash<='0';
						count<="000";
						actual_obstacle<=obstacle_selector(5 downto 3);
					else 
						respawn<=respawn+"00001";
					end if;
			else
				if(count<"111")then
					count<=count+"001";
				else null;
				end if;
			end if;
		
		end if;
	else
		if(restart='0')then
			LIVES<="11";
			LVL<="000";
			count<="111";
			score_U<="0000";
			score_D<="0000";
			score_M<="0000";
			respawn<="00000";
		else null;
		end if;
	end if;
else null;
end if;
end process;

process(crash,Ldebounced,Rdebounced)
begin
	if(rising_edge(crash))then
		go<='0';
	else null;
	end if;
	if(Ldebounced='1' or Rdebounced='1' or (restart='0' and LIVES="00"))then
		go<='1';
	else null;
	end if;
	


end process;




end RTL;