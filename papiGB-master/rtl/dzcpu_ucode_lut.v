`timescale 1ns / 1ps
`include "z80_opcode_definitions.v"

////////////////////////////////////////////////////////////////////////////////////
//
// pGB, yet another FPGA fully functional and super fun GB classic clone!
// Copyright (C) 2015-2016  Diego Valverde (diego.valverde.g@gmail.com)
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//
////////////////////////////////////////////////////////////////////////////////////


module dzcpu_ucode_lut
(
	input  wire[7:0]  iMop,
	output reg [9:0]  oUopFlowIdx
);







always @ ( iMop )
begin
	case ( iMop )
	`LDSPnn: oUopFlowIdx = 10'd1;
	`LDHLnn: oUopFlowIdx = 10'd5;
	`LDHLDA: oUopFlowIdx = 10'd9;
	`MAPcb:  oUopFlowIdx = 10'd13;
	`JRNZn:  oUopFlowIdx = 10'd17;
	`LDrn_c: oUopFlowIdx = 10'd23;
	`LDrn_a: oUopFlowIdx = 10'd26;
	`LDIOCA: oUopFlowIdx = 10'd29;
	`INCr_c: oUopFlowIdx = 10'd32;
	`LDHLmr_a: oUopFlowIdx = 10'd33;
	`LDIOnA: oUopFlowIdx = 10'd526;
	`LDDEnn: oUopFlowIdx = 10'd43;
	`LDADEm: oUopFlowIdx = 10'd94;
	`CALLnn: oUopFlowIdx = 10'd49;
	`LDrn_b: oUopFlowIdx = 10'd60;
	`PUSHBC: oUopFlowIdx = 10'd63;
	`RLA:    oUopFlowIdx = 10'd70;	//TODO: Make sure this is OK!
	`POPBC:  oUopFlowIdx = 10'd71;
	`DECr_b: oUopFlowIdx = 10'd300;
	`LDHLIA: oUopFlowIdx = 10'd78;
	`INCHL:  oUopFlowIdx = 10'd82;
	`RET:    oUopFlowIdx = 10'd252;//8'd83;
	`INCDE:  oUopFlowIdx = 10'd89;
	`CPn:    oUopFlowIdx = 10'd90;
	`LDmmA: oUopFlowIdx  = 10'd98;
	`DECr_a: oUopFlowIdx = 10'd47;
	`DECr_c: oUopFlowIdx = 10'd48;
	`JRZn:   oUopFlowIdx = 10'd106;
	`LDrn_l: oUopFlowIdx = 10'd112;
	`JRn:    oUopFlowIdx = 10'd115;
	`INCr_b: oUopFlowIdx = 10'd161;
	`LDrn_e: oUopFlowIdx = 10'd121;
	`LDAIOn: oUopFlowIdx = 10'd534;
	`INCr_h: oUopFlowIdx = 10'd312;
	`SUBr_b: oUopFlowIdx = 10'd132;
	`DECr_d: oUopFlowIdx = 10'd135;
	`LDrn_d: oUopFlowIdx = 10'd136;
	`JPnn:   oUopFlowIdx = 10'd139;
	`LDrn_h: oUopFlowIdx = 10'd146;
	`LDAHLI: oUopFlowIdx = 10'd149;
	`LDHLmn: oUopFlowIdx = 10'd154;
	`NOP:    oUopFlowIdx = 10'd162;
  `DI:     oUopFlowIdx = 10'd163;
  `INCr_d: oUopFlowIdx = 10'd164;
  `INCr_e: oUopFlowIdx = 10'd250; //8'd165;
  `DECr_e: oUopFlowIdx = 10'd166;
  `DECDE:  oUopFlowIdx = 10'd168;
	`DECBC:  oUopFlowIdx = 10'd169; //OK
  `DECr_h: oUopFlowIdx = 10'd170;
  `DECHL:  oUopFlowIdx = 10'd172;
  `INCr_a: oUopFlowIdx = 10'd302;
	`INCSP:  oUopFlowIdx = 10'd304;
	`DECSP:  oUopFlowIdx = 10'd306;
	`INCr_l: oUopFlowIdx = 10'd308;
	`DECr_l: oUopFlowIdx = 10'd310;
	`ADDr_a: oUopFlowIdx = 10'd175;
	`ADDr_b: oUopFlowIdx = 10'd178;
	`SUBr_c: oUopFlowIdx = 10'd181;
	`ADDr_c: oUopFlowIdx = 10'd184;
	`ADDr_d: oUopFlowIdx = 10'd187;
	`ADDr_e: oUopFlowIdx = 10'd190;
	`ADDr_h: oUopFlowIdx = 10'd193;
	`ADDr_l: oUopFlowIdx = 10'd196;
	`SUBr_d: oUopFlowIdx = 10'd199;
	`SUBr_e: oUopFlowIdx = 10'd202;
	`SUBr_h: oUopFlowIdx = 10'd205;
	`SUBr_l: oUopFlowIdx = 10'd208;
	`SUBr_a: oUopFlowIdx = 10'd211;
	`PUSHDE: oUopFlowIdx = 10'd214;
	`PUSHHL: oUopFlowIdx = 10'd220;
	`POPDE:  oUopFlowIdx = 10'd226;
	`POPHL:  oUopFlowIdx = 10'd232;
	`LDHLmr_b: oUopFlowIdx = 10'd238;
	`LDHLmr_c: oUopFlowIdx = 10'd241;
	`LDHLmr_d: oUopFlowIdx = 10'd244;
	`LDDEmA:   oUopFlowIdx = 10'd247;
	`PUSHAF:   oUopFlowIdx = 10'd261;
	`POPAF:    oUopFlowIdx = 10'd267;
	`LDBCnn:   oUopFlowIdx = 10'd273;
	`INCBC:    oUopFlowIdx = 10'd83;
	`LDAmm:    oUopFlowIdx = 10'd280;
	`ANDn:     oUopFlowIdx = 10'd85;
	`CALLNZnn: oUopFlowIdx = 10'd289;
	`ADDn:     oUopFlowIdx = 10'd314;
	`SUBn:     oUopFlowIdx = 10'd319;
	`CPr_c:    oUopFlowIdx = 10'd324;
	`LDrHLm_b: oUopFlowIdx = 10'd327;
	`LDrHLm_c: oUopFlowIdx = 10'd331;
	`LDrHLm_d: oUopFlowIdx = 10'd335;
	`XORHL:    oUopFlowIdx = 10'd339;
	`ADCn:     oUopFlowIdx = 10'd345;
	`ADDHLDE:  oUopFlowIdx = 10'd351;
	`JRNCn:    oUopFlowIdx = 10'd414;
	`XORn:     oUopFlowIdx = 10'd359;
	`RRA:      oUopFlowIdx = 10'd363;
	`RETNC:    oUopFlowIdx = 10'd365;
	`RETZ:     oUopFlowIdx = 10'd377;
	`ORHL:     oUopFlowIdx = 10'd387;
	`DECHLm:   oUopFlowIdx = 10'd391;
	`LDrHLm_l: oUopFlowIdx = 10'd397;
	`RETNZ:    oUopFlowIdx = 10'd401;
	`ADDHLHL:  oUopFlowIdx = 10'd411;
  `ANDHL:    oUopFlowIdx = 10'd420;
	`LDHLmr_e: oUopFlowIdx = 10'd424;
	`LDHLmr_h: oUopFlowIdx = 10'd427;
	`LDHLmr_l: oUopFlowIdx = 10'd430;
	`LDABCm:   oUopFlowIdx = 10'd433;
	`LDrHLm_a: oUopFlowIdx = 10'd437;
	`LDrHLm_e: oUopFlowIdx = 10'd441;
	`LDrHLm_h: oUopFlowIdx = 10'd445;
	`ADCr_a:   oUopFlowIdx = 10'd449;
	`ADCr_b:   oUopFlowIdx = 10'd453;
	`ADCr_c:   oUopFlowIdx = 10'd457;
	`ADCr_d:   oUopFlowIdx = 10'd461;
	`ADCr_e:   oUopFlowIdx = 10'd465;
	`ADCr_h:   oUopFlowIdx = 10'd469;
	`ADCr_l:   oUopFlowIdx = 10'd473;
	`SBCr_a:   oUopFlowIdx = 10'd477;
	`SBCr_b:   oUopFlowIdx = 10'd481;
	`SBCr_c:   oUopFlowIdx = 10'd485;
	`SBCr_d:   oUopFlowIdx = 10'd489;
	`SBCr_e:   oUopFlowIdx = 10'd493;
	`SBCr_h:   oUopFlowIdx = 10'd497;
	`SBCr_l:   oUopFlowIdx = 10'd501;
	`JPHL:     oUopFlowIdx = 10'd173;
	`EI:       oUopFlowIdx = 10'd511;
	`JPNZnn:   oUopFlowIdx = 10'd354;
	`JPZnn:		 oUopFlowIdx = 10'd542;
	`LDHLSPn:  oUopFlowIdx = 10'd512;
	`HALT:		 oUopFlowIdx = 10'd547;
	`RETC:		 oUopFlowIdx = 10'd549;
	`JPCnn:		 oUopFlowIdx = 10'd559;
	`INCHLm:	 oUopFlowIdx = 10'd564;
	`RETI:		 oUopFlowIdx = 10'd570;
  `ADDHLSP:	 oUopFlowIdx = 10'd580;
	`ADDHLBC:	 oUopFlowIdx = 10'd583;
	`RLCA:     oUopFlowIdx = 10'd586;
	`LDmmSP:   oUopFlowIdx = 10'd589;
	`LDSPHL:   oUopFlowIdx = 10'd601;
	`ORn:      oUopFlowIdx = 10'd603;
	`JRCn:		 oUopFlowIdx = 10'd607;
	`STOP:		 oUopFlowIdx = 10'd613;
	`SBCn:		 oUopFlowIdx = 10'd616;
	`LDAIOC:   oUopFlowIdx = 10'd621;

	default:
			 oUopFlowIdx = 10'd278;
	endcase
