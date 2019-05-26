Revision 3
; Created by bitgen P.20131013 at Tue Nov  7 12:36:08 2017
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
Bit   335363 0x0000011f   2467 Block=SLICE_X0Y138 Latch=AQ Net=count_1000<0>
Bit   335388 0x0000011f   2492 Block=SLICE_X0Y138 Latch=BQ Net=count_1000<1>
Bit   335393 0x0000011f   2497 Block=SLICE_X0Y138 Latch=CQ Net=count_1000<2>
Bit   335418 0x0000011f   2522 Block=SLICE_X0Y138 Latch=DQ Net=count_1000<3>
Bit   335427 0x0000011f   2531 Block=SLICE_X0Y139 Latch=AQ Net=count_1000<4>
Bit   335428 0x0000011f   2532 Block=SLICE_X1Y139 Latch=AQ Net=CLKOUT1_OBUF
Bit   335452 0x0000011f   2556 Block=SLICE_X0Y139 Latch=BQ Net=count_1000<5>
Bit   335457 0x0000011f   2561 Block=SLICE_X0Y139 Latch=CQ Net=count_1000<6>
Bit   335482 0x0000011f   2586 Block=SLICE_X0Y139 Latch=DQ Net=count_1000<7>
Bit   335491 0x0000011f   2595 Block=SLICE_X0Y140 Latch=AQ Net=count_1000<8>
Bit   335516 0x0000011f   2620 Block=SLICE_X0Y140 Latch=BQ Net=count_1000<9>
