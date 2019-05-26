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
// Sound module, channel 2. Squate waves with variable timmer, configurable frequency and envelope functions.
////////////////////////////////////////////////////////////////////////////////////

module SoundCtrlMX //parameters
  (
    input wire		iClock,			//CPU CLOCK, 4194304Hz
    input wire		iReset,
    input wire		iOsc262k,		//OSC2 clock 131072Hz

    input wire [4:0] iOut1,   	// Channel 1.
    input wire [4:0] iOut2,	// Channel 2.
    input wire [4:0] iOut3,	// Channel 3.
    input wire [4:0] iOut4,	// Channel 4.

    input wire [7:0] iNR50,   	// Left/Right enable + Left/Right volume.
    input wire [7:0] iNR51,   	// Enable channel 1/2/3/4 in Left/Right.

    output reg [4:0] 	oSO1, 	// Left channel.
    output reg [4:0] 	oSO2, 	 // Right channel.

    output wire [1:0]	oChSel,
    output wire			oChClk
  );

reg [7:0] rNR50, rNR51;
reg [4:0] rSO1_PRE, rSO2_PRE;
reg rSer_clk; 			// 8kHz clock, used for serializer.
reg [1:0] rSer_sel; 		// Indicates which channel data were sent. 


//Registers load
always @ (posedge iClock) begin
	if (iReset) begin
		rNR50 <= iNR50;
		rNR51 <= iNR51;
		rSer_sel <= 2'b0;
		rSer_clk <= 1'b0;

		rSO1_PRE <= 5'd15;
		rSO2_PRE <= 5'd15;		

	end
end

//Serializer
always @ (posedge iOsc262k) begin
		rSer_clk <= ~rSer_clk; 	
		rSer_sel <= (~rSer_clk) ? rSer_sel + 1 : rSer_sel;
end

//Volume control
always @ (*) begin

	case (rSer_sel)
		2'd0: begin
			rSO1_PRE = (rNR51[0]) ? iOut1 : 5'd15;
			rSO2_PRE = (rNR51[4]) ? iOut1 : 5'd15; 
		end
		2'd1: begin
			rSO1_PRE = (rNR51[1]) ? iOut2 : 5'd15;
			rSO2_PRE = (rNR51[5]) ? iOut2 : 5'd15;
		end
		2'd2: begin
			rSO1_PRE = (rNR51[2]) ? iOut3 : 5'd15;
			rSO2_PRE = (rNR51[6]) ? iOut3 : 5'd15;
		end
		2'd3: begin
			rSO1_PRE = (rNR51[3]) ? iOut4 : 5'd15;
			rSO2_PRE = (rNR51[7]) ? iOut4 : 5'd15;
		end
		default: begin
			rSO1_PRE = 5'dX;
			rSO2_PRE = 5'dX;
		end
	endcase
	
	oSO1 = rSO1_PRE >> (3'd7-rNR50[2:0]);
	oSO2 = rSO1_PRE >> (3'd7-rNR50[6:4]);	

end

assign oChSel = rSer_sel;
assign oChClk = rSer_clk;

endmodule	
