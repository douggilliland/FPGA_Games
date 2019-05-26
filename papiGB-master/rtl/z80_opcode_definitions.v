
//  00
  `define  NOP     8'h0
  `define  LDBCnn  8'h1
  `define  LDBCmA  8'h2
  `define  INCBC   8'h3

  `define  INCr_b 8'h4
  `define  DECr_b 8'h5
  `define  LDrn_b 8'h6
  `define  RLCA   8'h7
  `define  LDmmSP 8'h08
  `define  ADDHLBC 8'h09
  `define  LDABCm 8'ha
  `define  DECBC 8'hb

  `define  INCr_c 8'hc
  `define  DECr_c 8'hd
  `define  LDrn_c 8'he
//  `define  RRCA;

//  10
  `define  STOP 8'h10
  `define  LDDEnn 8'h11
  `define  LDDEmA 8'h12
  `define  INCDE 8'h13

  `define  INCr_d 8'h14
  `define  DECr_d 8'h15
  `define  LDrn_d 8'h16
  `define  RLA 8'h17
  `define  JRn 8'h18
  `define  ADDHLDE 8'h19
  `define  LDADEm 8'h1A
  `define  DECDE 8'h1b
  `define  INCr_e 8'h1c
  `define  DECr_e 8'h1d
  `define  LDrn_e 8'h1e
  `define  RRA    8'h1f
//  `define
//  20
  `define  JRNZn  8'h20
  `define  LDHLnn 8'h21
  `define  LDHLIA 8'h22
  `define  INCHL  8'h23
  `define  INCr_h 8'h24
  `define  DECr_h 8'h25
  `define  LDrn_h 8'h26
//  `define  DAA;

  `define  JRZn 8'h28
  `define  ADDHLHL 8'h29
  `define  LDAHLI 8'h2A
  `define  DECHL  8'h2b
  `define  INCr_l 8'h2c
  `define  DECr_l 8'h2d
  `define  LDrn_l 8'h2e
//  `define  CPL;
//  `define
//  30
  `define  JRNCn   8'h30
  `define  LDSPnn  8'h31
  `define  LDHLDA  8'h32
  `define  INCSP   8'h33

  `define  INCHLm 8'h34
  `define  DECHLm 8'h35
  `define  LDHLmn 8'h36
//  `define  SCF;

  `define  JRCn 8'h38
  `define  ADDHLSP 8'h39
//  `define  LDAHLD;
  `define  DECSP  8'h3b
  `define  INCr_a 8'h3c
  `define  DECr_a 8'h3d
  `define  LDrn_a 8'h3e
//  `define  CCF;

//  40
  `define  LDrr_bb 8'h40
  `define  LDrr_bc 8'h41
  `define  LDrr_bd 8'h42
  `define  LDrr_be 8'h43
  `define  LDrr_bh 8'h44
  `define  LDrr_bl 8'h45
  `define  LDrHLm_b 8'h46
  `define  LDrr_ba  8'h47
  `define  LDrr_cb  8'h48
  `define  LDrr_cc  8'h49
  `define  LDrr_cd  8'h4a
  `define  LDrr_ce  8'h4b
  `define  LDrr_ch  8'h4c
  `define  LDrr_cl  8'h4d
  `define  LDrHLm_c 8'h4e
  `define  LDrr_ca 8'h4f

//  50
  `define  LDrr_db 8'h50
  `define  LDrr_dc 8'h51
  `define  LDrr_dd 8'h52
  `define  LDrr_de 8'h53
  `define  LDrr_dh 8'h54
  `define  LDrr_dl 8'h55
  `define  LDrHLm_d 8'h56
  `define  LDrr_da 8'h57
  `define  LDrr_eb 8'h58
  `define  LDrr_ec 8'h59
  `define  LDrr_ed 8'h5a
  `define  LDrr_ee 8'h5b

  `define  LDrr_eh 8'h5c
  `define  LDrr_el 8'h5d
  `define  LDrHLm_e 8'h5e
  `define  LDrr_ea 8'h5f