end



endmodule


////////////////////////////////////////////////////////
//
//   MAP CB -- EXTENDED OPERATIONS
//
////////////////////////////////////////////////////////

module dzcpu_ucode_cblut
(
	input  wire[7:0]  iMop,
	output reg [8:0]  oUopFlowIdx
);

always @ ( iMop )
begin
	case ( iMop )
		8'h7C: oUopFlowIdx = 9'd16;		  //BIT7
		8'h11: oUopFlowIdx = 9'd69;		  //RLr_b
		8'h38: oUopFlowIdx = 9'd505;		//SRL_b
		`RRr_a,`RRr_b, `RRr_c, `RRr_d, `RRr_e, `RRr_h,	`RRr_l: oUopFlowIdx = 9'd509;		//RR

	default:
			oUopFlowIdx = 9'd0;
	endcase
end



endmodule




module dzcpu_ucode_rom
(
	input  wire[9:0]  iAddr,
	output reg [14:0]  oUop
);
always @ ( iAddr )
begin
	case ( iAddr )
	//Regular 1 Byte mOp
		0: oUop = { `inc_eof_fu, `z801bop , `a };
	//LDSPnn
		1: oUop = { `inc, `sma, `pc   };
		2: oUop = { `inc, `nop, `null };
		3: oUop = { `op , `srm, `spl  };
		4: oUop = { `inc_eof , `srm, `sph };
	//LDHLnn
		5: oUop = { `inc, `sma, `pc   };
		6: oUop = { `inc, `nop, `null };
		7: oUop = { `op , `srm, `l    };
		8: oUop = { `inc_eof , `srm, `h    };
	//LDHLDA
		9:  oUop = { `op,  `sma,   `hl };
		10: oUop = { `op,  `smw,   `a  };
		11: oUop = { `inc, `sma,   `pc };
		12: oUop = { `eof, `dec16, `hl };
	//MAPcb 0xCB
		13: oUop = { `inc, `sma, `pc   };
		14: oUop = { `op,  `nop, `null };
		15: oUop = { `inc, `jcb, `null };
	//BIT
		16: oUop = { `eof_fu, `bit, `null };
	//JRNZ
		17: oUop = { `inc, `sma, `pc   };
		18: oUop = { `op,  `nop, `null };
		19: oUop = { `inc_eof_z,  `srm, `x8 }; 	//If z return else x8 = MEM[pc]
		20: oUop = { `op,  `sx16r, `pc };  		//x16 = pc
		21: oUop = { `op,`addx16, `x8  };       //x16 = x16 + sign_extend{8'b0,x8}
		22: oUop = { `eof, `spc, `x16  };  		//pc = x16
	//LDrn_c
		23: oUop = {`inc, `sma, `pc};
		24: oUop = { `inc,  `nop, `null };
		25: oUop = {`eof, `srm,  `c };
	//LDrn_a
		26: oUop = {`inc, `sma, `pc};
		27: oUop = { `inc,  `nop, `null };
		28: oUop = {`eof, `srm,  `a };
	//LDIOCA
		29: oUop = {`op, `sma, `io_c };
		30: oUop = {`op, `smw, `a }; //I am missing a NOP
		31: oUop = {`inc_eof, `sma, `pc };
	//INCr_c
		32: oUop = {`inc_eof_fu, `inc16, `c };
	//LDHLmr_a
		33: oUop = {`inc, `sma, `hl  };
		34: oUop = {`op, `smw, `a    };
		35: oUop = {`eof, `sma, `pc  };
	//Unused
		36: oUop = { `inc, `sma, `pc  };
		37: oUop = { `op ,`sx8r, `c   };
		38: oUop = { `op ,`srm, `c    };
		39: oUop = { `op, `sma, `io_c }; //I am missing a NOP
		40: oUop = { `op, `smw, `a    };
		41: oUop = { `inc, `srx8, `c  };
		42: oUop = { `eof, `sma, `pc  };
	//LDDEnn
		43: oUop = { `inc, `sma, `pc   };
		44: oUop = { `inc, `nop, `null };
		45: oUop = { `op , `srm, `e    };
		46: oUop = { `inc_eof , `srm, `d };
	//DECr_a
		47:	oUop = { `inc_eof_fu, `dec16,    `a  };
	//DECr_c
		48:	oUop = { `inc_eof_fu, `dec16,    `c  };
	//CALLnn
		49: oUop = { `inc, `dec16,  `sp  };
		50: oUop = { `inc, `sx16r,  `hl  };
		51: oUop = { `op , `srm,    `l   }; //l = MEM[pc] = literal
		52: oUop = { `inc, `srm,    `h   }; //l = MEM[pc] = literal
		53: oUop = { `op,  `sma,    `sp  };
		54: oUop = { `op,  `smw,    `pch };	//MEM[sp] = pc[7:0]
		55: oUop = { `op,  `dec16,  `sp  };
		56: oUop = { `op , `smw,    `pc  };	//MEM[sp+1] = pc[15:8]
		57: oUop = { `op , `spc,    `hl  };
		58: oUop = { `op, `srx16,  `hl  };
		59: oUop = { `eof ,`sma,   `pc   };
	//LDrn_b
		60: oUop = { `inc, `sma, `pc   };
		61: oUop = { `inc, `nop, `null };
		62: oUop = { `eof , `srm, `b   };
	//PUSHBC
		63: oUop = { `op, `dec16,  `sp  };
		64: oUop = { `op, `sma,    `sp  };
		65: oUop = { `op ,`smw,    `b   };
		66: oUop = { `op, `dec16,  `sp  };
		67: oUop = { `op ,`smw,     `c  };
		68: oUop = { `inc_eof ,`sma,`pc };
	//RLr_r
		69: oUop = { `eof_fu, `shl,  `null  };
	//RLA
		70: oUop = { `inc_eof_fu, `shl,  `null  };
	//POPBC
		71: oUop = { `op, `sma,    `sp   };
		72: oUop = { `op ,`inc16,  `sp   };
		73: oUop = { `op ,`srm,    `c    };
		74: oUop = { `op ,`srm,    `b    };
		75: oUop = { `inc ,`inc16,  `sp  };
		76: oUop = { `eof, `sma,    `pc  };
	//UNUSED: You cannot have a eof, followed by another eof, if you do, then the second inst will
	//also execute!!!
		77:	oUop = { `op, `nop,    `null  };
	//LDHLIA
		78: oUop = {`op, `sma, `hl  };
		79: oUop = {`op, `smw, `a    };
		80: oUop = { `inc ,`inc16,  `hl };
		81: oUop = {`eof, `sma, `pc  };
	//INCHL
		82: oUop = { `inc_eof ,`inc16,  `hl };
	//INCBC
	  83: oUop = { `inc_eof ,`inc16,  `bc   };		//flags might be wrong for 16bits
  //UNUSED
		84: oUop = { `op, `nop, `null  };

	//ANDn
		85: oUop = { `inc, `sma,  `pc };
		86: oUop = { `op, `nop , `null };
		87: oUop = { `update_flags ,`anda,    `idata  };
		88: oUop = { `inc_eof ,`nop,    `null  };

	//INCDE
		89: oUop = { `inc_eof, `inc16, `de };
	//CPn
		90: oUop = { `inc, `sx16r, `a };
		91: oUop = { `op, `nop, `null };
		92: oUop = { `op, `srm, `x8   };
		93: oUop = { `inc_eof_fu, `subx16, `x8   };	//x16 = x16 - x8 -> a = a - lit
//LDADEm
		94: oUop = {`inc, `sma, `de  };
		95: oUop = {`op, `nop, `null };
		96: oUop = {`op, `srm, `a    };
		97: oUop = {`eof, `sma, `pc  };
//LDmmA
		98: oUop = {`inc, `sx16r,  `hl };
		99: oUop = {`inc,  `sma,   `pc };
		100: oUop = {`op,   `srm,   `l  };
		101: oUop = {`op,   `srm,   `h  };
		102: oUop = {`op,   `sma,   `hl };
		103: oUop = {`op,   `smw,   `a  };
		104: oUop = {`inc,  `sma,   `pc };
		105: oUop = {`eof,  `srx16, `hl };
//JRZn
		106: oUop = { `inc, `sma, `pc   };
		107: oUop = { `op,  `nop, `null };
		108: oUop = { `inc_eof_nz, `srm, `x8 }; 	//If not z return else x8 = MEM[pc]
		109: oUop = { `op,  `sx16r, `pc };  		//x16 = pc
		110: oUop = { `op,`addx16, `x8  };       //x16 = x16 + sign_extend{8'b0,x8}
		111: oUop = { `eof, `spc, `x16  };  		//pc = x16
//LDrn_l
		112: oUop = {`inc, `sma, `pc     };
		113: oUop = { `inc,  `nop, `null };
		114: oUop = {`eof, `srm,  `l     };
