Revision 3
; Created by bitgen P.68d at Thu Nov 30 18:36:03 2017
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
Bit 17115139 0x0040149f   1699 Block=SLICE_X66Y76 Latch=AQ Net=divisorfrec0/count_2924<0>
Bit 17115164 0x0040149f   1724 Block=SLICE_X66Y76 Latch=BQ Net=divisorfrec0/count_2924<1>
Bit 17115165 0x0040149f   1725 Block=SLICE_X67Y76 Latch=BQ Net=divisorfrec0/CLKOUT
Bit 17115169 0x0040149f   1729 Block=SLICE_X66Y76 Latch=CQ Net=divisorfrec0/count_2924<2>
Bit 17115194 0x0040149f   1754 Block=SLICE_X66Y76 Latch=DQ Net=divisorfrec0/count_2924<3>
Bit 17115203 0x0040149f   1763 Block=SLICE_X66Y77 Latch=AQ Net=divisorfrec0/count_2924<4>
Bit 17115228 0x0040149f   1788 Block=SLICE_X66Y77 Latch=BQ Net=divisorfrec0/count_2924<5>
Bit 17115233 0x0040149f   1793 Block=SLICE_X66Y77 Latch=CQ Net=divisorfrec0/count_2924<6>
Bit 17115258 0x0040149f   1818 Block=SLICE_X66Y77 Latch=DQ Net=divisorfrec0/count_2924<7>
Bit 17115267 0x0040149f   1827 Block=SLICE_X66Y78 Latch=AQ Net=divisorfrec0/count_2924<8>
Bit 17115292 0x0040149f   1852 Block=SLICE_X66Y78 Latch=BQ Net=divisorfrec0/count_2924<9>
Bit 17115297 0x0040149f   1857 Block=SLICE_X66Y78 Latch=CQ Net=divisorfrec0/count_2924<10>
Bit 17115322 0x0040149f   1882 Block=SLICE_X66Y78 Latch=DQ Net=divisorfrec0/count_2924<11>
Bit 17786851 0x0040179f   1155 Block=SLICE_X76Y68 Latch=AQ Net=genpulsos0/NoDoit
Bit 17993571 0x0040189f   1027 Block=SLICE_X78Y66 Latch=AQ Net=divisorfrecd0/count_1462<0>
Bit 17993572 0x0040189f   1028 Block=SLICE_X79Y66 Latch=AQ Net=divisorfrecgen0/count_1000<0>
Bit 17993596 0x0040189f   1052 Block=SLICE_X78Y66 Latch=BQ Net=divisorfrecd0/count_1462<1>
Bit 17993597 0x0040189f   1053 Block=SLICE_X79Y66 Latch=BQ Net=divisorfrecgen0/count_1000<1>
Bit 17993601 0x0040189f   1057 Block=SLICE_X78Y66 Latch=CQ Net=divisorfrecd0/count_1462<2>
Bit 17993602 0x0040189f   1058 Block=SLICE_X79Y66 Latch=CQ Net=divisorfrecgen0/count_1000<2>
Bit 17993626 0x0040189f   1082 Block=SLICE_X78Y66 Latch=DQ Net=divisorfrecd0/count_1462<3>
Bit 17993627 0x0040189f   1083 Block=SLICE_X79Y66 Latch=DQ Net=divisorfrecgen0/count_1000<3>
Bit 17993635 0x0040189f   1091 Block=SLICE_X78Y67 Latch=AQ Net=divisorfrecd0/count_1462<4>
Bit 17993636 0x0040189f   1092 Block=SLICE_X79Y67 Latch=AQ Net=divisorfrecgen0/count_1000<4>
Bit 17993660 0x0040189f   1116 Block=SLICE_X78Y67 Latch=BQ Net=divisorfrecd0/count_1462<5>
Bit 17993661 0x0040189f   1117 Block=SLICE_X79Y67 Latch=BQ Net=divisorfrecgen0/count_1000<5>
Bit 17993665 0x0040189f   1121 Block=SLICE_X78Y67 Latch=CQ Net=divisorfrecd0/count_1462<6>
Bit 17993666 0x0040189f   1122 Block=SLICE_X79Y67 Latch=CQ Net=divisorfrecgen0/count_1000<6>
Bit 17993690 0x0040189f   1146 Block=SLICE_X78Y67 Latch=DQ Net=divisorfrecd0/count_1462<7>
Bit 17993691 0x0040189f   1147 Block=SLICE_X79Y67 Latch=DQ Net=divisorfrecgen0/count_1000<7>
Bit 17993699 0x0040189f   1155 Block=SLICE_X78Y68 Latch=AQ Net=divisorfrecd0/count_1462<8>
Bit 17993700 0x0040189f   1156 Block=SLICE_X79Y68 Latch=AQ Net=divisorfrecgen0/count_1000<8>
Bit 17993724 0x0040189f   1180 Block=SLICE_X78Y68 Latch=BQ Net=divisorfrecd0/count_1462<9>
Bit 17993725 0x0040189f   1181 Block=SLICE_X79Y68 Latch=BQ Net=divisorfrecgen0/count_1000<9>
Bit 17993729 0x0040189f   1185 Block=SLICE_X78Y68 Latch=CQ Net=divisorfrecd0/count_1462<10>
Bit 17994083 0x0040189f   1539 Block=SLICE_X78Y74 Latch=AQ Net=contador0/calculate
Bit 17994084 0x0040189f   1540 Block=SLICE_X79Y74 Latch=AQ Net=contador0/count0<0>
Bit 17994109 0x0040189f   1565 Block=SLICE_X79Y74 Latch=BQ Net=contador0/count0<1>
Bit 17994114 0x0040189f   1570 Block=SLICE_X79Y74 Latch=CQ Net=contador0/count0<2>
Bit 17994139 0x0040189f   1595 Block=SLICE_X79Y74 Latch=DQ Net=contador0/count0<3>
Bit 17994180 0x0040189f   1636 Block=SLICE_X79Y75 Latch=AQ Net=contador0/count0<4>
Bit 17994205 0x0040189f   1661 Block=SLICE_X79Y75 Latch=BQ Net=contador0/count0<5>
Bit 17994210 0x0040189f   1666 Block=SLICE_X79Y75 Latch=CQ Net=contador0/count0<6>
Bit 17994235 0x0040189f   1691 Block=SLICE_X79Y75 Latch=DQ Net=contador0/count0<7>
Bit 18110017 0x0040191f   1121 Block=SLICE_X80Y67 Latch=CQ Net=divisorfrecgen0/CLKOUT1
Bit 18110025 0x0040191f   1129 Block=SLICE_X80Y67 Latch=CMUX Net=divisorfrecd0/CLKOUTD
Bit 18110051 0x0040191f   1155 Block=SLICE_X80Y68 Latch=AQ Net=divisor0/registro0<0>
Bit 18110071 0x0040191f   1175 Block=SLICE_X81Y68 Latch=BMUX Net=divisor0/DONE_glue_set
Bit 18110076 0x0040191f   1180 Block=SLICE_X80Y68 Latch=BQ Net=divisor0/registro0<1>
Bit 18110077 0x0040191f   1181 Block=SLICE_X81Y68 Latch=BQ Net=genpulsos0/Doit
Bit 18110081 0x0040191f   1185 Block=SLICE_X80Y68 Latch=CQ Net=divisor0/registro0<2>
Bit 18110106 0x0040191f   1210 Block=SLICE_X80Y68 Latch=DQ Net=divisor0/registro0<3>
Bit 18110116 0x0040191f   1220 Block=SLICE_X81Y69 Latch=AQ Net=divisor0/DONE
Bit 18110117 0x0040191f   1221 Block=SLICE_X81Y69 Latch=AMUX Net=divisor0/registro0[7]_count[7]_mux_2_OUT<2>
Bit 18110181 0x0040191f   1285 Block=SLICE_X81Y70 Latch=AMUX Net=divisor0/registro0[7]_count[7]_mux_2_OUT<4>
Bit 18110182 0x0040191f   1286 Block=SLICE_X80Y70 Latch=AMUX Net=divisor0/registro0<4>
Bit 18110198 0x0040191f   1302 Block=SLICE_X80Y70 Latch=BMUX Net=divisor0/registro0<5>
Bit 18110217 0x0040191f   1321 Block=SLICE_X80Y70 Latch=CMUX Net=divisor0/registro0<6>
Bit 18110227 0x0040191f   1331 Block=SLICE_X80Y70 Latch=DMUX Net=divisor0/registro0<7>
Bit 18110228 0x0040191f   1332 Block=SLICE_X81Y70 Latch=DMUX Net=divisor0/registro0[7]_count[7]_mux_2_OUT<6>