//  60
  `define  LDrr_hb 8'h60
  `define  LDrr_hc 8'h61
  `define  LDrr_hd 8'h62
  `define  LDrr_he 8'h63

  `define  LDrr_hh 8'h64
  `define  LDrr_hl 8'h65
  `define  LDrHLm_h 8'h66
  `define  LDrr_ha 8'h67
  `define  LDrr_lb 8'h68
  `define  LDrr_lc 8'h69
  `define  LDrr_ld 8'h6a
  `define  LDrr_le 8'h6b
  `define  LDrr_lh 8'h6c
  `define  LDrr_ll 8'h6d
  `define  LDrHLm_l 8'h6e
  `define  LDrr_la 8'h6f

//  70
  `define  LDHLmr_b 8'h70
  `define  LDHLmr_c 8'h71
  `define  LDHLmr_d 8'h72
  `define  LDHLmr_e 8'h73
  `define  LDHLmr_h 8'h74
  `define  LDHLmr_l 8'h75
  `define  HALT     8'h76
  `define  LDHLmr_a 8'h77
  `define  LDrr_ab 8'h78
  `define  LDrr_ac 8'h79
  `define  LDrr_ad 8'h7a
  `define  LDrr_ae 8'h7b
  `define  LDrr_ah 8'h7c
  `define  LDrr_al 8'h7d
  `define  LDrHLm_a 8'h7e
  `define  LDrr_aa 8'h7f
//  `define
//  80
  `define  ADDr_b 8'h80
  `define  ADDr_c 8'h81
  `define  ADDr_d 8'h82
  `define  ADDr_e 8'h83
  `define  ADDr_h 8'h84
  `define  ADDr_l 8'h85
//  `define  ADDHL;
  `define  ADDr_a 8'h87
  `define  ADCr_b 8'h88
  `define  ADCr_c 8'h89
  `define  ADCr_d 8'h8a
  `define  ADCr_e 8'h8b
  `define  ADCr_h 8'h8c
  `define  ADCr_l 8'h8d
//  `define  ADCHL;
  `define  ADCr_a 8'h8f
//  `define
//  90
  `define  SUBr_b 8'h90
  `define  SUBr_c 8'h91
  `define  SUBr_d 8'h92
  `define  SUBr_e 8'h93
//  `define
  `define  SUBr_h 8'h94
  `define  SUBr_l 8'h95
//  `define  SUBHL;
  `define  SUBr_a 8'h97
//  `define
  `define  SBCr_b 8'h98
  `define  SBCr_c 8'h99
  `define  SBCr_d 8'h9A
  `define  SBCr_e 8'h9B
//  `define
  `define  SBCr_h 8'h9C
  `define  SBCr_l 8'h9D
//  `define  SBCHL;
  `define  SBCr_a 8'h9F
//  `define
//  A0
  `define  ANDr_b 8'hA0
  `define  ANDr_c 8'hA1
  `define  ANDr_d 8'hA2
  `define  ANDr_e 8'hA3

  `define  ANDr_h 8'hA4
  `define  ANDr_l 8'hA5
  `define  ANDHL  8'hA6
  `define  ANDr_a 8'hA7

  `define  XORr_b 8'ha8
  `define  XORr_c 8'ha9
  `define  XORr_d 8'haa
  `define  XORr_e 8'hab

  `define  XORr_h 8'hac
  `define  XORr_l 8'had
  `define  XORHL  8'hAE
  `define  XORr_a 8'hAF

//  B0
  `define  ORr_b 8'hb0
  `define  ORr_c 8'hb1
  `define  ORr_d 8'hb2
  `define  ORr_e 8'hb3

  `define  ORr_h 8'hb4
  `define  ORr_l 8'hb5
  `define  ORHL  8'hb6
  `define  ORr_a 8'hb7

//  `define  CPr_b;
  `define  CPr_c 8'hb9
//  `define  CPr_d;
//  `define  CPr_e;

