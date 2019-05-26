library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VgaSync is
	port (
		reset       : in  std_logic;             -- Entrada para reiniciar o estado do controlador
		clock       : in  std_logic;             -- Entrada de clock (50 MHz)
		hsync       : out std_logic;             -- Sinal de sincronismo horizontal do VGA
		vsync       : out std_logic;             -- Sinal de sincronismo vertical do VGA
		row         : out unsigned(9 downto 0);  -- Índice da linha que esta sendo processada
		column      : out unsigned(10 downto 0); -- Índice da coluna que está sendo processada
		disp_enable : out std_logic              -- Indica se está dentro da região ativa do frame
	);
end entity;


architecture archVgaSync of VgaSync is

-- Sinais de controle Horizontal
signal s_comp_h1 : std_logic; -- Indica que o contador Horizontal está com o valor D
signal s_comp_h2 : std_logic; -- Indica que o contador Horizontal está com o valor D+E
signal s_comp_h3 : std_logic; -- Indica que o contador Horizontal está com o valor D+E+B
signal s_comp_h4 : std_logic; -- Indica que o contador Horizontal está com o valor D+E+B+C
signal s_hsync_next   : std_logic; -- Valor de H_SYNC no próximo pulso de clock
signal s_hsync_prev   : std_logic; -- Último valor atribuído em H_SYNC
signal s_activeh_next : std_logic; -- Indica que o contador Horizontal está na região ativa
signal s_activeh_prev : std_logic; -- Último valor atribuído em HDataOn
signal s_counth_next  : unsigned(10 downto 0); -- Próximo valor do contador Horizontal
signal s_counth_prev  : unsigned(10 downto 0); -- Valor atual do contador Horizontal

-- Sinais de controle Vertical
signal s_comp_v1 : std_logic; -- Indica que o contador Vertical está com o valor R
signal s_comp_v2 : std_logic; -- Indica que o contador Vertical está com o valor R+S
signal s_comp_v3 : std_logic; -- Indica que o contador Vertical está com o valor R+S+P
signal s_comp_v4 : std_logic; -- Indica que o contador Vertical está com o valor R+S+P+Q
signal s_vsync_next   : std_logic; -- Valor de V_SYNC no próximo pulso de clock
signal s_vsync_prev   : std_logic; -- Último valor atribuído em V_SYNC
signal s_activev_next : std_logic; -- Indica que o contador Vertical está na região ativa
signal s_activev_prev : std_logic; -- Último valor atribuído em VDataOn
signal s_countv_next  : unsigned(9 downto 0); -- Próximo valor do contador Vertical
signal s_countv_prev  : unsigned(9 downto 0); -- Valor atual do contador Vertical

begin

	--=============================================
	--SINAIS DE CONTROLE DO MÓDULO VGA
	--=============================================
	hsync  <= s_hsync_prev;
	vsync  <= s_vsync_prev;
	row    <= s_countv_prev;
	column <= s_counth_prev;
	disp_enable <= s_activeh_prev and s_activev_prev;
	
	--=============================================
	--Atualiza o sinal de saída dos FFD conforme o 
	--sinal de Clock/Reset
	--=============================================
	process (clock, reset)
	begin
		if (reset = '1') then
			s_counth_prev  <= (others => '0');
			s_countv_prev  <= (others => '0');
			s_hsync_prev   <= '0';
			s_vsync_prev   <= '0';
			s_activeh_prev <= '0';
			s_activev_prev <= '0';
		elsif rising_edge(clock) then
			-- Contadores
			s_counth_prev <= s_counth_next;
			s_countv_prev <= s_countv_next;
			
			--Sinais de sincronismo
			s_hsync_prev   <= s_hsync_next;
			s_vsync_prev   <= s_vsync_next;
			s_activeh_prev <= s_activeh_next;
			s_activev_prev <= s_activev_next;
		end if;
	end process;

	--=============================================
	--CONTADORES
	--=============================================
	
	--Contador - Horizontal
	-- O contador é reiniciado após 1040 pulsos
	s_counth_next <= (others => '0') when s_comp_h4 = '1' else
	                 s_counth_prev + 1;
	
	-- Contador - Vertical
	-- O contador é reiniciado após 666 pulsos
	-- O contador é incrementado somente após a finalização de uma linha
	s_countv_next <= (others => '0') when s_comp_v4 = '1' else
 	                 s_countv_prev + 1 when s_comp_h4 = '1' else
	                 s_countv_prev;
						
	--=============================================
	--COMPARADORES
	--=============================================
	
	--CONTADOR = D (800)
	s_comp_h1 <= '1' when s_counth_prev = 799 else '0';
	
	--CONTADOR = D + E (D + E = 800 + 56 = 856)
	s_comp_h2 <= '1' when s_counth_prev = 855 else '0';
	
	--CONTADOR = D + E + B (D + E + B = 800 + 56 + 120 = 976)
	s_comp_h3 <= '1' when s_counth_prev = 975 else '0';
	
	--CONTADOR = D + E + B + C = (D + E + B + C = 800 + 56 + 120 + 64 = 1040)
	s_comp_h4 <= '1' when s_counth_prev = 1039 else '0';
						
	--CONTADOR = R 600
	s_comp_v1 <= '1' when s_countv_prev = 599 else '0';
	
	--CONTADOR = R + S 600 + 37 = 637
	s_comp_v2 <= '1' when s_countv_prev = 636 else '0';
	
	--CONTADOR = R + S + P = 600 + 37 + 6 = 643
	s_comp_v3 <= '1' when s_countv_prev = 642 else '0';
	
	--CONTADOR = R + S + P + Q = 600 + 37 + 6 + 23 = 666
	s_comp_v4 <= '1' when s_countv_prev = 665 else '0';
	
	
	--=============================================
	--VALORES DE ENTRADA DOS FFD
	--=============================================
	
	--Sincronização - Horizontal
	-- HSYNC = 0 após 856 pulsos e permanece em zero até 976 pulsos
	s_hsync_next <= '0' when s_comp_h2 = '1' else --Reset
	              '1' when s_comp_h3 = '1' else --Set
	              s_hsync_prev;	         --Memória
	
	--Sincronização Vertical
	--VSYNC = 0 após 637 pulsos e permanece em zero até 643 pulsos	
	s_vsync_next <= '0' when s_comp_v2 = '1' else --Reset
	              '1' when s_comp_v3 = '1' else --Set
	              s_vsync_prev;	         --Memória
	
	--Região Ativa - Horizontal
	s_activeh_next <= '0' when s_comp_h1 = '1' else --Reset
	                '1' when s_comp_h4 = '1' else --Set
	                s_activeh_prev;		   --Memória

	--Região Ativa - Vertical
	s_activev_next <= '0' when s_comp_v1 = '1' else --Reset
	                '1' when s_comp_v4 = '1' else --Set
	                s_activev_prev;		   --Memória
	
end architecture;
