Revision 3
; Created by bitgen P.20131013 at Wed Nov 29 08:31:38 2017
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
Bit  2240567 0x0000099f    791 Block=SLICE_X29Y112 Latch=BMUX Net=count<3>
Bit  2240573 0x0000099f    797 Block=SLICE_X29Y112 Latch=BQ Net=count<4>
Bit  2240578 0x0000099f    802 Block=SLICE_X29Y112 Latch=CQ Net=count<6>
Bit  2240596 0x0000099f    820 Block=SLICE_X29Y112 Latch=DMUX Net=count<10>
Bit  2240603 0x0000099f    827 Block=SLICE_X29Y112 Latch=DQ Net=count<12>
Bit  2356835 0x00000a1f    707 Block=SLICE_X30Y111 Latch=AQ Net=count<0>
Bit  2356860 0x00000a1f    732 Block=SLICE_X30Y111 Latch=BQ Net=count<1>
Bit  2356865 0x00000a1f    737 Block=SLICE_X30Y111 Latch=CQ Net=count<2>
Bit  2356883 0x00000a1f    755 Block=SLICE_X30Y111 Latch=DMUX Net=Result<3>
Bit  2356902 0x00000a1f    774 Block=SLICE_X30Y112 Latch=AMUX Net=Result<4>
Bit  2356919 0x00000a1f    791 Block=SLICE_X31Y112 Latch=BMUX Net=clkout_rstpot
Bit  2356924 0x00000a1f    796 Block=SLICE_X30Y112 Latch=BQ Net=count<5>
Bit  2356925 0x00000a1f    797 Block=SLICE_X31Y112 Latch=BQ Net=clkout_OBUF
Bit  2356937 0x00000a1f    809 Block=SLICE_X30Y112 Latch=CMUX Net=Result<6>
Bit  2356954 0x00000a1f    826 Block=SLICE_X30Y112 Latch=DQ Net=count<7>
Bit  2356963 0x00000a1f    835 Block=SLICE_X30Y113 Latch=AQ Net=count<8>
Bit  2356988 0x00000a1f    860 Block=SLICE_X30Y113 Latch=BQ Net=count<9>
Bit  2357001 0x00000a1f    873 Block=SLICE_X30Y113 Latch=CMUX Net=Result<10>
Bit  2357018 0x00000a1f    890 Block=SLICE_X30Y113 Latch=DQ Net=count<11>
Bit  2357030 0x00000a1f    902 Block=SLICE_X30Y114 Latch=AMUX Net=Result<12>
