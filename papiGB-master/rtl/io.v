
`timescale 1ns / 1ps

`include "collaterals.v"

module io
(
  input wire        Clock,
  input wire        Reset,
  input wire [5:0]  iP,    //Pressed button
  output wire [5:0] oP,    //[5:4] most be triggered before [3:0]
  output wire       oIE    //Enable interruption $FFFF
);

wire [5:0] wiPlast;
wire [5:0] woPlast;
wire [5:0] wXnorAresult;
wire [5:0] wXnorBresult;
wire [5:0] wXnorCresult;
wire [5:0] wMuxAresult;
wire [5:0] wMuxBresult;

reg [5:0] rP;
`ifdef PRESS_A_KEY_AFTER
FFD_POSEDGE_SYNCRONOUS_RESET # ( 6 ) FFD_oHack
(
  .Clock(Clock),
  .Reset(Reset),
  .Enable(1'b1),
  .D(6'b111101),
  .Q(oP)
);
`else
  assign oP = rP;
`endif

FFD_POSEDGE_SYNCRONOUS_RESET # ( 6 ) FFD_oP
(
  .Clock(Clock),
  .Reset(Reset),
  .Enable(1'b1),
  .D(oP),
  .Q(woPlast)
);

FFD_POSEDGE_SYNCRONOUS_RESET # ( 6 ) FFD2_iP
(
  .Clock(Clock),
  .Reset(Reset),
  .Enable(1'b1),
  .D(iP),
  .Q(wiPlast)
);

XNOR # ( 6 ) XOR1
(
  .inA(iP),
  .inB(woPlast),
  .out(wXnorAresult)
);

XNOR # ( 6 ) XNOR2
(
  .inA(iP),
  .inB(wiPlast),
  .out(wXnorBresult)
);

MUX2 # ( 6 ) MUX1
(
  .select(&iP),
  .inA(wXnorAresult),
  .inB(iP),
  .out(wMuxAresult)
);

// assign wMuxBresult = (woPlast == iP) ? iP : wMuxAresult;
MUX2 # ( 6 ) MUX2
(
  .select(&wXnorAresult),
  .inA(wMuxAresult),
  .inB(iP),
  .out(wMuxBresult)
);

// assign oIE = (&oP == 0) ? 1 : 0;
MUX2 # ( 1 ) MUX3
(
  .select(&oP),
  .inA(1),
  .inB(0),
  .out(oIE)
);


always @ ( * )
  begin
    case (wMuxBresult)
      // one button is pressed. Or two buttons pressed with diferrent ending and type. Ex. Left + Start. Or juest A.
      6'b101110, 6'b101101, 6'b101011, 6'b100111,  6'b011110, 6'b011101, 6'b011011, 6'b010111:
      begin
        `ifdef JOYPAD_TOGGLE_PRESSED_KEY
          rP <= wMuxBresult;
        `else
          if (&wXnorBresult == 0)
            rP <= wMuxBresult;
          else
            rP <= woPlast;
        `endif
      end


      // two buttons pressed with the same ending. Ex A + Right (10 1110 + 01 1110)
      6'b011111,6'b101111:
      begin
        `ifdef JOYPAD_TOGGLE_PRESSED_KEY
          rP <= wMuxBresult;
        `else
          if (&wXnorBresult == 0)
            rP <= {wMuxBresult[5:4],woPlast[3:0]};
          else
            rP <= woPlast;
        `endif
      end


      // two buttons pressed with the same type. Ex. Up + Down. A + B
      6'b111110,6'b111101,6'b111011,6'b110111:
      begin
        `ifdef JOYPAD_TOGGLE_PRESSED_KEY
          rP <= wMuxBresult;
        `else
          if (&wXnorBresult == 0)
            rP <= {woPlast[5:4],wMuxBresult[3:0]};
          else
            rP <= woPlast;
        `endif
      end

      default:
      begin
        $display("Default %dns",$time);
        rP <= 6'b111111;
      end

    endcase
  end

endmodule
