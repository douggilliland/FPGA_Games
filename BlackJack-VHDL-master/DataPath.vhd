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
generic (width_cont,width_reg_zero,width_reg_perd,width_reg_acc,width_RAM,width_sum,width_disp : natural);
 port (
    clk                   : in  std_logic;                            -- clock
    rst_n                 : in  std_logic;                            -- reset
	 ctrl                  : in  std_logic_vector(8 downto 0);         -- Control
	 din_ram               : in  std_logic_vector(width_RAM-1 downto 0);         -- din entra con '0000' desde BlackJack
	 carta_incorrecta      : out std_logic;                             -- carta incorrecta
	 perdido               : out std_logic;                             -- ha perdido la partida
	 cartaActualValor      : out std_logic_vector(width_disp-1 downto 0);         -- Valor carta actual
	 puntuacionAcumulada_1 : out std_logic_vector(width_disp-1 downto 0);         -- Puntuacion acumulada carta
	 puntuacionAcumulada_2 : out std_logic_vector(width_disp-1 downto 0);         -- Puntuacion acumulada carta
    status                : out std_logic_vector(1 downto 0));        -- Status (es zero,es perdida acc > 21) posible nueva señal ganado en opcional

end DataPath;

architecture arch_DataPath of DataPath is

	component ContModn is
	generic (width : natural);
	port ( c_enable : in std_logic;
			 clk      : in std_logic;
			 rst      : in std_logic;
			 Y        : out std_logic_vector(width-1 downto 0));
	end component;

	component Conv_7seg is
		 port (x       : in  std_logic_vector (3 downto 0);
				 display : out std_logic_vector (6 downto 0) );
	end component;

	component RegPG is
	generic (width : natural);
	port ( a   : in  std_logic_vector(width-1 downto 0);
			 clk : in  std_logic;
			 load: in  std_logic;
			 rst : in  std_logic;
			 Y   : out std_logic_vector(width-1 downto 0));
	end component;
	
	component RegPG1 is
	generic (width : natural);
	port ( a   : in  std_logic;
			 clk : in  std_logic;
			 load: in  std_logic;
			 rst : in  std_logic;
			 Y   : out std_logic);
	end component;

	component adder is
		generic (width : natural);
		port(a    : in std_logic_vector  (width-2 downto 0);
			  b    : in std_logic_vector  (width-1 downto 0);
			  cout : out std_logic_vector (width-1 downto 0));
			  
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
	
	-- señales calculo de status
	
	signal zero : std_logic;
	signal perdida : std_logic;

	-- señales de interconexión

	signal res_cont : std_logic_vector(width_cont-1 downto 0);
	signal dout_RAM : std_logic_vector(width_RAM-1 downto 0);
	signal sum_res  : std_logic_vector(width_sum-1 downto 0);
	signal ACC_reg  : std_logic_vector(width_reg_acc-1 downto 0);
	signal ZERO_reg : std_logic;
	signal PERD_reg : std_logic;
	
	-- out display
	
	signal puntuacionAcumulada_1_aux : std_logic_vector (width_disp-1 downto 0);
	signal puntuacionAcumulada_2_aux : std_logic_vector (width_disp-1 downto 0);
	signal cartaActualValor_aux : std_logic_vector (width_disp-1 downto 0);

	-- señales conversion a display explicadas en powerpoint

	signal ACC_1  : std_logic_vector(3 downto 0);
	signal ACC_2  : std_logic_vector(3 downto 0);

	begin

	-- control a controlaux
	control_aux <= ctrl;
	
	-- para leds
	ACC_1 <= "000" & ACC_reg(width_reg_acc-1); --- 000 and msb     1
	ACC_2 <= ACC_reg(width_reg_acc-2 downto 0); --- msb-1 downto 0 F
	

	-- instanciación de componentes

		RAM : ram_memory port map (
			clk  => clk,
			we   => we_ram,
			addr => res_cont,
			din  => din_ram,
			dout => dout_RAM);
			
		CONTADOR : ContModn generic map (width => width_cont) port map (
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
			
		SUMADOR : adder generic map (width => width_sum) port map (
			a    => dout_RAM,
			b    => ACC_reg,
			cout => sum_res);
		
		ACC_REGISTER : RegPG generic map (width => width_reg_acc) port map (
			a    => sum_res,
			clk  => clk,
			load => ld_acc,
			rst  => rst_acc,
			Y    => ACC_reg);
			
		ZERO_REGISTER	: RegPG1 generic map (width => width_reg_zero) port map (
			a    => zero,
			clk  => clk,
			load => ld_zero,
			rst  => rst_zer,
			Y    => ZERO_reg);
			
		PERDIDO_REGISTER : RegPG1 generic map (width => width_reg_perd) port map (
			a    => perdida,
			clk  => clk,
			load => ld_per,
			rst  => rst_per,
			Y    => PERD_reg);
			
			-- señales a status
			status(0) <= ZERO_reg;
			status(1) <= PERD_reg;
			
			--señales a out
			puntuacionAcumulada_1 <= puntuacionAcumulada_1_aux;
			puntuacionAcumulada_2 <= puntuacionAcumulada_2_aux;
			cartaActualValor <= cartaActualValor_aux;
		
		-- combinacionalmente =0 >=21
		combi : process(dout_RAM,ACC_reg)
			begin
				if unsigned(dout_RAM) = 0 then
					zero <= '1';
					carta_incorrecta <= '1';
				end if;
				if unsigned(ACC_reg) >= 22 then
					perdida <= '1';
					perdido <= '1';
				end if;
			end process combi;

end arch_DataPath;

