Revision 3
; Created by bitgen P.20131013 at Fri Nov 10 03:54:50 2017
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
Bit  2938723 0x00000c9f    835 Block=SLICE_X40Y113 Latch=AQ Net=df/count<0>
Bit  2938748 0x00000c9f    860 Block=SLICE_X40Y113 Latch=BQ Net=df/count<1>
Bit  2938753 0x00000c9f    865 Block=SLICE_X40Y113 Latch=CQ Net=df/count<2>
Bit  2938778 0x00000c9f    890 Block=SLICE_X40Y113 Latch=DQ Net=df/count<3>
Bit  2938790 0x00000c9f    902 Block=SLICE_X40Y114 Latch=AMUX Net=Result<4>
Bit  2938812 0x00000c9f    924 Block=SLICE_X40Y114 Latch=BQ Net=df/count<5>
Bit  2938817 0x00000c9f    929 Block=SLICE_X40Y114 Latch=CQ Net=df/count<6>
Bit  2938842 0x00000c9f    954 Block=SLICE_X40Y114 Latch=DQ Net=df/count<7>
Bit  2938851 0x00000c9f    963 Block=SLICE_X40Y115 Latch=AQ Net=df/count<8>
Bit  2938871 0x00000c9f    983 Block=SLICE_X41Y115 Latch=BMUX Net=df/clkout_rstpot
Bit  2938876 0x00000c9f    988 Block=SLICE_X40Y115 Latch=BQ Net=df/count<9>
Bit  2938877 0x00000c9f    989 Block=SLICE_X41Y115 Latch=BQ Net=df/clkout
Bit  2938881 0x00000c9f    993 Block=SLICE_X40Y115 Latch=CQ Net=df/count<10>
Bit  2938906 0x00000c9f   1018 Block=SLICE_X40Y115 Latch=DQ Net=df/count<11>
Bit  2938915 0x00000c9f   1027 Block=SLICE_X40Y116 Latch=AQ Net=df/count<12>
Bit  2938935 0x00000c9f   1047 Block=SLICE_X41Y116 Latch=BMUX Net=df/count[31]_GND_2_o_equal_2_o<31>5
Bit  2938940 0x00000c9f   1052 Block=SLICE_X40Y116 Latch=BQ Net=df/count<13>
Bit  2938941 0x00000c9f   1053 Block=SLICE_X41Y116 Latch=BQ Net=df/count<4>
Bit  2938945 0x00000c9f   1057 Block=SLICE_X40Y116 Latch=CQ Net=df/count<14>
Bit  2938970 0x00000c9f   1082 Block=SLICE_X40Y116 Latch=DQ Net=df/count<15>
Bit  2938979 0x00000c9f   1091 Block=SLICE_X40Y117 Latch=AQ Net=df/count<16>
Bit  2939004 0x00000c9f   1116 Block=SLICE_X40Y117 Latch=BQ Net=df/count<17>
Bit  2939009 0x00000c9f   1121 Block=SLICE_X40Y117 Latch=CQ Net=df/count<18>
Bit  2939034 0x00000c9f   1146 Block=SLICE_X40Y117 Latch=DQ Net=df/count<19>
Bit  2939043 0x00000c9f   1155 Block=SLICE_X40Y118 Latch=AQ Net=df/count<20>
Bit  2939068 0x00000c9f   1180 Block=SLICE_X40Y118 Latch=BQ Net=df/count<21>
Bit  2939073 0x00000c9f   1185 Block=SLICE_X40Y118 Latch=CQ Net=df/count<22>
Bit  2939098 0x00000c9f   1210 Block=SLICE_X40Y118 Latch=DQ Net=df/count<23>
Bit  2939107 0x00000c9f   1219 Block=SLICE_X40Y119 Latch=AQ Net=df/count<24>
Bit  2939132 0x00000c9f   1244 Block=SLICE_X40Y119 Latch=BQ Net=df/count<25>
Bit  2939137 0x00000c9f   1249 Block=SLICE_X40Y119 Latch=CQ Net=df/count<26>
Bit  2939162 0x00000c9f   1274 Block=SLICE_X40Y119 Latch=DQ Net=df/count<27>
Bit  2939171 0x00000c9f   1283 Block=SLICE_X40Y120 Latch=AQ Net=df/count<28>
Bit  2939196 0x00000c9f   1308 Block=SLICE_X40Y120 Latch=BQ Net=df/count<29>
Bit  2939201 0x00000c9f   1313 Block=SLICE_X40Y120 Latch=CQ Net=df/count<30>
Bit  2939226 0x00000c9f   1338 Block=SLICE_X40Y120 Latch=DQ Net=df/count<31>
