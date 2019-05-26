//Dummy tb for sound channel 4.
//Tb is only  for debug this module. 

`timescale 1ns / 1ps
`include "aDefinitions.v"
`include "collaterals.v"
`include "SoundControllerChannel2.v"
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

  reg [7:0] nr20;
  reg [7:0] nr21;
  reg [7:0] nr22;
  reg [7:0] nr23;
  reg [7:0] nr24;
  
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


  SoundCtrlChannel2 # () scc2 (
    .iClock(clk),
    .iReset(rst),
    .iOsc64(clk64),
    .iOsc256(clk256),
    .iOsc262k(clk262k),
    .iNR21(nr21),
    .iNR22(nr22),
    .iNR23(nr23),
    .iNR24(nr24),
    .oOut(out)
  );

  initial begin
    $dumpfile("dump_sound_channel2.vcd");
    $dumpvars();
    $display("tiempo \t\t out2");
    $monitor ("%0d \t\t %0d",$time, out);
    clk = 0;
    rst = 1'b0;
    #10 rst = 1'b1;


    //test1 
    /*
    nr21 = 8'h03; // length = $03 = 03.
    nr22 = 8'hF4; // attenuate envelope, step time = 3. initial value = $F = 15.
    nr23 = 8'hBC; // low fre = $BC.
    nr24 = 8'h43; // high freq = $3, freq = $3BC = 956. timer enabled.
    */

    //test2
    /*
    nr21 = 8'h50; // length = $1F = 31.
    nr22 = 8'h1C; // amplify envelope, step time = 7. initial value = $2 = 2.
    nr23 = 8'hBC; // low freq = $BC.
    nr24 = 8'h03; // high freq = $3 , freq = $3BC = 956. time disabled.
    */

    repeat (2) @ (negedge clk);
    rst = 1'b0;
    #50_000_000;

    $finish;
  end
  
endmodule