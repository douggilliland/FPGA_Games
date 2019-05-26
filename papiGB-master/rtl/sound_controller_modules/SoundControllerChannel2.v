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


module SoundCtrlChannel2 //parameters
  (
    input wire		iClock,			//CPU CLOCK, 4194304Hz
    input wire		iReset,
    input wire		iOsc64,			//OSC1 clock 64Hz
	input wire		iOsc256,		//OSC1 clock 256Hz    
    input wire		iOsc262k,		//OSC2 clock 131072Hz

    input wire [7:0] iNR21,
    input wire [7:0] iNR22,
    input wire [7:0] iNR23,
    input wire [7:0] iNR24,            

    output reg [4:0]	oOut, 
    output wire oOnFlag    
  );

	reg [5:0] rLength;
 	reg [19:0] rLengthCounter;	
	reg [1:0] rDutyCycle;
	reg rTimedMode;
 	reg rLengthComplete; 	// Channe disable.

	reg rTone;
	reg [10:0] rSoundFrequency;
	reg [10:0] rSoundFrequencyCounter;

	reg [3:0] rStep;
	reg [18:0] rStepTime;
	reg [18:0] rStepCounter;
	reg [3:0] rInitialValue;
	reg rEvelopeMode;

 	wire [4:0] up_value, down_value;

 	// register load
	always @(posedge iClock) begin
		if (iReset || iNR24[7]) begin // Register reload and counters restart.

			rLength 		<= iNR21[5:0];
			rLengthCounter 	<= 64-iNR21[5:0]; 	// Decrements to zero then load rLength.
			rLengthComplete <= 0;			// Disables channel when is asserted.
			rDutyCycle		<= iNR21[7:6];
			rTimedMode <= iNR24[6];

			rStepTime		<= iNR22[2:0];
			rStepCounter 	<= iNR22[2:0]; // Decrements to zero then load rStepTime.
			rEvelopeMode	<= iNR22[3];
			rInitialValue	<= iNR22[7:4];
			rStep 			<= iNR22[7:4];

			rTone 			<= 0;
			rSoundFrequency[7:0] <= iNR23[7:0];
			rSoundFrequency[10:8] <= iNR24[2:0];
			rSoundFrequencyCounter <= 2048-{iNR24[2:0],iNR23[7:0]}; 

		end
	end

  	// step gen: generates the output amplitud value. 
  	always @(posedge iOsc64) begin
  		if (rStepTime != 0) begin 			// Check if channel is enabled.
	  		if (rStepCounter ==1 ) begin
	  			rStepCounter <= rStepTime; 	// Reset counter.
				if(rEvelopeMode) begin 		// Envelope mode.
					rStep <= ((rStep == 4'hF) ? rStep : rStep+1); //INCREASES ONLY IF STEP IF LOWER THAN TOP VALUE
				end
				else begin
					rStep <= ((rStep == 4'h0) ? rStep : rStep-1); //DECREASES ONLY IF STEP IF LOWER THAN BOTTOM VALUE
				end
	  		end
	  		else begin
	  			rStepCounter <= rStepCounter-1;
	  		end  	
	  	end
	end

	// tone gen: generates the frecuency of the output.
	always @(posedge iOsc262k) begin
		if (rSoundFrequencyCounter ==0) begin
			rSoundFrequencyCounter <= 2048-rSoundFrequency;
			rTone <= ~rTone;
		end
		else begin
			rSoundFrequencyCounter <= rSoundFrequencyCounter-1;
		end
	end


	// timmer: enable or disable channel output.
	always @(posedge iOsc256) begin
		if (rLengthCounter == 0) begin
			rLengthCounter <= 64-rLength;
			rLengthComplete <= rTimedMode; // Disable channel only if timmer is enabled.
		end
		else begin
			rLengthCounter <= rLengthCounter-1;
		end
	end

	//re-map mux
	assign up_value = 5'd15 + rStep;
	assign down_value = 5'd15 - rStep;

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

assign oOnFlag = rLengthComplete;	
endmodule	
