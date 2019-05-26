  //Dummy tb for sound channel 1.
//Tb is only  for debug this module. 

`timescale 1ns / 1ps
`include "aDefinitions.v"
`include "collaterals.v"
`include "SoundControllerChannel1.v"
`include "SoundControllerOSC1.v"
`include "SoundControllerOSC2.v"

module tb;
  
  reg clk;
  wire clk64;
  wire clk128;
  wire clk256;
  wire clk131k;
  wire clk262k;
  reg rst;
  wire [4:0] out;

  reg [7:0] nr10;
  reg [7:0] nr11;
  reg [7:0] nr12;
  reg [7:0] nr13;
  reg [7:0] nr14;
  
  always begin
    #`CLOCK_CYCLE clk = ~clk;
  end
  
 osc1 o1
  (
    .iClock(clk),
    .iReset(rst),
    .oOut64(clk64),
    .oOut128(clk128),
    .oOut256(clk256)
  );

 osc2 o2
  (
    .iClock(clk),
    .iReset(rst),
    .oOut131k(clk131k),
    .oOut262k(clk262k)
  );

  SoundCtrlChannel1 # () scc1 (
    .iClock(clk),
    .iReset(rst),
    .iOsc64(clk64),
    .iOsc128(clk128),
    .iOsc256(clk256),
    .iOsc262k(clk262k),
    .iNR10(nr10),
    .iNR11(nr11),
    .iNR12(nr12),
    .iNR13(nr13),
    .iNR14(nr14),
    .oOut(out)
  );


  integer i;

  initial begin
    //$dumpfile("dump_sound_channel1.vcd");
    //$dumpvars();
    //$display("tiempo \t\t out1");
    //$monitor ("%0d \t\t %0d",$time, out);
    clk = 0;
    rst = 1'b0;
    #10 rst = 1'b1;

    //test1 
    ///*
    nr10 = 8'h00; // disable sweep control.
    nr11 = 8'h1F; // length = $1F = 31.
    nr12 = 8'hF4; // attenuate envelope, step time = 4. initial value = $F = 15.
    nr13 = 8'hBC; // low fre = $BC.
    nr14 = 8'h03; // high freq = $3, freq = $3BC = 956. timer disabled.
    //*/

    //test2
    /*
    nr10 = 8'h00; // disable sweep control
    nr11 = 8'h01; // length = $01 = 01.
    nr12 = 8'h1C; // amplify envelope, step time = 7. initial value = $2 = 2.
    nr13 = 8'hBC; // low freq = $BC.
    nr14 = 8'h43; // high freq = $3 , freq = $3BC = 956. time enabled.
    */

    //test3 
    /*
    nr10 = 8'h59; // subtraction sweep, n= 1. sweep time = 3. 
    nr11 = 8'h1F; // length = $1F = 31.
    nr12 = 8'hF0; // disable envelope, step time = 7. initial value = $F = 15.
    nr13 = 8'hD0; // low freq = $0D
    nr14 = 8'h07; // high freq = $7, freq = $70D = 1805. timer disabled.
    */

    //test4 
    /*
    nr10 = 8'h51; // addition sweep, n = 1. sweep time = 3. 
    nr11 = 8'h1F; // length = $1F = 31
    nr12 = 8'hF0; // disable envelope, step time = 3. initial value = $2 = 2.
    nr13 = 8'h30; // low freq = $30.
    nr14 = 8'h00; // high freq = $0 , freq = $030 = 48. timer disabled.
    */

    repeat (2) @ (negedge clk);
    rst = 1'b0;

    for ( i = 0; i < 10000; i = i+1) begin
      #5120 $display ("%0d, ", out);
    end
//    #50_000_000;

    $finish;
  end
  
endmodule