//JRn
		115: oUop = { `inc, `sma, `pc   };
		116: oUop = { `op,  `nop, `null };
		117: oUop = { `inc, `srm, `x8   };
		118: oUop = { `op,  `sx16r, `pc };       //x16 = pc
		119: oUop = { `op,`addx16, `x8  };       //x16 = x16 + sign_extend{8'b0,x8}
		120: oUop = { `eof, `spc, `x16  };       //pc = x16
//LDrn_e
		121: oUop = {`inc, `sma, `pc     };
		122: oUop = { `inc,  `nop, `null };
		123: oUop = {`eof, `srm,  `e     };
//UNUSED
		124: oUop = { `inc, `sx8r, `c    };
		125: oUop = { `op,  `nop,  `null };
		126: oUop = { `op,  `srm,  `c    };
		127: oUop = { `op,   `sma, `io_c };
		128: oUop = { `op,   `srm,  `a   };
		129: oUop = { `op,   `srx8, `c   };
		130: oUop = { `inc_eof, `sma, `pc };
//UNUSED
		131: oUop = { `op, `nop, `null };
//SUBr_b
		132: oUop = { `op, `sx16r, `a       };
		133: oUop = { `update_flags, `subx16, `b      };
		134: oUop = { `inc_eof, `srx16, `a  };
