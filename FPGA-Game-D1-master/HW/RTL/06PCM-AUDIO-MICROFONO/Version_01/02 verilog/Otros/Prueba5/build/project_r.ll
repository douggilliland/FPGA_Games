Revision 3
; Created by bitgen P.20131013 at Fri Nov 24 08:28:48 2017
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
Bit 15555939 0x00400d9f    323 Block=SLICE_X44Y55 Latch=AQ Net=fi/wr_reg<0>
Bit 15555958 0x00400d9f    342 Block=SLICE_X44Y55 Latch=BMUX Net=fi/_n0078_inv2
Bit 15555964 0x00400d9f    348 Block=SLICE_X44Y55 Latch=BQ Net=fi/wr_reg<1>
Bit 15555965 0x00400d9f    349 Block=SLICE_X45Y55 Latch=BQ Net=fi/wr_reg<3>
Bit 15555969 0x00400d9f    353 Block=SLICE_X44Y55 Latch=CQ Net=fi/wr_reg<2>
Bit 15555970 0x00400d9f    354 Block=SLICE_X45Y55 Latch=CQ Net=fi/wr_reg<4>
Bit 15555977 0x00400d9f    361 Block=SLICE_X44Y55 Latch=CMUX Net=N4
Bit 15555978 0x00400d9f    362 Block=SLICE_X45Y55 Latch=CMUX Net=fi/Result<3>
Bit 15555995 0x00400d9f    379 Block=SLICE_X45Y55 Latch=DQ Net=fi/wr_reg<5>
Bit 15556003 0x00400d9f    387 Block=SLICE_X44Y56 Latch=AQ Net=fi/rd_reg<5>
Bit 15556004 0x00400d9f    388 Block=SLICE_X45Y56 Latch=AQ Net=fi/rd_reg<0>
Bit 15556023 0x00400d9f    407 Block=SLICE_X45Y56 Latch=BMUX Net=fi/rd_reg<1>
Bit 15556029 0x00400d9f    413 Block=SLICE_X45Y56 Latch=BQ Net=fi/rd_reg<2>
Bit 15556034 0x00400d9f    418 Block=SLICE_X45Y56 Latch=CQ Net=fi/rd_reg<3>
Bit 15556052 0x00400d9f    436 Block=SLICE_X45Y56 Latch=DMUX Net=fi/Result<3>1
Bit 15556059 0x00400d9f    443 Block=SLICE_X45Y56 Latch=DQ Net=fi/rd_reg<4>
Bit 15672291 0x00400e1f    323 Block=SLICE_X46Y55 Latch=AQ Net=fi/dffw2
Bit 15672292 0x00400e1f    324 Block=SLICE_X47Y55 Latch=AQ Net=fi/full_reg
Bit 15672355 0x00400e1f    387 Block=SLICE_X46Y56 Latch=AQ Net=fi/dffr2
Bit 15672356 0x00400e1f    388 Block=SLICE_X47Y56 Latch=AQ Net=fi/empty_reg
Bit 15672358 0x00400e1f    390 Block=SLICE_X46Y56 Latch=AMUX Net=fi/_n0112_inv1
Bit 15672374 0x00400e1f    406 Block=SLICE_X46Y56 Latch=BMUX Net=fi/_n0112_inv2
Bit 18432548 0x00401a9f    452 Block=SLICE_X85Y57 Latch=AQ Net=done_OBUF
Bit 18432612 0x00401a9f    516 Block=SLICE_X85Y58 Latch=AQ Net=count<0>
Bit 18432637 0x00401a9f    541 Block=SLICE_X85Y58 Latch=BQ Net=count<1>
Bit 18432642 0x00401a9f    546 Block=SLICE_X85Y58 Latch=CQ Net=count<2>
Bit 18432667 0x00401a9f    571 Block=SLICE_X85Y58 Latch=DQ Net=count<3>
Bit 18432676 0x00401a9f    580 Block=SLICE_X85Y59 Latch=AQ Net=count<4>
Bit 18432701 0x00401a9f    605 Block=SLICE_X85Y59 Latch=BQ Net=count<5>
Bit 18432706 0x00401a9f    610 Block=SLICE_X85Y59 Latch=CQ Net=count<6>
Bit 18432731 0x00401a9f    635 Block=SLICE_X85Y59 Latch=DQ Net=count<7>
Bit 18432740 0x00401a9f    644 Block=SLICE_X85Y60 Latch=AQ Net=count<8>
Bit 18432822 0x00401a9f    726 Block=SLICE_X84Y61 Latch=BMUX Net=Mcompar_count[320]_INV_42_o_cy<13>
Bit 18432841 0x00401a9f    745 Block=SLICE_X84Y61 Latch=CMUX Net=_n0033
Bit 18549412 0x00401b1f    964 Block=SLICE_X87Y65 Latch=AQ Net=df/count<0>
Bit 18549437 0x00401b1f    989 Block=SLICE_X87Y65 Latch=BQ Net=df/count<1>
Bit 18549442 0x00401b1f    994 Block=SLICE_X87Y65 Latch=CQ Net=df/count<2>
Bit 18549467 0x00401b1f   1019 Block=SLICE_X87Y65 Latch=DQ Net=df/count<3>
Bit 18549477 0x00401b1f   1029 Block=SLICE_X87Y66 Latch=AMUX Net=Result<4>1
Bit 18549501 0x00401b1f   1053 Block=SLICE_X87Y66 Latch=BQ Net=df/count<5>
Bit 18549506 0x00401b1f   1058 Block=SLICE_X87Y66 Latch=CQ Net=df/count<6>
Bit 18549531 0x00401b1f   1083 Block=SLICE_X87Y66 Latch=DQ Net=df/count<7>
Bit 18549540 0x00401b1f   1092 Block=SLICE_X87Y67 Latch=AQ Net=df/count<8>
Bit 18549565 0x00401b1f   1117 Block=SLICE_X87Y67 Latch=BQ Net=df/count<9>
Bit 18549570 0x00401b1f   1122 Block=SLICE_X87Y67 Latch=CQ Net=df/count<10>
Bit 18549595 0x00401b1f   1147 Block=SLICE_X87Y67 Latch=DQ Net=df/count<11>
Bit 18549604 0x00401b1f   1156 Block=SLICE_X87Y68 Latch=AQ Net=df/count<12>
Bit 18549629 0x00401b1f   1181 Block=SLICE_X87Y68 Latch=BQ Net=df/count<13>
Bit 18549634 0x00401b1f   1186 Block=SLICE_X87Y68 Latch=CQ Net=df/count<14>
Bit 18549659 0x00401b1f   1211 Block=SLICE_X87Y68 Latch=DQ Net=df/count<15>
Bit 18549668 0x00401b1f   1220 Block=SLICE_X87Y69 Latch=AQ Net=df/count<16>
Bit 18549693 0x00401b1f   1245 Block=SLICE_X87Y69 Latch=BQ Net=df/count<17>
Bit 18549698 0x00401b1f   1250 Block=SLICE_X87Y69 Latch=CQ Net=df/count<18>
Bit 18549723 0x00401b1f   1275 Block=SLICE_X87Y69 Latch=DQ Net=df/count<19>
Bit 18549731 0x00401b1f   1283 Block=SLICE_X86Y70 Latch=AQ Net=df/clkout
Bit 18549732 0x00401b1f   1284 Block=SLICE_X87Y70 Latch=AQ Net=df/count<20>
Bit 18549734 0x00401b1f   1286 Block=SLICE_X86Y70 Latch=AMUX Net=df/clkout_rstpot
Bit 18549757 0x00401b1f   1309 Block=SLICE_X87Y70 Latch=BQ Net=df/count<21>
Bit 18549762 0x00401b1f   1314 Block=SLICE_X87Y70 Latch=CQ Net=df/count<22>
Bit 18549779 0x00401b1f   1331 Block=SLICE_X86Y70 Latch=DMUX Net=df/count[31]_GND_5_o_equal_2_o<31>5
Bit 18549786 0x00401b1f   1338 Block=SLICE_X86Y70 Latch=DQ Net=df/count<4>
Bit 18549787 0x00401b1f   1339 Block=SLICE_X87Y70 Latch=DQ Net=df/count<23>
Bit 18549796 0x00401b1f   1348 Block=SLICE_X87Y71 Latch=AQ Net=df/count<24>
Bit 18549821 0x00401b1f   1373 Block=SLICE_X87Y71 Latch=BQ Net=df/count<25>
Bit 18549826 0x00401b1f   1378 Block=SLICE_X87Y71 Latch=CQ Net=df/count<26>
Bit 18549851 0x00401b1f   1403 Block=SLICE_X87Y71 Latch=DQ Net=df/count<27>
Bit 18549860 0x00401b1f   1412 Block=SLICE_X87Y72 Latch=AQ Net=df/count<28>
Bit 18549885 0x00401b1f   1437 Block=SLICE_X87Y72 Latch=BQ Net=df/count<29>
Bit 18549890 0x00401b1f   1442 Block=SLICE_X87Y72 Latch=CQ Net=df/count<30>
Bit 18549915 0x00401b1f   1467 Block=SLICE_X87Y72 Latch=DQ Net=df/count<31>
