

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.Constants.ALL;

entity Mechanics is
    Port( 
            clk: in STD_LOGIC;
            Hpos: in INTEGER range 0 to Htot - 1;
            Vpos : in INTEGER range 0 to Vtot - 1;
            buttonUR,buttonUL,buttonDR,buttonDL,buttonEnd: in STD_LOGIC;
            R,G,B: out STD_LOGIC_VECTOR (3 downto 0) );
end Mechanics;

architecture Behavioral of Mechanics is

    --SIGNALS
   signal toggleData: STD_LOGIC_VECTOR (27 downto 0);
   signal randomBit: STD_LOGIC;
   signal coilyState: STD_LOGIC_VECTOR( 1 downto 0);
   -- 00: not in the game yet
   -- 01: in the process of joining the game
   -- 10: exists as "coily egg"
   -- 11: coily has hatched 
     --00 not moving
   ------------------ 
   signal CoilyposX: INTEGER := refA(0,0);
   signal CoilyposY: INTEGER := shiftv;

   signal Enemyproximity: STD_LOGIC := '0';

   signal moveclock: STD_LOGIC_VECTOR ( 21 downto 0 );
  

   signal QbertposX: INTEGER := refA(3,1); 
   signal QbertposY: INTEGER := 400 + shiftv;

   signal Lives: STD_LOGIC_VECTOR ( 1 downto 0) := "11";
   signal QbertR: STD_LOGIC_VECTOR ( 3 downto 0) := "1111";
   signal QbertG: STD_LOGIC_VECTOR ( 3 downto 0) := "0100";

 
   ------------------
   signal score: INTEGER;
   signal endgame: STD_LOGIC_VECTOR ( 1 downto 0):= "00";
   signal startgame: STD_LOGIC := '0';
   --11 : restart
   --10 : won
   --01 : lost
   --00 : continue without ditruption
   signal reset: std_logic;
--COMPONENTS
component randomBitGen is
    Port ( clock : in STD_LOGIC;
       randomBit : out STD_LOGIC);
    end component;
    
component Drawing is
        Port( 
                clk, startgame: in STD_LOGIC;
                Hpos: in INTEGER range 0 to Htot - 1;
                Vpos : in INTEGER range 0 to Vtot - 1;
                QbertposX,QbertposY,CoilyposX,CoilyposY,score: in INTEGER;
                endgame, Lives, CoilyState: in STD_LOGIC_VECTOR (1 downto 0);
                toggleData: in STD_LOGIC_VECTOR (27 downto 0);
                QbertR,QbertG: in STD_LOGIC_VECTOR (3 downto 0);
                R,G,B: out STD_LOGIC_VECTOR (3 downto 0) );
    end component;
    
--   button debouncer
--    component buttonPress is
--        Port ( butclk : in STD_LOGIC;
--           UR : in STD_LOGIC;
--           UL : in STD_LOGIC;
--           DR : in STD_LOGIC;
--           DL : in STD_LOGIC;
--           R : in STD_LOGIC;
--           movement : out STD_LOGIC_VECTOR (3 downto 0);
--           reset : out STD_LOGIC );
--        end component;


begin
--  debouncecomp: buttonPress port map(
--       butclk => clk,
--       UR => buttonUR,
--       UL => buttonUL,
--       DR => buttonDR,
--       DL => buttonDL,
--       R => buttonEnd,
--       reset => reset,
--       movement => movement );

drawercomp: Drawing port map( 
            clk => clk,
            startgame => startgame,
            Hpos => Hpos,
            Vpos => Vpos,
            QbertposX => QbertposX,
            QbertposY => QbertposY,
            CoilyposX=> CoilyposX,
            CoilyposY=> CoilyposY,
            score=> score,
            endgame=> endgame, 
            Lives=> Lives, 
            CoilyState=> CoilyState,
            toggleData=> toggleData,
            QbertR=>QbertR,
            QbertG=>QbertG,
            R=>R,
            G=>G,
            B=>B );

randomcomp: randomBitGen port map(
       clock  => clk,
       randomBit  => randomBit );
