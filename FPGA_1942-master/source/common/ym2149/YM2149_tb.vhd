
use std.textio.ALL;
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_arith.all;
  use ieee.std_logic_unsigned.all;

entity YM2149_TB is
end;

architecture Sim of YM2149_TB is
  component YM2149
    port (
    -- data bus
    I_DA                : in  std_logic_vector(7 downto 0);
    O_DA                : out std_logic_vector(7 downto 0);
--    O_DA_OE_L           : out std_logic;
    -- control
    I_A9_L              : in  std_logic;
    I_A8                : in  std_logic;
    I_BDIR              : in  std_logic;
    I_BC2               : in  std_logic;
    I_BC1               : in  std_logic;
    I_SEL_L             : in  std_logic;

    O_AUDIO             : out std_logic_vector(7 downto 0);
--    -- port a
--    I_IOA               : in  std_logic_vector(7 downto 0);
--    O_IOA               : out std_logic_vector(7 downto 0);
--    O_IOA_OE_L          : out std_logic;
--    -- port b
--    I_IOB               : in  std_logic_vector(7 downto 0);
--    O_IOB               : out std_logic_vector(7 downto 0);
--    O_IOB_OE_L          : out std_logic;

    ENA                 : in  std_logic; -- clock enable for higher speed operation
    RESET_L             : in  std_logic;
    CLK                 : in  std_logic  -- note 6 Mhz
    );
  end component;

  --  signals
  constant CLKPERIOD          : time := 333.3333 ns;
  signal func                 : string(8 downto 1);

  signal clk                  : std_logic;
  signal reset_l              : std_logic;

  signal da_in                : std_logic_vector(7 downto 0);
  signal da_out               : std_logic_vector(7 downto 0);
  signal da_oe_l              : std_logic;
  signal bdir                 : std_logic;
  signal bc2                  : std_logic;
  signal bc1                  : std_logic;
  signal audio                : std_logic_vector(7 downto 0);
  signal ioa_in               : std_logic_vector(7 downto 0) := (others => '0');
  signal ioa_out              : std_logic_vector(7 downto 0);
  signal ioa_oe_l             : std_logic;
  signal iob_in               : std_logic_vector(7 downto 0) := (others => '0');
  signal iob_out              : std_logic_vector(7 downto 0);
  signal iob_oe_l             : std_logic;
begin
  u0 : YM2149
    port map (
    -- data bus
    I_DA                => da_in,
    O_DA                => da_out,
--    O_DA_OE_L           => da_oe_l,
    -- control
    I_A9_L              => '0',
    I_A8                => '1',
    I_BDIR              => bdir,
    I_BC2               => bc2,
    I_BC1               => bc1,
    I_SEL_L             => '1',

    O_AUDIO             => audio,
--    -- port a
--    I_IOA               => ioa_in,
--    O_IOA               => ioa_out,
--    O_IOA_OE_L          => ioa_oe_l,
--    -- port b
--    I_IOB               => iob_in,
--    O_IOB               => iob_out,
--    O_IOB_OE_L          => iob_oe_l,

    ENA                 => '1',
    RESET_L             => reset_l,
    CLK                 => clk
    );

  p_clk  : process
  begin
    CLK <= '0';
    wait for CLKPERIOD / 2;
    CLK <= '1';
    wait for CLKPERIOD / 2;
  end process;

  p_debug_comb : process(bdir, bc2, bc1)
    variable sel : std_logic_vector(2 downto 0);
  begin
    func <= "-XXXXXX-";
    sel := bdir & bc2 & bc1;
    case sel is
      when "000" |
           "010" |
           "101" => func <= "inactive";
      when "001" |
           "100" |
           "111" => func <= "address ";
      when "011" => func <= "read    ";
      when "110" => func <= "write   ";
      when others => null;
    end case;
  end process;

  p_test : process

  procedure write(
    addr : in bit_vector(3 downto 0);
    data : in bit_vector(7 downto 0)
  ) is
  begin
    wait until rising_edge(clk);
    -- addr
    bdir <= '1';
    bc2 <= '1';
    bc1 <= '1';
    da_in <= x"0" & to_stdlogicvector(addr);
    wait until rising_edge(clk);
    bdir <= '0';
    bc2 <= '0';
    bc1 <= '0';
    wait until rising_edge(clk);
    da_in <= (others => 'Z');
    wait until rising_edge(clk);
    -- write
    bdir <= '1';
    bc2 <= '1';
    bc1 <= '0';
    da_in <= to_stdlogicvector(data);
    wait until rising_edge(clk);
    bdir <= '0';
    bc2 <= '0';
    bc1 <= '0';
    wait until rising_edge(clk);
    da_in <= (others => 'Z');
    wait until rising_edge(clk);

  end write;

  procedure read(
    addr : in bit_vector(3 downto 0)
  ) is
  begin
    wait until rising_edge(clk);
    -- addr
    bdir <= '1';
    bc2 <= '1';
    bc1 <= '1';
    da_in <= x"0" & to_stdlogicvector(addr);
    wait until rising_edge(clk);
    bdir <= '0';
    bc2 <= '0';
    bc1 <= '0';
    wait until rising_edge(clk);
    da_in <= (others => 'Z');
    wait until rising_edge(clk);
    -- read
    bdir <= '0';
    bc2 <= '1';
    bc1 <= '1';
    da_in <= (others => 'Z');
    wait until rising_edge(clk);
    bdir <= '0';
    bc2 <= '0';
    bc1 <= '0';
    wait until rising_edge(clk);

  end read;

  begin
    reset_l <= '0';
    da_in <= (others => 'Z');
    bdir <= '0';
    bc2 <= '0';
    bc1 <= '0';
    wait for CLKPERIOD*10;
    reset_l <= '1';

    wait for 50 ms;
    write(x"0",x"00");
    write(x"1",x"11"); -- 91.552734375Hz, 10.922666ms
    write(x"2",x"22");
    write(x"3",x"33");
    write(x"4",x"44");
    write(x"5",x"55");
    write(x"6",x"66");
    write(x"7",x"77");
    write(x"8",x"88");
    write(x"9",x"99");
    write(x"a",x"aa");
    write(x"b",x"bb");
    write(x"c",x"cc");
    write(x"d",x"dd");
    write(x"e",x"ee");
    write(x"f",x"ff");
    wait for 100 ms;

    write(x"7",x"00");
    write(x"7",x"ff");
    write(x"7",x"55");
    write(x"7",x"aa");
    write(x"7",x"0f");
    write(x"7",x"f0");


