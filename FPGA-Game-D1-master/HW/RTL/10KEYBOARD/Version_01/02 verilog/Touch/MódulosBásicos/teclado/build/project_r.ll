Revision 3
; Created by bitgen P.68d at Thu Nov 30 14:19:08 2017
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
Bit  4289571 0x0000129f    707 Block=SLICE_X60Y111 Latch=AQ Net=dfuno/count<0>
Bit  4289596 0x0000129f    732 Block=SLICE_X60Y111 Latch=BQ Net=dfuno/count<1>
Bit  4289601 0x0000129f    737 Block=SLICE_X60Y111 Latch=CQ Net=dfuno/count<2>
Bit  4289626 0x0000129f    762 Block=SLICE_X60Y111 Latch=DQ Net=dfuno/count<3>
Bit  4289635 0x0000129f    771 Block=SLICE_X60Y112 Latch=AQ Net=dfuno/count<4>
Bit  4289660 0x0000129f    796 Block=SLICE_X60Y112 Latch=BQ Net=dfuno/count<5>
Bit  4289665 0x0000129f    801 Block=SLICE_X60Y112 Latch=CQ Net=dfuno/count<6>
Bit  4289690 0x0000129f    826 Block=SLICE_X60Y112 Latch=DQ Net=dfuno/count<7>
Bit  4289699 0x0000129f    835 Block=SLICE_X60Y113 Latch=AQ Net=dfuno/count<8>
Bit  4289719 0x0000129f    855 Block=SLICE_X61Y113 Latch=BMUX Net=dfuno/CLKOUT_rstpot
Bit  4289724 0x0000129f    860 Block=SLICE_X60Y113 Latch=BQ Net=dfuno/count<9>
Bit  4289725 0x0000129f    861 Block=SLICE_X61Y113 Latch=BQ Net=dfuno/CLKOUT
Bit  4289729 0x0000129f    865 Block=SLICE_X60Y113 Latch=CQ Net=dfuno/count<10>
Bit  4289754 0x0000129f    890 Block=SLICE_X60Y113 Latch=DQ Net=dfuno/count<11>
Bit  4289763 0x0000129f    899 Block=SLICE_X60Y114 Latch=AQ Net=dfuno/count<12>
Bit 18665700 0x00401b9f    900 Block=SLICE_X89Y64 Latch=AQ Net=psdos0/regis<0>
Bit 18665725 0x00401b9f    925 Block=SLICE_X89Y64 Latch=BQ Net=psdos0/regis<1>
Bit 18665730 0x00401b9f    930 Block=SLICE_X89Y64 Latch=CQ Net=psdos0/regis<2>
Bit 18665755 0x00401b9f    955 Block=SLICE_X89Y64 Latch=DQ Net=psdos0/regis<3>
Bit 18665763 0x00401b9f    963 Block=SLICE_X88Y65 Latch=AQ Net=psdos0/init
Bit 18665802 0x00401b9f   1002 Block=SLICE_X89Y65 Latch=CMUX Net=N5
Bit 18665828 0x00401b9f   1028 Block=SLICE_X89Y66 Latch=AQ Net=psdos0/regis<4>
Bit 18665847 0x00401b9f   1047 Block=SLICE_X89Y66 Latch=BMUX Net=psdos0/regis[8]_regis[8]_mux_8_OUT<0>
Bit 18665853 0x00401b9f   1053 Block=SLICE_X89Y66 Latch=BQ Net=psdos0/regis<5>
Bit 18665858 0x00401b9f   1058 Block=SLICE_X89Y66 Latch=CQ Net=psdos0/regis<6>
Bit 18665883 0x00401b9f   1083 Block=SLICE_X89Y66 Latch=DQ Net=psdos0/regis<7>
Bit 18665892 0x00401b9f   1092 Block=SLICE_X89Y67 Latch=AQ Net=psdos0/regis<8>
Bit 18665893 0x00401b9f   1093 Block=SLICE_X89Y67 Latch=AMUX Net=psdos0/mux11111
Bit 18666011 0x00401b9f   1211 Block=SLICE_X89Y68 Latch=DQ Net=psdos0/i<3>
Bit 18666019 0x00401b9f   1219 Block=SLICE_X88Y69 Latch=AQ Net=psdos0/i<0>
Bit 18666020 0x00401b9f   1220 Block=SLICE_X89Y69 Latch=AQ Net=psdos0/j<0>
Bit 18666044 0x00401b9f   1244 Block=SLICE_X88Y69 Latch=BQ Net=psdos0/i<1>
Bit 18666067 0x00401b9f   1267 Block=SLICE_X88Y69 Latch=DMUX Net=psdos0/j[3]_INV_10_o12
Bit 18666074 0x00401b9f   1274 Block=SLICE_X88Y69 Latch=DQ Net=psdos0/i<2>