process(clk)
begin
    if (rising_edge(clk)) then
      if ( moveclock(21) = '1') then     
        moveclock <= ( others => '0' );
      end if;
      moveclock <= moveclock + '1';
     end if;
end process;
process(moveclock(21),buttonEnd)
variable ingametimer: INTEGER;
variable Qbertdirection :STD_LOGIC_VECTOR ( 3 downto 0);
variable nextblockX, nextblockY: INTEGER;
variable movement: STD_LOGIC_VECTOR ( 3 downto 0);
variable CoilyMoving: STD_LOGIC; 
variable startgamevar: STD_LOGIC;
variable CoilynextX: INTEGER;
variable CoilynextY: INTEGER;
variable endgamevar: STD_LOGIC_VECTOR (1 downto 0) := endgame;
variable QbertposXvar,QbertposYvar,CoilyposXvar,CoilyposYvar,scorevar: INTEGER;
variable Livesvar: STD_LOGIC_VECTOR (1 downto 0):= Lives;
variable QbertblockX: INTEGER;
variable QbertblockY: INTEGER;
variable coilyStatevar: STD_LOGIC_VECTOR( 1 downto 0) := coilyState;
variable CoilyblockX: INTEGER := 0;
variable CoilyblockY: INTEGER := 0;
begin
    if ( rising_edge(moveclock(21)) ) then
      if ( buttonEnd = '1' and ingametimer mod 4 = 1) then
         startgamevar := '1';
         Qbertdirection := "0000";
         endgamevar := "00";
         coilyStatevar := "00";
         toggleData <= (others => '0');
         toggleData(0) <= '1';
         scorevar := 1;
         ingametimer := 0;
         QbertblockX := 0;
         QbertblockY := 0;
         nextblockX := 0; 
         nextblockY := 0;
         CoilyposXvar := refA(0,0);
         CoilyposYvar := shiftv;
         coilyBlockX := 0;
         CoilynextX := 0;
         coilyBlockY := 0;
         CoilynextY := 0;
         QbertR <= "1111";
         QbertG <= "0100";
         QbertposXvar := refA(0,0); 
         QbertposYvar := 100 + shiftv;
         Livesvar := "11"; 
       end if;
       if ( score = 28 ) then
         endgamevar := "10";
       end if;
       if ( endgamevar = "00" and startgamevar = '1' ) then   
       

          ---calculating coily proximity
          if QbertposXvar >= CoilyposXvar then
                if QbertposYvar >= CoilyposYvar then
                    if QbertposYvar - Coilyposyvar < 10 and QbertposXvar - CoilyposXvar < 10 then
                         Enemyproximity <= '1';
                    end if;
                elsif QbertposYvar < CoilyposYvar then
                    if Coilyposyvar - QbertposYvar < 10 and QbertposXvar - CoilyposXvar < 10 then
                     Enemyproximity <= '1';
                   end if;
                end if;
           elsif QbertposXvar < CoilyposXvar then
                if QbertposYvar > CoilyposYvar then
                    if QbertposYvar - Coilyposyvar < 10 and CoilyposXvar - QbertposXvar < 10 then
                         Enemyproximity <= '1';
                    end if;
                elsif QbertposYvar < CoilyposYvar then
                    if Coilyposyvar - QbertposYvar < 10 and CoilyposXvar - QbertposXvar < 10 then
                        Enemyproximity <= '1';
                    end if;
                end if;  
           end if;
           --QBERT LOSING A LIFE
           if ( QbertblockX = 0 and Qbertdirection(2) = '1' ) or -- falling from the left side
             ( QbertblockY = QbertblockX and Qbertdirection(3) = '1'  ) or -- falling from the right side
             ( QbertblockY = 6 and ( Qbertdirection(1) = '1' or Qbertdirection(0) = '1') ) or -- falling from the bottom edge
             ( Enemyproximity = '1') then -- colliding with coily
              if not( Livesvar = "00" ) then
                  -- loosing a life
                  Livesvar := Livesvar - "01";
                  QbertblockX := 0;
                  QbertblockY := 0;
                  QbertposXvar := refA(0,0); 
                  QbertposYvar := 100 + shiftv;
                  nextblockX := 0;
                  nextblockY := 0;
                  QbertG <= "0010"; 
                  --Qbert gets redder as it looses lives
               end if;
               if ( Livesvar = "00" ) then
                   endgamevar := "01";
                   QbertG <= ( others => '0' ); --Qbert becomes completely red when he loses his last life   
              end if;
            Qbertdirection := "0000"; 
            Enemyproximity <= '0';
         end if;
          --------------------------------------------------------MOVEMENT MECHANICS
         if ( Qbertdirection = "0000" and endgame = "00" ) then
              Qbertdirection := buttonUR & buttonUL & buttonDR & buttonDL;
              case Qbertdirection is
              --DL
                  when "0001" =>
                      nextblockY := nextblockY + 1;
             --DR
                  when "0010" =>
                      nextblockX := nextblockX + 1;
                      nextblockY := nextblockY + 1;
             --UL
                  when "0100" =>
                      nextblockY := nextblockY - 1;
                      nextblockX := nextblockX - 1;
             --UR        
                  when "1000" =>
                      nextblockY := nextblockY - 1;                    
                  when others =>
                      nextblockX := QbertblockX;
                      nextblockY := QbertblockY;
              end case;
          end if;
          if ( refA( nextblockY, nextblockX) = QbertposXvar 
              and  nextblockY*100 + 100 + shiftv = QbertposYvar ) and not(Qbertdirection = "0000") then
              
                      --completes movement
                      QbertblockX := nextblockX;
                     -- QbertposX <= refA( nextblockY, nextblockX);
                      QbertblockY := nextblockY;
                     -- QbertposY <= nextblockY*100 + 100 + shiftv;
                      Qbertdirection := "0000";   
                   if ( toggleData( QbertblockX + QbertblockY*( QbertblockY + 1 ) / 2 ) /= '1' ) then
                        scorevar := scorevar + 1;
                        toggleData( QbertblockX + QbertblockY*( QbertblockY + 1 ) / 2 ) <= '1';
                   end if;
          end if;

          --Coily's next position
          if ( coilyStatevar = "00" and ingametimer = 15 ) then
              CoilyposXvar := refA(0,0);
              CoilyposYvar := shiftv;
              CoilynextX := 0;
              CoilynextY := 0;
              coilyStatevar := "01"; 
              coilyMoving := '1';            
          elsif  refA( CoilynextY, CoilynextX) = CoilyposXvar and  CoilynextY*100 + 100 + shiftv = CoilyposYvar  then
              coilyMoving := '0';
              coilyBlockX := CoilynextX;
              coilyBlockY := CoilynextY;
              if ( coilyStatevar = "01") then
                  coilyStatevar := "10";
              elsif ( coilyStatevar = "10" ) then
                  if ( coilyBlockY = 6 ) then
                      coilyStatevar := "11";
                  elsif ( randomBit = '0' ) then
                      CoilynextY := CoilynextY + 1;  
                      coilyMoving := '1';              
                  elsif ( randomBit = '1' ) then
                      CoilynextX := CoilynextX + 1;
                      CoilynextY := CoilynextY + 1;
                      coilyMoving := '1';
                  end if;  
              end if;      
             -- the primitive AI of Coily after hatching
              if ( coilyStatevar = "11" and  coilyMoving = '0' ) then 
              coilyMoving := '1';
                 if QbertposXvar > CoilyposXvar then
                    if QbertposYvar > CoilyposYvar or 
                        ( QbertposYvar = CoilyposYvar and CoilyblockX = CoilyblockY )then 
                      -- Down Right
                      CoilynextY := CoilynextY + 1;
                      CoilynextX := CoilynextX + 1;       
                    elsif QbertposYvar < CoilyposYvar or 
                        ( QbertposYvar = CoilyposYvar and CoilyblockY = 6) then
                      --Up Right
                       CoilynextY := CoilynextY - 1;
                    elsif QbertposYvar = CoilyposYvar then
                        --Randomly select up or down right 
                        if ( randomBit = '0' ) then
                            CoilynextY := CoilynextY + 1;
                            CoilynextX := CoilynextX + 1;               
                        elsif ( randomBit = '1' ) then
                            CoilynextY := CoilynextY - 1;
                        end if;
                    end if;

                elsif QbertposXvar < CoilyposXvar then    
                    if QbertposYvar > CoilyposYvar or 
                       ( QbertposYvar = CoilyposYvar and CoilyblockX = 0) then
                        --Down Left
                        CoilynextY := CoilynextY + 1;
                    elsif QbertposYvar < CoilyposYvar or 
                        ( QbertposYvar = CoilyposYvar and CoilyblockY = 6) then
                        --Up Left
                         CoilynextY := CoilynextY - 1;
                         CoilynextX := CoilynextX - 1;
                    elsif QbertposYvar = CoilyposYvar then
                        --Randomly select up or down left 
                         if ( randomBit = '0' ) then
                             CoilynextY := CoilynextY - 1;
                              CoilynextX := CoilynextX - 1;             
                         elsif ( randomBit = '1' ) then
                             CoilynextY := CoilynextY + 1;
                         end if;
                    end if;
  
                elsif Qbertposxvar = Coilyposxvar then    
                    if QbertposYvar > CoilyposYvar then
                        --Down 
                        if ( randomBit = '0' ) then
                             CoilynextY := CoilynextY + 1;
                             CoilynextX := CoilynextX + 1;
                        elsif ( randomBit = '1' ) then
                              CoilynextY := CoilynextY + 1;
                         end if;
            
                    elsif QbertposYvar < CoilyposYvar then
                        --Up 
                        if ( randomBit = '0' ) then
                              CoilynextY := CoilynextY - 1;
                              CoilynextX := CoilynextX - 1;
                        elsif ( randomBit = '1' ) then
                              CoilynextY := CoilynextY - 1;
                        end if;
        
                     end if;
                end if; 
              end if;
           end if;
          if ( coilyMoving = '1') then
          --increment / derement position
            if coilyStatevar = "01" then
                 CoilyposYvar := CoilyposYvar + 2;
            elsif coilyStatevar = "11" or coilyStatevar = "10" then
                 if ( refA( CoilynextY, CoilynextX) > CoilyposXvar ) then
                     CoilyposXvar := CoilyposXvar + 1;
                 elsif ( refA( CoilynextY, CoilynextX) < CoilyposXvar ) then
                     CoilyposXvar := CoilyposXvar - 1;
                 end if;
                 if ( 100*CoilynextY + 100 + shiftv > CoilyposYvar ) then
                      CoilyposYvar := CoilyposYvar + 2;
                 elsif ( 100*CoilynextY + 100 + shiftv < CoilyposYvar ) then
                     CoilyposYvar := CoilyposYvar - 2;
                 end if;  
             end if;            
          end if;
          --THE MECHANICS OF QBERT
            --increment / derement position       
                if ( Qbertdirection = "0001" ) then
                    QbertposXvar := QbertposXvar -1;
                    QbertposYvar := QbertposYvar + 2;
                elsif ( Qbertdirection = "0010" ) then
                    QbertposXvar := QbertposXvar + 1;
                    QbertposYvar := QbertposYvar + 2;
                elsif ( Qbertdirection = "0100" ) then
                    QbertposYvar := QbertposYvar - 2;
                    QbertposXvar := QbertposXvar - 1;
                elsif ( Qbertdirection = "1000" ) then
                    QbertposYvar := QbertposYvar - 2;
                    QbertposXvar := QbertposXvar + 1;
                end if;                 
     end if;
   ingametimer := ingametimer + 1;
  end if;
        endgame <= endgamevar; 
       
        QbertposX <= QbertposXvar;
         QbertposY<= QbertposYvar;
        CoilyposX <= CoilyposXvar;
        Coilyposy <= CoilyposYvar;
        score <= scorevar;
        Lives <= Livesvar;
        CoilyState <= coilyStatevar;
        startgame <= startgamevar;
end process;

end Behavioral;

            