//  `define  CPr_h;
//  `define  CPr_l;
//  `define  CPHL;
//  `define  CPr_a;
//  `define
//C0
  `define  RETNZ 8'hC0
  `define  POPBC 8'hC1
  `define  JPNZnn 8'hC2
  `define  JPnn   8'hC3

  `define  CALLNZnn  8'hC4
  `define  PUSHBC    8'hC5
  `define  ADDn      8'hC6
  `define  RST00     8'hC7

  `define  RETZ   8'hC8
  `define  RET    8'hC9
  `define  JPZnn  8'hCA
  `define  MAPcb  8'hCB

//  //  `define  CALLZnn;
  `define  CALLnn 8'hCD
  `define  ADCn   8'hCe
//  //  `define  RST08;
//  //  `define
//  D0
  `define  RETNC 8'hd0
  `define  RETC  8'hd8
  `define  POPDE 8'hD1
//  //  `define  JPNCnn;
//  //  `define  XX;
//  //  `define
//  //  `define  CALLNCnn;
  `define  PUSHDE 8'hD5
  `define  SUBn   8'hD6
//  //  `define  RST10;
//  //  `define
  `define  RETI   8'hD9
  `define  JPCnn  8'hDA
//  //  `define  XX;
//  //  `define
//  //  `define  CALLCnn;
//  //  `define  XX;
  `define  SBCn 8'hDE
//  //  `define  RST18;
//  //  `define

  `define  LDIOnA 8'hE0
  `define  POPHL  8'hE1
  `define  LDIOCA 8'hE2
//  //  `define  XX;

//  //  `define  XX;
  `define  PUSHHL 8'hE5
  `define  ANDn   8'hE6
//  //  `define  RST20;

//  //  `define  ADDSPn;
  `define  JPHL   8'hE9
  `define  LDmmA  8'hEA
//  //  `define  XX;
//  //  `define  XX;
  `define  XORn   8'hee
//  //  `define  RST28;
//  //  `define
//  F0
  `define  LDAIOn 8'hf0
  `define  POPAF  8'hf1
  `define  LDAIOC 8'hf2
  `define  DI     8'hF3


//  //  `define  XX;
  `define  PUSHAF 8'hF5
  `define  ORn    8'hf6
//  //  `define  RST30;

`define  LDHLSPn  8'hf8 //TODO: Need more room to implement this guy....
//  //  `define  XX;
`define  LDSPHL 8'hF9
`define  LDAmm 8'hFA
`define  EI    8'hFB
`define  CPn 8'hFE
//  //  `define  RST38

//  CB00
`define  RLCr_b 8'h00
`define  RLCr_c 8'h01
`define  RLCr_d 8'h02
`define  RLCr_e 8'h03

`define  RLCr_h  8'h4
`define  RLCr_l  8'h5
`define  RLCHL  8'h6
`define  RLCr_a  8'h7

`define  RRCr_b 8'h8
`define  RRCr_c 8'h9
`define  RRCr_d 8'ha
`define  RRCr_e 8'hb

`define  RRCr_h 8'hc
`define  RRCr_l 8'hd
`define  RRCHL 8'he
`define  RRCr_a 8'hf

//  CB10
`define  RLr_b 8'h10
`define  RLr_c 8'h11
`define  RLr_d 8'h12
`define  RLr_e 8'h13
`define  RLr_h 8'h14
`define  RLr_l 8'h15
`define  RLHL  8'h16
`define  RLr_a 8'h17

`define  RRr_b 8'h18
`define  RRr_c 8'h19
`define  RRr_d 8'h1a
`define  RRr_e 8'h1b