--    wait for 50 ms;
--    write(x"0",x"00");
--    write(x"1",x"08"); -- 91.552734375Hz, 10.922666ms
--    write(x"2",x"00");
--    write(x"3",x"00");
--    write(x"4",x"00");
--    write(x"5",x"00");
--    write(x"6",x"00");
--    write(x"7",x"fe");
--    write(x"8",x"0f");
--    write(x"9",x"0f");
--    write(x"a",x"0f");
--    write(x"b",x"00");
--    write(x"c",x"00");
--    write(x"d",x"00");
--    write(x"e",x"02");
--    write(x"f",x"00");
--    wait for 100 ms;
--
--    write(x"0",x"00");
--    write(x"1",x"00");
--    write(x"2",x"00");
--    write(x"3",x"06"); -- 122.0703125Hz, 8.192ms
--    write(x"4",x"00");
--    write(x"5",x"00");
--    write(x"6",x"00");
--    write(x"7",x"fd");
--    write(x"8",x"0f");
--    write(x"9",x"0f");
--    write(x"a",x"0f");
--    write(x"b",x"00");
--    write(x"c",x"00");
--    write(x"d",x"00");
--    write(x"e",x"02");
--    write(x"f",x"00");
--    wait for 100 ms;
--
--    write(x"0",x"00");
--    write(x"1",x"00");
--    write(x"2",x"00");
--    write(x"3",x"00");
--    write(x"4",x"00");
--    write(x"5",x"04"); -- 183.10546875Hz, 5.46133333ms
--    write(x"6",x"00");
--    write(x"7",x"fb");
--    write(x"8",x"0f");
--    write(x"9",x"0f");
--    write(x"a",x"0f");
--    write(x"b",x"00");
--    write(x"c",x"00");
--    write(x"d",x"00");
--    write(x"e",x"02");
--    write(x"f",x"00");
--    wait for 100 ms;
--
--    write(x"0",x"00");
--    write(x"1",x"00");
--    write(x"2",x"00");
--    write(x"3",x"00");
--    write(x"4",x"00");
--    write(x"5",x"00");
--    write(x"6",x"00");
--    write(x"7",x"ff");
--    write(x"8",x"00");
--    write(x"9",x"00");
--    write(x"a",x"00");
--    write(x"b",x"00");
--    write(x"c",x"00");
--    write(x"d",x"00");
--    write(x"e",x"02");
--    write(x"f",x"00");


--    wait for 250 ms;
--    write(x"0",x"71");
--    write(x"1",x"04");
--    write(x"2",x"00");
--    write(x"3",x"00");
--    write(x"4",x"00");
--    write(x"5",x"00");
--    write(x"6",x"00");
--    write(x"7",x"fe");
--    write(x"8",x"0d");
--    write(x"9",x"00");
--    write(x"a",x"00");
--    write(x"b",x"00");
--    write(x"c",x"00");
--    write(x"d",x"00");
--    write(x"e",x"02");
--    write(x"f",x"00");
--
--    wait for 250 ms;
--    write(x"0",x"fc");
--    write(x"1",x"04");
--    write(x"2",x"00");
--    write(x"3",x"00");
--    write(x"4",x"00");
--    write(x"5",x"00");
--    write(x"6",x"00");
--    write(x"7",x"fe");
--    write(x"8",x"0d");
--    write(x"9",x"00");
--    write(x"a",x"00");
--    write(x"b",x"00");
--    write(x"c",x"00");
--    write(x"d",x"00");
--    write(x"e",x"02");
--    write(x"f",x"00");
    wait;
  end process;

end Sim;

