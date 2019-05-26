



library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.Constants.ALL;



entity Drawing is
    Port( 
            clk, startgame: in STD_LOGIC;
            Hpos: in INTEGER range 0 to Htot - 1;
            Vpos : in INTEGER range 0 to Vtot - 1;
            QbertposX,QbertposY,CoilyposX,CoilyposY,score: in INTEGER;
            endgame, Lives, CoilyState: in STD_LOGIC_VECTOR (1 downto 0);
            toggleData: in STD_LOGIC_VECTOR (27 downto 0);
            QbertR,QbertG: in STD_LOGIC_VECTOR (3 downto 0);
            R,G,B: out STD_LOGIC_VECTOR (3 downto 0) );
end Drawing;

architecture Behavioral of Drawing is
signal drawWon: STD_LOGIC;
signal drawGameOver: STD_LOGIC;
signal drawBackground: STD_LOGIC;
signal drawQbert: STD_LOGIC;
signal drawCoily: STD_LOGIC;
signal drawStart: STD_LOGIC;
signal drawBadBalls: STD_LOGIC;
signal RB, GB, BB : STD_LOGIC_VECTOR (3 downto 0);
begin
process(clk)
  begin
    if( rising_edge(clk) ) then   
         drawBackground <= '0';
         drawQbert <= '0';
         drawCoily <= '0';
         drawBadBalls <= '0';
         drawGameOver <= '0';
         drawWon <= '0';    
         drawStart <= '0';
        if ( ( Hpos > 0 and Hpos < HFP + HSP + HBP ) or ( Vpos > 0 and Vpos < VFP + VSP + VBP ) ) then
           R <= ( others => '0' );
           G <= ( others => '0' );
           B <= ( others => '0' );
        else
          --QBERT
              if ( Vpos > QbertposY and Hpos < QbertposX + 99  and Hpos > QbertposX  and Vpos < QbertposY + 99 ) then
                drawQbert <=Qbertmap( Vpos - QbertposY)(Hpos - QbertposX );
              end if;
        --END OF GAME
                      --BACKGROUND 
            -- the top faces of the cubes

            for x in 0 to 6 loop
            for y in 0 to 6 loop
              if (startgame = '1' and x <= y ) or 
                 (startgame = '0' and (  (y = 2 and x < 2) or (y= 3 and x = 1) or (y = 4 and (x = 1 or x = 2)) ) )
                 then
                if ( Vpos + Hpos > refA(y,x) + y*100 + 100 + shiftv + 50  ) AND
                 ( Vpos + Hpos < refA(y,x) + y*100 + shiftv + 100 + 150  ) AND 
                 ( Vpos - Hpos > y*100 + shiftv + 100 - refA(y,x) - 50  ) AND 
                 ( Vpos - Hpos < y*100 + shiftv + 100 - refA(y,x) + 50  ) then
                 
                    if toggleData(x+y*(y+1)/2) = '1' then
                      ------------------
                        RB <= "0000";
                        GB <= "1111";
                        BB <= "1111";
                     else
                        RB <= "1111";
                        GB <= "1111";
                        BB <= "0000";
                     end if;
                     drawBackground <= '1';   
                -- drawing the sides of the cubes   
                elsif ( Vpos - Hpos > y*100 + shiftv + 100 - refA(y,x) + 50  ) AND
                      ( Vpos - Hpos < y*100 + shiftv + 100 - refA(y,x) + 100  ) AND
                      ( Hpos > refA(y,x) ) AND ( Hpos < refA(y,x) + 50 ) then
                         RB <= "0110";
                         GB <= "1111";
                         BB <= "0000";
                         drawBackground <= '1';  
                elsif ( Vpos + Hpos > refA(y,x) + y*100 + shiftv + 100 + 150  ) AND
                      ( Vpos + Hpos < refA(y,x) + y*100 + shiftv + 100 + 200  ) AND
                      ( Hpos > refA(y,x) + 50 ) AND ( Hpos < refA(y,x) + 100 ) then
                          RB <= "0010";
                          GB <= "1111";
                          BB <= "0110";
                          drawBackground <= '1';  
                end if;
             end if;
          end loop;
          end loop;
                        
        if ( startgame = '1') then
          --DRAWING "GAME OVER" AND QBERT'S NOISE BUBBLE 
              if endgame = "01" and ( ( Vpos > QbertposY -12 and Hpos <= QbertposX + 125 
                                     and Hpos > QbertposX + 75  and Vpos <= QbertposY + 16
                                     and swearA( Vpos - QbertposY + 12)(Hpos - QbertposX - 75 ) = '1' ) or
                                    ( Vpos > 50 + shiftv and Vpos <= 176 + shiftv
                                    and Hpos > 620 + shifth and Hpos <= 820 + shifth
                                    and govA( Vpos - 50 - shiftv)(Hpos - 620 - shifth) = '1' ) ) then
                 drawGameOver <= '1';
              end if;  
          --DRAWING YOU WON               
               if endgame = "10" and Vpos > 50 + shiftv and Vpos <= 176 + shiftv
                                 and Hpos > 570 + shifth and Hpos <= 870 + shifth
                                 and wonA( Vpos - 50 - shiftv)(Hpos - 570 - shifth) = '1'  then
                    drawWon <= '1';
               end if;    
          --COILY
              if ( coilyState /= "00" and Vpos > CoilyposY and Hpos < CoilyposX + 99 and Hpos > CoilyposX and Vpos < CoilyposY + 198 ) then
                  if ( coilyState = "01" or coilyState = "10" ) then
                      if ( 400 >= (( Hpos - CoilyposX - 50 )**2)/4 + ( Vpos - CoilyposY - 50 )**2 ) then
                         drawCoily <= '1'; 
                      end if;
                  elsif ( coilyState = "11" ) then
                   drawCoily <=Coilymap( Vpos - CoilyposY)(Hpos - CoilyposX );
                  end if;
              end if;
                            
            --drawing scoreboard
            if  (  ( Vpos > 180 + shiftv and Vpos < 269 + shiftv and Hpos > 50 + shifth and Hpos < 109 + shifth ) and
                ( numA( Vpos - 180 - shiftv )(Hpos - 50 - shifth + 60*(score/10) ) = '1' ) ) or
                (  ( Vpos > 180 + shiftv and Vpos < 269 + shiftv and Hpos > 130 + shifth and Hpos < 189 + shifth ) and
                ( numA( Vpos - 180 - shiftv )(Hpos - 130 - shifth + 60*(score mod 10) ) = '1' ) ) then
                    RB <= QbertR;
                    GB <= QbertG;
                    BB <= (others => '0');
                    drawBackground <= '1';
            end if;   
            --drawing lives left (hearts)
            if ( Vpos >= 50 + shiftv and Vpos < 130 + shiftv and Hpos >= 50 + shifth and Hpos < 130 + shifth ) then
                if HeartA( Vpos - 50 - shiftv )(Hpos - 50 - shifth ) = '1' then
                    if not (Lives= "00") then
                        RB <= "1111";
                        GB <= ( others => '0' );
                        BB <= ( others => '0' );
                        drawBackground <= '1';
                    elsif not( (Hpos - shifth - Vpos + shiftv < 7 and Vpos - shiftv - Hpos + shifth < 7) 
                    or ( Hpos - shifth + Vpos - shiftv < 187 and Hpos - shifth + Vpos - shiftv > 173 ) ) then
                        RB <= "1000";
                        GB <= "0010";
                        BB <= ( others => '0' );
                        drawBackground <= '1';
                    end if;
                end if;
            elsif ( Vpos >= 50 + shiftv and Vpos < 130 + shiftv and Hpos >= 130 + shifth and Hpos < 210 + shifth ) then
                if HeartA( Vpos - 50 - shiftv )(Hpos - 130 - shifth ) = '1' then
                     if Lives="11" or Lives="10" then
                         RB <= "1111";
                         GB <= ( others => '0' );
                         BB <= ( others => '0' );
                        drawBackground <= '1';                         
                     elsif not ( (Hpos - shifth - Vpos + shiftv < 87 and Vpos - shiftv - Hpos + shifth + 80 < 7) 
                     or ( Hpos - shifth + Vpos - shiftv < 267 and Hpos - shifth + Vpos - shiftv > 253) ) then
                         RB <= "1000";
                         GB <= "0010";
                         BB <= ( others => '0' );
                        drawBackground <= '1';                         
                     end if;
                 end if;
            elsif ( Vpos >= 50 + shiftv and Vpos < 130 + shiftv and Hpos >= 210 + shifth and Hpos < 290 + shifth ) then
                if HeartA( Vpos - 50 - shiftv )(Hpos - 210 - shifth ) = '1' then
                     if Lives = "11" then
                         RB <= "1111";
                         GB <= ( others => '0' );
                         BB <= ( others => '0' );
                         drawBackground <= '1';                  
                     elsif not ( (Hpos - shifth - Vpos + shiftv < 167 and Vpos - shiftv - Hpos + shifth + 160 < 7) or 
                     ( Hpos -shifth + Vpos - shiftv < 347 and Hpos - shifth + Vpos - shiftv > 333) ) then
                         RB <= "1000";
                         GB <= "0010";
                         BB <= ( others => '0' );
                         drawBackground <= '1';                       
                     end if;
                 end if;
            end if; 
         end if;      
         if startgame = '0' then 
            --DRAWING THE START SCREEN
                if ( Vpos > 300 + shiftv and Vpos < 721 + shiftv and Hpos > 800 + shifth and Hpos < 1182 + shifth ) then
                    if butA( Vpos - 300 - shiftv )(Hpos - 800 - shifth ) = '1' then
                             drawStart <= '1';
                     end if;  
                  end if; 
          end if;                                                
           ------------------------------------------------------ determining the order in which images are displayed when superposed 
              if drawGameOver = '1' or drawWon = '1' or  drawStart = '1' then
                  R <= (others => '1');
                  G <= (others => '1');
                  B <= (others => '1');
              elsif drawQbert = '1' then
                  R <= QbertR;
                  G <= QbertG;
                  B <= (others => '0');
              elsif drawCoily = '1' then
                  R <= "1111";
                  G <= "0011";
                  B <= "1110";
              elsif drawBadBalls = '1' then
                  R <= "1111";
                  G <= "0001";
                  B <= (others => '0');
              elsif drawBackground = '1' then
                 R <= RB;
                 G <= GB;
                 B <= BB;
             else
                 R <= (others => '0');
                 G <= (others => '0');
                 B <= (others => '0');
             end if;
         end if;    
       end if;

end process;
end Behavioral;
