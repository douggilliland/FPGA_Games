Revision 3
; Created by bitgen P.20131013 at Tue Nov 21 11:33:15 2017
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
Bit  1328611 0x0000059f    259 Block=SLICE_X14Y104 Latch=AQ Net=div/clk_div
Bit  2472547 0x00000a9f     67 Block=SLICE_X32Y101 Latch=AQ Net=div/count<0>
Bit  2472572 0x00000a9f     92 Block=SLICE_X32Y101 Latch=BQ Net=div/count<1>
Bit  2472577 0x00000a9f     97 Block=SLICE_X32Y101 Latch=CQ Net=div/count<2>
Bit  2472602 0x00000a9f    122 Block=SLICE_X32Y101 Latch=DQ Net=div/count<3>
Bit  2472611 0x00000a9f    131 Block=SLICE_X32Y102 Latch=AQ Net=div/count<4>
Bit  2472631 0x00000a9f    151 Block=SLICE_X33Y102 Latch=BMUX Net=div/count[31]_GND_2_o_equal_2_o_0
Bit  2472636 0x00000a9f    156 Block=SLICE_X32Y102 Latch=BQ Net=div/count<5>
Bit  2472641 0x00000a9f    161 Block=SLICE_X32Y102 Latch=CQ Net=div/count<6>
Bit  2472666 0x00000a9f    186 Block=SLICE_X32Y102 Latch=DQ Net=div/count<7>
Bit  2472675 0x00000a9f    195 Block=SLICE_X32Y103 Latch=AQ Net=div/count<8>
Bit  2472700 0x00000a9f    220 Block=SLICE_X32Y103 Latch=BQ Net=div/count<9>
Bit  2472705 0x00000a9f    225 Block=SLICE_X32Y103 Latch=CQ Net=div/count<10>
Bit  2472730 0x00000a9f    250 Block=SLICE_X32Y103 Latch=DQ Net=div/count<11>
Bit  2472739 0x00000a9f    259 Block=SLICE_X32Y104 Latch=AQ Net=div/count<12>
Bit 18665955 0x00401b9f   1155 Block=SLICE_X88Y68 Latch=AQ Net=scratch<0>
Bit 18665980 0x00401b9f   1180 Block=SLICE_X88Y68 Latch=BQ Net=scratch<1>
Bit 18665981 0x00401b9f   1181 Block=SLICE_X89Y68 Latch=BQ Net=scratch<2>
Bit 18665986 0x00401b9f   1186 Block=SLICE_X89Y68 Latch=CQ Net=scratch<7>
Bit 18666004 0x00401b9f   1204 Block=SLICE_X89Y68 Latch=DMUX Net=bitpos[2]_bitpos[3]_AND_20_o1
Bit 18666020 0x00401b9f   1220 Block=SLICE_X89Y69 Latch=AQ Net=scratch<3>
Bit 18666045 0x00401b9f   1245 Block=SLICE_X89Y69 Latch=BQ Net=scratch<6>
Bit 18666058 0x00401b9f   1258 Block=SLICE_X89Y69 Latch=CMUX Net=bitpos[2]_bitpos[3]_AND_16_o1
Bit 18666075 0x00401b9f   1275 Block=SLICE_X89Y69 Latch=DQ Net=scratch<4>
Bit 18666083 0x00401b9f   1283 Block=SLICE_X88Y70 Latch=AQ Net=bitpos<0>
Bit 18666086 0x00401b9f   1286 Block=SLICE_X88Y70 Latch=AMUX Net=bitpos<1>
Bit 18666102 0x00401b9f   1302 Block=SLICE_X88Y70 Latch=BMUX Net=bitpos<3>
Bit 18666103 0x00401b9f   1303 Block=SLICE_X89Y70 Latch=BMUX Net=_n0088_inv
Bit 18666108 0x00401b9f   1308 Block=SLICE_X88Y70 Latch=BQ Net=bitpos<2>
Bit 18666132 0x00401b9f   1332 Block=SLICE_X89Y70 Latch=DMUX Net=state_FSM_FFd1
Bit 18666139 0x00401b9f   1339 Block=SLICE_X89Y70 Latch=DQ Net=state_FSM_FFd2
Bit 18666173 0x00401b9f   1373 Block=SLICE_X89Y71 Latch=BQ Net=scratch<5>
