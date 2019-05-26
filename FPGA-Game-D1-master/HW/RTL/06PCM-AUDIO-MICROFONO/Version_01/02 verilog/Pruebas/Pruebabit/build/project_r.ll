Revision 3
; Created by bitgen P.20131013 at Thu Nov 30 10:41:48 2017
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
Bit 18666563 0x00401b9f   1763 Block=SLICE_X88Y77 Latch=AQ Net=df/clkout
Bit 18666627 0x00401b9f   1827 Block=SLICE_X88Y78 Latch=AQ Net=df/count<0>
Bit 18666628 0x00401b9f   1828 Block=SLICE_X89Y78 Latch=AQ Net=df/count<4>
Bit 18666652 0x00401b9f   1852 Block=SLICE_X88Y78 Latch=BQ Net=df/count<1>
Bit 18666657 0x00401b9f   1857 Block=SLICE_X88Y78 Latch=CQ Net=df/count<2>
Bit 18666682 0x00401b9f   1882 Block=SLICE_X88Y78 Latch=DQ Net=df/count<3>
Bit 18666694 0x00401b9f   1894 Block=SLICE_X88Y79 Latch=AMUX Net=Result<4>
