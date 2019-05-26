Revision 3
; Created by bitgen P.68d at Thu Nov 30 15:41:50 2017
; Bit lines have the following form:
; <offset> <frame address> <frame offset> <information>
; <information> may be zero or more <kw>=<value> pairs
; Block=<blockname     specifies the block associated with this
;                      memory cell.
;
; Latch=<name>         specifies the latch associated with this memory cell.
;
; Net=<netname>        specifies the user net associated with this
;                      memory cell.
;
; COMPARE=[YES | NO]   specifies whether or not it is appropriate
;                      to compare this bit position between a
;                      "program" and a "readback" bitstream.
;                      If not present the default is NO.
;
; Ram=<ram id>:<bit>   This is used in cases where a CLB function
; Rom=<ram id>:<bit>   generator is used as RAM (or ROM).  <Ram id>
;                      will be either 'F', 'G', or 'M', indicating
;                      that it is part of a single F or G function
;                      generator used as RAM, or as a single RAM
;                      (or ROM) built from both F and G.  <Bit> is
;                      a decimal number.
;
; Info lines have the following form:
; Info <name>=<value>  specifies a bit associated with the LCA
;                      configuration options, and the value of
;                      that bit.  The names of these bits may have
;                      special meaning to software reading the .ll file.
;
Info STARTSEL0=1
Bit  3850083 0x0000109f    771 Block=SLICE_X54Y112 Latch=AQ Net=dfuno/count<0>
Bit  3850108 0x0000109f    796 Block=SLICE_X54Y112 Latch=BQ Net=dfuno/count<1>
Bit  3850113 0x0000109f    801 Block=SLICE_X54Y112 Latch=CQ Net=dfuno/count<2>
Bit  3850138 0x0000109f    826 Block=SLICE_X54Y112 Latch=DQ Net=dfuno/count<3>
Bit  3850147 0x0000109f    835 Block=SLICE_X54Y113 Latch=AQ Net=dfuno/count<4>
Bit  3850172 0x0000109f    860 Block=SLICE_X54Y113 Latch=BQ Net=dfuno/count<5>
Bit  3850177 0x0000109f    865 Block=SLICE_X54Y113 Latch=CQ Net=dfuno/count<6>
Bit  3850202 0x0000109f    890 Block=SLICE_X54Y113 Latch=DQ Net=dfuno/count<7>
Bit  3850211 0x0000109f    899 Block=SLICE_X54Y114 Latch=AQ Net=dfuno/count<8>
Bit  3850231 0x0000109f    919 Block=SLICE_X55Y114 Latch=BMUX Net=dfuno/CLKOUT_rstpot
Bit  3850236 0x0000109f    924 Block=SLICE_X54Y114 Latch=BQ Net=dfuno/count<9>
Bit  3850237 0x0000109f    925 Block=SLICE_X55Y114 Latch=BQ Net=dfuno/CLKOUT
Bit  3850241 0x0000109f    929 Block=SLICE_X54Y114 Latch=CQ Net=dfuno/count<10>
Bit  3850266 0x0000109f    954 Block=SLICE_X54Y114 Latch=DQ Net=dfuno/count<11>
Bit  3850275 0x0000109f    963 Block=SLICE_X54Y115 Latch=AQ Net=dfuno/count<12>
Bit 13391939 0x0040041f   1763 Block=SLICE_X10Y77 Latch=AQ Net=psdos0/regis<0>
Bit 13391964 0x0040041f   1788 Block=SLICE_X10Y77 Latch=BQ Net=psdos0/regis<1>
Bit 13391969 0x0040041f   1793 Block=SLICE_X10Y77 Latch=CQ Net=psdos0/regis<2>
Bit 13391978 0x0040041f   1802 Block=SLICE_X11Y77 Latch=CMUX Net=N5
Bit 13391994 0x0040041f   1818 Block=SLICE_X10Y77 Latch=DQ Net=psdos0/regis<3>
Bit 13392003 0x0040041f   1827 Block=SLICE_X10Y78 Latch=AQ Net=psdos0/regis<4>
Bit 13392028 0x0040041f   1852 Block=SLICE_X10Y78 Latch=BQ Net=psdos0/regis<5>
Bit 13392033 0x0040041f   1857 Block=SLICE_X10Y78 Latch=CQ Net=psdos0/regis<6>
Bit 13392052 0x0040041f   1876 Block=SLICE_X11Y78 Latch=DMUX Net=psdos0/regis[8]_regis[8]_mux_8_OUT<0>
Bit 13392058 0x0040041f   1882 Block=SLICE_X10Y78 Latch=DQ Net=psdos0/regis<7>
Bit 14626627 0x0040099f   1827 Block=SLICE_X28Y78 Latch=AQ Net=psdos0/i<0>
Bit 14626628 0x0040099f   1828 Block=SLICE_X29Y78 Latch=AQ Net=psdos0/regis<8>
Bit 14626629 0x0040099f   1829 Block=SLICE_X29Y78 Latch=AMUX Net=psdos0/mux11111
Bit 14626652 0x0040099f   1852 Block=SLICE_X28Y78 Latch=BQ Net=psdos0/i<1>
Bit 14626675 0x0040099f   1875 Block=SLICE_X28Y78 Latch=DMUX Net=psdos0/j[3]_INV_10_o12
Bit 14626682 0x0040099f   1882 Block=SLICE_X28Y78 Latch=DQ Net=psdos0/i<2>
Bit 14626691 0x0040099f   1891 Block=SLICE_X28Y79 Latch=AQ Net=psdos0/init
Bit 14626747 0x0040099f   1947 Block=SLICE_X29Y79 Latch=DQ Net=psdos0/i<3>
Bit 14742979 0x00400a1f   1827 Block=SLICE_X30Y78 Latch=AQ Net=psdos0/j<0>
