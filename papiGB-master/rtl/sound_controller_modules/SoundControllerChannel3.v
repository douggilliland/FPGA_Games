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
// Sound module, channel 3. Squate waves with variable timmer, configurable frequency and envelope functions.
////////////////////////////////////////////////////////////////////////////////////


module SoundCtrlChannel3 //parameters
  (
    input wire		iClock,			//CPU CLOCK, 4194304Hz
    input wire		iReset,
	input wire		iOsc256,		//OSC1 clock 256Hz    
    input wire		iOsc262k,		//OSC2 clock 131072Hz

    input wire [7:0] iNR30,
    input wire [7:0] iNR31,
    input wire [7:0] iNR32,
    input wire [7:0] iNR33,
    input wire [7:0] iNR34,

    output reg [4:0]	oOut, 
    output wire oOnFlag
  );


	reg [8:0] rLength;
 	reg [19:0] rLengthCounter;	
	reg rTimedMode;
 	reg rLengthComplete; 	// Channe disable.

	reg rTone;
	reg [10:0] rSoundFrequency;
	reg [10:0] rSoundFrequencyCounter;

	reg rChannelEnable;
	reg [1:0] rOutLevel;
	reg [3:0] rStep;
	reg [3:0] rStepScaled;

 	wire [4:0] up_value, down_value;

 	reg [4:0] rWaveRamIndex;
	reg rWaveRamHnL;

	reg [7:0] iWaveRam [0:31]; // Wave samples Ram 64 samples of 4 bits

	// triangular waveform
	///*
	always @ (posedge iClock) begin
		if (iReset) begin
			iWaveRam[0]=8'h01;
			iWaveRam[1]=8'h23;
			iWaveRam[2]=8'h45;
			iWaveRam[3]=8'h67;
			iWaveRam[4]=8'h89;
			iWaveRam[5]=8'hAB;
			iWaveRam[6]=8'hCD;
			iWaveRam[7]=8'hEF;
			iWaveRam[8]=8'hED;
			iWaveRam[9]=8'hCB;
			iWaveRam[10]=8'hA9;
			iWaveRam[11]=8'h87;
			iWaveRam[12]=8'h65;
			iWaveRam[13]=8'h43;
			iWaveRam[14]=8'h21;
			iWaveRam[15]=8'h00;
			iWaveRam[16]=8'h01;
			iWaveRam[17]=8'h23;
			iWaveRam[18]=8'h45;
			iWaveRam[19]=8'h67;
			iWaveRam[20]=8'h89;
			iWaveRam[21]=8'hAB;
			iWaveRam[22]=8'hCD;
			iWaveRam[23]=8'hEF;
			iWaveRam[24]=8'hED;
			iWaveRam[25]=8'hCB;
			iWaveRam[26]=8'hA9;
			iWaveRam[27]=8'h87;
			iWaveRam[28]=8'h65;
			iWaveRam[29]=8'h43;
			iWaveRam[30]=8'h21;
			iWaveRam[31]=8'h00;
		end
	end
	//*/

	// sawtooth waveform
	/*
	always @ (posedge iClock) begin
		if (iReset) begin
			iWaveRam[0]=8'hFE;
			iWaveRam[1]=8'hDC;
			iWaveRam[2]=8'hBA;
			iWaveRam[3]=8'h98;
			iWaveRam[4]=8'h76;
			iWaveRam[5]=8'h54;
			iWaveRam[6]=8'h32;
			iWaveRam[7]=8'h10;
			iWaveRam[8]=8'hFE;
			iWaveRam[9]=8'hDC;
			iWaveRam[10]=8'hBA;
			iWaveRam[11]=8'h98;
			iWaveRam[12]=8'h76;
			iWaveRam[13]=8'h54;
			iWaveRam[14]=8'h32;
			iWaveRam[15]=8'h10;
			iWaveRam[16]=8'hFE;
			iWaveRam[17]=8'hDC;
			iWaveRam[18]=8'hBA;
			iWaveRam[19]=8'h98;
			iWaveRam[20]=8'h76;
			iWaveRam[21]=8'h54;
			iWaveRam[22]=8'h32;
			iWaveRam[23]=8'h10;
			iWaveRam[24]=8'hFE;
			iWaveRam[25]=8'hDC;
			iWaveRam[26]=8'hBA;
			iWaveRam[27]=8'h98;
			iWaveRam[28]=8'h76;
			iWaveRam[29]=8'h54;
			iWaveRam[30]=8'h32;
			iWaveRam[31]=8'h10;			
		end
	end
	*/
 	
 	// register load
	always @(posedge iClock) begin
		if (iReset || iNR34[7]) begin // Register reload and counters restart.

			rChannelEnable	<= iNR30[7];

			rLength 		<= iNR31[7:0];
			rLengthCounter 	<= 256 - iNR31[7:0]; 	// Decrements to zero then load rLength.
			rLengthComplete <= 0;			// Disables channel when is asserted.

			rTimedMode 		<= iNR34[6];

			rOutLevel		<= iNR32[6:5];
			rStep			<= iWaveRam[0][3:0];
			rWaveRamIndex	<= 0;
			rWaveRamHnL		<= 1; // Indicates if low or high part have been read.

			rTone 			<= 0;
			rSoundFrequency[10:0] <= 2048-{iNR34[2:0],iNR33[7:0]};
			rSoundFrequencyCounter <= 2048-{iNR34[2:0],iNR33[7:0]}; 

		end
	end

	// wave ram reader
	always @ (posedge rTone) begin
		if (rChannelEnable) begin
			if (~rWaveRamHnL) begin	
				rStep <= iWaveRam[rWaveRamIndex][7:4];
				rWaveRamHnL <= ~rWaveRamHnL;
			end
			else begin
				rStep <= iWaveRam[rWaveRamIndex][3:0];
				rWaveRamHnL <= ~rWaveRamHnL;
				
				if (rWaveRamIndex == 5'd31) begin
					rWaveRamIndex <= rWaveRamIndex+1;
					rLengthComplete <= rTimedMode;			
				end
				else begin
					rWaveRamIndex <= rWaveRamIndex+1;
				end
			end
		end
		else begin
			rStep <= 4'b0;
		end	
	end

	// tone gen: generates the frecuency of the output.
	always @(posedge iOsc262k) begin
		if (rSoundFrequencyCounter ==0) begin
			rSoundFrequencyCounter <= rSoundFrequency;
			rTone <= ~rTone;
		end
		else begin
			rSoundFrequencyCounter <= rSoundFrequencyCounter-1;
		end
	end


	// timmer: enable or disable channel output.
	always @(posedge iOsc256) begin
		if (rLengthCounter == 0) begin
			rLengthCounter <= 256-rLength;
			rLengthComplete <= rTimedMode; // Disable channel only if timmer is enabled.
		end
		else begin
			rLengthCounter <= rLengthCounter-1;
		end
	end

	//re-map mux
	assign up_value = 5'd15 + rStepScaled;
	assign down_value = 5'd15 - rStepScaled;

	always @(posedge iClock) begin
		if (rLengthComplete) begin
			oOut[4:0] <= 5'd15;
		end
		else begin
			if (rTone) begin
				oOut[4:0] <= up_value[4:0];
			end
			else begin
				oOut[4:0] <= down_value[4:0];
			end
		end
	end


	// output level manager
	always @ (rOutLevel or rStep) begin
		case (rOutLevel[1:0])
			2'd0: rStepScaled = 0;
			2'd1: rStepScaled = rStep;
			2'd2: rStepScaled = rStep >> 1;
			2'd3: rStepScaled = rStep >> 2;
		endcase
	end

assign oOnFlag = rLengthComplete;

endmodule	
