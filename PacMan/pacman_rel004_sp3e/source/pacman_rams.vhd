--
-- A simulation model of Pacman hardware
-- Copyright (c) MikeJ - January 2006
--
-- All rights reserved
--
-- Redistribution and use in source and synthezised forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- Redistributions of source code must retain the above copyright notice,
-- this list of conditions and the following disclaimer.
--
-- Redistributions in synthesized form must reproduce the above copyright
-- notice, this list of conditions and the following disclaimer in the
-- documentation and/or other materials provided with the distribution.
--
-- Neither the name of the author nor the names of other contributors may
-- be used to endorse or promote products derived from this software without
-- specific prior written permission.
--
-- THIS CODE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO,
-- THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
-- PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.
--
-- You are responsible for any legal issues arising from your use of this code.
--
-- The latest version of this file can be found at: www.fpgaarcade.com
--
-- Email pacman@fpgaarcade.com
--
-- Revision list
--
-- version 003 Jan 2006 release, general tidy up
-- version 001 initial release
--
library ieee;
  use ieee.std_logic_1164.all;
  use ieee.std_logic_unsigned.all;
  use ieee.numeric_std.all;

library UNISIM;
  use UNISIM.Vcomponents.all;

use work.pkg_pacman.all;

entity PACMAN_RAMS is
  port (
    I_AB              : in    std_logic_vector(11 downto 0);
    I_DATA            : in    std_logic_vector( 7 downto 0);
    O_DATA            : out   std_logic_vector( 7 downto 0);
    I_R_W_L           : in    std_logic;
    I_VRAM_L          : in    std_logic;
    ENA_6             : in    std_logic;
    CLK               : in    std_logic
    );
end;

architecture RTL of PACMAN_RAMS is

  signal ram_addr : std_logic_vector(10 downto 0);
  signal dout_v   : std_logic_vector(7 downto 0);
  signal dout_c   : std_logic_vector(7 downto 0);
  signal dout_w   : std_logic_vector(7 downto 0);
  signal cs       : std_logic_vector(3 downto 0);
  signal we_v     : std_logic;
  signal we_c     : std_logic;
  signal we_w     : std_logic;

begin
  -- if you wanted to save one more block ram, clearly two of these rams could be combined.
  ram_addr <= '0' & I_AB(9 downto 0);

  vram : component RAMB16_S9
    port map (
      do   => dout_v,
      dop  => open,
      addr => ram_addr,
      clk  => CLK,
      di   => I_DATA(7 downto 0),
      dip  => "0",
      en   => ENA_6,
      ssr  => '0',
      we   => we_v
      );

  cram : component RAMB16_S9
    port map (
      do   => dout_c,
      dop  => open,
      addr => ram_addr,
      clk  => CLK,
      di   => I_DATA(7 downto 0),
      dip  => "0",
      en   => ENA_6,
      ssr  => '0',
      we   => we_c
      );

  wram : component RAMB16_S9
    port map (
      do   => dout_w,
      dop  => open,
      addr => ram_addr,
      clk  => CLK,
      di   => I_DATA(7 downto 0),
      dip  => "0",
      en   => ENA_6,
      ssr  => '0',
      we   => we_w
      );

  p_cs_comb  : process(I_AB, I_VRAM_L)
  begin
    cs <= "1111";
    if (I_VRAM_L = '0') then
      case I_AB(11 downto 10) is
        when "00" => cs <= "1110";
        when "01" => cs <= "1101";
        when "10" => cs <= "1011";
        when "11" => cs <= "0111";
        when others => null;
      end case;
    end if;
  end process;

  p_we_comb  : process(I_R_W_L, cs)
  begin
    we_v <= not cs(0) and not I_R_W_L;
    we_c <= not cs(1) and not I_R_W_L;
    we_w <= not cs(3) and not I_R_W_L;
  end process;

  p_mux_comb : process(I_AB, dout_v, dout_c, dout_w)
  begin
    O_DATA <= (others => '0');
    case I_AB(11 downto 10) is
      when "00" => O_DATA <= dout_v;
      when "01" => O_DATA <= dout_c;
      when "10" => O_DATA <= (others => '0');
      when "11" => O_DATA <= dout_w;
      when others => null;
    end case;
  end process;

end architecture RTL;
