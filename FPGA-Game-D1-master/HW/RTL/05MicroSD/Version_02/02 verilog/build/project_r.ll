Revision 3
; Created by bitgen P.20131013 at Wed Oct 18 15:18:55 2017
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
Bit  3170650 0x00000d9f     58 Block=SLICE_X44Y100 Latch=DQ Net=df/sclkn
Bit  3286948 0x00000e1f      4 Block=SLICE_X47Y100 Latch=AQ Net=df/div<4>
Bit  3286973 0x00000e1f     29 Block=SLICE_X47Y100 Latch=BQ Net=df/div<5>
Bit  3286978 0x00000e1f     34 Block=SLICE_X47Y100 Latch=CQ Net=df/div<6>
Bit  3286995 0x00000e1f     51 Block=SLICE_X46Y100 Latch=DMUX Net=cs_OBUF
Bit  3287003 0x00000e1f     59 Block=SLICE_X47Y100 Latch=DQ Net=df/div<7>
Bit  3287012 0x00000e1f     68 Block=SLICE_X47Y101 Latch=AQ Net=df/div<8>
Bit  3287037 0x00000e1f     93 Block=SLICE_X47Y101 Latch=BQ Net=df/div<9>
Bit 15675140 0x00400e1f   3172 Block=SLICE_X47Y99 Latch=AQ Net=df/div<0>
Bit 15675165 0x00400e1f   3197 Block=SLICE_X47Y99 Latch=BQ Net=df/div<1>
Bit 15675170 0x00400e1f   3202 Block=SLICE_X47Y99 Latch=CQ Net=df/div<2>
Bit 15675195 0x00400e1f   3227 Block=SLICE_X47Y99 Latch=DQ Net=df/div<3>
Bit 16560451 0x0040121f   2915 Block=SLICE_X58Y95 Latch=AQ Net=shi/dezi_7_P_7
Bit 16560516 0x0040121f   2980 Block=SLICE_X59Y96 Latch=AQ Net=shi/dezi_7_LDC
Bit 16560517 0x0040121f   2981 Block=SLICE_X59Y96 Latch=AMUX Net=shi/reset_datase[7]_AND_4_o
Bit 16560518 0x0040121f   2982 Block=SLICE_X58Y96 Latch=AMUX Net=shi/dezi_7_C_7
Bit 16883203 0x0040139f   2467 Block=SLICE_X62Y88 Latch=AQ Net=shi/dezi_6_LDC
Bit 16883204 0x0040139f   2468 Block=SLICE_X63Y88 Latch=AQ Net=shi/dezi_6_P_6
Bit 16883205 0x0040139f   2469 Block=SLICE_X63Y88 Latch=AMUX Net=shi/reset_datase[6]_AND_6_o
Bit 16883251 0x0040139f   2515 Block=SLICE_X62Y88 Latch=DMUX Net=shi/dezi[7]_dezi[6]_mux_0_OUT<7>
Bit 16883267 0x0040139f   2531 Block=SLICE_X62Y89 Latch=AQ Net=shi/dezi_6_C_6
Bit 16999363 0x0040141f   2275 Block=SLICE_X64Y85 Latch=AQ Net=shi/dezi_5_LDC
Bit 16999365 0x0040141f   2277 Block=SLICE_X65Y85 Latch=AMUX Net=shi/reset_datase[5]_AND_8_o
Bit 16999412 0x0040141f   2324 Block=SLICE_X65Y85 Latch=DMUX Net=shi/dezi_5_P_5
Bit 16999427 0x0040141f   2339 Block=SLICE_X64Y86 Latch=AQ Net=shi/dezi_5_C_5
Bit 17231683 0x0040151f   1891 Block=SLICE_X68Y79 Latch=AQ Net=shi/dezi_2_P_2
Bit 17231684 0x0040151f   1892 Block=SLICE_X69Y79 Latch=AQ Net=shi/dezi_2_C_2
Bit 17231747 0x0040151f   1955 Block=SLICE_X68Y80 Latch=AQ Net=shi/dezi_0_C_0
Bit 17231876 0x0040151f   2084 Block=SLICE_X69Y82 Latch=AQ Net=shi/dezi_4_P_4
Bit 17232435 0x0040151f   2643 Block=SLICE_X68Y90 Latch=DMUX Net=cnt/done
Bit 17347909 0x0040159f   1765 Block=SLICE_X71Y77 Latch=AMUX Net=shi/reset_datase[1]_AND_16_o
Bit 17347963 0x0040159f   1819 Block=SLICE_X71Y77 Latch=DQ Net=shi/dezi_1_LDC
Bit 17348027 0x0040159f   1883 Block=SLICE_X71Y78 Latch=DQ Net=shi/dezi_1_C_1
Bit 17348035 0x0040159f   1891 Block=SLICE_X70Y79 Latch=AQ Net=shi/dezi_2_LDC
Bit 17348036 0x0040159f   1892 Block=SLICE_X71Y79 Latch=AQ Net=shi/dezi_1_P_1
Bit 17348037 0x0040159f   1893 Block=SLICE_X71Y79 Latch=AMUX Net=shi/reset_datase[2]_AND_14_o
Bit 17348083 0x0040159f   1939 Block=SLICE_X70Y79 Latch=DMUX Net=shi/dezi[7]_dezi[6]_mux_0_OUT<3>
Bit 17348100 0x0040159f   1956 Block=SLICE_X71Y80 Latch=AQ Net=shi/dezi_0_P_0
Bit 17348101 0x0040159f   1957 Block=SLICE_X71Y80 Latch=AMUX Net=shi/reset_datase[0]_AND_18_o
Bit 17348147 0x0040159f   2003 Block=SLICE_X70Y80 Latch=DMUX Net=shi/dezi[7]_dezi[6]_mux_0_OUT<1>
Bit 17348154 0x0040159f   2010 Block=SLICE_X70Y80 Latch=DQ Net=shi/dezi_0_LDC
Bit 17348163 0x0040159f   2019 Block=SLICE_X70Y81 Latch=AQ Net=shi/dezi_3_P_3
Bit 17348165 0x0040159f   2021 Block=SLICE_X71Y81 Latch=AMUX Net=shi/dezi_3_C_3
Bit 17348227 0x0040159f   2083 Block=SLICE_X70Y82 Latch=AQ Net=shi/dezi_4_LDC
Bit 17348228 0x0040159f   2084 Block=SLICE_X71Y82 Latch=AQ Net=shi/dezi_4_C_4
Bit 17348229 0x0040159f   2085 Block=SLICE_X71Y82 Latch=AMUX Net=shi/reset_datase[4]_AND_10_o
Bit 17348275 0x0040159f   2131 Block=SLICE_X70Y82 Latch=DMUX Net=shi/dezi[7]_dezi[6]_mux_0_OUT<5>
Bit 17555011 0x0040169f   2019 Block=SLICE_X72Y81 Latch=AQ Net=shi/dezi_3_LDC
Bit 17555013 0x0040169f   2021 Block=SLICE_X73Y81 Latch=AMUX Net=shi/reset_datase[3]_AND_12_o
Bit 18111171 0x0040191f   2275 Block=SLICE_X80Y85 Latch=AQ Net=cnt/countd<0>
Bit 18111173 0x0040191f   2277 Block=SLICE_X81Y85 Latch=AMUX Net=cnt/Mcount_countd_val
Bit 18111196 0x0040191f   2300 Block=SLICE_X80Y85 Latch=BQ Net=cnt/countd<1>
Bit 18111201 0x0040191f   2305 Block=SLICE_X80Y85 Latch=CQ Net=cnt/countd<2>
Bit 18111226 0x0040191f   2330 Block=SLICE_X80Y85 Latch=DQ Net=cnt/countd<3>
Bit 18664996 0x00401b9f    196 Block=SLICE_X89Y53 Latch=AQ Net=shd/dezd<1>
Bit 18665021 0x00401b9f    221 Block=SLICE_X89Y53 Latch=BQ Net=shd/dezd<2>
Bit 18665026 0x00401b9f    226 Block=SLICE_X89Y53 Latch=CQ Net=shd/dezd<3>
Bit 18665051 0x00401b9f    251 Block=SLICE_X89Y53 Latch=DQ Net=shd/dezd<4>
Bit 18666435 0x00401b9f   1635 Block=SLICE_X88Y75 Latch=AQ Net=shd/dezd<5>
Bit 18666460 0x00401b9f   1660 Block=SLICE_X88Y75 Latch=BQ Net=shd/dezd<6>
