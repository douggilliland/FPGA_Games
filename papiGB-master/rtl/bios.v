`timescale 1ns / 1ps
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

module bios
(
	input wire iClock,
	input wire [7:0] iAddr,
	output reg [7:0] oData
);


always @ ( posedge iClock )
begin
	case ( iAddr )
		8'd0: oData =  8'h31;
		8'd1: oData =  8'hFE;
		8'd2 : oData =  8'hFF;
		8'd3 : oData =  8'hAF;
		8'd4 : oData =  8'h21;
		8'd5 : oData =  8'hFF;
		8'd6 : oData =  8'h9F;
		8'd7 : oData =  8'h32;
		8'd8 : oData =  8'hCB;
		8'd9 : oData =  8'h7C;
		8'd10 : oData =  8'h20;
		8'd11 : oData =  8'hFB;
		8'd12 : oData =  8'h21;
		8'd13 : oData =  8'h26;
		8'd14 : oData =  8'hFF;
		8'd15 : oData =  8'h0E;
		8'd16 : oData =  8'h11;
		8'd17 : oData =  8'h3E;
		8'd18 : oData =  8'h80;
		8'd19 : oData =  8'h32;
		8'd20 : oData =  8'hE2;
		8'd21 : oData =  8'h0C;
		8'd22 : oData =  8'h3E;
		8'd23 : oData =  8'hF3;
		8'd24 : oData =  8'hE2;
		8'd25 : oData =  8'h32;
		8'd26 : oData =  8'h3E;
		8'd27 : oData =  8'h77;
		8'd28 : oData =  8'h77;
		8'd29 : oData =  8'h3E;
		8'd30 : oData =  8'hFC;
		8'd31 : oData =  8'hE0;
		8'd32 : oData =  8'h47;
		8'd33 : oData =  8'h11;
		8'd34 : oData =  8'h04;
		8'd35 : oData =  8'h01;
		8'd36 : oData =  8'h21;
		8'd37 : oData =  8'h10;
		8'd38 : oData =  8'h80;
		8'd39 : oData =  8'h1A;
		8'd40 : oData =  8'hCD;
		8'd41 : oData =  8'h95;
		8'd42 : oData =  8'h00;
		8'd43 : oData =  8'hCD;
		8'd44 : oData =  8'h96;
		8'd45 : oData =  8'h00;
		8'd46 : oData =  8'h13;
		8'd47 : oData =  8'h7B;
		8'd48 : oData =  8'hFE;
		8'd49 : oData =  8'h34;
		8'd50 : oData =  8'h20;
		8'd51 : oData =  8'hF3;
		8'd52 : oData =  8'h11;
		8'd53 : oData =  8'hD8;
		8'd54 : oData =  8'h00;
		8'd55 : oData =  8'h06;
		8'd56 : oData =  8'h08;
		8'd57 : oData =  8'h1A;
		8'd58 : oData =  8'h13;
		8'd59 : oData =  8'h22;
		8'd60 : oData =  8'h23;
		8'd61 : oData =  8'h05;
		8'd62 : oData =  8'h20;
		8'd63 : oData =  8'hF9;
		8'd64 : oData =  8'h3E;
		8'd65 : oData =  8'h19;
		8'd66 : oData =  8'hEA;
		8'd67 : oData =  8'h10;
		8'd68 : oData =  8'h99;
		8'd69 : oData =  8'h21;
		8'd70 : oData =  8'h2F;
		8'd71 : oData =  8'h99;
		8'd72 : oData =  8'h0E;
		8'd73 : oData =  8'h0C;
		8'd74 : oData =  8'h3D;
		8'd75 : oData =  8'h28;
		8'd76 : oData =  8'h08;
		8'd77 : oData =  8'h32;
		8'd78 : oData =  8'h0D;
		8'd79 : oData =  8'h20;
		8'd80 : oData =  8'hF9;
		8'd81 : oData =  8'h2E;
		8'd82 : oData =  8'h0F;
		8'd83 : oData =  8'h18;
		8'd84 : oData =  8'hF3;
		8'd85 : oData =  8'h67;
		8'd86 : oData =  8'h3E;
		8'd87 : oData =  8'h64;
		8'd88 : oData =  8'h57;
		8'd89 : oData =  8'hE0;
		8'd90 : oData =  8'h42;
		8'd91 : oData =  8'h3E;
		8'd92 : oData =  8'h91;
		8'd93 : oData =  8'hE0;
		8'd94 : oData =  8'h40;
		8'd95 : oData =  8'h04;
		8'd96 : oData =  8'h1E;
		8'd97 : oData =  8'h02;
		8'd98 : oData =  8'h0E;
		8'd99 : oData =  8'h0C;
		8'd100 : oData =  8'hF0;
		8'd101 : oData =  8'h44;
		8'd102 : oData =  8'hFE;
		8'd103 : oData =  8'h90;
		8'd104 : oData =  8'h20;
		8'd105 : oData =  8'hFA;
		8'd106 : oData =  8'h0D;
		8'd107 : oData =  8'h20;
		8'd108 : oData =  8'hF7;
		8'd109 : oData =  8'h1D;
		8'd110 : oData =  8'h20;
		8'd111 : oData =  8'hF2;
		8'd112 : oData =  8'h0E;
		8'd113 : oData =  8'h13;
		8'd114 : oData =  8'h24;
		8'd115 : oData =  8'h7C;
		8'd116 : oData =  8'h1E;
		8'd117 : oData =  8'h83;
		8'd118 : oData =  8'hFE;
		8'd119 : oData =  8'h62;
		8'd120 : oData =  8'h28;
		8'd121 : oData =  8'h06;
		8'd122 : oData =  8'h1E;
		8'd123 : oData =  8'hC1;
		8'd124 : oData =  8'hFE;
		8'd125 : oData =  8'h64;
		8'd126 : oData =  8'h20;
		8'd127 : oData =  8'h06;
		8'd128 : oData =  8'h7B;
		8'd129 : oData =  8'hE2;
		8'd130 : oData =  8'h0C;
		8'd131 : oData =  8'h3E;
		8'd132 : oData =  8'h87;
		8'd133 : oData =  8'hF2;
		8'd134 : oData =  8'hF0;
		8'd135 : oData =  8'h42;
		8'd136 : oData =  8'h90;
		8'd137 : oData =  8'hE0;
		8'd138 : oData =  8'h42;
		8'd139 : oData =  8'h15;
		8'd140 : oData =  8'h20;
		8'd141 : oData =  8'hD2;
		8'd142 : oData =  8'h05;
		8'd143 : oData =  8'h20;
		8'd144 : oData =  8'h4F;
		8'd145 : oData =  8'h16;
		8'd146 : oData =  8'h20;
		8'd147 : oData =  8'h18;
		8'd148 : oData =  8'hCB;
		8'd149 : oData =  8'h4F;
		8'd150 : oData =  8'h06;
		8'd151 : oData =  8'h04;
		8'd152 : oData =  8'hC5;
		8'd153 : oData =  8'hCB;
		8'd154 : oData =  8'h11;
		8'd155 : oData =  8'h17;
		8'd156 : oData =  8'hC1;
		8'd157 : oData =  8'hCB;
		8'd158 : oData =  8'h11;
		8'd159 : oData =  8'h17;
		8'd160 : oData =  8'h05;
		8'd161 : oData =  8'h20;
		8'd162 : oData =  8'hF5;
		8'd163 : oData =  8'h22;
		8'd164 : oData =  8'h23;
		8'd165 : oData =  8'h22;
		8'd166 : oData =  8'h23;
		8'd167 : oData =  8'hC9;
		8'd168 : oData =  8'hCE;
		8'd169 : oData =  8'hED;
		8'd170 : oData =  8'h66;
		8'd171 : oData =  8'h66;
		8'd172 : oData =  8'hCC;
		8'd173 : oData =  8'h0D;
		8'd174 : oData =  8'h00;
		8'd175 : oData =  8'h0B;
		8'd176 : oData =  8'h03;
		8'd177 : oData =  8'h73;
		8'd178 : oData =  8'h00;
		8'd179 : oData =  8'h83;
		8'd180 : oData =  8'h00;
		8'd181 : oData =  8'h0C;
		8'd182 : oData =  8'h00;
		8'd183 : oData =  8'h0D;
		8'd184 : oData =  8'h00;
		8'd185 : oData =  8'h08;
		8'd186 : oData =  8'h11;
		8'd187 : oData =  8'h1F;
		8'd188 : oData =  8'h88;
		8'd189 : oData =  8'h89;
		8'd190 : oData =  8'h00;
		8'd191 : oData =  8'h0E;
		8'd192 : oData =  8'hDC;
		8'd193 : oData =  8'hCC;
		8'd194 : oData =  8'h6E;
		8'd195 : oData =  8'hE6;
		8'd196 : oData =  8'hDD;
		8'd197 : oData =  8'hDD;
		8'd198 : oData =  8'hD9;
		8'd199 : oData =  8'h99;
		8'd200 : oData =  8'hBB;
		8'd201 : oData =  8'hBB;
		8'd202 : oData =  8'h67;
		8'd203 : oData =  8'h63;
		8'd204 : oData =  8'h6E;
		8'd205 : oData =  8'h0E;
		8'd206 : oData =  8'hEC;
		8'd207 : oData =  8'hCC;
		8'd208 : oData =  8'hDD;
		8'd209 : oData =  8'hDC;
		8'd210 : oData =  8'h99;
		8'd211 : oData =  8'h9F;
		8'd212 : oData =  8'hBB;
		8'd213 : oData =  8'hB9;
		8'd214 : oData =  8'h33;
		8'd215 : oData =  8'h3E;
		8'd216 : oData =  8'h3c;
		8'd217 : oData =  8'h42;
		8'd218 : oData =  8'hB9;
		8'd219 : oData =  8'hA5;
		8'd220 : oData =  8'hB9;
		8'd221 : oData =  8'hA5;
		8'd222 : oData =  8'h42;
		8'd223 : oData =  8'h3C;
		8'd224 : oData =  8'h21;
		8'd225 : oData =  8'h04;
		8'd226 : oData =  8'h01;
		8'd227 : oData =  8'h11;
		8'd228 : oData =  8'hA8;
		8'd229 : oData =  8'h00;
		8'd230 : oData =  8'h1A;
		8'd231 : oData =  8'h13;
		8'd232 : oData =  8'hBE;
		8'd233 : oData =  8'h20;
		8'd234 : oData =  8'hFE;
		8'd235 : oData =  8'h23;
		8'd236 : oData =  8'h7D;
		8'd237 : oData =  8'hFE;
		8'd238 : oData =  8'h34;
		8'd239 : oData =  8'h20;
		8'd240 : oData =  8'hF5;
		8'd241 : oData =  8'h06;
		8'd242 : oData =  8'h19;
		8'd243 : oData =  8'h78;
		8'd244 : oData =  8'h86;
		8'd245 : oData =  8'h23;
		8'd246 : oData =  8'h05;
		8'd247 : oData =  8'h20;
		8'd248 : oData =  8'hFB;
		8'd249 : oData =  8'h86;
		8'd250 : oData =  8'h20;
		8'd251 : oData =  8'hFE;
		8'd252 : oData =  8'h3E;
		8'd253 : oData =  8'h01;
		8'd254 : oData =  8'hE0;
		8'd255 : oData =  8'h50;
		default:
			oData = 8'h0;
	endcase
end


endmodule