`define  RRr_h  8'h1c
`define  RRr_l  8'h1d
`define  RRHL  8'h1e
`define  RRr_a  8'h1f
//  //  `define
//  CB20
//  //  `define  SLAr_b;
//  //  `define  SLAr_c;
//  //  `define  SLAr_d;
//  //  `define  SLAr_e;
//  //  `define
//  //  `define  SLAr_h;
//  //  `define  SLAr_l;
//  //  `define  XX;
//  //  `define  SLAr_a;
//  //  `define
//  //  `define  SRAr_b;
//  //  `define  SRAr_c;
//  //  `define  SRAr_d;
//  //  `define  SRAr_e;
//  //  `define
//  //  `define  SRAr_h;
//  //  `define  SRAr_l;
//  //  `define  XX;
//  //  `define  SRAr_a;
//  //  `define
//  CB30
`define  SWAPr_b 8'h30
`define  SWAPr_d 8'h31
`define  SWAPr_e 8'h32
`define  SWAPr_c 8'h33
`define  SWAPr_h 8'h34
`define  SWAPr_l 8'h35

`define  SWAPr_a  8'h36
`define  SRLr_b  8'h37
`define  SRLr_c  8'h38
`define  SRLr_d  8'h39
`define  SRLr_e  8'h3a
`define  SRLr_h  8'h3b
`define  SRLr_l  8'h3c
`define  SRLr_a  8'h3d

//  CB40
//  //  `define  BIT0b;
//  //  `define  BIT0c;
//  //  `define  BIT0d;
//  //  `define  BIT0e;
//  //  `define
//  //  `define  BIT0h;
//  //  `define  BIT0l;
//  //  `define  BIT0m;
//  //  `define  BIT0a;
//  //  `define
//  //  `define  BIT1b;
//  //  `define  BIT1c;
//  //  `define  BIT1d;
//  //  `define  BIT1e;
//  //  `define
//  //  `define  BIT1h;
//  //  `define  BIT1l;
//  //  `define  BIT1m;
//  //  `define  BIT1a;
//  //  `define
//  CB50
//  //  `define  BIT2b;
//  //  `define  BIT2c;
//  //  `define  BIT2d;
//  //  `define  BIT2e;
//  //  `define
//  //  `define  BIT2h;
//  //  `define  BIT2l;
//  //  `define  BIT2m;
//  //  `define  BIT2a;
//  //  `define
//  //  `define  BIT3b;
//  //  `define  BIT3c;
//  //  `define  BIT3d;
//  //  `define  BIT3e;
//  //  `define
//  //  `define  BIT3h;
//  //  `define  BIT3l;
//  //  `define  BIT3m;
//  //  `define  BIT3a;
//  //  `define
//  CB60
//  //  `define  BIT4b;
//  //  `define  BIT4c;
//  //  `define  BIT4d;
//  //  `define  BIT4e;
//  //  `define
//  //  `define  BIT4h;
//  //  `define  BIT4l;
//  //  `define  BIT4m;
//  //  `define  BIT4a;
//  //  `define
//  //  `define  BIT5b;
//  //  `define  BIT5c;
//  //  `define  BIT5d;
//  //  `define  BIT5e;
//  //  `define
//  //  `define  BIT5h;
//  //  `define  BIT5l;
//  //  `define  BIT5m;
//  //  `define  BIT5a;
//  //  `define
//  CB70
//  //  `define  BIT6b;
//  //  `define  BIT6c;
//  //  `define  BIT6d;
//  //  `define  BIT6e;
//  //  `define  BIT6h;
//  //  `define  BIT6l;
//  //  `define  BIT6m;
//  //  `define  BIT6a;
//  //  `define  BIT7b;
//  //  `define  BIT7c;
//  //  `define  BIT7d;
//  //  `define  BIT7e;

`define  BIT7h 8'h7c
`define  BIT7l 8'h7d
`define  BIT7m 8'h7e
`define  BIT7a 8'h7F

