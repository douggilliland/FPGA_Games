library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.PushBoxLevels.all;

entity PushBoxMap is
	generic (
		-- Número de bits de cada coordenada do mapa
		MAP_WIDTH_BITS  : natural := 4;
		MAP_HEIGHT_BITS : natural := 4
	);
	port (
		clk : in  std_logic;
		
		-- Inputs de botão
		btn_cima     : in  std_logic;
		btn_baixo    : in  std_logic;
		btn_esquerda : in  std_logic;
		btn_direita  : in  std_logic;
		btn_next_lvl : in  std_logic;
		rst          : in  std_logic;
		
		-- Bit que indica vitória quando é '1'
		victory : out std_logic;
		
		-- Número que indica o nível atual
		cur_level : out unsigned(7 downto 0);
		
		-- Dados VGA
		display_x         : in unsigned(3 downto 0);
		display_y         : in unsigned(3 downto 0);
		display_pos_value : out unsigned(2 downto 0)
	);
end entity;

architecture archPushBoxMap of PushBoxMap is

	-- Codificação do mapa:
	-- Bit 2: indica se é um objetivo ou não
	--   (caso especial) "100" indica parede "void", que é mostrada como um quadrado preto no VGA. Não indica objetivo.
	-- Bits 1 downto 0: indica o que está no local:
	--   00: Parede
	--   01: Chão
	--   10: Jogador
	--   11: Caixa

	-- Número que indica qual o nível atual
	signal s_cur_level : integer range 0 to level_count-1 := 0;

	-- Mapa e posição do player que são alterados dentro do jogo
	signal map_matrix : map_matrix_t := c_map_matrix_array(0);
	signal player_pos_x : unsigned(MAP_HEIGHT_BITS-1 downto 0) := start_player_pos_x(0);
	signal player_pos_y : unsigned(MAP_WIDTH_BITS-1 downto 0)  := start_player_pos_y(0);

	-- Sinais que guardam as três últimas leituras dos botões, para verificar um button press
	signal s_btn_cima     : unsigned(2 downto 0) := "000";
	signal s_btn_baixo    : unsigned(2 downto 0) := "000";
	signal s_btn_esquerda : unsigned(2 downto 0) := "000";
	signal s_btn_direita  : unsigned(2 downto 0) := "000";
	signal s_btn_next_lvl : unsigned(2 downto 0) := "000";
	signal s_rst          : unsigned(2 downto 0) := "000";

	-- Sinal que indica vitória quando é '1'
	signal s_victory : std_logic := '0';

