Revision 3
; Created by bitgen P.20131013 at Tue Nov 14 22:33:27 2017
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
Bit 17115809 0x0040149f   2369 Block=SLICE_X66Y86 Latch=CQ Net=anteconmutador0/digitT<7>
Bit 17115843 0x0040149f   2403 Block=SLICE_X66Y87 Latch=AQ Net=anteconmutador0/digitT<1>
Bit 17115863 0x0040149f   2423 Block=SLICE_X67Y87 Latch=BMUX Net=anteconmutador0/digitT[7]_d[7]_mux_1_OUT<4>
Bit 17115868 0x0040149f   2428 Block=SLICE_X66Y87 Latch=BQ Net=anteconmutador0/digitT<2>
Bit 17115873 0x0040149f   2433 Block=SLICE_X66Y87 Latch=CQ Net=anteconmutador0/digitT<3>
Bit 17115907 0x0040149f   2467 Block=SLICE_X66Y88 Latch=AQ Net=anteconmutador0/digitT<4>
Bit 17115926 0x0040149f   2486 Block=SLICE_X66Y88 Latch=BMUX Net=anteconmutador0/digitT[7]_d[7]_mux_1_OUT<0>
Bit 17115932 0x0040149f   2492 Block=SLICE_X66Y88 Latch=BQ Net=anteconmutador0/digitT<0>
Bit 17115937 0x0040149f   2497 Block=SLICE_X66Y88 Latch=CQ Net=anteconmutador0/digitT<5>
Bit 17115946 0x0040149f   2506 Block=SLICE_X67Y88 Latch=CMUX Net=anteconmutador0/Msub_digitT[7]_GND_4_o_sub_4_OUT_lut<6>
Bit 17115962 0x0040149f   2522 Block=SLICE_X66Y88 Latch=DQ Net=anteconmutador0/digitT<6>
Bit 17232003 0x0040151f   2211 Block=SLICE_X68Y84 Latch=AQ Net=divisor0/DONE
Bit 17232195 0x0040151f   2403 Block=SLICE_X68Y87 Latch=AQ Net=anteconmutador0/U
Bit 17232214 0x0040151f   2422 Block=SLICE_X68Y87 Latch=BMUX Net=anteconmutador0/_n0143_inv
Bit 17232215 0x0040151f   2423 Block=SLICE_X69Y87 Latch=BMUX Net=anteconmutador0/Msub_digitT[7]_GND_4_o_sub_4_OUT_cy<2>
Bit 17232226 0x0040151f   2434 Block=SLICE_X69Y87 Latch=CQ Net=anteconmutador0/i
Bit 17232260 0x0040151f   2468 Block=SLICE_X69Y88 Latch=AQ Net=anteconmutador0/unidades<0>
Bit 17348228 0x0040159f   2084 Block=SLICE_X71Y82 Latch=AQ Net=divisorfrecd0/count_1462<0>
Bit 17348253 0x0040159f   2109 Block=SLICE_X71Y82 Latch=BQ Net=divisorfrecd0/count_1462<1>
Bit 17348258 0x0040159f   2114 Block=SLICE_X71Y82 Latch=CQ Net=divisorfrecd0/count_1462<2>
Bit 17348283 0x0040159f   2139 Block=SLICE_X71Y82 Latch=DQ Net=divisorfrecd0/count_1462<3>
Bit 17348291 0x0040159f   2147 Block=SLICE_X70Y83 Latch=AQ Net=divisorfrecd0/CLKOUTD
Bit 17348292 0x0040159f   2148 Block=SLICE_X71Y83 Latch=AQ Net=divisorfrecd0/count_1462<4>
Bit 17348317 0x0040159f   2173 Block=SLICE_X71Y83 Latch=BQ Net=divisorfrecd0/count_1462<5>
Bit 17348322 0x0040159f   2178 Block=SLICE_X71Y83 Latch=CQ Net=divisorfrecd0/count_1462<6>
Bit 17348347 0x0040159f   2203 Block=SLICE_X71Y83 Latch=DQ Net=divisorfrecd0/count_1462<7>
Bit 17348355 0x0040159f   2211 Block=SLICE_X70Y84 Latch=AQ Net=divisor0/registro<0>
Bit 17348356 0x0040159f   2212 Block=SLICE_X71Y84 Latch=AQ Net=divisorfrecd0/count_1462<8>
Bit 17348358 0x0040159f   2214 Block=SLICE_X70Y84 Latch=AMUX Net=divisor0/registro<4>
Bit 17348374 0x0040159f   2230 Block=SLICE_X70Y84 Latch=BMUX Net=divisor0/registro<5>
Bit 17348380 0x0040159f   2236 Block=SLICE_X70Y84 Latch=BQ Net=divisor0/registro<1>
Bit 17348381 0x0040159f   2237 Block=SLICE_X71Y84 Latch=BQ Net=divisorfrecd0/count_1462<9>
Bit 17348385 0x0040159f   2241 Block=SLICE_X70Y84 Latch=CQ Net=divisor0/registro<2>
Bit 17348386 0x0040159f   2242 Block=SLICE_X71Y84 Latch=CQ Net=divisorfrecd0/count_1462<10>
Bit 17348393 0x0040159f   2249 Block=SLICE_X70Y84 Latch=CMUX Net=divisor0/registro<6>
Bit 17348410 0x0040159f   2266 Block=SLICE_X70Y84 Latch=DQ Net=divisor0/registro<3>
Bit 17555141 0x0040169f   2149 Block=SLICE_X73Y83 Latch=AMUX Net=divisor0/registro0[7]_count[7]_mux_2_OUT<2>
Bit 17555203 0x0040169f   2211 Block=SLICE_X72Y84 Latch=AQ Net=anteconmutador0/decenas<0>
Bit 17555204 0x0040169f   2212 Block=SLICE_X73Y84 Latch=AQ Net=divisor0/registro0<0>
Bit 17555229 0x0040169f   2237 Block=SLICE_X73Y84 Latch=BQ Net=divisor0/registro0<1>
Bit 17555233 0x0040169f   2241 Block=SLICE_X72Y84 Latch=CQ Net=anteconmutador0/decenas<1>
Bit 17555234 0x0040169f   2242 Block=SLICE_X73Y84 Latch=CQ Net=divisor0/registro0<2>
Bit 17555241 0x0040169f   2249 Block=SLICE_X72Y84 Latch=CMUX Net=divisor0/DONE_glue_set
Bit 17555251 0x0040169f   2259 Block=SLICE_X72Y84 Latch=DMUX Net=anteconmutador0/decenas<2>
Bit 17555258 0x0040169f   2266 Block=SLICE_X72Y84 Latch=DQ Net=anteconmutador0/decenas<3>
Bit 17555259 0x0040169f   2267 Block=SLICE_X73Y84 Latch=DQ Net=divisor0/registro0<3>
Bit 17555267 0x0040169f   2275 Block=SLICE_X72Y85 Latch=AQ Net=anteconmutador0/De
Bit 17555514 0x0040169f   2522 Block=SLICE_X72Y88 Latch=DQ Net=anteconmutador0/centenas<0>
Bit 17671364 0x0040171f   2020 Block=SLICE_X75Y81 Latch=AQ Net=divisor0/registro0<4>
Bit 17671365 0x0040171f   2021 Block=SLICE_X75Y81 Latch=AMUX Net=divisor0/registro0[7]_count[7]_mux_2_OUT<4>
Bit 17671389 0x0040171f   2045 Block=SLICE_X75Y81 Latch=BQ Net=divisor0/registro0<5>
Bit 17671394 0x0040171f   2050 Block=SLICE_X75Y81 Latch=CQ Net=divisor0/registro0<6>
Bit 17671419 0x0040171f   2075 Block=SLICE_X75Y81 Latch=DQ Net=divisor0/registro0<7>
Bit 17787717 0x0040179f   2021 Block=SLICE_X77Y81 Latch=AMUX Net=divisor0/registro0[7]_count[7]_mux_2_OUT<6>
Bit 17995011 0x0040189f   2467 Block=SLICE_X78Y88 Latch=AQ Net=conmutacion0/titileo<1>
Bit 17995014 0x0040189f   2470 Block=SLICE_X78Y88 Latch=AMUX Net=conmutacion0/titileo<0>
Bit 18667332 0x00401b9f   2532 Block=SLICE_X89Y89 Latch=AQ Net=divisorfrecdisp0/count_100000<0>
Bit 18667357 0x00401b9f   2557 Block=SLICE_X89Y89 Latch=BQ Net=divisorfrecdisp0/count_100000<1>
Bit 18667362 0x00401b9f   2562 Block=SLICE_X89Y89 Latch=CQ Net=divisorfrecdisp0/count_100000<2>
Bit 18667387 0x00401b9f   2587 Block=SLICE_X89Y89 Latch=DQ Net=divisorfrecdisp0/count_100000<3>
Bit 18667396 0x00401b9f   2596 Block=SLICE_X89Y90 Latch=AQ Net=divisorfrecdisp0/count_100000<4>
Bit 18667421 0x00401b9f   2621 Block=SLICE_X89Y90 Latch=BQ Net=divisorfrecdisp0/count_100000<5>
Bit 18667426 0x00401b9f   2626 Block=SLICE_X89Y90 Latch=CQ Net=divisorfrecdisp0/count_100000<6>
Bit 18667451 0x00401b9f   2651 Block=SLICE_X89Y90 Latch=DQ Net=divisorfrecdisp0/count_100000<7>
Bit 18667460 0x00401b9f   2660 Block=SLICE_X89Y91 Latch=AQ Net=divisorfrecdisp0/count_100000<8>
Bit 18667485 0x00401b9f   2685 Block=SLICE_X89Y91 Latch=BQ Net=divisorfrecdisp0/count_100000<9>
Bit 18667490 0x00401b9f   2690 Block=SLICE_X89Y91 Latch=CQ Net=divisorfrecdisp0/count_100000<10>
Bit 18667515 0x00401b9f   2715 Block=SLICE_X89Y91 Latch=DQ Net=divisorfrecdisp0/count_100000<11>
Bit 18667524 0x00401b9f   2724 Block=SLICE_X89Y92 Latch=AQ Net=divisorfrecdisp0/count_100000<12>
Bit 18667548 0x00401b9f   2748 Block=SLICE_X88Y92 Latch=BQ Net=divisorfrecdisp0/CLKOUTseg
Bit 18667549 0x00401b9f   2749 Block=SLICE_X89Y92 Latch=BQ Net=divisorfrecdisp0/count_100000<13>
Bit 18667554 0x00401b9f   2754 Block=SLICE_X89Y92 Latch=CQ Net=divisorfrecdisp0/count_100000<14>
Bit 18667579 0x00401b9f   2779 Block=SLICE_X89Y92 Latch=DQ Net=divisorfrecdisp0/count_100000<15>
Bit 18667588 0x00401b9f   2788 Block=SLICE_X89Y93 Latch=AQ Net=divisorfrecdisp0/count_100000<16>