//  CB80
//  //  `define  RES0b;
//  //  `define  RES0c;
//  //  `define  RES0d;
//  //  `define  RES0e;
//  //  `define
//  //  `define  RES0h;
//  //  `define  RES0l;
//  //  `define  RES0m;
//  //  `define  RES0a;
//  //  `define
//  //  `define  RES1b;
//  //  `define  RES1c;
//  //  `define  RES1d;
//  //  `define  RES1e;
//  //  `define
//  //  `define  RES1h;
//  //  `define  RES1l;
//  //  `define  RES1m;
//  //  `define  RES1a;
//  //  `define
//  CB90
//  //  `define  RES2b;
//  //  `define  RES2c;
//  //  `define  RES2d;
//  //  `define  RES2e;
//  //  `define
//  //  `define  RES2h;
//  //  `define  RES2l;
//  //  `define  RES2m;
//  //  `define  RES2a;
//  //  `define
//  //  `define  RES3b;
//  //  `define  RES3c;
//  //  `define  RES3d;
//  //  `define  RES3e;
//  //  `define
//  //  `define  RES3h;
//  //  `define  RES3l;
//  //  `define  RES3m;
//  //  `define  RES3a;
//  //  `define
//  CBA0
//  //  `define  RES4b;
//  //  `define  RES4c;
//  //  `define  RES4d;
//  //  `define  RES4e;
//  //  `define
//  //  `define  RES4h;
//  //  `define  RES4l;
//  //  `define  RES4m;
//  //  `define  RES4a;
//  //  `define
//  //  `define  RES5b;
//  //  `define  RES5c;
//  //  `define  RES5d;
//  //  `define  RES5e;
//  //  `define
//  //  `define  RES5h;
//  //  `define  RES5l;
//  //  `define  RES5m;
//  //  `define  RES5a;
//  //  `define
//  CBB0
//  //  `define  RES6b;
//  //  `define  RES6c;
//  //  `define  RES6d;
//  //  `define  RES6e;
//  //  `define
//  //  `define  RES6h;
//  //  `define  RES6l;
//  //  `define  RES6m;
//  //  `define  RES6a;
//  //  `define
//  //  `define  RES7b;
//  //  `define  RES7c;
//  //  `define  RES7d;
//  //  `define  RES7e;
//  //  `define
//  //  `define  RES7h;
//  //  `define  RES7l;
//  //  `define  RES7m;
//  //  `define  RES7a;
//  //  `define
//  CBC0
//  //  `define  SET0b;
//  //  `define  SET0c;
//  //  `define  SET0d;
//  //  `define  SET0e;
//  //  `define
//  //  `define  SET0h;
//  //  `define  SET0l;
//  //  `define  SET0m;
//  //  `define  SET0a;
//  //  `define
//  //  `define  SET1b;
//  //  `define  SET1c;
//  //  `define  SET1d;
//  //  `define  SET1e;
//  //  `define
//  //  `define  SET1h;
//  //  `define  SET1l;
//  //  `define  SET1m;
//  //  `define  SET1a;
//  //  `define
//  CBD0
//  //  `define  SET2b;
//  //  `define  SET2c;
//  //  `define  SET2d;
//  //  `define  SET2e;
//  //  `define
//  //  `define  SET2h;
//  //  `define  SET2l;
//  //  `define  SET2m;
//  //  `define  SET2a;
//  //  `define
//  //  `define  SET3b;
//  //  `define  SET3c;
//  //  `define  SET3d;
//  //  `define  SET3e;
//  //  `define
//  //  `define  SET3h;
//  //  `define  SET3l;
//  //  `define  SET3m;
//  //  `define  SET3a;
//  //  `define
//  CBE0
//  //  `define  SET4b;
//  //  `define  SET4c;
//  //  `define  SET4d;
//  //  `define  SET4e;
//  //  `define
//  //  `define  SET4h;
//  //  `define  SET4l;
//  //  `define  SET4m;
//  //  `define  SET4a;
//  //  `define
//  //  `define  SET5b;
//  //  `define  SET5c;
//  //  `define  SET5d;
//  //  `define  SET5e;
//  //  `define
//  //  `define  SET5h;
//  //  `define  SET5l;
//  //  `define  SET5m;
//  //  `define  SET5a;
//  //  `define
//  CBF0
//  //  `define  SET6b;
//  //  `define  SET6c;
//  //  `define  SET6d;
//  //  `define  SET6e;
//  //  `define
//  //  `define  SET6h;
//  //  `define  SET6l;
//  //  `define  SET6m;
//  //  `define  SET6a;
//  //  `define
//  //  `define  SET7b;
//  //  `define  SET7c;
//  //  `define  SET7d;
//  //  `define  SET7e;
//  //  `define
//  //  `define  SET7h;
//  //  `define  SET7l;
//  //  `define  SET7m;
//  //  `define  SET7a;

