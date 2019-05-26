library verilog;
use verilog.vl_types.all;
entity PushBox is
    port(
        VGA_HS          : out    vl_logic;
        SW              : in     vl_logic_vector(2 downto 0);
        CLOCK_50        : in     vl_logic;
        VGA_VS          : out    vl_logic;
        HEX0            : out    vl_logic_vector(6 downto 0);
        KEY             : in     vl_logic_vector(3 downto 0);
        HEX1            : out    vl_logic_vector(6 downto 0);
        LEDG            : out    vl_logic_vector(0 downto 0);
        VGA_B           : out    vl_logic_vector(3 downto 0);
        VGA_G           : out    vl_logic_vector(3 downto 0);
        VGA_R           : out    vl_logic_vector(3 downto 0)
    );
end PushBox;
