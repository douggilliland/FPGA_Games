----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:18:41 12/12/2015 
-- Design Name: 
-- Module Name:    BlackJack - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity BlackJack is
port (clk              : in std_logic;
		reset            : in std_logic;
		comenzar         : in std_logic;
		otra_carta       : in std_logic;
		me_planto        : in std_logic;
		maquina_lista    : out std_logic;
		carta_incorrecta : out std_logic;
		partida_perdida  : out std_logic;
		carta_actual     : out std_logic_vector (6 downto 0);
		valor_acumulado  : out std_logic_vector (13 downto 0));
end BlackJack;

architecture arch_BlackJack of BlackJack is

-- implementacion de los componentes

component DataPath is
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

end component;

component ControlUnit is
 port (
    clk                   : in  std_logic;                             -- clock
    rst_n                 : in  std_logic;                             -- reset
	 inicio                : in  std_logic;                             -- señal de inicio
	 otra_carta            : in  std_logic;                             -- otra carta
	 plantarse             : in  std_logic;                             -- plantarse
	 status                : in  std_logic_vector(1 downto 0);          -- Status (es zero,es perdida acc > 21) posible nueva señal ganado en opcional
	 maquina_lista         : out std_logic;                             -- maquina lista
	 ctrl                  : out std_logic_vector(8 downto 0));         -- Control

end component;

--definicion señales control y status

signal ctrl   : std_logic_vector(8 downto 0);
signal status : std_logic_vector(1 downto 0);

-- signal outs

signal acumulada1 : std_logic_vector (6 downto 0);
signal acumulada2 : std_logic_vector (6 downto 0);

begin

valor_acumulado <= acumulada1 & acumulada2;

DATAPATHH: DataPath generic map (
			width_cont     => 6,
			width_reg_zero => 1,
			width_reg_perd => 1,
			width_reg_acc  => 5,
			width_RAM      => 4,
			width_sum      => 5,
			width_disp     => 7) port map (
				clk                    => clk,
				rst_n                  => reset,
				ctrl                   => ctrl,
				din_ram                => "0000",
				cartaActualValor       => carta_actual,
				puntuacionAcumulada_1  => acumulada1,
				puntuacionAcumulada_2  => acumulada2,
				carta_incorrecta       => carta_incorrecta,
				perdido                => partida_perdida,
				status                 => status);

CONTROL_UNIT: ControlUnit port map(
				clk              => clk,
				rst_n            => reset,
				inicio           => comenzar,
				otra_carta       => otra_carta,
				plantarse        => me_planto,
				status           => status,
				maquina_lista    => maquina_lista,
				ctrl             => ctrl);
				


end arch_BlackJack;

