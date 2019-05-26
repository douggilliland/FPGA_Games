Revision 3
; Created by bitgen P.68d at Thu Nov 30 17:07:59 2017
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
Bit  3733860 0x0000101f    900 Block=SLICE_X53Y114 Latch=AQ Net=dfuno/count<0>
Bit  3733885 0x0000101f    925 Block=SLICE_X53Y114 Latch=BQ Net=dfuno/count<1>
Bit  3733890 0x0000101f    930 Block=SLICE_X53Y114 Latch=CQ Net=dfuno/count<2>
Bit  3733915 0x0000101f    955 Block=SLICE_X53Y114 Latch=DQ Net=dfuno/count<3>
Bit  3733924 0x0000101f    964 Block=SLICE_X53Y115 Latch=AQ Net=dfuno/count<4>
Bit  3733949 0x0000101f    989 Block=SLICE_X53Y115 Latch=BQ Net=dfuno/count<5>
Bit  3733954 0x0000101f    994 Block=SLICE_X53Y115 Latch=CQ Net=dfuno/count<6>
Bit  3733971 0x0000101f   1011 Block=SLICE_X52Y115 Latch=DMUX Net=dfuno/CLKOUT_rstpot
Bit  3733978 0x0000101f   1018 Block=SLICE_X52Y115 Latch=DQ Net=dfuno/CLKOUT
Bit  3733979 0x0000101f   1019 Block=SLICE_X53Y115 Latch=DQ Net=dfuno/count<7>
Bit  3733988 0x0000101f   1028 Block=SLICE_X53Y116 Latch=AQ Net=dfuno/count<8>
Bit  3734013 0x0000101f   1053 Block=SLICE_X53Y116 Latch=BQ Net=dfuno/count<9>
Bit  3734018 0x0000101f   1058 Block=SLICE_X53Y116 Latch=CQ Net=dfuno/count<10>
Bit  3734043 0x0000101f   1083 Block=SLICE_X53Y116 Latch=DQ Net=dfuno/count<11>
Bit  3734052 0x0000101f   1092 Block=SLICE_X53Y117 Latch=AQ Net=dfuno/count<12>
Bit 13275587 0x0040039f   1763 Block=SLICE_X8Y77 Latch=AQ Net=psdos0/i<0>
Bit 13275606 0x0040039f   1782 Block=SLICE_X8Y77 Latch=BMUX Net=psdos0/i<1>
Bit 13275612 0x0040039f   1788 Block=SLICE_X8Y77 Latch=BQ Net=psdos0/i<2>
Bit 13275617 0x0040039f   1793 Block=SLICE_X8Y77 Latch=CQ Net=psdos0/i<3>
Bit 13275625 0x0040039f   1801 Block=SLICE_X8Y77 Latch=CMUX Net=psdos0/GND_2_o_GND_2_o_equal_12_o
Bit 13391939 0x0040041f   1763 Block=SLICE_X10Y77 Latch=AQ Net=psdos0/regis<4>
Bit 13391964 0x0040041f   1788 Block=SLICE_X10Y77 Latch=BQ Net=psdos0/regis<5>
Bit 13391969 0x0040041f   1793 Block=SLICE_X10Y77 Latch=CQ Net=psdos0/regis<6>
Bit 13391977 0x0040041f   1801 Block=SLICE_X10Y77 Latch=CMUX Net=N5
Bit 13391988 0x0040041f   1812 Block=SLICE_X11Y77 Latch=DMUX Net=psdos0/i[3]_Decoder_2_OUT<3><3>1
Bit 13391994 0x0040041f   1818 Block=SLICE_X10Y77 Latch=DQ Net=psdos0/regis<7>
Bit 13392003 0x0040041f   1827 Block=SLICE_X10Y78 Latch=AQ Net=psdos0/regis<0>
Bit 13392028 0x0040041f   1852 Block=SLICE_X10Y78 Latch=BQ Net=psdos0/regis<1>
Bit 13392033 0x0040041f   1857 Block=SLICE_X10Y78 Latch=CQ Net=psdos0/regis<2>
Bit 13392058 0x0040041f   1882 Block=SLICE_X10Y78 Latch=DQ Net=psdos0/regis<3>
Bit 13392068 0x0040041f   1892 Block=SLICE_X11Y79 Latch=AQ Net=psdos0/init
Bit 18667113 0x00401b9f   2313 Block=SLICE_X88Y85 Latch=CMUX Net=psdos0/DONE