//DECr_d
		135:	oUop = { `inc_eof_fu, `dec16,    `d  };
//LDrn_d
		136: oUop = {`inc, `sma, `pc     };
		137: oUop = { `inc,  `nop, `null };
		138: oUop = {`eof, `srm,  `d     };
//JPnn
		139: oUop = {`op, `sx16r,  `hl };
		140: oUop = {`inc,  `sma,   `pc };
		141: oUop = {`inc,  `nop, `null };
		142: oUop = {`inc,   `srm,   `l  };
		143: oUop = {`op,   `srm,   `h  };
		144: oUop = {`op,   `spc,   `hl  };
		145: oUop = {`eof,  `srx16, `hl };
//LDrn_h
		146: oUop = {`inc, `sma, `pc     };
		147: oUop = { `inc,  `nop, `null };
		148: oUop = {`eof, `srm,  `h     };
//LDAHLI
		149: oUop = {`op, `sma, `hl  };
		150: oUop = {`op,  `nop, `null };
		151: oUop = {`op, `srm, `a    };
		152: oUop = { `inc ,`inc16,  `hl };
		153: oUop = {`eof, `sma, `pc  };
//LDHLmn
		154: oUop = {`inc,  `sma,   `pc };
		155: oUop = {`op,  `nop, `null };
		156: oUop = {`op,   `srm,   `x8  };
		157: oUop = {`op,   `sma,   `hl };
		158: oUop = {`op,  `nop, `null };
		159: oUop = {`op,   `smw,   `x8  };
		160: oUop = {`inc_eof,  `sma,   `pc };
//INCR_b
		161: oUop = {`inc_eof_fu, `inc16, `b };

//NOP
		162: oUop = { `inc_eof, `nop, `null };
//DI
		163: oUop = { `inc_eof, `ceti, `null }; //Disable Interruption
//INCr_d
		164: oUop = { `update_flags, `inc16, `d };
		165: oUop = { `inc_eof,  `nop, `null };
//DECr_e
		166: oUop = { `update_flags, `dec16, `e };
		167: oUop = { `inc_eof,  `nop, `null };
//DECDE
		168: oUop = { `inc_eof, `dec16, `de };
//DECBC
		169: oUop = { `inc_eof,  `dec16, `bc};
//DECr_h
		170: oUop = { `update_flags, `dec16, `h };
		171: oUop = { `inc_eof,  `nop, `null };
//DECHL
		172: oUop = { `inc_eof, `dec16, `hl };
//JPHL
		173: oUop = { `op,  `nop, `null };
		174: oUop = { `eof,  `spc, `hl };
//ADDr_a
		175: oUop = { `op, `sx16r, `a       };
		176: oUop = { `update_flags, `addx16u, `a };
		177: oUop = { `inc_eof, `srx16, `a  };
//ADDr_b
		178: oUop = { `op, `sx16r, `a       };
		179: oUop = { `update_flags, `addx16u, `b };
		180: oUop = { `inc_eof, `srx16, `a  };
//SUBr_c
		181: oUop = { `op, `sx16r, `a       };
		182: oUop = { `update_flags, `subx16, `c      };
		183: oUop = { `inc_eof, `srx16, `a  };

//ADDr_c
		184: oUop = { `op, `sx16r, `a       };
		185: oUop = { `update_flags, `addx16u, `c };
		186: oUop = { `inc_eof, `srx16, `a  };

//ADDr_d
		187: oUop = { `op, `sx16r, `a       };
		188: oUop = { `update_flags, `addx16u, `d };
		189: oUop = { `inc_eof, `srx16, `a  };

//ADDr_e
		190: oUop = { `op, `sx16r, `a       };
		191: oUop = { `update_flags, `addx16u, `e };
		192: oUop = { `inc_eof, `srx16, `a  };

//ADDr_h
		193: oUop = { `op, `sx16r, `a       };
		194: oUop = { `update_flags, `addx16u, `h };
		195: oUop = { `inc_eof, `srx16, `a  };

//ADDr_l
		196: oUop = { `op, `sx16r, `a       };
		197: oUop = { `update_flags, `addx16u, `l };
		198: oUop = { `inc_eof, `srx16, `a  };
//SUBr_d
		199: oUop = { `op, `sx16r, `a       };
		200: oUop = { `update_flags, `subx16, `d      };
		201: oUop = { `inc_eof, `srx16, `a  };
//SUBr_e
		202: oUop = { `op, `sx16r, `a       };
		203: oUop = { `update_flags, `subx16, `e      };
		204: oUop = { `inc_eof, `srx16, `a  };
//SUBr_h
		205: oUop = { `op, `sx16r, `a       };
		206: oUop = { `update_flags, `subx16, `h      };
		207: oUop = { `inc_eof, `srx16, `a  };
//SUBr_l
		208: oUop = { `op, `sx16r, `a       };
		209: oUop = { `update_flags, `subx16, `l      };
		210: oUop = { `inc_eof, `srx16, `a  };
