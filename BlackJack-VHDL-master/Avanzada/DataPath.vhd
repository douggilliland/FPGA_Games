----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:15:59 12/11/2015 
-- Design Name: 
-- Module Name:    DataPath - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DataPath is
 port (
    clk                   : in  std_logic;                            -- clock
	 ctrl                  : in  std_logic_vector(8 downto 0);         -- Control
	 din_ram               : in  std_logic_vector(3 downto 0);         -- din entra con '0000' desde BlackJack
	 carta_incorrecta      : out std_logic;                             -- carta incorrecta
--  puntuacionPartida     : out std_logic_vector(3 downto 0);
	 perdido               : out std_logic;                             -- ha perdido la partida
	 cartaActualValor      : out std_logic_vector(6 downto 0);         -- Valor carta actual
	 puntuacionAcumulada_1 : out std_logic_vector(6 downto 0);         -- Puntuacion acumulada carta
	 puntuacionAcumulada_2 : out std_logic_vector(6 downto 0);         -- Puntuacion acumulada carta
    status                : out std_logic);        -- Status (es zero,es perdida acc > 21) posible nueva señal ganado en opcional

end DataPath;

architecture arch_DataPath of DataPath is

	component ContModn is
	port ( c_enable : in std_logic;
			 clk      : in std_logic;
			 rst      : in std_logic;
			 Y        : out std_logic_vector(5 downto 0));
	end component;

	component Conv_7seg is
		 port (x       : in  std_logic_vector (3 downto 0);
				 display : out std_logic_vector (6 downto 0) );
	end component;

	component RegPG is
	port ( a   : in  std_logic_vector(4 downto 0);
			 clk : in  std_logic;
			 load: in  std_logic;
			 rst : in  std_logic;
			 Y   : out std_logic_vector(4 downto 0));
	end component;
	
	component RegPG1 is
	port ( a   : in  std_logic;
			 clk : in  std_logic;
			 load: in  std_logic;
			 rst : in  std_logic;
			 Y   : out std_logic);
	end component;

	component adder is
		port(a    : in std_logic_vector  (3 downto 0);
			  b    : in std_logic_vector  (4 downto 0);
			  cout : out std_logic_vector (4 downto 0));
			  
	end component;

	component ram_memory is
	port ( clk  : in std_logic;
			 we   : in std_logic;
			 addr : in std_logic_vector  (5 downto 0);
			 din  : in std_logic_vector  (3 downto 0);
			 dout : out std_logic_vector (3 downto 0));
	end component ;

	-- señales de control
	
  	signal control_aux : std_logic_vector (8 downto 0);
	alias we_ram  : std_logic is control_aux (0);
	alias ld_acc  : std_logic is control_aux (1);
	alias ld_per  : std_logic is control_aux (2);
	alias rst_per : std_logic is control_aux (3);
	alias rst_acc : std_logic is control_aux (4);
	alias rst_zer : std_logic is control_aux (5);
	alias rst_con : std_logic is control_aux (6);
	alias ld_zero : std_logic is control_aux (7);
	alias ce_cont : std_logic is control_aux (8);

	-- señales de interconexión

	signal res_cont : std_logic_vector(5 downto 0);
	signal dout_RAM : std_logic_vector(3 downto 0);
	signal sum_res  : std_logic_vector(4 downto 0);
	signal ACC_reg  : std_logic_vector(4 downto 0);
	signal ZERO_reg : std_logic;
	signal PERD_reg : std_logic;
-- signal punt_sum : std_logic_vector(4 downto 0);
-- signal punt_reg : std_logic_vector(4 downto 0);
	---
	
	signal zero     : std_logic;
	signal perdida  : std_logic;
	
	-- out display
	
	signal puntuacionAcumulada_1_aux : std_logic_vector (6 downto 0);
	signal puntuacionAcumulada_2_aux : std_logic_vector (6 downto 0);
	signal cartaActualValor_aux : std_logic_vector (6 downto 0);

	-- señales conversion a display explicadas en powerpoint

	signal ACC_1  : std_logic_vector(3 downto 0);
	signal ACC_2  : std_logic_vector(3 downto 0);

	begin

	-- control a controlaux
	control_aux <= ctrl;
	
	-- para leds
	ACC_1 <= "000" & ACC_reg(4); --- 000 and msb     1
	ACC_2 <= ACC_reg(3 downto 0); --- msb-1 downto 0 F
	

	-- instanciación de componentes

		RAM : ram_memory port map (
			clk  => clk,
			we   => we_ram,
			addr => res_cont,
			din  => din_ram,
			dout => dout_RAM);
			
		CONTADOR : ContModn port map (
			c_enable => ce_cont,
			clk      => clk,
			rst      => rst_con,
			Y        => res_cont);
			
		CONV_ACC_1 : Conv_7seg port map (
			x       => ACC_1,
			display => puntuacionAcumulada_1_aux);
			
		CONV_ACC_2 : Conv_7seg port map (
			x       => ACC_2,
			display => puntuacionAcumulada_2_aux);
			
		CONV_CARTA : Conv_7seg port map (
			x       => dout_RAM,
			display => cartaActualValor_aux);
			
		SUMADOR : adder port map (
			a    => dout_RAM,
			b    => ACC_reg,
			cout => sum_res);
		
		ACC_REGISTER : RegPG port map (
			a    => sum_res,
			clk  => clk,
			load => ld_acc,
			rst  => rst_acc,
			Y    => ACC_reg);
			
		ZERO_REGISTER	: RegPG1 port map (
			a    => zero,
			clk  => clk,
			load => ld_zero,
			rst  => rst_zer,
			Y    => ZERO_reg);
			
		PERDIDO_REGISTER : RegPG1 port map (
			a    => perdida,
			clk  => clk,
			load => ld_per,
			rst  => rst_per,
			Y    => PERD_reg);
			
		--PUNTUACION_REGISTER : RegPG port map (
		-- a    => punt_sum,
		--	clk  => clk,
		--	load => ld_punt,
		--	rst  => rst_punt,
		-- Y    => punt_reg);
		--
		--);
			
			-- señales a status y salida
			status<= perdida;
			perdido<= PERD_reg;
			carta_incorrecta<=ZERO_reg;
			
			--señales a out
			puntuacionAcumulada_1 <= puntuacionAcumulada_1_aux;
			puntuacionAcumulada_2 <= puntuacionAcumulada_2_aux;
			cartaActualValor <= cartaActualValor_aux;
		
		zero <= '1' when unsigned(dout_RAM) = 0 else '0';
		perdida <= '1' when unsigned(ACC_reg) >= 22 else '0';
		
		-- 

end arch_DataPath;

