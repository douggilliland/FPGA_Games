library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.std_logic_unsigned.all;
use ieee.numeric_std.all;
-- Alex Grinshpun Apr 2017
-- Dudy Nov 13 2017

entity objects_mux is
port 	(
		CLK	: in std_logic; --						//	27 MHz
		b_drawing_request : in std_logic;
		b_mVGA_RGB 	: in std_logic_vector(7 downto 0); --	, -- b  input signal 
		
		rect_drawing_request: in std_logic;
		rect_mVGA_RGB 	: in std_logic_vector(7 downto 0); --	, -- b  input signal 

		y_drawing_request : in std_logic;	-- not used in this exammple 
		y_mVGA_RGB 	: in std_logic_vector(7 downto 0); --	,  -- y input signal 


		m_mVGA_R 	: out std_logic_vector(7 downto 0); --	,  
		m_mVGA_G 	: out std_logic_vector(7 downto 0); --	, 
		m_mVGA_B 	: out std_logic_vector(7 downto 0); --	, 
		RESETn : in std_logic

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
		if (rect_drawing_request = '1') then
			m_mVGA_t <= rect_mVGA_RGB;  --first priority from B 
		elsif (b_drawing_request = '1' ) then  
			m_mVGA_t <= b_mVGA_RGB;  --first priority from B 
		else
			m_mVGA_t <= y_mVGA_RGB ; -- second priority from y
		end if; 
	end if ; 

end process ;

m_mVGA_R	<= m_mVGA_t(7 downto 5)& "00000"; -- expand to 10 bits 
m_mVGA_G	<= m_mVGA_t(4 downto 2)& "00000";
m_mVGA_B	<= m_mVGA_t(1 downto 0)& "000000";


end behav;