//SUB_a
		211: oUop = { `op, `sx16r, `a       };
		212: oUop = { `update_flags, `subx16, `a      };
		213: oUop = { `inc_eof, `srx16, `a  };
//PUSHDE
		214: oUop = { `op, `dec16,  `sp  };
		215: oUop = { `op, `sma,    `sp  };
		216: oUop = { `op ,`smw,    `d   };
		217: oUop = { `op, `dec16,  `sp  };
		218: oUop = { `op ,`smw,     `e  };
		219: oUop = { `inc_eof ,`sma,`pc };
//PUSHHL
		220: oUop = { `op, `dec16,  `sp  };
		221: oUop = { `op, `sma,    `sp  };
		222: oUop = { `op ,`smw,    `h   };
		223: oUop = { `op, `dec16,  `sp  };
		224: oUop = { `op ,`smw,     `l  };
		225: oUop = { `inc_eof ,`sma,`pc };
//POPDE
		226: oUop = { `op, `sma,    `sp   };
		227: oUop = { `op ,`inc16,  `sp   };
		228: oUop = { `op ,`srm,    `e    };
		229: oUop = { `op ,`srm,    `d    };
		230: oUop = { `inc ,`inc16,  `sp  };
		231: oUop = { `eof, `sma,    `pc  };
//POPHL
		232: oUop = { `op, `sma,    `sp   };
		233: oUop = { `op ,`inc16,  `sp   };
		234: oUop = { `op ,`srm,    `l    };
		235: oUop = { `op ,`srm,    `h    };
		236: oUop = { `inc ,`inc16,  `sp  };
		237: oUop = { `eof, `sma,    `pc  };
//LDHLmr_b
		238: oUop = {`inc, `sma, `hl  };
		239: oUop = {`op, `smw, `b    };
		240: oUop = {`eof, `sma, `pc  };
//LDHLmr_c
		241: oUop = {`inc, `sma, `hl  };
		242: oUop = {`op, `smw, `c    };
		243: oUop = {`eof, `sma, `pc  };
//LDHLmr_d
		244: oUop = {`inc, `sma, `hl  };
		245: oUop = {`op, `smw, `d    };
		246: oUop = {`eof, `sma, `pc  };
//LDDEmA
		247: oUop = {`op, `sma, `de  };
		248: oUop = {`op, `smw, `a    };
		249: oUop = {`inc_eof, `sma, `pc    };
//INCr_e
    250:  oUop = { `update_flags, `inc16, `e };
		251:  oUop = { `inc_eof, `nop, `null };

//RET
		252: oUop = {`op ,`sma,  `sp   };
		253: oUop = {`op, `sx16r,  `hl };
		254: oUop = {`op, `inc16, `sp  };
		255: oUop = {`op,   `srm,   `l  };
		256: oUop = {`op,   `srm,   `h  };
		257: oUop = {`op,   `spc,   `hl  };
		258: oUop = {`op,  `srx16, `hl };
		259: oUop = {`op, `inc16, `sp  };
		260: oUop = { `eof ,`sma,  `pc   };

//PUSHAF
		261: oUop = { `op, `dec16,  `sp  };
		262: oUop = { `op, `sma,    `sp  };
		263: oUop = { `op ,`smw,    `a   };
		264: oUop = { `op, `dec16,  `sp  };
		265: oUop = { `op ,`smw,     `f  };
		266: oUop = { `inc_eof ,`sma,`pc };

//POPAF
		267: oUop = { `op, `sma,    `sp   };
		268: oUop = { `op ,`inc16,  `sp   };
		269: oUop = { `op ,`srm,    `f    };
		270: oUop = { `op ,`srm,    `a    };
		271: oUop = { `inc ,`inc16,  `sp  };
		272: oUop = { `eof, `sma,    `pc  };
//LDBCnn
		273: oUop = { `inc, `sma, `pc   };
		274: oUop = { `inc, `nop, `null };
	  275: oUop = { `op , `srm, `c    };
		276: oUop = { `inc_eof , `srm, `b    };
//INCBC
		277: oUop = { `inc_eof ,`inc16,  `bc };
//Z80 1 Byte op
    278: oUop = { `update_flags, `z801bop , `a };
		279: oUop = { `inc_eof, `nop , `null };
//LDAmm
	  280: oUop = { `inc, `sx16r,  `hl };
		281: oUop = { `inc, `sma , `pc };
		282: oUop = { `op ,`srm,    `l  };
		283: oUop = { `op ,`srm,    `h  };
		284: oUop = { `op, `sma ,   `hl };
		285: oUop = { `op, `nop ,   `null };	//remember to wait 1cc after sma
		286: oUop = { `op ,`srm,    `a  };
		287: oUop = { `op, `srx16,  `hl };
		288: oUop = { `inc_eof, `sma , `pc };
//CALLNZnn *** TODO BUG
		289: oUop = { `inc,  `nop,  `null  };
		290: oUop = { `inc,  `nop,  `null  };
		291: oUop = { `op , `srm,    `y8   }; //l = MEM[pc] = literal
		292: oUop = { `inc_eof_z, `srm, `x8   }; //l = MEM[pc] = literal
		293: oUop = { `op,  `dec16,  `sp  };
		294: oUop = { `op,  `sma,    `sp  };
		295: oUop = { `op,  `smw,    `pch };	//MEM[sp] = pc[7:0]
		296: oUop = { `op,  `dec16,  `sp  };
		297: oUop = { `op , `smw,    `pc  };	//MEM[sp+1] = pc[15:8]
		298: oUop = { `op , `spc,    `xy16  };
		299: oUop = { `eof ,`sma,   `pc   };
//DECr_b
		300:	oUop = { `update_flags, `dec16,    `b  };
		301:  oUop = { `inc_eof, `nop, `null};
//INCr_a
		302: oUop = { `update_flags, `inc16, `a };
		303:  oUop = { `inc_eof, `nop, `null};
//INCSP
		304: oUop = { `op, `inc16, `sp };  //increment SP
		305:  oUop = { `inc_eof, `nop, `null};
//DECSP
		306: oUop = { `inc_eof, `dec16, `sp };
//UNUSED
		307:  oUop = { `op, `nop, `null};
//INCr_l
		308: oUop = { `update_flags, `inc16, `l };
		309:  oUop = { `inc_eof, `nop, `null};
//DECr_l
		310: oUop = { `update_flags, `dec16, `l };
		311:  oUop = { `inc_eof, `nop, `null};
//INCr_h
    312: oUop = { `update_flags, `inc16, `h };
		313:  oUop = { `inc_eof, `nop, `null};
//ADDn
		314: oUop = { `inc, `sma, `pc   };
		315: oUop = { `op,  `nop, `null };
		316: oUop = { `op,  `srm, `x16 };
		317: oUop = { `update_flags,  `addx16u, `a };
		318: oUop = { `inc_eof, `srx16, `a};
//SUBn
		319: oUop = { `inc, `sma, `pc   };
		320: oUop = { `op,  `sx16r, `a };
		321: oUop = { `op,  `srm, `x8 };
		322: oUop = { `update_flags,  `subx16, `x8 };
		323: oUop = { `inc_eof, `srx16, `a};
//CPr_c
		324: oUop = { `op,  `sx16r, `a };
		325: oUop = { `update_flags,  `subx16, `c };
		326: oUop = { `inc_eof, `nop, `null};
