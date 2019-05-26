library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Alex Grinshpun Apr 2017
-- Dudy Nov 13 2017

entity objects_mux is
port 	(
		CLK	: in std_logic; --						//	27 MHz
		ball_drawing_request : in std_logic;
		ball_mVGA_RGB 	: in std_logic_vector(7 downto 0); --	, -- b  input signal 
		
		obj_drawing_request: in std_logic;
		obj_mVGA_RGB 	: in std_logic_vector(7 downto 0); --	, -- b  input signal 

		y_drawing_request : in std_logic;	-- not used in this exammple 
		y_mVGA_RGB 	: in std_logic_vector(7 downto 0); --	,  -- y input signal 

		m_mVGA_R 	: out std_logic_vector(7 downto 0); --	,  
		m_mVGA_G 	: out std_logic_vector(7 downto 0); --	, 
		m_mVGA_B 	: out std_logic_vector(7 downto 0); --	, 
		RESETn : in std_logic;
		
		left_flipper_drawing_request : in std_logic;
		left_flipper_mVGA_RGB : in std_logic_vector(7 downto 0);
		
		right_flipper_drawing_request : in std_logic;
		right_flipper_mVGA_RGB : in std_logic_vector(7 downto 0);
		
		middle_layer_drawing_request : in std_logic;
		middle_layer_mVGA_RGB : in std_logic_vector(7 downto 0)

	);
end objects_mux;

architecture behav of objects_mux is 
signal m_mVGA_t 	: std_logic_vector(7 downto 0); --	,  

begin

-- priority encoder process

process ( RESETn, CLK)
begin 
	if RESETn = '0' then
			m_mVGA_t	<=  (others => '0') ; 	

	elsif rising_edge(CLK) then
		if (left_flipper_drawing_request = '1') then
			m_mVGA_t <= left_flipper_mVGA_RGB;
		elsif (right_flipper_drawing_request = '1') then
			m_mVGA_t <= right_flipper_mVGA_RGB;
		elsif (obj_drawing_request = '1') then
			m_mVGA_t <= obj_mVGA_RGB; 
		
		elsif (ball_drawing_request = '1' ) then  
			m_mVGA_t <= ball_mVGA_RGB;
		elsif (middle_layer_drawing_request = '1') then
			m_mVGA_t <= middle_layer_mVGA_RGB;
		else
			m_mVGA_t <= y_mVGA_RGB ;
		end if; 
	end if ; 

end process ;

m_mVGA_R	<= m_mVGA_t(7 downto 5)& "00000"; -- expand to 10 bits 
m_mVGA_G	<= m_mVGA_t(4 downto 2)& "00000";
m_mVGA_B	<= m_mVGA_t(1 downto 0)& "000000";


end behav;