begin

	-- Envia o valor do pixel para o VGA
	display_pos_value <= map_matrix(to_integer(2**MAP_WIDTH_BITS-1 - display_y), to_integer(2**MAP_HEIGHT_BITS-1 - display_x));
	
	-- Envia o valor do nível atual para os displays de sete segmentos
	cur_level <= to_unsigned(s_cur_level, 8);
	
	-- Processo do clock
	process (clk)
	begin
		if rising_edge(clk) then
			-- Lê os botões (joga fora a leitura mais antiga e concatena a nova no final do vetor)
			s_btn_cima     <= s_btn_cima    (1 downto 0) & btn_cima;
			s_btn_baixo    <= s_btn_baixo   (1 downto 0) & btn_baixo;
			s_btn_esquerda <= s_btn_esquerda(1 downto 0) & btn_esquerda;
			s_btn_direita  <= s_btn_direita (1 downto 0) & btn_direita;
			s_btn_next_lvl <= s_btn_next_lvl(1 downto 0) & btn_next_lvl;
			s_rst          <= s_rst         (1 downto 0) & rst;
			
			-- Reseta o mapa
			if s_rst(2 downto 1) = "10" then
				map_matrix <= c_map_matrix_array(s_cur_level);
				player_pos_x <= start_player_pos_x(s_cur_level);
				player_pos_y <= start_player_pos_y(s_cur_level);
			end if;
				
			-- Troca o nível
			if s_btn_next_lvl(2 downto 1) = "10" then
				if s_victory = '1' then
					map_matrix <= c_map_matrix_array(s_cur_level + 1);
					player_pos_x <= start_player_pos_x(s_cur_level + 1);
					player_pos_y <= start_player_pos_y(s_cur_level + 1);
					s_cur_level <= s_cur_level + 1;
				end if;
			end if;
			
			-- Detecta botão CIMA
			if s_btn_cima(2 downto 1) = "10" then
				-- Verifica se a posição do movimento é uma caixa, e se esta pode ser movida
				if map_matrix(to_integer(player_pos_y + 1), to_integer(player_pos_x))(1 downto 0) = "11" and
				   map_matrix(to_integer(player_pos_y + 2), to_integer(player_pos_x))(1 downto 0) = "01" then
				    
					-- Altera posição do player
					map_matrix(to_integer(player_pos_y + 1), to_integer(player_pos_x))(1 downto 0) <= "10";
					-- Altera posição da caixa
					map_matrix(to_integer(player_pos_y + 2), to_integer(player_pos_x))(1 downto 0) <= "11";
					-- Limpa local anterior do player
					map_matrix(to_integer(player_pos_y), to_integer(player_pos_x))(1 downto 0) <= "01";
					player_pos_y <= player_pos_y + 1;
				
				-- Verifica se a posição do movimento é chão
				elsif map_matrix(to_integer(player_pos_y + 1), to_integer(player_pos_x))(1 downto 0) = "01" then
					
					-- Altera posição do player
					map_matrix(to_integer(player_pos_y + 1), to_integer(player_pos_x))(1 downto 0) <= "10";
					-- Limpa local anterior do player
					map_matrix(to_integer(player_pos_y), to_integer(player_pos_x))(1 downto 0) <= "01";
					player_pos_y <= player_pos_y + 1;
					
				end if;
			-- Detecta botão BAIXO
			elsif s_btn_baixo(2 downto 1) = "10" then
				-- Verifica se a posição do movimento é uma caixa, e se esta pode ser movida
				if map_matrix(to_integer(player_pos_y - 1), to_integer(player_pos_x))(1 downto 0) = "11" and
				   map_matrix(to_integer(player_pos_y - 2), to_integer(player_pos_x))(1 downto 0) = "01" then
				    
					-- Altera posição do player
					map_matrix(to_integer(player_pos_y - 1), to_integer(player_pos_x))(1 downto 0) <= "10";
					-- Altera posição da caixa
					map_matrix(to_integer(player_pos_y - 2), to_integer(player_pos_x))(1 downto 0) <= "11";
					-- Limpa local anterior do player
					map_matrix(to_integer(player_pos_y), to_integer(player_pos_x))(1 downto 0) <= "01";
					player_pos_y <= player_pos_y - 1;
				
				-- Verifica se a posição do movimento é chão
				elsif map_matrix(to_integer(player_pos_y - 1), to_integer(player_pos_x))(1 downto 0) = "01" then
					
					-- Altera posição do player
					map_matrix(to_integer(player_pos_y - 1), to_integer(player_pos_x))(1 downto 0) <= "10";
					-- Limpa local anterior do player
					map_matrix(to_integer(player_pos_y), to_integer(player_pos_x))(1 downto 0) <= "01";
					player_pos_y <= player_pos_y - 1;
					
				end if;
			end if;
			
			-- Detecta botão ESQUERDA
			if s_btn_esquerda(2 downto 1) = "10" then
				-- Verifica se a posição do movimento é uma caixa, e se esta pode ser movida
				if map_matrix(to_integer(player_pos_y), to_integer(player_pos_x + 1))(1 downto 0) = "11" and
				   map_matrix(to_integer(player_pos_y), to_integer(player_pos_x + 2))(1 downto 0) = "01" then
				    
					-- Altera posição do player
					map_matrix(to_integer(player_pos_y), to_integer(player_pos_x + 1))(1 downto 0) <= "10";
					-- Altera posição da caixa
					map_matrix(to_integer(player_pos_y), to_integer(player_pos_x + 2))(1 downto 0) <= "11";
					-- Limpa local anterior do player
					map_matrix(to_integer(player_pos_y), to_integer(player_pos_x))(1 downto 0) <= "01";
					player_pos_x <= player_pos_x + 1;
				
				-- Verifica se a posição do movimento é chão
				elsif map_matrix(to_integer(player_pos_y), to_integer(player_pos_x + 1))(1 downto 0) = "01" then
					
					-- Altera posição do player
					map_matrix(to_integer(player_pos_y), to_integer(player_pos_x + 1))(1 downto 0) <= "10";
					-- Limpa local anterior do player
					map_matrix(to_integer(player_pos_y), to_integer(player_pos_x))(1 downto 0) <= "01";
					player_pos_x <= player_pos_x + 1;
					
				end if;
			-- Detecta botão DIREITA
			elsif s_btn_direita(2 downto 1) = "10" then
				-- Verifica se a posição do movimento é uma caixa, e se esta pode ser movida
				if map_matrix(to_integer(player_pos_y), to_integer(player_pos_x - 1))(1 downto 0) = "11" and
				   map_matrix(to_integer(player_pos_y), to_integer(player_pos_x - 2))(1 downto 0) = "01" then
				    
					-- Altera posição do player
					map_matrix(to_integer(player_pos_y), to_integer(player_pos_x - 1))(1 downto 0) <= "10";
					-- Altera posição da caixa
					map_matrix(to_integer(player_pos_y), to_integer(player_pos_x - 2))(1 downto 0) <= "11";
					-- Limpa local anterior do player
					map_matrix(to_integer(player_pos_y), to_integer(player_pos_x))(1 downto 0) <= "01";
					player_pos_x <= player_pos_x - 1;
				
				-- Verifica se a posição do movimento é chão
				elsif map_matrix(to_integer(player_pos_y), to_integer(player_pos_x - 1))(1 downto 0) = "01" then
					
					-- Altera posição do player
					map_matrix(to_integer(player_pos_y), to_integer(player_pos_x - 1))(1 downto 0) <= "10";
					-- Limpa local anterior do player
					map_matrix(to_integer(player_pos_y), to_integer(player_pos_x))(1 downto 0) <= "01";
					player_pos_x <= player_pos_x - 1;
					
				end if;
			end if;
			
			-- Verifica se o jogador ganhou
			s_victory <= '1';
			for i in 0 to 2**MAP_WIDTH_BITS-1 loop
				for j in 0 to 2**MAP_WIDTH_BITS-1 loop
					-- Caso encontre alguma posição objetivo que não tenha uma caixa em cima e não seja uma parede "void", o jogador não ganhou
					if map_matrix(i, j)(2) = '1' and map_matrix(i, j)(1 downto 0) /= "11" and map_matrix(i, j)(1 downto 0) /= "00" then
						s_victory <= '0';
					end if;
				end loop;
			end loop;
			victory <= s_victory;
		end if;
	end process;
	
end architecture;