//LDrHLm_b
		327:  oUop = { `op,  `sma,   `hl };
		328:  oUop = { `op,  `nop,   `null };
		329:  oUop = { `op,  `srm,   `b };
		330:  oUop = { `inc_eof, `sma, `pc};
//LDrHLm_c
		331:  oUop = { `op,  `sma,   `hl };
		332:  oUop = { `op,  `nop,   `null };
		333:  oUop = { `op,  `srm,   `c };
		334:  oUop = { `inc_eof, `sma, `pc};
//LDrHLm_d
		335:  oUop = { `op,  `sma,   `hl };
		336:  oUop = { `op,  `nop,   `null };
		337:  oUop = { `op,  `srm,   `d };
		338:  oUop = { `inc_eof, `sma, `pc};
//XORHL
		339:  oUop = { `op,  `sma,   `hl   };
		340:  oUop = { `op,  `nop,   `null };
		341:  oUop = { `op,  `srm,   `x16  };
		342:  oUop = { `update_flags, `xorx16, `a};
		343:  oUop = { `op, `srx16, `a};
		344:  oUop = { `inc_eof, `sma, `pc};
//ADCn
		345:  oUop = { `inc,  `sma,   `pc   };
		346:  oUop = { `op,  `nop,   `null };
		347:  oUop = { `op,  `srm,   `x16  };
		348:  oUop = { `update_flags,  `addx16c,   `a };
		349:  oUop = { `op,  `nop,   `null  };
		350:  oUop = { `inc_eof, `srx16, `a};
//ADDHLDE
		351:  oUop = { `inc,  `sx16r,   `hl   };
		352:  oUop = { `update_flags,  `addx16,   `de   };
		353:  oUop = { `eof,  `srx16,   `hl   };
//JPNZnn
		354: oUop = { `inc,  `nop,  `null  };
		355: oUop = { `inc,  `nop,  `null  };
		356: oUop = { `op , `srm,    `y8   }; //l = MEM[pc] = literal
		357: oUop = { `inc_eof_z, `srm, `x8   }; //l = MEM[pc] = literal
		358: oUop = { `eof , `spc,    `xy16  };
//XORn
		359: oUop = { `inc, `sma,  `pc };
		360: oUop = { `op, `sx16r , `a };
		361: oUop = { `update_flags ,`xorx16, `idata  };
		362: oUop = { `inc_eof ,`srx16,  `a  };
//RRA
		363: oUop = { `update_flags, `rrot,  `null  };
		364: oUop = { `inc_eof, `nop,  `null  };
//RETNC
		365:  oUop = { `op, `xorx16, `x16 };
		366:  oUop = { `op,  `nop,   `null  };
		367:  oUop = { `inc_eof_c,  `srm, `x16 };
		368: oUop = {`op ,`sma,  `sp   };
		369: oUop = {`op, `sx16r,  `hl };
		370: oUop = {`op, `inc16, `sp  };
		371: oUop = {`op,   `srm,   `l  };
		372: oUop = {`op,   `srm,   `h  };
		373: oUop = {`op,   `spc,   `hl  };
		374: oUop = {`op,  `srx16, `hl };
		375: oUop = {`op, `inc16, `sp  };
		376: oUop = { `eof ,`sma,  `pc   };

//RETZ
		377: oUop = { `inc_eof_nz,  `nop, `null };
		378: oUop = {`op ,`sma,  `sp   };
		379: oUop = {`op, `sx16r,  `hl };
		380: oUop = {`op, `inc16, `sp  };
		381: oUop = {`op,   `srm,   `l  };
		382: oUop = {`op,   `srm,   `h  };
		383: oUop = {`op,   `spc,   `hl  };
		384: oUop = {`op,  `srx16, `hl };
		385: oUop = {`op, `inc16, `sp  };
		386: oUop = { `eof ,`sma,  `pc   };
//ORHL
		387: oUop = {`op ,`sma,  `hl   };
		388: oUop = {`op,  `nop,   `null };
		389: oUop = {`update_flags,   `ora,   `idata  };
		390: oUop = { `inc_eof ,`sma,  `pc   };
//DECHLm
		391: oUop = {`op ,`sma,  `hl   };
		392: oUop = {`op,  `nop,   `null };
		393: oUop = {`op,  `srm,   `x16  };
		394: oUop = {`update_flags,  `dec16,   `x16 };
		395: oUop = {`nop,  `smw,   `x16 };
		396: oUop = {`inc_eof,  `sma,   `pc };
//LDrHLm_l
		397: oUop = {`op ,`sma,  `hl   };
		398: oUop = {`op,  `nop,   `null };
		399: oUop = {`op,  `srm,   `l  };
		400: oUop = {`inc_eof,  `sma,   `pc };
//RETNZ
		401: oUop = { `inc_eof_z,  `nop, `null };
		402: oUop = {`op ,`sma,  `sp   };
		403: oUop = {`op, `sx16r,  `hl };
		404: oUop = {`op, `inc16, `sp  };
		405: oUop = {`op,   `srm,   `l  };
		406: oUop = {`op,   `srm,   `h  };
		407: oUop = {`op,   `spc,   `hl  };
		408: oUop = {`op,  `srx16, `hl };
		409: oUop = {`op, `inc16, `sp  };
		410: oUop = { `eof ,`sma,  `pc   };
//ADDHLHL
		411: oUop = {`op, `sx16r,  `hl   };
		412: oUop = {`update_flags, `addx16u,  `x16 };
		413: oUop = {`inc_eof, `srx16,  `hl   };

//JRNCn
		414:  oUop = { `inc,  `sma,   `pc   };
		415:  oUop = { `inc_eof_c, `sx16r, `pc };
		416:  oUop = { `op,  `addx16, `idata };
		417:  oUop = { `op,  `inc16, `x16 };
		418:  oUop = { `op,  `spc, `x16 }; //this is only low part of pc
		419:  oUop = { `eof,  `nop, `null };
//ANDHL
			420: oUop = { `inc, `sma,  `hl };
			421: oUop = { `op, `nop , `null };
			422: oUop = { `update_flags ,`anda,    `idata  };
			423: oUop = { `inc_eof ,`nop,    `null  };
//LDHLmr_e
			424: oUop = {`inc, `sma, `hl  };
			425: oUop = {`op, `smw, `e    };
			426: oUop = {`eof, `sma, `pc  };
