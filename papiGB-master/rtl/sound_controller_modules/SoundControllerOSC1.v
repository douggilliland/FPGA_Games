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

module osc1
	(
		input wire iClock,
		input wire iReset,
		output wire oOut64,
		output wire oOut128,
		output wire oOut256
	);

	reg [16:0] 	rOscCounter; // log2(4194204/256) = log2(4194204)= 14. Last bit correspond to the output.


	always @ (posedge iClock) begin
		if (iReset) begin
			rOscCounter <= 0;
		end
		else begin
			rOscCounter <= rOscCounter+1;
		end
	end

	assign oOut64 = rOscCounter[15];
	assign oOut128 = rOscCounter[14];
	assign oOut256 = rOscCounter[13];

endmodule