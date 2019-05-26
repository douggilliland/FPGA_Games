library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package PushBoxLevels is

	constant c_map_height_bits : integer := 4;
	constant c_map_width_bits  : integer := 4;
	constant level_count : integer := 16;

	-- Matriz do mapa
	-- Bit 2: indica se é um objetivo ou não
	--   (caso especial) "100" indica parede "void", que é mostrada como um quadrado preto no VGA. Não indica objetivo.
	-- Bits 1 downto 0: indica o que está no local:
	--   00: Parede
	--   01: Chão
	--   10: Jogador
	--   11: Caixa
	type map_matrix_t is array(2**c_map_width_bits-1 downto 0, 2**c_map_height_bits-1 downto 0) of unsigned(2 downto 0);
	type map_matrix_array_t is array(0 to level_count-1) of map_matrix_t;
	type player_start_array_t is array(0 to level_count-1) of unsigned(c_map_height_bits-1 downto 0);

	constant c_map_matrix_array : map_matrix_array_t := (
		-- Nível 0
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "000", "000", "000", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "000", "101", "000", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "000", "001", "000", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "011", "001", "011", "101", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "101", "001", "011", "010", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "000", "011", "000", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "000", "101", "000", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "000", "000", "000", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100")),

		-- Nível 1
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "000", "000", "000", "000", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "010", "001", "001", "000", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "001", "011", "011", "000", "100", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "001", "011", "001", "000", "100", "000", "101", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "000", "000", "001", "000", "000", "000", "101", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "001", "001", "001", "001", "101", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "001", "001", "001", "000", "001", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "001", "001", "001", "000", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "000", "000", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100")),

		-- Nível 2
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "000", "000", "000", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "001", "001", "001", "001", "001", "000", "000", "000", "100", "100", "100"),
		 ("100", "100", "100", "000", "000", "011", "000", "000", "000", "001", "001", "001", "000", "100", "100", "100"),
		 ("100", "100", "100", "000", "001", "010", "001", "011", "001", "001", "011", "001", "000", "100", "100", "100"),
		 ("100", "100", "100", "000", "001", "101", "101", "000", "001", "011", "001", "000", "000", "100", "100", "100"),
		 ("100", "100", "100", "000", "000", "101", "101", "000", "001", "001", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "000", "000", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100")),
		
		-- Nível 3
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "000", "000", "000", "000", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "000", "001", "001", "000", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "010", "011", "001", "000", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "000", "011", "001", "000", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "000", "001", "011", "001", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "101", "011", "001", "001", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "101", "101", "111", "101", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "000", "000", "000", "000", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100")),
		
		-- Nível 4
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "000", "000", "000", "000", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "010", "001", "000", "000", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "001", "011", "001", "001", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "001", "000", "001", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "101", "000", "001", "000", "001", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "101", "011", "001", "001", "000", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "101", "001", "001", "001", "011", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "000", "000", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100")),
		
		-- Nível 5
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "000", "000", "000", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "000", "000", "000", "000", "001", "001", "001", "001", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "000", "001", "001", "001", "101", "000", "000", "000", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "000", "001", "000", "001", "000", "001", "001", "001", "001", "000", "000", "100", "100", "100"),
		 ("100", "100", "000", "001", "000", "001", "011", "001", "011", "000", "101", "001", "000", "100", "100", "100"),
		 ("100", "100", "000", "001", "000", "001", "001", "111", "001", "001", "000", "001", "000", "100", "100", "100"),
		 ("100", "100", "000", "001", "101", "000", "011", "001", "011", "001", "000", "001", "000", "100", "100", "100"),
		 ("100", "100", "000", "000", "001", "001", "001", "001", "000", "001", "000", "001", "000", "000", "000", "100"),
		 ("100", "100", "100", "000", "001", "000", "000", "000", "101", "001", "001", "001", "001", "010", "000", "100"),
		 ("100", "100", "100", "000", "001", "001", "001", "001", "001", "000", "000", "001", "001", "001", "000", "100"),
		 ("100", "100", "100", "000", "000", "000", "000", "000", "000", "000", "000", "000", "000", "000", "000", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100")),
		
		-- Nível 6
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "000", "000", "000", "000", "000", "000", "000", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "000", "001", "001", "000", "001", "010", "000", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "001", "001", "001", "000", "001", "001", "000", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "011", "001", "011", "001", "011", "001", "000", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "001", "011", "000", "000", "001", "001", "000", "100", "100", "100"),
		 ("100", "100", "100", "000", "000", "000", "001", "011", "001", "000", "001", "000", "000", "100", "100", "100"),
		 ("100", "100", "100", "000", "101", "101", "101", "101", "101", "001", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "000", "000", "000", "000", "000", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100")),
		
		-- Nível 7
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "000", "000", "000", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "001", "001", "001", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "000", "101", "001", "011", "000", "000", "001", "000", "000", "100", "100", "100"),
		 ("100", "100", "100", "000", "101", "101", "011", "001", "011", "001", "001", "010", "000", "100", "100", "100"),
		 ("100", "100", "100", "000", "101", "101", "001", "011", "001", "011", "001", "000", "000", "100", "100", "100"),
		 ("100", "100", "100", "000", "000", "000", "000", "000", "000", "001", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "000", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100")),
		
		-- Nível 8
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "000", "000", "000", "000", "000", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "001", "001", "000", "000", "001", "001", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "001", "001", "001", "011", "001", "001", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "011", "001", "000", "000", "000", "001", "011", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "001", "000", "101", "101", "101", "000", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "000", "000", "001", "000", "101", "101", "101", "000", "001", "000", "000", "100", "100", "100"),
		 ("100", "100", "000", "001", "011", "001", "001", "011", "001", "001", "011", "001", "000", "100", "100", "100"),
		 ("100", "100", "000", "001", "001", "001", "001", "001", "000", "001", "010", "001", "000", "100", "100", "100"),
		 ("100", "100", "000", "000", "000", "000", "000", "000", "000", "000", "000", "000", "000", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100")),
		
		-- Nível 9
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "000", "000", "000", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "000", "001", "001", "001", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "011", "011", "011", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "010", "001", "011", "101", "101", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "001", "011", "101", "101", "101", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "000", "001", "001", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "000", "000", "000", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100")),
		
		-- Nível 10
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "000", "000", "000", "100", "100", "000", "000", "000", "000", "000", "100", "100"),
		 ("100", "100", "000", "000", "001", "001", "000", "100", "100", "000", "001", "001", "001", "000", "100", "100"),
		 ("100", "100", "000", "001", "011", "001", "000", "000", "000", "000", "011", "001", "001", "000", "100", "100"),
		 ("100", "100", "000", "001", "001", "011", "101", "101", "101", "101", "001", "011", "001", "000", "100", "100"),
		 ("100", "100", "000", "000", "001", "001", "001", "001", "000", "001", "010", "001", "000", "000", "100", "100"),
		 ("100", "100", "100", "000", "000", "000", "000", "000", "000", "000", "000", "000", "000", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100")),
		
		-- Nível 11
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "000", "000", "000", "000", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "001", "001", "010", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "001", "001", "011", "101", "001", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "001", "001", "101", "011", "101", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "001", "111", "011", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "000", "001", "001", "001", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "000", "000", "000", "000", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100")),
		
		-- Nível 12
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "000", "000", "000", "000", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "000", "101", "101", "000", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "000", "001", "101", "000", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "001", "001", "011", "101", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "001", "011", "001", "001", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "001", "001", "000", "011", "011", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "001", "001", "010", "001", "001", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "000", "000", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100")),
		
		-- Nível 13
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "000", "000", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "001", "001", "000", "001", "001", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "001", "011", "101", "101", "011", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "010", "011", "101", "111", "001", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "001", "011", "101", "101", "011", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "001", "001", "000", "001", "001", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "000", "000", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100")),
		
		-- Nível 14
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "000", "000", "000", "000", "000", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "001", "001", "001", "001", "000", "000", "000", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "000", "001", "011", "001", "001", "001", "001", "000", "100", "100", "100"),
		 ("100", "100", "100", "000", "000", "000", "001", "011", "001", "000", "000", "001", "000", "100", "100", "100"),
		 ("100", "100", "100", "000", "101", "101", "101", "001", "011", "001", "001", "001", "000", "100", "100", "100"),
		 ("100", "100", "100", "000", "101", "101", "101", "011", "000", "011", "001", "000", "000", "100", "100", "100"),
		 ("100", "100", "100", "000", "000", "000", "000", "001", "000", "001", "011", "001", "000", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "000", "001", "001", "010", "001", "001", "000", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "000", "000", "000", "000", "000", "000", "000", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100")),
		
		-- Nível 15
		(("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "000", "000", "000", "000", "000", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "001", "001", "001", "001", "000", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "001", "011", "011", "011", "000", "000", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "001", "001", "000", "101", "101", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "000", "000", "001", "001", "101", "101", "011", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "001", "010", "001", "001", "001", "001", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "000", "000", "000", "000", "000", "000", "000", "000", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"),
		 ("100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100", "100"))
	);

	-- Posição inicial do jogador no mapa para cada nível
	constant start_player_pos_x : player_start_array_t := (
		"0111", -- Nível 0
		"1011", -- Nível 1
		"1010", -- Nível 2
		"1001", -- Nível 3
		"1001", -- Nível 4
		"0010", -- Nível 5
		"0100", -- Nível 6
		"0100", -- Nível 7
		"0101", -- Nível 8
		"1010", -- Nível 9
		"0101", -- Nível 10
		"0110", -- Nível 11
		"1000", -- Nível 12
		"1010", -- Nível 13
		"0110", -- Nível 14
		"1001" -- Nível 15
	);
	constant start_player_pos_y : player_start_array_t := (
		"0111", -- Nível 0
		"1011", -- Nível 1
		"1000", -- Nível 2
		"1001", -- Nível 3
		"1010", -- Nível 4
		"0101", -- Nível 5
		"1010", -- Nível 6
		"1000", -- Nível 7
		"0101", -- Nível 8
		"1000", -- Nível 9
		"0110", -- Nível 10
		"1010", -- Nível 11
		"0101", -- Nível 12
		"1000", -- Nível 13
		"0101", -- Nível 14
		"0110" -- Nível 15
	);

end package;