//flags
`define flag_z 7  //zero
`define flag_n 6  //neg
`define flag_h 5  //half carry
`define flag_c 4  //carry

//+------------+-----------+-------------+
//|   14:10         9:5         4:0     |
//+------------+-----------+-------------+
//| Predicate  | Operation |  Operand    |
//+------------+-----------+-------------+

//Prefixed
`define op              5'b00000
`define eof             5'b00001
`define eof_c           5'b00010
`define eof_nc          5'b00011
`define eof_z           5'b00100
`define eof_nz          5'b00101

`define inc             5'b01000
`define inc_eof         5'b01001
`define inc_eof_c       5'b01010
`define inc_eof_nc      5'b01011
`define inc_eof_z       5'b01100
`define inc_eof_nz      5'b01101

`define update_flags    5'b10000
`define eof_fu          5'b10001
`define inc_fu          5'b11000
`define inc_eof_fu      5'b11001
`define inc_eof_c_fu    5'b11010
`define inc_eof_nc_fu   5'b11011
`define inc_eof_z_fu    5'b11100
`define inc_eof_nz_fu   5'b11101


`define uop_flags_update_enable 14
`define uop_flags_eof           12

`define nop      5'h0
`define sma      5'h1
`define srm      5'h2
`define jcb      5'h3
`define z801bop  5'h4
`define smw      5'h5
`define dec16    5'h6
`define bit      5'h7
`define addx16   5'h8
`define spc      5'h9
`define sx16r    5'ha
`define sx8r     5'hb
`define inc16    5'hc
`define srx8     5'hd
`define shl      5'he
`define subx16   5'hf
`define srx16    5'h10
`define seti	   5'h11
`define cibit	   5'h12
`define ceti	   5'h13
`define jint     5'h14
`define anda     5'h15
`define ora      5'h16
`define xorx16   5'h17
`define rrot     5'h18
`define xora     5'h19
`define addx16c 5'h1a
`define addx16u   5'h1b
`define shr       5'h1c
`define hlt       5'h1d
`define shl8      5'h1e
`define addx16c_ext 5'h1f

`define null 5'h0



`define b     5'd0
`define c     5'd1
`define d     5'd2
`define e     5'd3
`define h     5'd4
`define l     5'd5
`define hl    5'd6
`define a     5'd7
`define pc    5'd8
`define pch   5'd9
`define sp    5'd10
`define f     5'd11
`define spl   5'd12
`define sph   5'd13
`define y16   5'd14
`define z16   5'd15
`define x8    5'd16
`define x16   5'd17
`define io_c  5'd18
`define de    5'd19

`define bc    5'd21
`define af    5'd22
`define idata 5'd23
`define carry 5'd24
`define y8    5'd25
`define xy16  5'd26
`define int_flags_adr 5'd27

`define DZCPU_AFTER_RESET 0
`define DZCPU_START_FLOW  1
`define DZCPU_RUN_FLOW    2
`define DZCPU_END_FLOW    3




//this is offset interruption microflow
`define FLOW_ID_INTERRUPT   10'd516

`define INT_ADDR_VBLANK 					     16'h40
`define INT_ADDR_LCD_STATUS_TRIGGER		 16'h48
`define INT_ADDR_TIMER_OVERFLOW        16'h50
`define INT_ADDR_VBLANK_JOYPAD_PRESS   16'h60
