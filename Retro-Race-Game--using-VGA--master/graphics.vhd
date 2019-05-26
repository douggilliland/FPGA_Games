library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

ENTITY graphics IS
PORT(PosHor: in std_logic_vector(9 downto 0);  
	  PosVer: in std_logic_vector(9 downto 0);
	  Player: in std_logic_vector(1 downto 0);
	  PosCar1: in std_logic_vector(4 downto 0);
	  PosCar2: in std_logic_vector(4 downto 0);
	  PosCar3: in std_logic_vector(4 downto 0);
	  PosCalle: in std_logic_vector(1 downto 0);
	  LVL: in std_logic_vector(2 downto 0);
	  LIVES: in std_logic_vector(1 downto 0);
	  score_U:in std_logic_vector(3 downto 0);
	  score_D:in std_logic_vector(3 downto 0);
	  score_M:in std_logic_vector(3 downto 0);
	  respawn: in std_logic_vector(4 downto 0);
	  R:out std_logic_vector(9 downto 0);
	  G:out std_logic_vector(9 downto 0);
	  B:out std_logic_vector(9 downto 0));
	  
 END graphics;

architecture RTL of graphics is

signal x,y : integer range 0 to 800;
signal Pos1: integer range 0 to 20;
signal Pos2: integer range 0 to 20;
signal Pos3: integer range 0 to 20;
signal PosC: integer range 0 to 3;
signal PosR: integer range 0 to 32;

begin

x <= conv_integer(PosHor);
y <= conv_integer(PosVer);
Pos1<=conv_integer(PosCar1);
Pos2<=conv_integer(PosCar2);
Pos3<=conv_integer(PosCar3);
PosC<=conv_integer(PosCalle);
PosR<=conv_integer(respawn);

