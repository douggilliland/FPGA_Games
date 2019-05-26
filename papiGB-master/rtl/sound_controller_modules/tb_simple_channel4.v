//Dummy tb for sound channel 4.
//Tb is only  for debug this module. 

`timescale 1ns / 1ps
`include "aDefinitions.v"
`include "collaterals.v"
`include "SoundControllerChannel4.v"
`include "SoundControllerOSC1.v"
`include "SoundControllerOSC2.v"

module tb;
  
  reg clk;
  wire clk64;
  wire clk256;
  wire clk131k;
  wire clk262k;
  reg rst;
  wire [4:0] out;
  
  reg [7:0] nr41;
  reg [7:0] nr42;
  reg [7:0] nr43;
  reg [7:0] nr44;


  always begin
    #`CLOCK_CYCLE clk = ~clk;
  end
  
 osc1 o1
  (
    .iClock(clk),
    .iReset(rst),
    .oOut64(clk64),
    .oOut256(clk256)
  );

 osc2 o2
  (
    .iClock(clk),
    .iReset(rst),
    .oOut131k(clk131k),
    .oOut262k(clk262k)
  );


  SoundCtrlChannel4 # () scc2 (
    .iClock(clk),
    .iReset(rst),
    .iOsc64(clk64),
    .iOsc256(clk256),
    .iNR41(nr41),
    .iNR42(nr42),
    .iNR43(nr43),
    .iNR44(nr44),
    .oOut(out)
  );

integer i;

  initial begin
//    $dumpfile("dump_sound_channel4.vcd");
//    $dumpvars();
//    $display("tiempo \t\t out4");
//    $monitor ("%0d \t\t %0d",$time, out);
    clk = 0;
    rst = 1'b0;
    @(negedge clk) rst = 1'b1;

    //test1 
    /*
    nr41 = 8'h03; // length = $XX, timer disabled
    nr42 = 8'hF4; // attenuate envelope, step time = 7. initial value = $F = 15.
    nr43 = 8'h52; // div ratio = 3. lfrs = 15 stages , shifts = 3
    nr44 = 8'h40; // timer disabled.
    */

    //test2
    ///*
    nr41 = 8'h00; // length = $XX, timer disabled
    nr42 = 8'h1C; // amplify envelope, step time = 7. initial value = $2 = 2.
    nr43 = 8'h52; // div ratio = 3. lfrs = 7 stages , shifts = 3
    nr44 = 8'h00; // timer disabled.
    //*/

    repeat (2) @ (negedge clk);
    rst = 1'b0;
//    #50_000_000;
    for ( i = 0; i < 10000; i = i+1) begin
      #5120 $display ("%0d, ", out);
    end

    $finish;
  end
  
endmodule
