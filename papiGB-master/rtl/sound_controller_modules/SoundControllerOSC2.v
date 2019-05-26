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
// Sound module, channel 1. Squate waves with variable timer, frequency, envelope functions and frequency sweep. 
////////////////////////////////////////////////////////////////////////////////////

module osc2
	(
		input wire iClock,
		input wire iReset,
		output wire oOut131k,
		output wire oOut262k
	);

	reg [4:0] 	rOscCounter; // log2(4194204/131072*2) = log2(16)= 4. Last bit corresponds to the output.


	always @ (posedge iClock) begin
		if (iReset) begin
			rOscCounter <= 0;
		end
		else begin
			rOscCounter <= rOscCounter+1;
		end
	end

	assign oOut131k = rOscCounter[4];
	assign oOut262k = rOscCounter[3];

endmodule