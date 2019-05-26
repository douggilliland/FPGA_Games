Revision 3
; Created by bitgen P.20131013 at Mon Nov 27 21:37:20 2017
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
Bit 14625251 0x0040099f    451 Block=SLICE_X28Y57 Latch=AQ Net=fi/count1<0>
Bit 14625270 0x0040099f    470 Block=SLICE_X28Y57 Latch=BMUX Net=fi/dffr1_rstpot
Bit 14625276 0x0040099f    476 Block=SLICE_X28Y57 Latch=BQ Net=fi/count1<1>
Bit 14625318 0x0040099f    518 Block=SLICE_X28Y58 Latch=AMUX Net=fi/rd_wr_AND_3_o
Bit 15090660 0x00400b9f    452 Block=SLICE_X37Y57 Latch=AQ Net=fi/count<0>
Bit 15090685 0x00400b9f    477 Block=SLICE_X37Y57 Latch=BQ Net=fi/count<1>
Bit 15090707 0x00400b9f    499 Block=SLICE_X36Y57 Latch=DMUX Net=fi/dffw1_rstpot
Bit 15090714 0x00400b9f    506 Block=SLICE_X36Y57 Latch=DQ Net=fi/dffw1
Bit 16118409 0x0040101f    425 Block=SLICE_X52Y56 Latch=CMUX Net=fi/dffr1
Bit 17553188 0x0040169f    196 Block=SLICE_X73Y53 Latch=AQ Net=fi/wr_reg<0>
Bit 17553213 0x0040169f    221 Block=SLICE_X73Y53 Latch=BQ Net=fi/wr_reg<1>
Bit 17553218 0x0040169f    226 Block=SLICE_X73Y53 Latch=CQ Net=fi/wr_reg<2>
Bit 17553243 0x0040169f    251 Block=SLICE_X73Y53 Latch=DQ Net=fi/wr_reg<3>
Bit 17553252 0x0040169f    260 Block=SLICE_X73Y54 Latch=AQ Net=fi/wr_reg<4>
Bit 17553254 0x0040169f    262 Block=SLICE_X72Y54 Latch=AMUX Net=fi/wr_succ<0>
Bit 17553270 0x0040169f    278 Block=SLICE_X72Y54 Latch=BMUX Net=fi/wr_succ<1>
Bit 17553277 0x0040169f    285 Block=SLICE_X73Y54 Latch=BQ Net=fi/wr_reg<5>
Bit 17553282 0x0040169f    290 Block=SLICE_X73Y54 Latch=CQ Net=fi/wr_reg<6>
Bit 17553289 0x0040169f    297 Block=SLICE_X72Y54 Latch=CMUX Net=fi/wr_succ<2>
Bit 17553299 0x0040169f    307 Block=SLICE_X72Y54 Latch=DMUX Net=fi/wr_succ<3>
Bit 17553307 0x0040169f    315 Block=SLICE_X73Y54 Latch=DQ Net=fi/wr_reg<7>
Bit 17553316 0x0040169f    324 Block=SLICE_X73Y55 Latch=AQ Net=fi/wr_reg<8>
Bit 17553318 0x0040169f    326 Block=SLICE_X72Y55 Latch=AMUX Net=fi/wr_succ<4>
Bit 17553334 0x0040169f    342 Block=SLICE_X72Y55 Latch=BMUX Net=fi/wr_succ<5>
Bit 17553341 0x0040169f    349 Block=SLICE_X73Y55 Latch=BQ Net=fi/wr_reg<9>
Bit 17553346 0x0040169f    354 Block=SLICE_X73Y55 Latch=CQ Net=fi/wr_reg<10>
Bit 17553353 0x0040169f    361 Block=SLICE_X72Y55 Latch=CMUX Net=fi/wr_succ<6>
Bit 17553363 0x0040169f    371 Block=SLICE_X72Y55 Latch=DMUX Net=fi/wr_succ<7>
Bit 17553371 0x0040169f    379 Block=SLICE_X73Y55 Latch=DQ Net=fi/wr_reg<11>
Bit 17553380 0x0040169f    388 Block=SLICE_X73Y56 Latch=AQ Net=fi/wr_reg<12>
Bit 17553382 0x0040169f    390 Block=SLICE_X72Y56 Latch=AMUX Net=fi/wr_succ<8>
Bit 17553398 0x0040169f    406 Block=SLICE_X72Y56 Latch=BMUX Net=fi/wr_succ<9>
Bit 17553405 0x0040169f    413 Block=SLICE_X73Y56 Latch=BQ Net=fi/wr_reg<13>
Bit 17553410 0x0040169f    418 Block=SLICE_X73Y56 Latch=CQ Net=fi/wr_reg<14>
Bit 17553417 0x0040169f    425 Block=SLICE_X72Y56 Latch=CMUX Net=fi/wr_succ<10>
Bit 17553427 0x0040169f    435 Block=SLICE_X72Y56 Latch=DMUX Net=fi/wr_succ<11>
Bit 17553435 0x0040169f    443 Block=SLICE_X73Y56 Latch=DQ Net=fi/wr_reg<15>
Bit 17553444 0x0040169f    452 Block=SLICE_X73Y57 Latch=AQ Net=fi/wr_reg<16>
Bit 17553446 0x0040169f    454 Block=SLICE_X72Y57 Latch=AMUX Net=fi/wr_succ<12>
Bit 17553462 0x0040169f    470 Block=SLICE_X72Y57 Latch=BMUX Net=fi/wr_succ<13>
Bit 17553469 0x0040169f    477 Block=SLICE_X73Y57 Latch=BQ Net=fi/wr_reg<17>
Bit 17553474 0x0040169f    482 Block=SLICE_X73Y57 Latch=CQ Net=fi/wr_reg<18>
Bit 17553481 0x0040169f    489 Block=SLICE_X72Y57 Latch=CMUX Net=fi/wr_succ<14>
Bit 17553491 0x0040169f    499 Block=SLICE_X72Y57 Latch=DMUX Net=fi/wr_succ<15>
Bit 17553499 0x0040169f    507 Block=SLICE_X73Y57 Latch=DQ Net=fi/wr_reg<19>
Bit 17553510 0x0040169f    518 Block=SLICE_X72Y58 Latch=AMUX Net=fi/wr_succ<16>
Bit 17553526 0x0040169f    534 Block=SLICE_X72Y58 Latch=BMUX Net=fi/wr_succ<17>
Bit 17553545 0x0040169f    553 Block=SLICE_X72Y58 Latch=CMUX Net=fi/wr_succ<18>
Bit 17553555 0x0040169f    563 Block=SLICE_X72Y58 Latch=DMUX Net=fi/wr_succ<19>
Bit 17669604 0x0040171f    260 Block=SLICE_X75Y54 Latch=AQ Net=fi/rd_reg<0>
Bit 17669606 0x0040171f    262 Block=SLICE_X74Y54 Latch=AMUX Net=fi/rd_succ<0>
Bit 17669622 0x0040171f    278 Block=SLICE_X74Y54 Latch=BMUX Net=fi/rd_succ<1>
Bit 17669629 0x0040171f    285 Block=SLICE_X75Y54 Latch=BQ Net=fi/rd_reg<1>
Bit 17669634 0x0040171f    290 Block=SLICE_X75Y54 Latch=CQ Net=fi/rd_reg<2>
Bit 17669641 0x0040171f    297 Block=SLICE_X74Y54 Latch=CMUX Net=fi/rd_succ<2>
Bit 17669651 0x0040171f    307 Block=SLICE_X74Y54 Latch=DMUX Net=fi/rd_succ<3>
Bit 17669659 0x0040171f    315 Block=SLICE_X75Y54 Latch=DQ Net=fi/rd_reg<3>
Bit 17669668 0x0040171f    324 Block=SLICE_X75Y55 Latch=AQ Net=fi/rd_reg<4>
Bit 17669670 0x0040171f    326 Block=SLICE_X74Y55 Latch=AMUX Net=fi/rd_succ<4>
Bit 17669686 0x0040171f    342 Block=SLICE_X74Y55 Latch=BMUX Net=fi/rd_succ<5>
Bit 17669693 0x0040171f    349 Block=SLICE_X75Y55 Latch=BQ Net=fi/rd_reg<5>
Bit 17669698 0x0040171f    354 Block=SLICE_X75Y55 Latch=CQ Net=fi/rd_reg<6>
Bit 17669705 0x0040171f    361 Block=SLICE_X74Y55 Latch=CMUX Net=fi/rd_succ<6>
Bit 17669715 0x0040171f    371 Block=SLICE_X74Y55 Latch=DMUX Net=fi/rd_succ<7>
Bit 17669723 0x0040171f    379 Block=SLICE_X75Y55 Latch=DQ Net=fi/rd_reg<7>
Bit 17669732 0x0040171f    388 Block=SLICE_X75Y56 Latch=AQ Net=fi/rd_reg<8>
Bit 17669734 0x0040171f    390 Block=SLICE_X74Y56 Latch=AMUX Net=fi/rd_succ<8>
Bit 17669750 0x0040171f    406 Block=SLICE_X74Y56 Latch=BMUX Net=fi/rd_succ<9>
Bit 17669757 0x0040171f    413 Block=SLICE_X75Y56 Latch=BQ Net=fi/rd_reg<9>
Bit 17669762 0x0040171f    418 Block=SLICE_X75Y56 Latch=CQ Net=fi/rd_reg<10>
Bit 17669769 0x0040171f    425 Block=SLICE_X74Y56 Latch=CMUX Net=fi/rd_succ<10>
Bit 17669779 0x0040171f    435 Block=SLICE_X74Y56 Latch=DMUX Net=fi/rd_succ<11>
Bit 17669787 0x0040171f    443 Block=SLICE_X75Y56 Latch=DQ Net=fi/rd_reg<11>
Bit 17669796 0x0040171f    452 Block=SLICE_X75Y57 Latch=AQ Net=fi/rd_reg<12>
Bit 17669798 0x0040171f    454 Block=SLICE_X74Y57 Latch=AMUX Net=fi/rd_succ<12>
Bit 17669814 0x0040171f    470 Block=SLICE_X74Y57 Latch=BMUX Net=fi/rd_succ<13>
Bit 17669821 0x0040171f    477 Block=SLICE_X75Y57 Latch=BQ Net=fi/rd_reg<13>
Bit 17669826 0x0040171f    482 Block=SLICE_X75Y57 Latch=CQ Net=fi/rd_reg<14>
Bit 17669833 0x0040171f    489 Block=SLICE_X74Y57 Latch=CMUX Net=fi/rd_succ<14>
Bit 17669843 0x0040171f    499 Block=SLICE_X74Y57 Latch=DMUX Net=fi/rd_succ<15>
Bit 17669851 0x0040171f    507 Block=SLICE_X75Y57 Latch=DQ Net=fi/rd_reg<15>
Bit 17669860 0x0040171f    516 Block=SLICE_X75Y58 Latch=AQ Net=fi/rd_reg<16>
Bit 17669862 0x0040171f    518 Block=SLICE_X74Y58 Latch=AMUX Net=fi/rd_succ<16>
Bit 17669878 0x0040171f    534 Block=SLICE_X74Y58 Latch=BMUX Net=fi/rd_succ<17>
Bit 17669885 0x0040171f    541 Block=SLICE_X75Y58 Latch=BQ Net=fi/rd_reg<17>
Bit 17669890 0x0040171f    546 Block=SLICE_X75Y58 Latch=CQ Net=fi/rd_reg<18>
Bit 17669897 0x0040171f    553 Block=SLICE_X74Y58 Latch=CMUX Net=fi/rd_succ<18>
Bit 17669907 0x0040171f    563 Block=SLICE_X74Y58 Latch=DMUX Net=fi/rd_succ<19>
Bit 17669915 0x0040171f    571 Block=SLICE_X75Y58 Latch=DQ Net=fi/rd_reg<19>
Bit 17785891 0x0040179f    195 Block=SLICE_X76Y53 Latch=AQ Net=fi/full_reg
Bit 17785955 0x0040179f    259 Block=SLICE_X76Y54 Latch=AQ Net=fi/empty_reg
Bit 17785975 0x0040179f    279 Block=SLICE_X77Y54 Latch=BMUX Net=fi/_n0147_inv3
Bit 17786004 0x0040179f    308 Block=SLICE_X77Y54 Latch=DMUX Net=fi/empty_reg_rstpot
Bit 17786121 0x0040179f    425 Block=SLICE_X76Y56 Latch=CMUX Net=fi/_n0101
Bit 18432932 0x00401a9f    836 Block=SLICE_X85Y63 Latch=AQ Net=count<0>
Bit 18432957 0x00401a9f    861 Block=SLICE_X85Y63 Latch=BQ Net=count<1>
Bit 18432962 0x00401a9f    866 Block=SLICE_X85Y63 Latch=CQ Net=count<2>
Bit 18432987 0x00401a9f    891 Block=SLICE_X85Y63 Latch=DQ Net=count<3>
Bit 18432996 0x00401a9f    900 Block=SLICE_X85Y64 Latch=AQ Net=count<4>
Bit 18433021 0x00401a9f    925 Block=SLICE_X85Y64 Latch=BQ Net=count<5>
Bit 18433026 0x00401a9f    930 Block=SLICE_X85Y64 Latch=CQ Net=count<6>
Bit 18433043 0x00401a9f    947 Block=SLICE_X84Y64 Latch=DMUX Net=done_OBUF
Bit 18433051 0x00401a9f    955 Block=SLICE_X85Y64 Latch=DQ Net=count<7>
Bit 18666020 0x00401b9f   1220 Block=SLICE_X89Y69 Latch=AQ Net=df/count<0>
Bit 18666045 0x00401b9f   1245 Block=SLICE_X89Y69 Latch=BQ Net=df/count<1>
Bit 18666050 0x00401b9f   1250 Block=SLICE_X89Y69 Latch=CQ Net=df/count<2>
Bit 18666075 0x00401b9f   1275 Block=SLICE_X89Y69 Latch=DQ Net=df/count<3>
Bit 18666085 0x00401b9f   1285 Block=SLICE_X89Y70 Latch=AMUX Net=Result<4>1
Bit 18666109 0x00401b9f   1309 Block=SLICE_X89Y70 Latch=BQ Net=df/count<5>
Bit 18666114 0x00401b9f   1314 Block=SLICE_X89Y70 Latch=CQ Net=df/count<6>
Bit 18666139 0x00401b9f   1339 Block=SLICE_X89Y70 Latch=DQ Net=df/count<7>
Bit 18666148 0x00401b9f   1348 Block=SLICE_X89Y71 Latch=AQ Net=df/count<8>
Bit 18666173 0x00401b9f   1373 Block=SLICE_X89Y71 Latch=BQ Net=df/count<9>
Bit 18666178 0x00401b9f   1378 Block=SLICE_X89Y71 Latch=CQ Net=df/count<10>
Bit 18666203 0x00401b9f   1403 Block=SLICE_X89Y71 Latch=DQ Net=df/count<11>
Bit 18666212 0x00401b9f   1412 Block=SLICE_X89Y72 Latch=AQ Net=df/count<12>
Bit 18666237 0x00401b9f   1437 Block=SLICE_X89Y72 Latch=BQ Net=df/count<13>
Bit 18666242 0x00401b9f   1442 Block=SLICE_X89Y72 Latch=CQ Net=df/count<14>
Bit 18666267 0x00401b9f   1467 Block=SLICE_X89Y72 Latch=DQ Net=df/count<15>
Bit 18666275 0x00401b9f   1475 Block=SLICE_X88Y73 Latch=AQ Net=df/clkout
Bit 18666276 0x00401b9f   1476 Block=SLICE_X89Y73 Latch=AQ Net=df/count<16>
Bit 18666278 0x00401b9f   1478 Block=SLICE_X88Y73 Latch=AMUX Net=df/clkout_rstpot
Bit 18666301 0x00401b9f   1501 Block=SLICE_X89Y73 Latch=BQ Net=df/count<17>
Bit 18666306 0x00401b9f   1506 Block=SLICE_X89Y73 Latch=CQ Net=df/count<18>
Bit 18666331 0x00401b9f   1531 Block=SLICE_X89Y73 Latch=DQ Net=df/count<19>
Bit 18666340 0x00401b9f   1540 Block=SLICE_X89Y74 Latch=AQ Net=df/count<20>
Bit 18666358 0x00401b9f   1558 Block=SLICE_X88Y74 Latch=BMUX Net=df/count[31]_GND_5_o_equal_2_o<31>5
Bit 18666364 0x00401b9f   1564 Block=SLICE_X88Y74 Latch=BQ Net=df/count<4>
Bit 18666365 0x00401b9f   1565 Block=SLICE_X89Y74 Latch=BQ Net=df/count<21>
Bit 18666370 0x00401b9f   1570 Block=SLICE_X89Y74 Latch=CQ Net=df/count<22>
Bit 18666395 0x00401b9f   1595 Block=SLICE_X89Y74 Latch=DQ Net=df/count<23>
Bit 18666436 0x00401b9f   1636 Block=SLICE_X89Y75 Latch=AQ Net=df/count<24>
Bit 18666461 0x00401b9f   1661 Block=SLICE_X89Y75 Latch=BQ Net=df/count<25>
Bit 18666466 0x00401b9f   1666 Block=SLICE_X89Y75 Latch=CQ Net=df/count<26>
Bit 18666491 0x00401b9f   1691 Block=SLICE_X89Y75 Latch=DQ Net=df/count<27>
Bit 18666500 0x00401b9f   1700 Block=SLICE_X89Y76 Latch=AQ Net=df/count<28>
Bit 18666525 0x00401b9f   1725 Block=SLICE_X89Y76 Latch=BQ Net=df/count<29>
Bit 18666530 0x00401b9f   1730 Block=SLICE_X89Y76 Latch=CQ Net=df/count<30>
Bit 18666555 0x00401b9f   1755 Block=SLICE_X89Y76 Latch=DQ Net=df/count<31>