//LDHLmr_h
			427: oUop = {`inc, `sma, `hl  };
			428: oUop = {`op, `smw, `h    };
			429: oUop = {`eof, `sma, `pc  };
//LDHLmr_h
			430: oUop = {`inc, `sma, `hl  };
			431: oUop = {`op, `smw, `l    };
			432: oUop = {`eof, `sma, `pc  };
//LDABCm
			433: oUop = {`inc, `sma, `bc  };
			434: oUop = {`op, `nop, `null };
			435: oUop = {`op, `srm, `a    };
			436: oUop = {`eof, `sma, `pc  };
//LDrHLm_a
			437: oUop = {`inc, `sma, `hl  };
			438: oUop = {`op, `nop, `null };
			439: oUop = {`op, `srm, `a    };
			440: oUop = {`eof, `sma, `pc  };
//LDrHLm_e
			441: oUop = {`inc, `sma, `hl  };
			442: oUop = {`op, `nop, `null };
			443: oUop = {`op, `srm, `e    };
			444: oUop = {`eof, `sma, `pc  };
//LDrHLm_e
			445: oUop = {`inc, `sma, `hl  };
			446: oUop = {`op, `nop, `null };
			447: oUop = {`op, `srm, `h    };
			448: oUop = {`eof, `sma, `pc  };
//ADCr_a
			449: oUop = { `op, `sx16r, `a  };
			450: oUop = { `op, `addx16, `carry };
			451: oUop = { `update_flags, `addx16, `a};
			452: oUop = { `inc_eof, `srx16, `a  };
//ADCr_b
			453: oUop = { `op, `sx16r, `a  };
			454: oUop = { `op, `addx16, `carry };
			455: oUop = { `update_flags, `addx16, `b};
			456: oUop = { `inc_eof, `srx16, `a  };
//ADCr_c
			457: oUop = { `op, `sx16r, `a  };
			458: oUop = { `op, `addx16, `carry };
			459: oUop = { `update_flags, `addx16, `c};
			460: oUop = { `inc_eof, `srx16, `a  };
//ADCr_d
			461: oUop = { `op, `sx16r, `a  };
			462: oUop = { `op, `addx16, `carry };
			463: oUop = { `update_flags, `addx16, `d};
			464: oUop = { `inc_eof, `srx16, `a  };
//ADCr_e
			465: oUop = { `op, `sx16r, `a  };
			466: oUop = { `op, `addx16, `carry };
			467: oUop = { `update_flags, `addx16, `e};
			468: oUop = { `inc_eof, `srx16, `a  };
//ADCr_h
			469: oUop = { `op, `sx16r, `a  };
			470: oUop = { `op, `addx16, `carry };
			471: oUop = { `update_flags, `addx16, `h};
			472: oUop = { `inc_eof, `srx16, `a  };
//ADCr_l
			473: oUop = { `op, `sx16r, `a  };
			474: oUop = { `op, `addx16, `carry };
			475: oUop = { `update_flags, `addx16, `l};
			476: oUop = { `inc_eof, `srx16, `a  };

//SBCr_a
			477: oUop = { `op, `sx16r, `a  };
			478: oUop = { `op, `subx16, `carry };
			479: oUop = { `update_flags, `subx16, `a};
			480: oUop = { `inc_eof, `srx16, `a  };
//SBCr_b
			481: oUop = { `op, `sx16r, `a  };
			482: oUop = { `op, `subx16, `carry };
			483: oUop = { `update_flags, `subx16, `b};
			484: oUop = { `inc_eof, `srx16, `a  };
//SBCr_c
			485: oUop = { `op, `sx16r, `a  };
			486: oUop = { `op, `subx16, `carry };
			487: oUop = { `update_flags, `subx16, `c};
			488: oUop = { `inc_eof, `srx16, `a  };
//SBCr_d
			489: oUop = { `op, `sx16r, `a  };
			490: oUop = { `op, `subx16, `carry };
			491: oUop = { `update_flags, `subx16, `d};
			492: oUop = { `inc_eof, `srx16, `a  };
//SBCr_e
			493: oUop = { `op, `sx16r, `a  };
			494: oUop = { `op, `subx16, `carry };
			495: oUop = { `update_flags, `subx16, `e};
			496: oUop = { `inc_eof, `srx16, `a  };
//SBCr_h
			497: oUop = { `op, `sx16r, `a  };
			498: oUop = { `op, `subx16, `carry };
			499: oUop = { `update_flags, `subx16, `h};
			500: oUop = { `inc_eof, `srx16, `a  };
//SBCr_l
			501: oUop = { `op, `sx16r, `a  };
			502: oUop = { `op, `subx16, `carry };
			503: oUop = { `update_flags, `subx16, `l};
			504: oUop = { `inc_eof, `srx16, `a  };

//CB SHR
		  505: oUop = { `update_flags, `shr,  `null  };
			506: oUop = { `eof, `nop, `null  };

//CB SHL
		  507: oUop = { `update_flags, `shl,  `null  };
			508: oUop = { `eof, `nop, `null  };
//CB RROT
			509: oUop = { `update_flags, `rrot,  `null  };
			510: oUop = { `eof, `nop,  `null  };
