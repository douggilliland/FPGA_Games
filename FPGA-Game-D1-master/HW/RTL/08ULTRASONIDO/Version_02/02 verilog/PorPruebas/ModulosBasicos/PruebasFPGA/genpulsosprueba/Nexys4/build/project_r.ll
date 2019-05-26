Revision 3
; Created by bitgen P.20131013 at Tue Nov 14 15:51:50 2017
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
Bit 16559939 0x0040121f   2403 Block=SLICE_X58Y87 Latch=AQ Net=divisorfrecgen0/count_500<0>
Bit 16559964 0x0040121f   2428 Block=SLICE_X58Y87 Latch=BQ Net=divisorfrecgen0/count_500<1>
Bit 16559969 0x0040121f   2433 Block=SLICE_X58Y87 Latch=CQ Net=divisorfrecgen0/count_500<2>
Bit 16559994 0x0040121f   2458 Block=SLICE_X58Y87 Latch=DQ Net=divisorfrecgen0/count_500<3>
Bit 16560003 0x0040121f   2467 Block=SLICE_X58Y88 Latch=AQ Net=divisorfrecgen0/count_500<4>
Bit 16560004 0x0040121f   2468 Block=SLICE_X59Y88 Latch=AQ Net=divisorfrecgen0/CLKOUT1
Bit 16560028 0x0040121f   2492 Block=SLICE_X58Y88 Latch=BQ Net=divisorfrecgen0/count_500<5>
Bit 16560033 0x0040121f   2497 Block=SLICE_X58Y88 Latch=CQ Net=divisorfrecgen0/count_500<6>
Bit 16560058 0x0040121f   2522 Block=SLICE_X58Y88 Latch=DQ Net=divisorfrecgen0/count_500<7>
Bit 16560067 0x0040121f   2531 Block=SLICE_X58Y89 Latch=AQ Net=divisorfrecgen0/count_500<8>
Bit 18316516 0x00401a1f    772 Block=SLICE_X83Y62 Latch=AQ Net=genpulsos0/ledpul0
Bit 18316541 0x00401a1f    797 Block=SLICE_X83Y62 Latch=BQ Net=genpulsos0/ledpul1
Bit 18316579 0x00401a1f    835 Block=SLICE_X82Y63 Latch=AQ Net=genpulsos0/Doit
Bit 18316582 0x00401a1f    838 Block=SLICE_X82Y63 Latch=AMUX Net=genpulsos0/ledpul1_glue_set
Bit 18316643 0x00401a1f    899 Block=SLICE_X82Y64 Latch=AQ Net=genpulsos0/NoDoit
