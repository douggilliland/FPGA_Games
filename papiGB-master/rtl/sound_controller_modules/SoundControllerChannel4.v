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
// Sound module, channel 4. White noise generation module using LFSR.
////////////////////////////////////////////////////////////////////////////////////


module SoundCtrlChannel4 //parameters
  (
    input wire    iClock,     //CPU CLOCK, 4194304Hz
    input wire    iReset,
    input wire    iOsc64,     //OSC1 clock 64Hz
    input wire    iOsc256,    //OSC1 clock 256Hz

    input wire [7:0] iNR41,
    input wire [7:0] iNR42,
    input wire [7:0] iNR43,
    input wire [7:0] iNR44,            

    output reg [4:0]  oOut,
    output wire oOnFlag    
  );


  reg [5:0] rLength;
  reg [19:0] rLengthCounter;  
  reg rLengthComplete;  // Channe disable.

  wire rTone;

  reg [3:0] rStep;
  reg [18:0] rStepTime;
  reg [18:0] rStepCounter;
  reg [3:0] rInitialValue;
  reg rEvelopeMode;

  reg [2:0] rDivRatioFreq;
  reg [3:0] rShiftClockFreq;

  reg rPolCoutSteps;

  reg rClkDiv;
  reg [5:0] rDivRatioCounter;

  reg rCountPre;
  reg [14:0] rShiftCounter;

  reg rTimedMode;

  wire [4:0] up_value, down_value;

  // register load
  always @(posedge iClock) begin
    if (iReset || iNR44[7]) begin // Register reload and counters restart.

      rLength         <= iNR41[5:0];
      rLengthCounter  <= 64-iNR41[5:0];  // Decrements to zero then load rLength.
      rLengthComplete <= 0;     // Disables channel when is asserted.

      rStepTime   <= iNR42[2:0];
      rStepCounter  <= iNR42[2:0]; // Decrements to zero then load rStepTime.
      rEvelopeMode  <= iNR42[3];
      rInitialValue <= iNR42[7:4];
      rStep       <= iNR42[7:4];

      rDivRatioFreq <= iNR43[2:0];

//      rDivRatioCounter <= 6'd16;
      if (iNR43[2:0]==0) begin
        rDivRatioCounter[5:0] <= 6'd4;
      end
      else begin
        rDivRatioCounter[5:0] <= {iNR43[2:0],3'b0};
      end

//      rDivRatioCounter <= (iNR43[2:0]==0) ? 6'd4 : (iNR43[2:0]<<3) ; // fcpu/8      
      rClkDiv     <= 0;

      rPolCoutSteps <= iNR43[3];

      rShiftClockFreq <= iNR43[7:4];
      rShiftCounter <= (iNR43[7:4] < 15) ? 1 << iNR43[7:4] : 1 << 14;
      rCountPre   <= 0;

      rTimedMode <= iNR44[6];
    end
  end

    // step gen: generates the output amplitud value. 
    always @(posedge iOsc64) begin
      if (rStepTime != 0) begin       // Check if channel is enabled.
        if (rStepCounter ==1 ) begin
          rStepCounter <= rStepTime;  // Reset counter.
        if(rEvelopeMode) begin    // Envelope mode.
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


  // clock divider
  always @(posedge iClock) begin
    if (rDivRatioCounter === 0) begin
      rClkDiv <= ~rClkDiv;
     
      if (rDivRatioFreq==0) begin
        rDivRatioCounter <= 6'd4;
      end
      else begin
        rDivRatioCounter <= {rDivRatioFreq,3'b0};
      end
//	rDivRatioCounter <= 6'd16;
//      rDivRatioCounter <= (rDivRatioFreq==0) ? 6'd4 : (rDivRatioFreq<<3) ; // fcpu/8      
    end
    else begin
      rDivRatioCounter <= rDivRatioCounter-1;
    end
  end

  // counter pre-scaler
 always @(posedge rClkDiv) begin
    if (rShiftCounter == 0) begin
      rCountPre <= ~rCountPre;
      rShiftCounter <= (rShiftClockFreq < 15) ? 1 << rShiftClockFreq : 1 << 14;
    end
    else begin
      rShiftCounter <= rShiftCounter-1;    
    end
  end

  // white noise gen
  lfsr l0 (
      .iClock(rCountPre),
      .iReset(iReset),
      .iStages(rPolCoutSteps),
      .oOut(rTone)
    );
  

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

// misc modules.

module lfsr //parameters
  (
    input wire        iClock,
    input wire        iReset,
    input wire        iStages,
    output	           oOut 
  );
  
  //Stage conection wires.
  wire wS0S1, wS1S2, wS2S3, wS3S4, wS4S5, wS5S6, wS6S7, wS7S8;
  wire wS8S9, wS9S10, wS10S11, wS11S12, wS12S13, wS13S14, wS14S15, wS15S16;

  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_0 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),
    .D(oOut ^ wS6S7),
    .Q(wS0S1)
  );
  
  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_1 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),    
    .D(wS0S1),
    .Q(wS1S2)
  );

  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_2 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),    
    .D(wS1S2),
    .Q(wS2S3)
  );


  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_3 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),
    .D(wS2S3),
    .Q(wS3S4)
  );

  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_4 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),
    .D(wS3S4),
    .Q(wS4S5)
  );

  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_5 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),
    .D(wS4S5),
    .Q(wS5S6)
  );

  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_6 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),
    .D(wS5S6),
    .Q(wS6S7)
  );
  
  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_7 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),
    .D(wS6S7),
    .Q(wS7S8)
  );  
  

  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_8 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),
    .D(wS7S8),
    .Q(wS8S9)
  );
  
  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_9 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),    
    .D(wS8S9),
    .Q(wS9S10)
  );

  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_10 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),    
    .D(wS9S10),
    .Q(wS10S11)
  );


  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_11 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),
    .D(wS10S11),
    .Q(wS11S12)
  );

  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_12 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),
    .D(wS11S12),
    .Q(wS12S13)
  );

  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_13 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),
    .D(wS12S13),
    .Q(wS13S14)
  );

  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_14 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),
    .D(wS13S14),
    .Q(wS14S15)
  );
  
  FFD_POSEDGE_ASYNCRONOUS_RESET_INIT # ( 1 ) FF_CH4_15 (
    .Clock(iClock),
    .Reset(iReset),
    .Enable(1),
    .iInitial(1),
    .D(wS14S15),
    .Q(wS15S16)
  );  

  assign oOut = (iStages) ? wS7S8 : wS15S16 ;
endmodule
