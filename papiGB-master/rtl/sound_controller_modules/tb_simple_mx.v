//Dummy tb for sound mx.
//Tb is only  for debug this module. 

`timescale 1ns / 1ps
`include "aDefinitions.v"
`include "collaterals.v"
`include "SoundControllerMX.v"
`include "SoundControllerOSC1.v"
`include "SoundControllerOSC2.v"

module tb;
  
  reg  clk;
  wire clk131k;
  wire clk262k;
  reg rst;

  wire [4:0] right, left;
  reg [7:0] nr50, nr51;
  wire [4:0] wOut1, wOut2, wOut3, wOut4;
  
  always begin
    #`CLOCK_CYCLE clk = ~clk;
  end
  
 osc2 o2
  (
    .iClock(clk),
    .iReset(rst),
    .oOut131k(clk131k),
    .oOut262k(clk262k)
  );

  SoundCtrlMX # () smx1 (
    .iClock(clk),
    .iReset(rst),
    .iOsc262k(clk262k),
    .iNR50(nr50),
    .iNR51(nr51),
    .iOut1(wOut1),
    .iOut2(wOut2),
    .iOut3(wOut3),
    .iOut4(wOut4),        

    .oSO1(left),
    .oSO2(right)
  );

  assign wOut1 = 5'hA;
  assign wOut2 = 5'hB;
  assign wOut3 = 5'hC;
  assign wOut4 = 5'hD;  

  integer i;

  initial begin
    $dumpfile("dump_sound_mx.vcd");
    $dumpvars();
    $display("tiempo \t left \t right");
    $monitor ("%0d \t %0d \t %0d",$time, left, right);
    clk = 0;
    rst = 1'b0;
    #10 rst = 1'b1;

    //test1 
    ///*
    nr50 = 8'h77; // max volume.
    nr51 = 8'hFF; // enable channels.
    //*/

    repeat (2) @ (negedge clk);
    rst = 1'b0;

    #50_000;

    $finish;
  end
  
endmodule