//UNUSED
//EI
      511:
		  begin
	 			//$display("%dns %h : INT ENABLE!!!!!!!!!!!!!!!!!!!!!!!!!!!!!",$time, iAddr);
		 		oUop = { `inc_eof, `seti, `null };
		  end

	//LDHLSPn
			512: oUop = { `inc, `sma, `pc   };
			513: oUop = { `op, `sx16r, `sp  };
			514: oUop = { `update_flags,`addx16, `idata  };
			515: oUop = { `inc_eof,`srx16, `hl   };
//FLOW_ID_INTERRUPT
			516: oUop = { `inc, `dec16,  `sp  };
			517: oUop = { `op,  `sma,    `sp  };
			518: oUop = { `op,  `smw,    `pch };	//MEM[sp] = pc[7:0]
			519: oUop = { `op,  `dec16,  `sp  };
			520: oUop = { `op , `smw,    `pc  };	//MEM[sp+1] = pc[15:8]
			//Clean iflags 0xff0f
			521: oUop = { `op,   `xorx16, `x16 };
			522: oUop = { `op , `sma,    `int_flags_adr  };
			523: oUop = { `op , `smw,    `x16  };
			524: oUop = { `op , `jint,    `null  };
			525: oUop = { `eof , `sma,    `pc  };
	//LDIOnA
			526: oUop = { `inc, `sma, `pc  };
			527: oUop = { `op ,`sx8r, `c   };
			528: oUop = { `op ,`srm, `c    };
			529: oUop = { `op, `sma, `io_c }; //I am missing a NOP
			530: oUop = { `op,`nop, `null  };
			531: oUop = { `op, `smw, `a    };
			532: oUop = { `inc, `srx8, `c  };
			533: oUop = { `eof, `sma, `pc  };
	//LDAIOn
			534: oUop = { `inc, `sx8r, `c    };
			535: oUop = { `op,  `nop,  `null };
			536: oUop = { `op,  `srm,  `c    };
			537: oUop = { `op,   `sma, `io_c };
			538: oUop = { `op,`nop, `null  };
			539: oUop = { `op,   `srm,  `a   };
			540: oUop = { `op,   `srx8, `c   };
			541: oUop = { `inc_eof, `sma, `pc };
	//JPZnn
			542: oUop = { `inc,  `nop,  `null  };
			543: oUop = { `inc,  `nop,  `null  };
			544: oUop = { `op , `srm,    `y8   }; //l = MEM[pc] = literal
			545: oUop = { `inc_eof_nz, `srm, `x8 }; //l = MEM[pc] = literal
			546: oUop = { `eof , `spc,  `xy16  };
	//HALT
			547: oUop = { `op, `hlt,  `null };
			548: oUop = { `inc_eof, `nop, `null };
	//RETC
			549: oUop = { `inc_eof_nc, `nop, `null };
			550: oUop = { `op,   `sma,     `sp     };
			551: oUop = { `op,   `sx16r,   `hl     };
			552: oUop = { `op,   `inc16,   `sp     };
			553: oUop = { `op,   `srm,     `l      };
			554: oUop = { `op,   `srm,     `h      };
			555: oUop = { `op,   `spc,     `hl     };
			556: oUop = { `op,   `srx16,   `hl     };
			557: oUop = { `op,   `inc16,   `sp     };
			558: oUop = { `eof,  `sma,     `pc     };
	//JPCnn
			559: oUop = { `inc,   `nop,   `null  };
			560: oUop = { `inc,   `nop,   `null  };
			561: oUop = { `op ,   `srm,    `y8   }; //l = MEM[pc] = literal
			562: oUop = { `inc_eof_nc, `srm, `x8 }; //l = MEM[pc] = literal
			563: oUop = { `eof ,  `spc,   `xy16  };
	//INCHLm
			564: oUop = { `op  , `sma  ,  `hl     }; //control to hl
			565: oUop = { `op  , `nop,   `null    }; //control to hl
			566: oUop = { `op  , `srm  ,  `x8     }; //recuperar cont. de memoria(hl)
			567: oUop = { `op  , `inc16,  `x8     };
			568: oUop = { `inc  , `smw  ,  `x8     };
			569: oUop = { `eof , `sma  ,  `pc     };//control to pc
	//RETI
			570: oUop = { `op,   `sma,     `sp     };//control to sp
			571: oUop = { `op,   `sx16r,   `hl     };//backup hl
			572: oUop = { `op,   `inc16,   `sp     };//pop
			573: oUop = { `op,   `srm,     `l      };//load sp to l
			574: oUop = { `op,   `srm,     `h      };//load sp+1 to h
			575: oUop = { `op,   `spc,     `hl     };//load (hl) to pc
			576: oUop = { `op,   `srx16,   `hl     };//
			577: oUop = { `op,   `inc16,   `sp     };//pop
			578: oUop = { `op,  `sma,     `pc      };//control to pc
			579: oUop = { `eof,   `seti,    `null	 };//enable interrupt
	//ADDHLSP
			580:  oUop = { `inc,  `sx16r,   `hl   };
			581:  oUop = { `update_flags,  `addx16,   `sp   };
			582:  oUop = { `eof,  `srx16,   `hl   };
	//ADDHLBC
			583:  oUop = { `inc,  `sx16r,   `hl   };
			584:  oUop = { `update_flags,  `addx16,   `bc   };
			585:  oUop = { `eof,  `srx16,   `hl   };

	//RLCA
			586:  oUop = { `op, `xorx16, `x16  };
			587:  oUop = { `op, `shl8,   `null  };
			588:  oUop = { `inc_eof_fu,  `addx16c_ext,  `a  };

	//LDmmSP
			589: oUop = {`inc, `sx16r,  `hl };
			590: oUop = {`inc,  `sma,   `pc };
			591: oUop = {`op,   `srm,   `l  };
			592: oUop = {`op,   `srm,   `h  };
			593: oUop = {`op,   `sma,   `hl };
			594: oUop = {`op,   `smw,   `spl  };
			595: oUop = {`op,   `inc16,   `hl  };
			596: oUop = {`op,   `smw,   `sph  };
			597: oUop = {`inc,  `sma,   `pc };
			598: oUop = {`op,  `srx16, `hl };
			599: oUop = {`op  , `nop,   `null};
			600: oUop = {`eof,  `nop, `null };
	//LDSPHL
			601:  oUop = {`inc, `sx16r,  `hl };
			602:  oUop = { `eof, `srx16,   `sp  };

	//ORn
			603: oUop = { `inc, `sma,  `pc };
			604: oUop = { `op, `nop , `null };
			605: oUop = { `update_flags ,`ora,    `idata  };
			606: oUop = { `inc_eof ,`nop,    `null  };
	//JRCn
			607: oUop = { `inc, `sma, `pc   };
			608: oUop = { `op,  `nop, `null };
			609: oUop = { `inc_eof_nc, `srm, `x8 }; 	//If not c return else x8 = MEM[pc]
			610: oUop = { `op,  `sx16r, `pc };  		//x16 = pc
			611: oUop = { `op,`addx16, `x8  };       //x16 = x16 + sign_extend{8'b0,x8}
			612: oUop = { `eof, `spc, `x16  };  		//pc = x16
	//STOP
			613: oUop = { `inc, `hlt,  `null };
			614: oUop = { `op, `nop,  `null };
			615: oUop = { `inc_eof, `nop, `null };
	//SBCn
			616: oUop = { `op, `sx16r, `a  };
			617: oUop = { `inc, `sma, `pc  };
			618: oUop = { `op, `subx16, `carry };
			619: oUop = { `update_flags, `subx16, `idata};
			620: oUop = { `inc_eof, `srx16, `a  };
	//LDAIOC
			621: oUop = {`op, `sma,  `io_c };
			622: oUop = {`op, `nop,  `null };
			623: oUop = {`op, `srm,  `a };
			624: oUop = {`inc_eof, `sma, `pc }; 

	default:
		oUop = {`op, `nop, `null };
	endcase
end


endmodule