Process(PosHor)
begin
if(x>143 and x<778 and  y>35 and y<515) then
	if((x>143 and x<203)or (x>533)) then --Bordes negros
		
		if((x>=593 and x<610 and y>=65 and y<70)or	--S
			(x>=588 and x<593 and y>=70 and y<85)or
			(x>=593 and x<608 and y>=85 and y<90)or
			(x>=608 and x<613 and y>=90 and y<105)or
			(x>=591 and x<608 and y>=105 and y<110)or
			(x>=618 and x<623 and y>=65 and y<110)or	--P
			(x>=618 and x<638 and y>=65 and y<70)or
			(x>=618 and x<638 and y>=85 and y<90)or
			(x>=638 and x<643 and y>=70 and y<85)or
			(x>=648 and x<653 and y>=65 and y<105)or	--E
			(x>=648 and x<668 and y>=65 and y<70)or
			(x>=648 and x<668 and y>=85 and y<90)or
			(x>=648 and x<668 and y>=105 and y<110)or
			(x>=673 and x<678 and y>=65 and y<105)or	--E
			(x>=673 and x<693 and y>=65 and y<70)or
			(x>=673 and x<693 and y>=85 and y<90)or
			(x>=673 and x<693 and y>=105 and y<110)or
			(x>=698 and x<703 and y>=65 and y<110)or 	--D
			(x>=698 and x<718 and y>=65 and y<70)or
			(x>=698 and x<718 and y>=105 and y<110)or
			(x>=718 and x<723 and y>=70 and y<105)
		)then 
			R<="1011111011";
			G<="1101100011";
			B<="1001000011";
		else
			if((x>=623 and x<633 and y>=135 and y<175))then
				if(LVL="011" or LVL="100" or LVL="101" or LVL="111")then
					R<="1011111011";
					G<="1101100011";
					B<="1001000011";
				else
					R<="0001010011";
					G<="0001010011";
					B<="0001010011";
				end if;
			else
				if(x>=623 and x<633 and y>=185 and y<225)then
					if(LVL="001" or LVL="101" or LVL="111")then
						R<="1011111011";
						G<="1101100011";
						B<="1001000011";
					else
						R<="0001010011";
						G<="0001010011";
						B<="0001010011";
					end if;
				else
					if(x>=633 and x<673 and y>=125 and y<135)then	
						if(LVL="001" or LVL="010" or LVL="100" or LVL="101" or LVL="110" or LVL="111")then
							R<="1011111011";
							G<="1101100011";
							B<="1001000011";
						else
							R<="0001010011";
							G<="0001010011";
							B<="0001010011";
						end if;
					else
						if(x>=633 and x<673 and y>=175 and y<185)then
							if(LVL="001" or LVL="010" or LVL="011" or LVL="101" or LVL="100" or LVL="111")then
								R<="1011111011";
								G<="1101100011";
								B<="1001000011";
							else
								R<="0001010011";
								G<="0001010011";
								B<="0001010011";
							end if;
						else
							if(x>=633 and x<673 and y>=225 and y<235)then
								if(LVL="001" or LVL="010" or LVL="100" or LVL="101" or LVL="111")then
									R<="1011111011";
									G<="1101100011";
									B<="1001000011";
								else
									R<="0001010011";
									G<="0001010011";
									B<="0001010011";
								end if;
							else
								if(x>=673 and x<683 and y>=135 and y<175)then
									if(LVL="000" or LVL="001" or LVL="010" or LVL="011" or LVL="110" or LVL="111")then
										R<="1011111011";
										G<="1101100011";
										B<="1001000011";
									else
										R<="0001010011";
										G<="0001010011";
										B<="0001010011";
									end if;
								else
									if(x>=673 and x<683 and y>=185 and y<225)then
										if(LVL="000" or LVL="010" or LVL="011" or LVL="100" or LVL="101" or LVL="110" or LVL="111")then
											R<="1011111011";
											G<="1101100011";
											B<="1001000011";
										else
											R<="0001010011";
											G<="0001010011";
											B<="0001010011";
										end if;
									else
										if((x>=583 and x<588 and y>=435 and y<450)or--Vida 1
											(x>=588 and x<603 and y>=430 and y<435)or
											(x>=603 and x<608 and y>=435 and y<440)or
											(x>=608 and x<623 and y>=430 and y<435)or
											(x>=623 and x<628 and y>=435 and y<450)or
											(x>=588 and x<593 and y>=450 and y<455)or
											(x>=593 and x<598 and y>=455 and y<460)or
											(x>=598 and x<603 and y>=460 and y<465)or
											(x>=603 and x<608 and y>=465 and y<470)or
											(x>=608 and x<613 and y>=460 and y<465)or
											(x>=613 and x<618 and y>=455 and y<460)or
											(x>=618 and x<623 and y>=450 and y<455)
										)then
											if(LIVES<"11")then
												R<="0000000000";
												G<="0000000000";
												B<="0000000000";
											else
												R<="1011111011";
												G<="1101100011";
												B<="1001000011";
											end if;
										else
											if((x>=583+50 and x<588+50 and y>=435 and y<450)or--Vida 2
												(x>=588+50 and x<603+50 and y>=430 and y<435)or
												(x>=603+50 and x<608+50 and y>=435 and y<440)or
												(x>=608+50 and x<623+50 and y>=430 and y<435)or
												(x>=623+50 and x<628+50 and y>=435 and y<450)or
												(x>=588+50 and x<593+50 and y>=450 and y<455)or
												(x>=593+50 and x<598+50 and y>=455 and y<460)or
												(x>=598+50 and x<603+50 and y>=460 and y<465)or
												(x>=603+50 and x<608+50 and y>=465 and y<470)or
												(x>=608+50 and x<613+50 and y>=460 and y<465)or
												(x>=613+50 and x<618+50 and y>=455 and y<460)or
												(x>=618+50 and x<623+50 and y>=450 and y<455)
											)then
												if(LIVES<"10")then
													R<="0000000000";
													G<="0000000000";
													B<="0000000000";
												else
													R<="1011111011";
													G<="1101100011";
													B<="1001000011";
												end if;
											else
												if((x>=583+100 and x<588+100 and y>=435 and y<450)or--Vida 3
													(x>=588+100 and x<603+100 and y>=430 and y<435)or
													(x>=603+100 and x<608+100 and y>=435 and y<440)or
													(x>=608+100 and x<623+100 and y>=430 and y<435)or
													(x>=623+100 and x<628+100 and y>=435 and y<450)or
													(x>=588+100 and x<593+100 and y>=450 and y<455)or
													(x>=593+100 and x<598+100 and y>=455 and y<460)or
													(x>=598+100 and x<603+100 and y>=460 and y<465)or
													(x>=603+100 and x<608+100 and y>=465 and y<470)or
													(x>=608+100 and x<613+100 and y>=460 and y<465)or
													(x>=613+100 and x<618+100 and y>=455 and y<460)or
													(x>=618+100 and x<623+100 and y>=450 and y<455)
												)then
													if(LIVES<"01")then
														R<="0000000000";
														G<="0000000000";
														B<="0000000000";
													else
														R<="1011111011";
														G<="1101100011";
														B<="1001000011";
													end if;
												else
												
													if((x>=543 and x<550 and y>=340 and y<343)or--S
														(x>=540 and x<543 and y>=343 and y<350)or
														(x>=543 and x<550 and y>=350 and y<353)or
														(x>=550 and x<553 and y>=353 and y<360)or
														(x>=543 and x<550 and y>=360 and y<363)or
														(x>=558 and x<561 and y>=350 and y<360)or--c
														(x>=561 and x<571 and y>=347 and y<350)or
														(x>=561 and x<571 and y>=360 and y<363)or
														(x>=575 and x<578 and y>=350 and y<360)or--o
														(x>=578 and x<588 and y>=347 and y<350)or
														(x>=578 and x<588 and y>=360 and y<363)or
														(x>=588 and x<591 and y>=350 and y<360)or
														(x>=595 and x<598 and y>=347 and y<363)or--r
														(x>=598 and x<601 and y>=350 and y<353)or
														(x>=601 and x<604 and y>=347 and y<350)or
														(x>=607 and x<619 and y>=354 and y<357)or--e
														(x>=607 and x<610 and y>=349 and y<360)or
														(x>=619 and x<622 and y>=349 and y<355)or
														(x>=610 and x<619 and y>=347 and y<350)or
														(x>=610 and x<620 and y>=360 and y<363)
														
													)then
														R<="1011111011";
														G<="1101100011";
														B<="1001000011";
													else
														if(x>=638 and x<653 and y>=340 and y<345)then
															if(score_M="0000" or score_M="0010" or score_M="0011" or score_M>"0100")then
																R<="1011111011";
																G<="1101100011";
																B<="1001000011";
															else
																R<="0001010011";
																G<="0001010011";
																B<="0001010011";
															end if;
														else
															if(x>=633 and x<638 and y>=345 and y<360)then
																if(score_M="0000" or (score_M>="0100" and score_M<="0110") or score_M>"0111")then
																	R<="1011111011";
																	G<="1101100011";
																	B<="1001000011";
																else
																	R<="0001010011";
																	G<="0001010011";
																	B<="0001010011";
																end if;
															else
																if(x>=653 and x<658 and y>=345 and y<360)then
																	if((score_M>="0000" and score_M<="0100") or score_M>="0111")then
																		R<="1011111011";
																		G<="1101100011";
																		B<="1001000011";
																	else
																		R<="0001010011";
																		G<="0001010011";
																		B<="0001010011";
																	end if;
																else
																	if(x>=638 and x<653 and y>=360 and y<365)then
																		if((score_M>="0010" and score_M<="0110") or score_M>"0111")then
																			R<="1011111011";
																			G<="1101100011";
																			B<="1001000011";
																		else
																			R<="0001010011";
																			G<="0001010011";
																			B<="0001010011";
																		end if;
																	else
																		if(x>=633 and x<638 and y>=365 and y<380)then
																			if(score_M="0000" or score_M="0010" or score_M="0110" or score_M="1000")then
																				R<="1011111011";
																				G<="1101100011";
																				B<="1001000011";
																			else
																				R<="0001010011";
																				G<="0001010011";
																				B<="0001010011";
																			end if;
																		else
																			if(x>=653 and x<658 and y>=365 and y<380)then
																				if(score_M<"0010" or score_M>"0010")then
																					R<="1011111011";
																					G<="1101100011";
																					B<="1001000011";
																				else
																					R<="0001010011";
																					G<="0001010011";
																					B<="0001010011";
																				end if;
																			else
																				if(x>=638 and x<653 and y>=380 and y<385)then
																					if(score_M="0000" or score_M="0010" or score_M="0011" or score_M="0101" or score_M="0110" or score_M="1000")then
																						R<="1011111011";
																						G<="1101100011";
																						B<="1001000011";
																					else
																						R<="0001010011";
																						G<="0001010011";
																						B<="0001010011";
																					end if;
																				else
																					---------
																					if(x>=638+35 and x<653+35 and y>=340 and y<345)then
																						if(score_D="0000" or score_D="0010" or score_D="0011" or score_D>"0100")then
																							R<="1011111011";
																							G<="1101100011";
																							B<="1001000011";
																						else
																							R<="0001010011";
																							G<="0001010011";
																							B<="0001010011";
																						end if;
																					else
																						if(x>=633+35 and x<638+35 and y>=345 and y<360)then
																							if(score_D="0000" or (score_D>="0100" and score_D<="0110") or score_D>"0111")then
																								R<="1011111011";
																								G<="1101100011";
																								B<="1001000011";
																							else
																								R<="0001010011";
																								G<="0001010011";
																								B<="0001010011";
																							end if;
																						else
																							if(x>=653+35 and x<658+35 and y>=345 and y<360)then
																								if((score_D>="0000" and score_D<="0100") or score_D>="0111")then
																									R<="1011111011";
																									G<="1101100011";
																									B<="1001000011";
																								else
																									R<="0001010011";
																									G<="0001010011";
																									B<="0001010011";
																								end if;
																							else
																								if(x>=638+35 and x<653+35 and y>=360 and y<365)then
																									if((score_D>="0010" and score_D<="0110") or score_D>"0111")then
																										R<="1011111011";
																										G<="1101100011";
																										B<="1001000011";
																									else
																										R<="0001010011";
																										G<="0001010011";
																										B<="0001010011";
																									end if;
																								else
																									if(x>=633+35 and x<638+35 and y>=365 and y<380)then
																										if(score_D="0000" or score_D="0010" or score_D="0110" or score_D="1000")then
																											R<="1011111011";
																											G<="1101100011";
																											B<="1001000011";
																										else
																											R<="0001010011";
																											G<="0001010011";
																											B<="0001010011";
																										end if;
																									else
																										if(x>=653+35 and x<658+35 and y>=365 and y<380)then
																											if(score_D<"0010" or score_D>"0010")then
																												R<="1011111011";
																												G<="1101100011";
																												B<="1001000011";
																											else
																												R<="0001010011";
																												G<="0001010011";
																												B<="0001010011";
																											end if;
																										else
																											if(x>=638+35 and x<653+35 and y>=380 and y<385)then
																												if(score_D="0000" or score_D="0010" or score_D="0011" or score_D="0101" or score_D="0110" or score_D="1000")then
																													R<="1011111011";
																													G<="1101100011";
																													B<="1001000011";
																												else
																													R<="0001010011";
																													G<="0001010011";
																													B<="0001010011";
																												end if;
																											else
																												---------
																												if(x>=638+70 and x<653+70 and y>=340 and y<345)then
																													if(score_U="0000" or score_U="0010" or score_U="0011" or score_U>"0100")then
																														R<="1011111011";
																														G<="1101100011";
																														B<="1001000011";
																													else
																														R<="0001010011";
																														G<="0001010011";
																														B<="0001010011";
																													end if;
																												else
																													if(x>=633+70 and x<638+70 and y>=345 and y<360)then
																														if(score_U="0000" or (score_U>="0100" and score_U<="0110") or score_U>"0111")then
																															R<="1011111011";
																															G<="1101100011";
																															B<="1001000011";
																														else
																															R<="0001010011";
																															G<="0001010011";
																															B<="0001010011";
																														end if;
																													else
																														if(x>=653+70 and x<658+70 and y>=345 and y<360)then
																															if((score_U>="0000" and score_U<="0100") or score_U>="0111")then
																																R<="1011111011";
																																G<="1101100011";
																																B<="1001000011";
																															else
																																R<="0001010011";
																																G<="0001010011";
																																B<="0001010011";
																															end if;
																														else
																															if(x>=638+70 and x<653+70 and y>=360 and y<365)then
																																if((score_U>="0010" and score_U<="0110") or score_U>"0111")then
																																	R<="1011111011";
																																	G<="1101100011";
																																	B<="1001000011";
																																else
																																	R<="0001010011";
																																	G<="0001010011";
																																	B<="0001010011";
																																end if;
																															else
																																if(x>=633+70 and x<638+70 and y>=365 and y<380)then
																																	if(score_U="0000" or score_U="0010" or score_U="0110" or score_U="1000")then
																																		R<="1011111011";
																																		G<="1101100011";
																																		B<="1001000011";
																																	else
																																		R<="0001010011";
																																		G<="0001010011";
																																		B<="0001010011";
																																	end if;
																																else
																																	if(x>=653+70 and x<658+70 and y>=365 and y<380)then
																																		if(score_U<"0010" or score_U>"0010")then
																																			R<="1011111011";
																																			G<="1101100011";
																																			B<="1001000011";
																																		else
																																			R<="0001010011";
																																			G<="0001010011";
																																			B<="0001010011";
																																		end if;
																																	else
																																		if(x>=638+70 and x<653+70 and y>=380 and y<385)then
																																			if(score_U="0000" or score_U="0010" or score_U="0011" or score_U="0101" or score_U="0110" or score_U="1000")then
																																				R<="1011111011";
																																				G<="1101100011";
																																				B<="1001000011";
																																			else
																																				R<="0001010011";
																																				G<="0001010011";
																																				B<="0001010011";
																																			end if;
																																		else
																																			R<="0000000000";
																																			G<="0000000000";
																																			B<="0000000000";
																																		end if;
																																	end if;
																																end if;
																															end if;
																														end if;
																													end if;
																												end if;
																											end if;
																										end if;
																									end if;
																								end if;
																							end if;
																						end if;
																					end if;
																				end if;
																			end if;
																		end if;
																	end if;
																end if;
															end if;
														end if;
													end if;
												
												end if;
											end if;
										end if;
									end if;
								end if;
							end if;
						end if;
					end if;
				end if;
			end if;
			
		end if;
		
		
	-----------------------------------------	
	else
		if((PosR>0 and x>=203 and x<=533 and y>=(515-(30*PosR)) and y<515 and PosR<=16)or
			(PosR>0 and x>=203 and x<=533 and y>=(515-(30*(PosR-((PosR-16)*2)))) and y<515 and PosR>16)
		)then
			if(((x>(0*30)+203+5 and x<(0*30)+203+25)or
				 (x>(1*30)+203+5 and x<(1*30)+203+25)or
				 (x>(2*30)+203+5 and x<(2*30)+203+25)or
				 (x>(3*30)+203+5 and x<(3*30)+203+25)or
				 (x>(4*30)+203+5 and x<(4*30)+203+25)or
				 (x>(5*30)+203+5 and x<(5*30)+203+25)or
				 (x>(6*30)+203+5 and x<(6*30)+203+25)or
				 (x>(7*30)+203+5 and x<(7*30)+203+25)or
				 (x>(8*30)+203+5 and x<(8*30)+203+25)or
				 (x>(9*30)+203+5 and x<(9*30)+203+25)or
				 (x>(10*30)+203+5 and x<(10*30)+203+25)
				 )and ((y>(0*30)+35+5 and y<(0*30)+35+25)or
				 (y>(1*30)+35+5 and y<(1*30)+35+25)or
				 (y>(2*30)+35+5 and y<(2*30)+35+25)or
				 (y>(3*30)+35+5 and y<(3*30)+35+25)or
				 (y>(4*30)+35+5 and y<(4*30)+35+25)or
				 (y>(5*30)+35+5 and y<(5*30)+35+25)or
				 (y>(6*30)+35+5 and y<(6*30)+35+25)or
				 (y>(7*30)+35+5 and y<(7*30)+35+25)or
				 (y>(8*30)+35+5 and y<(8*30)+35+25)or
				 (y>(9*30)+35+5 and y<(9*30)+35+25)or
				 (y>(10*30)+35+5 and y<(10*30)+35+25)or
				 (y>(11*30)+35+5 and y<(11*30)+35+25)or
				 (y>(12*30)+35+5 and y<(12*30)+35+25)or
				 (y>(13*30)+35+5 and y<(13*30)+35+25)or
				 (y>(14*30)+35+5 and y<(14*30)+35+25)or
				 (y>(15*30)+35+5 and y<(15*30)+35+25)))	then
				R<="0000000000";
				G<="0000000000";
				B<="0000000000";
			else
				if((((x>(0*30)+200+5 and x<(0*30)+206+25)or
					 (x>(1*30)+200+5 and x<(1*30)+206+25)or
					 (x>(2*30)+200+5 and x<(2*30)+206+25)or
					 (x>(3*30)+200+5 and x<(3*30)+206+25)or
					 (x>(4*30)+200+5 and x<(4*30)+206+25)or
					 (x>(5*30)+200+5 and x<(5*30)+206+25)or
					 (x>(6*30)+200+5 and x<(6*30)+206+25)or
					 (x>(7*30)+200+5 and x<(7*30)+206+25)or
					 (x>(8*30)+200+5 and x<(8*30)+206+25)or
					 (x>(9*30)+200+5 and x<(9*30)+206+25)or
					 (x>(10*30)+200+5 and x<(10*30)+206+25)
					 )and ((y>(0*30)+32+5 and y<(0*30)+35+25)or
					 (y>(1*30)+32+5 and y<(1*30)+38+25)or
					 (y>(2*30)+32+5 and y<(2*30)+38+25)or
					 (y>(3*30)+32+5 and y<(3*30)+38+25)or
					 (y>(4*30)+32+5 and y<(4*30)+38+25)or
					 (y>(5*30)+32+5 and y<(5*30)+38+25)or
					 (y>(6*30)+32+5 and y<(6*30)+38+25)or
					 (y>(7*30)+32+5 and y<(7*30)+38+25)or
					 (y>(8*30)+32+5 and y<(8*30)+38+25)or
					 (y>(9*30)+32+5 and y<(9*30)+38+25)or
					 (y>(10*30)+32+5 and y<(10*30)+38+25)or
					 (y>(11*30)+32+5 and y<(11*30)+38+25)or
					 (y>(12*30)+32+5 and y<(12*30)+38+25)or
					 (y>(13*30)+32+5 and y<(13*30)+38+25)or
					 (y>(14*30)+32+5 and y<(14*30)+38+25)or
					 (y>(15*30)+32+5 and y<(15*30)+38+25)))or
					x=(1*30)+203 or x=(2*30)+203 or x=(3*30)+203 or x=(4*30)+203 or x=(5*30)+203 or x=(6*30)+203 or x=(7*30)+203 or
					x=(8*30)+203 or x=(9*30)+203 or x=(10*30)+203 or y=(12*30)+35 or y=(13*30)+35 or y=(14*30)+35 or y=(15*30)+35
					or y=(1*30)+35 or y=(2*30)+35 or y=(3*30)+35 or y=(4*30)+35 or y=(5*30)+35 or y=(6*30)+35 or y=(7*30)+35
					or y=(8*30)+35 or y=(9*30)+35 or y=(10*30)+35 or y=(11*30)+35)	then
					
					R<="1011111011";
					G<="1101100011";
					B<="1001000011";
				else
					R<="0000000000";
					G<="0000000000";
					B<="0000000000";
				end if;
			end if;
		else 

		if(LIVES="00" and x>=243 and x<493 and y>=155 and y<335)then
			if((x>=278 and x<288 and y>=195 and y<225)or--G
				(x>=283 and x<293 and y>=190 and y<195)or
				(x>=288 and x<313 and y>=185 and y<190)or
				(x>=283 and x<293 and y>=225 and y<230)or
				(x>=288 and x<318 and y>=230 and y<235)or
				(x>=308 and x<318 and y>=210 and y<230)or
				(x>=303 and x<313 and y>=210 and y<215)or
				(x>=328 and x<338 and y>=195 and y<235)or--A
				(x>=333 and x<343 and y>=190 and y<195)or 
				(x>=338 and x<353 and y>=185 and y<190)or
				(x>=348 and x<358 and y>=190 and y<195)or
				(x>=353 and x<363 and y>=195 and y<235)or
				(x>=338 and x<353 and y>=210 and y<220)or
				(x>=373 and x<383 and y>=185 and y<235)or--M
				(x>=383 and x<388 and y>=190 and y<210)or
				(x>=388 and x<393 and y>=195 and y<215)or
				(x>=393 and x<398 and y>=190 and y<210)or
				(x>=398 and x<408 and y>=185 and y<235)or
				(x>=418 and x<428 and y>=185 and y<235)or--E
				(x>=428 and x<453 and y>=185 and y<192)or
				(x>=428 and x<448 and y>=205 and y<212)or
				(x>=428 and x<453 and y>=228 and y<235)or
				(x>=278 and x<288 and y>=255 and y<295)or--O
				(x>=283 and x<313 and y>=250 and y<255)OR
				(x>=308 and x<318 and y>=255 and y<295)or
				(x>=283 and x<313 and y>=295 and y<300)or
				(x>=328 and x<338 and y>=250 and y<285)or--V
				(x>=333 and x<343 and y>=280 and y<290)or
				(x>=338 and x<353 and y>=285 and y<295)or
				(x>=343 and x<348 and y>=295 and y<300)or
				(x>=348 and x<358 and y>=280 and y<290)or
				(x>=353 and x<363 and y>=250 and y<285)or
				(x>=338 and x<353 and y>=185 and y<190)or--E
				(x>=373 and x<383 and y>=250 and y<300)or
				(x>=383 and x<408 and y>=250 and y<257)or
				(x>=383 and x<403 and y>=270 and y<277)or
				(x>=383 and x<408 and y>=293 and y<300)or
				(x>=418 and x<428 and y>=250 and y<300)or--R
				(x>=428 and x<448 and y>=250 and y<255)or
				(x>=443 and x<453 and y>=255 and y<270)or
				(x>=438 and x<448 and y>=270 and y<275)or
				(x>=428 and x<443 and y>=275 and y<280)or
				(x>=438 and x<448 and y>=280 and y<290)or
				(x>=443 and x<453 and y>=290 and y<300)
				
			)then
				R<="1011111011";
				G<="1101100011";
				B<="1001000011";
			else
				R<="0000000000";
				G<="0000000000";
				B<="0000000000";
			end if;
		
		else
	
		if(((x>203 and x<233) or (x>503 and x<533)) and  ((y>5+(PosC*30) and y<5+((PosC+1)*30)) or 
			 (y>35+(PosC*30) and y<35+((PosC+1)*30)) or    (y>95+(PosC*30) and y<95+((PosC+1)*30))or
			 (y>125+(PosC*30) and y<125+((PosC+1)*30))or   (y>185+(PosC*30) and y<185+((PosC+1)*30))or
			 (y>215+(PosC*30) and y<215+((PosC+1)*30))or   (y>275+(PosC*30) and y<275+((PosC+1)*30))or
			 (y>305+(PosC*30) and y<305+((PosC+1)*30))or   (y>365+(PosC*30) and y<365+((PosC+1)*30))or
			 (y>395+(PosC*30) and y<395+((PosC+1)*30))or   (y>455+(PosC*30) and y<455+((PosC+1)*30))or
			 (y>485+(PosC*30) and y<485+((PosC+1)*30))))then
			
			if(((x>208 and x<228) or (x>508 and x<528)) and  ((y>10+(PosC*30) and y<0+((PosC+1)*30)) or 
			 (y>40+(PosC*30) and y<30+((PosC+1)*30)) or    (y>100+(PosC*30) and y<90+((PosC+1)*30))or
			 (y>130+(PosC*30) and y<120+((PosC+1)*30))or   (y>190+(PosC*30) and y<180+((PosC+1)*30))or
			 (y>220+(PosC*30) and y<210+((PosC+1)*30))or   (y>280+(PosC*30) and y<270+((PosC+1)*30))or
			 (y>310+(PosC*30) and y<300+((PosC+1)*30))or   (y>370+(PosC*30) and y<360+((PosC+1)*30))or
			 (y>400+(PosC*30) and y<390+((PosC+1)*30))or   (y>460+(PosC*30) and y<450+((PosC+1)*30))or
			 (y>490+(PosC*30) and y<480+((PosC+1)*30))))then
			
			
				R<="0000000000";
				G<="0000000000";
				B<="0000000000";
			else
				if(((x>205 and x<231) or (x>505 and x<531)) and  ((y>7+(PosC*30) and y<3+((PosC+1)*30)) or 
					 (y>37+(PosC*30) and y<33+((PosC+1)*30)) or    (y>97+(PosC*30) and y<93+((PosC+1)*30))or
					 (y>127+(PosC*30) and y<123+((PosC+1)*30))or   (y>187+(PosC*30) and y<183+((PosC+1)*30))or
					 (y>217+(PosC*30) and y<213+((PosC+1)*30))or   (y>277+(PosC*30) and y<273+((PosC+1)*30))or
					 (y>307+(PosC*30) and y<303+((PosC+1)*30))or   (y>367+(PosC*30) and y<363+((PosC+1)*30))or
					 (y>397+(PosC*30) and y<393+((PosC+1)*30))or   (y>457+(PosC*30) and y<453+((PosC+1)*30))or
					 (y>487+(PosC*30) and y<483+((PosC+1)*30))))then
					 
					 
					R<="1011111011";
					G<="1101100011";
					B<="1001000011";
				else
					R<="0000000000";
					G<="0000000000";
					B<="0000000000";
				end if;
			
			
			end if;
			
		else
	
	
		if( (PosCar1="00001" and y>35 and y<65 and  ((x>233 and x<263)or(x>293 and x<323)))or
			 (PosCar1="00010" and ((y>66 and y<96 and  ((x>233 and x<263)or(x>293 and x<323))) or(y>35 and y<65 and x>263 and x<293)))or
			 (PosCar1="00011"and ((y>97 and y<127 and  ((x>233 and x<263)or(x>293 and x<323))) or(y>66 and y<96 and x>263 and x<293) or
										 (y>35 and y<65 and((x>233 and x<263)or(x>263 and x<293)or(x>293 and x<323)))))or
			 (PosCar1>"00011" and ((x>233 and x<263 and  PosVer>35+((Pos1-3)*30) and PosVer<35+((Pos1-2)*30))or --llanta delantera izq
											(x>263 and x<293 and  PosVer>35+((Pos1-3)*30) and PosVer<35+((Pos1-2)*30))or --tronco medio
											(x>293 and x<323 and  PosVer>35+((Pos1-3)*30) and PosVer<35+((Pos1-2)*30))or --llanta delantera derecha
											(x>263 and x<293 and  PosVer>35+((Pos1-4)*30) and PosVer<35+((Pos1-3)*30))or --punta
											(x>263 and x<293 and  PosVer>35+((Pos1-2)*30) and PosVer<35+((Pos1-1)*30))or --tronco bajo
											(x>233 and x<263 and  PosVer>35+((Pos1-1)*30) and PosVer<35+((Pos1)*30))or --llanta trasera izq
											(x>293 and x<323 and  PosVer>35+((Pos1-1)*30) and PosVer<35+((Pos1)*30))))or
			 (PosCar2="00001" and y>35 and y<65 and  ((x>323 and x<353)or(x>383 and x<413)))or
			 (PosCar2="00010" and ((y>66 and y<96 and  ((x>323 and x<353)or(x>383 and x<413))) or(y>35 and y<65 and x>353 and x<383)))or
			 (PosCar2="00011"and ((y>97 and y<127 and  ((x>323 and x<353)or(x>383 and x<413))) or(y>66 and y<96 and x>353 and x<383) or
										 (y>35 and y<65 and((x>323 and x<353)or(x>353 and x<383)or(x>383 and x<413)))))or
			 (PosCar2>"00011" and ((x>323 and x<353 and  PosVer>35+((Pos2-3)*30) and PosVer<35+((Pos2-2)*30))or --llanta delantera izq
											(x>353 and x<383 and  PosVer>35+((Pos2-3)*30) and PosVer<35+((Pos2-2)*30))or --tronco medio
											(x>383 and x<413 and  PosVer>35+((Pos2-3)*30) and PosVer<35+((Pos2-2)*30))or --llanta delantera derecha
											(x>353 and x<383 and  PosVer>35+((Pos2-4)*30) and PosVer<35+((Pos2-3)*30))or --punta
											(x>353 and x<383 and  PosVer>35+((Pos2-2)*30) and PosVer<35+((Pos2-1)*30))or --tronco bajo
											(x>323 and x<353 and  PosVer>35+((Pos2-1)*30) and PosVer<35+((Pos2)*30))or --llanta trasera izq
											(x>383 and x<413 and  PosVer>35+((Pos2-1)*30) and PosVer<35+((Pos2)*30))))or
			 (PosCar3="00001" and y>35 and y<65 and  ((x>413 and x<443)or(x>473 and x<503)))or
			 (PosCar3="00010" and ((y>66 and y<96 and  ((x>413 and x<443)or(x>473 and x<503))) or(y>35 and y<65 and x>443 and x<473)))or
			 (PosCar3="00011"and ((y>97 and y<127 and  ((x>413 and x<443)or(x>473 and x<503))) or(y>66 and y<96 and x>443 and x<473) or
										 (y>35 and y<65 and((x>413 and x<443)or(x>443 and x<473)or(x>473 and x<503)))))or
			 (PosCar3>"00011" and  ((x>413 and x<443 and  PosVer>35+((Pos3-3)*30) and PosVer<35+((Pos3-2)*30))or --llanta delantera izq
											(x>443 and x<473 and  PosVer>35+((Pos3-3)*30) and PosVer<35+((Pos3-2)*30))or --tronco medio
											(x>473 and x<503 and  PosVer>35+((Pos3-3)*30) and PosVer<35+((Pos3-2)*30))or --llanta delantera derecha
											(x>443 and x<473 and  PosVer>35+((Pos3-4)*30) and PosVer<35+((Pos3-3)*30))or --punta
											(x>443 and x<473 and  PosVer>35+((Pos3-2)*30) and PosVer<35+((Pos3-1)*30))or --tronco bajo
											(x>413 and x<443 and  PosVer>35+((Pos3-1)*30) and PosVer<35+((Pos3)*30))or --llanta trasera izq
											(x>473 and x<503 and  PosVer>35+((Pos3-1)*30) and PosVer<35+((Pos3)*30))))	
				) then
			
			
			
			
			if( (PosCar1="00001" and y>40 and y<60 and  ((x>238 and x<258)or(x>298 and x<318)))or
			 (PosCar1="00010" and ((y>71 and y<91 and  ((x>238 and x<258)or(x>298 and x<318))) or(y>40 and y<60 and x>268 and x<288)))or
			 (PosCar1="00011"and ((y>102 and y<122 and  ((x>238 and x<258)or(x>298 and x<318))) or(y>71 and y<91 and x>268 and x<288) or
										 (y>40 and y<60 and((x>238 and x<258)or(x>268 and x<288)or(x>298 and x<318)))))or
			 (PosCar1>"00011" and ((x>238 and x<258 and  PosVer>40+((Pos1-3)*30) and PosVer<30+((Pos1-2)*30))or --llanta delantera izq
											(x>268 and x<288 and  PosVer>40+((Pos1-3)*30) and PosVer<30+((Pos1-2)*30))or --tronco medio
											(x>298 and x<318 and  PosVer>40+((Pos1-3)*30) and PosVer<30+((Pos1-2)*30))or --llanta delantera derecha
											(x>268 and x<288 and  PosVer>40+((Pos1-4)*30) and PosVer<30+((Pos1-3)*30))or --punta
											(x>268 and x<288 and  PosVer>40+((Pos1-2)*30) and PosVer<30+((Pos1-1)*30))or --tronco bajo
											(x>238 and x<258 and  PosVer>40+((Pos1-1)*30) and PosVer<30+((Pos1)*30))or --llanta trasera izq
											(x>298 and x<318 and  PosVer>40+((Pos1-1)*30) and PosVer<30+((Pos1)*30))))or
			 (PosCar2="00001" and y>40 and y<60 and  ((x>328 and x<348)or(x>388 and x<408)))or
			 (PosCar2="00010" and ((y>71 and y<91 and  ((x>328 and x<348)or(x>388 and x<408))) or(y>40 and y<60 and x>358 and x<378)))or
			 (PosCar2="00011"and ((y>102 and y<122 and  ((x>328 and x<348)or(x>388 and x<408))) or(y>71 and y<91 and x>358 and x<378) or
										 (y>40 and y<60 and((x>328 and x<348)or(x>358 and x<378)or(x>388 and x<408)))))or
			 (PosCar2>"00011" and ((x>328 and x<348 and  PosVer>40+((Pos2-3)*30) and PosVer<30+((Pos2-2)*30))or --llanta delantera izq
											(x>358 and x<378 and  PosVer>40+((Pos2-3)*30) and PosVer<30+((Pos2-2)*30))or --tronco medio
											(x>388 and x<408 and  PosVer>40+((Pos2-3)*30) and PosVer<30+((Pos2-2)*30))or --llanta delantera derecha
											(x>358 and x<378 and  PosVer>40+((Pos2-4)*30) and PosVer<30+((Pos2-3)*30))or --punta
											(x>358 and x<378 and  PosVer>40+((Pos2-2)*30) and PosVer<30+((Pos2-1)*30))or --tronco bajo
											(x>328 and x<348 and  PosVer>40+((Pos2-1)*30) and PosVer<30+((Pos2)*30))or --llanta trasera izq
											(x>388 and x<408 and  PosVer>40+((Pos2-1)*30) and PosVer<30+((Pos2)*30))))or
			 (PosCar3="00001" and y>40 and y<60 and  ((x>418 and x<438)or(x>478 and x<498)))or
			 (PosCar3="00010" and ((y>71 and y<91 and  ((x>418 and x<438)or(x>478 and x<498))) or(y>40 and y<60 and x>448 and x<468)))or
			 (PosCar3="00011"and ((y>102 and y<122 and  ((x>418 and x<438)or(x>478 and x<498))) or(y>71 and y<91 and x>448 and x<468) or
										 (y>40 and y<60 and((x>418 and x<438)or(x>448 and x<478)or(x>478 and x<498)))))or
			 (PosCar3>"00011" and  ((x>418 and x<438 and  PosVer>40+((Pos3-3)*30) and PosVer<30+((Pos3-2)*30))or --llanta delantera izq
											(x>448 and x<468 and  PosVer>40+((Pos3-3)*30) and PosVer<30+((Pos3-2)*30))or --tronco medio
											(x>478 and x<498 and  PosVer>40+((Pos3-3)*30) and PosVer<30+((Pos3-2)*30))or --llanta delantera derecha
											(x>448 and x<468 and  PosVer>40+((Pos3-4)*30) and PosVer<30+((Pos3-3)*30))or --punta
											(x>448 and x<468 and  PosVer>40+((Pos3-2)*30) and PosVer<30+((Pos3-1)*30))or --tronco bajo
											(x>418 and x<438 and  PosVer>40+((Pos3-1)*30) and PosVer<30+((Pos3)*30))or --llanta trasera izq
											(x>478 and x<498 and  PosVer>40+((Pos3-1)*30) and PosVer<30+((Pos3)*30))))	
				) then
			
			
			R<="0000000000";
			G<="0000000000";
			B<="0000000000";
			
			else
				if( (PosCar1="00001" and y>37 and y<63 and  ((x>235 and x<261)or(x>295 and x<321)))or
			 (PosCar1="00010" and ((y>68 and y<94 and  ((x>235 and x<261)or(x>295 and x<321))) or(y>37 and y<63 and x>265 and x<291)))or
			 (PosCar1="00011"and ((y>99 and y<125 and  ((x>235 and x<261)or(x>295 and x<321))) or(y>68 and y<96 and x>265 and x<291) or
										 (y>37 and y<63 and((x>235 and x<261)or(x>265 and x<291)or(x>295 and x<321)))))or
			 (PosCar1>"00011" and ((x>235 and x<261 and  PosVer>37+((Pos1-3)*30) and PosVer<33+((Pos1-2)*30))or --llanta delantera izq
											(x>265 and x<291 and  PosVer>37+((Pos1-3)*30) and PosVer<33+((Pos1-2)*30))or --tronco medio
											(x>295 and x<321 and  PosVer>37+((Pos1-3)*30) and PosVer<33+((Pos1-2)*30))or --llanta delantera derecha
											(x>265 and x<291 and  PosVer>37+((Pos1-4)*30) and PosVer<33+((Pos1-3)*30))or --punta
											(x>265 and x<291 and  PosVer>37+((Pos1-2)*30) and PosVer<33+((Pos1-1)*30))or --tronco bajo
											(x>235 and x<261 and  PosVer>37+((Pos1-1)*30) and PosVer<33+((Pos1)*30))or --llanta trasera izq
											(x>295 and x<321 and  PosVer>37+((Pos1-1)*30) and PosVer<33+((Pos1)*30))))or
			 (PosCar2="00001" and y>37 and y<63 and  ((x>325 and x<351)or(x>385 and x<411)))or
			 (PosCar2="00010" and ((y>68 and y<94 and  ((x>325 and x<351)or(x>385 and x<411))) or(y>37 and y<61 and x>355 and x<381)))or
			 (PosCar2="00011"and ((y>99 and y<125 and  ((x>325 and x<351)or(x>385 and x<411))) or(y>68 and y<94 and x>355 and x<381) or
										 (y>37 and y<63 and((x>325 and x<351)or(x>355 and x<381)or(x>385 and x<411)))))or
			 (PosCar2>"00011" and ((x>325 and x<351 and  PosVer>37+((Pos2-3)*30) and PosVer<33+((Pos2-2)*30))or --llanta delantera izq
											(x>355 and x<381 and  PosVer>37+((Pos2-3)*30) and PosVer<33+((Pos2-2)*30))or --tronco medio
											(x>385 and x<411 and  PosVer>37+((Pos2-3)*30) and PosVer<33+((Pos2-2)*30))or --llanta delantera derecha
											(x>355 and x<381 and  PosVer>37+((Pos2-4)*30) and PosVer<33+((Pos2-3)*30))or --punta
											(x>355 and x<381 and  PosVer>37+((Pos2-2)*30) and PosVer<33+((Pos2-1)*30))or --tronco bajo
											(x>325 and x<351 and  PosVer>37+((Pos2-1)*30) and PosVer<33+((Pos2)*30))or --llanta trasera izq
											(x>385 and x<411 and  PosVer>37+((Pos2-1)*30) and PosVer<33+((Pos2)*30))))or
			 (PosCar3="00001" and y>37 and y<63 and  ((x>415 and x<441)or(x>475 and x<501)))or
			 (PosCar3="00010" and ((y>68 and y<94 and  ((x>415 and x<441)or(x>475 and x<501))) or(y>37 and y<63 and x>445 and x<471)))or
			 (PosCar3="00011"and ((y>99 and y<125 and  ((x>415 and x<441)or(x>475 and x<501))) or(y>68 and y<94 and x>445 and x<471) or
										 (y>37 and y<63 and((x>415 and x<441)or(x>445 and x<471)or(x>475 and x<501)))))or
			 (PosCar3>"00011" and  ((x>415 and x<441 and  PosVer>37+((Pos3-3)*30) and PosVer<33+((Pos3-2)*30))or --llanta delantera izq
											(x>445 and x<471 and  PosVer>37+((Pos3-3)*30) and PosVer<33+((Pos3-2)*30))or --tronco medio
											(x>475 and x<501 and  PosVer>37+((Pos3-3)*30) and PosVer<33+((Pos3-2)*30))or --llanta delantera derecha
											(x>445 and x<471 and  PosVer>37+((Pos3-4)*30) and PosVer<33+((Pos3-3)*30))or --punta
											(x>445 and x<471 and  PosVer>37+((Pos3-2)*30) and PosVer<33+((Pos3-1)*30))or --tronco bajo
											(x>415 and x<441 and  PosVer>37+((Pos3-1)*30) and PosVer<33+((Pos3)*30))or --llanta trasera izq
											(x>475 and x<501 and  PosVer>37+((Pos3-1)*30) and PosVer<33+((Pos3)*30))))	
				) then
				
				
					R<="1011111011";
					G<="1101100011";
					B<="1001000011";
				
				else
				
					R<="0000000000";
					G<="0000000000";
					B<="0000000000";

				end if;
			
			
			
			
			end if;
			--------
		else
		
		
		
		
		if(Player="00" and ((x>233 and x<263 and  PosVer>423 and PosVer<453)or --llanta delantera izq
								  (x>263 and x<293 and  PosVer>423 and PosVer<453)or --tronco medio
								  (x>293 and x<323 and  PosVer>423 and PosVer<453)or --llanta delantera derecha
								  (x>263 and x<293 and  PosVer>392 and PosVer<422)or --punta
								  (x>263 and x<293 and  PosVer>454 and PosVer<484)or --tronco bajo
								  (x>233 and x<263 and  PosVer>485 and PosVer<515)or --llanta trasera izq
								  (x>293 and x<323 and  PosVer>485 and PosVer<515))) then --llanta trasera derecha
			
			if ((x>238 and x<258 and  PosVer>428 and PosVer<448)or
								  (x>268 and x<288 and  PosVer>428 and PosVer<448)or
								  (x>298 and x<318 and  PosVer>428 and PosVer<448)or
								  (x>268 and x<288 and  PosVer>397 and PosVer<417)or
								  (x>268 and x<288 and  PosVer>459 and PosVer<479)or
								  (x>238 and x<258 and  PosVer>490 and PosVer<510)or
								  (x>298 and x<318 and  PosVer>490 and PosVer<510)) then 
			
				R<="0000000000";
				G<="0000000000";
				B<="0000000000";
			else
				if ((x>235 and x<261 and  PosVer>425 and PosVer<451)or
									  (x>265 and x<291 and  PosVer>425 and PosVer<451)or
									  (x>295 and x<321 and  PosVer>425 and PosVer<451)or
									  (x>265 and x<291 and  PosVer>394 and PosVer<420)or
									  (x>265 and x<291 and  PosVer>456 and PosVer<482)or
									  (x>235 and x<261 and  PosVer>487 and PosVer<513)or
									  (x>295 and x<321 and  PosVer>487 and PosVer<513)) then 
				
					R<="1011111011";
					G<="1101100011";
					B<="1001000011";
				else
					R<="0000000000";
					G<="0000000000";
					B<="0000000000";
				end if;
			end if;
			
		else
			if(Player="01" and ((x>323 and x<353 and  PosVer>423 and PosVer<453)or
								  (x>353 and x<383 and  PosVer>423 and PosVer<453)or
								  (x>383 and x<413 and  PosVer>423 and PosVer<453)or
								  (x>353 and x<383 and  PosVer>392 and PosVer<422)or
								  (x>353 and x<383 and  PosVer>454 and PosVer<484)or
								  (x>323 and x<353 and  PosVer>485 and PosVer<515)or
								  (x>383 and x<413 and  PosVer>485 and PosVer<515))) then
				
				if ((x>328 and x<348 and  PosVer>428 and PosVer<448)or
								  (x>358 and x<378 and  PosVer>428 and PosVer<448)or
								  (x>388 and x<408 and  PosVer>428 and PosVer<448)or
								  (x>358 and x<378 and  PosVer>397 and PosVer<417)or
								  (x>358 and x<378 and  PosVer>459 and PosVer<479)or
								  (x>328 and x<348 and  PosVer>490 and PosVer<510)or
								  (x>388 and x<408 and  PosVer>490 and PosVer<510)) then 
			
					R<="0000000000";
					G<="0000000000";
					B<="0000000000";
				else
					if ((x>325 and x<351 and  PosVer>425 and PosVer<451)or
										  (x>355 and x<381 and  PosVer>425 and PosVer<451)or
										  (x>385 and x<411 and  PosVer>425 and PosVer<451)or
										  (x>355 and x<381 and  PosVer>394 and PosVer<420)or
										  (x>355 and x<381 and  PosVer>456 and PosVer<482)or
										  (x>325 and x<351 and  PosVer>487 and PosVer<513)or
										  (x>385 and x<411 and  PosVer>487 and PosVer<513)) then 
					
						R<="1011111011";
						G<="1101100011";
						B<="1001000011";
					else
						R<="0000000000";
						G<="0000000000";
						B<="0000000000";
					end if;
				end if;
			else
				if(Player="10" and ((x>413 and x<443 and  PosVer>423 and PosVer<453)or
								  (x>443 and x<473 and  PosVer>423 and PosVer<453)or
								  (x>473 and x<503 and  PosVer>423 and PosVer<453)or
								  (x>443 and x<473 and  PosVer>392 and PosVer<422)or
								  (x>443 and x<473 and  PosVer>454 and PosVer<484)or
								  (x>413 and x<443 and  PosVer>485 and PosVer<515)or
								  (x>473 and x<503 and  PosVer>485 and PosVer<515))) then
					
					if ((x>418 and x<438 and  PosVer>428 and PosVer<448)or
								  (x>448 and x<468 and  PosVer>428 and PosVer<448)or
								  (x>478 and x<498 and  PosVer>428 and PosVer<448)or
								  (x>448 and x<468 and  PosVer>397 and PosVer<417)or
								  (x>448 and x<468 and  PosVer>459 and PosVer<479)or
								  (x>418 and x<438 and  PosVer>490 and PosVer<510)or
								  (x>478 and x<498 and  PosVer>490 and PosVer<510)) then 
			
						R<="0000000000";
						G<="0000000000";
						B<="0000000000";
					else
						if ((x>415 and x<441 and  PosVer>425 and PosVer<451)or
											  (x>445 and x<471 and  PosVer>425 and PosVer<451)or
											  (x>475 and x<501 and  PosVer>425 and PosVer<451)or
											  (x>445 and x<471 and  PosVer>394 and PosVer<420)or
											  (x>445 and x<471 and  PosVer>456 and PosVer<482)or
											  (x>415 and x<441 and  PosVer>487 and PosVer<513)or
											  (x>475 and x<501 and  PosVer>487 and PosVer<513)) then 
						
							R<="1011111011";
							G<="1101100011";
							B<="1001000011";
						else
							R<="0000000000";
							G<="0000000000";
							B<="0000000000";
						end if;
					end if;
				else
	
							
					
					
			
					if ((((x>(0*30)+203+5 and x<(0*30)+203+25)or
							(x>(1*30)+203+5 and x<(1*30)+203+25)or
							(x>(2*30)+203+5 and x<(2*30)+203+25)or
							(x>(3*30)+203+5 and x<(3*30)+203+25)or
							(x>(4*30)+203+5 and x<(4*30)+203+25)or
							(x>(5*30)+203+5 and x<(5*30)+203+25)or
							(x>(6*30)+203+5 and x<(6*30)+203+25)or
							(x>(7*30)+203+5 and x<(7*30)+203+25)or
							(x>(8*30)+203+5 and x<(8*30)+203+25)or
							(x>(9*30)+203+5 and x<(9*30)+203+25)or
							(x>(10*30)+203+5 and x<(10*30)+203+25)
							)and ((y>(0*30)+35+5 and y<(0*30)+35+25)or
							(y>(1*30)+35+5 and y<(1*30)+35+25)or
							(y>(2*30)+35+5 and y<(2*30)+35+25)or
							(y>(3*30)+35+5 and y<(3*30)+35+25)or
							(y>(4*30)+35+5 and y<(4*30)+35+25)or
							(y>(5*30)+35+5 and y<(5*30)+35+25)or
							(y>(6*30)+35+5 and y<(6*30)+35+25)or
							(y>(7*30)+35+5 and y<(7*30)+35+25)or
							(y>(8*30)+35+5 and y<(8*30)+35+25)or
							(y>(9*30)+35+5 and y<(9*30)+35+25)or
							(y>(10*30)+35+5 and y<(10*30)+35+25)or
							(y>(11*30)+35+5 and y<(11*30)+35+25)or
							(y>(12*30)+35+5 and y<(12*30)+35+25)or
							(y>(13*30)+35+5 and y<(13*30)+35+25)or
							(y>(14*30)+35+5 and y<(14*30)+35+25)or
							(y>(15*30)+35+5 and y<(15*30)+35+25)))or
							x=(1*30)+203 or x=(2*30)+203 or x=(3*30)+203 or x=(4*30)+203 or x=(5*30)+203 or x=(6*30)+203 or x=(7*30)+203 or
							x=(8*30)+203 or x=(9*30)+203 or x=(10*30)+203 or y=(12*30)+35 or y=(13*30)+35 or y=(14*30)+35 or y=(15*30)+35
							or y=(1*30)+35 or y=(2*30)+35 or y=(3*30)+35 or y=(4*30)+35 or y=(5*30)+35 or y=(6*30)+35 or y=(7*30)+35
							or y=(8*30)+35 or y=(9*30)+35 or y=(10*30)+35 or y=(11*30)+35) then
						R<="1000111111";
						G<="1010101111";
						B<="0111100111";
					ELSE
							R<="1011111011";
							G<="1101100011";
							B<="1001000011";
					end if;
			
						
	
				end if;
			end if;
			end if;
			end if;
			end if;
		end if;
		end if;
			
			
	end if;
else --zona no visible
	R<="0000000000";
	G<="0000000000";
	B<="0000000000";
end if;

end process;       
END RTL;

