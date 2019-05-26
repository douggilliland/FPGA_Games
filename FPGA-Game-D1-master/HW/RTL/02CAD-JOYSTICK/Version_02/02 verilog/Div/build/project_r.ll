Revision 3
; Created by bitgen P.20131013 at Mon Nov 20 10:17:20 2017
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
Bit   335812 0x0000011f   2916 Block=SLICE_X1Y145 Latch=AQ Net=clk_div_OBUF
Bit  2473635 0x00000a9f   1155 Block=SLICE_X32Y118 Latch=AQ Net=count<0>
Bit  2473660 0x00000a9f   1180 Block=SLICE_X32Y118 Latch=BQ Net=count<1>
Bit  2473665 0x00000a9f   1185 Block=SLICE_X32Y118 Latch=CQ Net=count<2>
Bit  2473690 0x00000a9f   1210 Block=SLICE_X32Y118 Latch=DQ Net=count<3>
Bit  2473699 0x00000a9f   1219 Block=SLICE_X32Y119 Latch=AQ Net=count<4>
Bit  2473719 0x00000a9f   1239 Block=SLICE_X33Y119 Latch=BMUX Net=Mcount_count_val
Bit  2473724 0x00000a9f   1244 Block=SLICE_X32Y119 Latch=BQ Net=count<5>
Bit  2473729 0x00000a9f   1249 Block=SLICE_X32Y119 Latch=CQ Net=count<6>
Bit  2473754 0x00000a9f   1274 Block=SLICE_X32Y119 Latch=DQ Net=count<7>
Bit  2473763 0x00000a9f   1283 Block=SLICE_X32Y120 Latch=AQ Net=count<8>
Bit  2473788 0x00000a9f   1308 Block=SLICE_X32Y120 Latch=BQ Net=count<9>
Bit  2473793 0x00000a9f   1313 Block=SLICE_X32Y120 Latch=CQ Net=count<10>
Bit  2473818 0x00000a9f   1338 Block=SLICE_X32Y120 Latch=DQ Net=count<11>
Bit  2473827 0x00000a9f   1347 Block=SLICE_X32Y121 Latch=AQ Net=count<12>
