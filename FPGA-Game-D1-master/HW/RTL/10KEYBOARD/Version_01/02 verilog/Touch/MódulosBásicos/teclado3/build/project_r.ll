Revision 3
; Created by bitgen P.68d at Thu Nov 30 17:22:08 2017
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
Bit  3733860 0x0000101f    900 Block=SLICE_X53Y114 Latch=AQ Net=dfuno/count<0>
Bit  3733885 0x0000101f    925 Block=SLICE_X53Y114 Latch=BQ Net=dfuno/count<1>
Bit  3733890 0x0000101f    930 Block=SLICE_X53Y114 Latch=CQ Net=dfuno/count<2>
Bit  3733915 0x0000101f    955 Block=SLICE_X53Y114 Latch=DQ Net=dfuno/count<3>
Bit  3733924 0x0000101f    964 Block=SLICE_X53Y115 Latch=AQ Net=dfuno/count<4>
Bit  3733949 0x0000101f    989 Block=SLICE_X53Y115 Latch=BQ Net=dfuno/count<5>
Bit  3733953 0x0000101f    993 Block=SLICE_X52Y115 Latch=CQ Net=dfuno/CLKOUT
Bit  3733954 0x0000101f    994 Block=SLICE_X53Y115 Latch=CQ Net=dfuno/count<6>
Bit  3733961 0x0000101f   1001 Block=SLICE_X52Y115 Latch=CMUX Net=dfuno/CLKOUT_rstpot
Bit  3733979 0x0000101f   1019 Block=SLICE_X53Y115 Latch=DQ Net=dfuno/count<7>
Bit  3733988 0x0000101f   1028 Block=SLICE_X53Y116 Latch=AQ Net=dfuno/count<8>
Bit  3734013 0x0000101f   1053 Block=SLICE_X53Y116 Latch=BQ Net=dfuno/count<9>
Bit  3734018 0x0000101f   1058 Block=SLICE_X53Y116 Latch=CQ Net=dfuno/count<10>
Bit  3734043 0x0000101f   1083 Block=SLICE_X53Y116 Latch=DQ Net=dfuno/count<11>
Bit  3734052 0x0000101f   1092 Block=SLICE_X53Y117 Latch=AQ Net=dfuno/count<12>
Bit 18665764 0x00401b9f    964 Block=SLICE_X89Y65 Latch=AQ Net=psdos0/regis<0>
Bit 18665789 0x00401b9f    989 Block=SLICE_X89Y65 Latch=BQ Net=psdos0/regis<1>
Bit 18665794 0x00401b9f    994 Block=SLICE_X89Y65 Latch=CQ Net=psdos0/regis<2>
Bit 18665819 0x00401b9f   1019 Block=SLICE_X89Y65 Latch=DQ Net=psdos0/regis<3>
Bit 18665828 0x00401b9f   1028 Block=SLICE_X89Y66 Latch=AQ Net=psdos0/regis<4>
Bit 18665853 0x00401b9f   1053 Block=SLICE_X89Y66 Latch=BQ Net=psdos0/regis<5>
Bit 18665858 0x00401b9f   1058 Block=SLICE_X89Y66 Latch=CQ Net=psdos0/regis<6>
Bit 18665865 0x00401b9f   1065 Block=SLICE_X88Y66 Latch=CMUX Net=N5
Bit 18665866 0x00401b9f   1066 Block=SLICE_X89Y66 Latch=CMUX Net=psdos0/i[3]_Decoder_2_OUT<3><3>1
Bit 18665883 0x00401b9f   1083 Block=SLICE_X89Y66 Latch=DQ Net=psdos0/regis<7>
Bit 18665892 0x00401b9f   1092 Block=SLICE_X89Y67 Latch=AQ Net=psdos0/i<0>
Bit 18665911 0x00401b9f   1111 Block=SLICE_X89Y67 Latch=BMUX Net=psdos0/i<1>
Bit 18665917 0x00401b9f   1117 Block=SLICE_X89Y67 Latch=BQ Net=psdos0/i<2>
Bit 18665921 0x00401b9f   1121 Block=SLICE_X88Y67 Latch=CQ Net=psdos0/init
Bit 18665922 0x00401b9f   1122 Block=SLICE_X89Y67 Latch=CQ Net=psdos0/i<3>
Bit 18665930 0x00401b9f   1130 Block=SLICE_X89Y67 Latch=CMUX Net=psdos0/GND_2_o_GND_2_o_equal_12_o
Bit 18667095 0x00401b9f   2295 Block=SLICE_X89Y85 Latch=BMUX Net=psdos0/DONE
