//Dummy tb for sound channel 4.
//Tb is only  for debug this module. 

`timescale 1ns / 1ps
`include "aDefinitions.v"
`include "collaterals.v"
`include "SoundControllerChannel3.v"
`include "SoundControllerOSC1.v"
`include "SoundControllerOSC2.v"

module tb;
  
  reg clk;
  wire clk256;
  wire clk262k;
  reg rst;
  wire [4:0] out;

  reg [7:0] nr30;
  reg [7:0] nr31;
  reg [7:0] nr32;
  reg [7:0] nr33;
  reg [7:0] nr34;

  always begin
    #`CLOCK_CYCLE clk = ~clk;
  end
  
 osc1 o1
  (
    .iClock(clk),
    .iReset(rst),
    .oOut256(clk256)
  );

 osc2 o2
  (
    .iClock(clk),
    .iReset(rst),
    .oOut262k(clk262k)
  );

  SoundCtrlChannel3 # () scc3 (
    .iClock(clk),
    .iReset(rst),
    .iOsc256(clk256),
    .iOsc262k(clk262k),
    .iNR30(nr30),
    .iNR31(nr31),
    .iNR32(nr32),
    .iNR33(nr33),
    .iNR34(nr34),
    .oOut(out)
  );

integer i;

  initial begin
//    $dumpfile("dump_sound_channel3.vcd");
//    $dumpvars();
//    $display("tiempo \t\t out3");
//    $monitor ("%0d \t\t %0d",$time, out);
    clk = 0;
    rst = 1'b0;
    #10 rst = 1'b1;

    //test1
    ///*    
    nr30 = 8'h80; 
    nr31 = 8'h8A;
    nr32 = 8'h20;
    nr33 = 8'hBC;
    nr34 = 8'h43; // timer mode

    repeat (2) @ (negedge clk);
    rst = 1'b0;

    for ( i = 0; i < 5000; i = i+1) begin
      #5120 $display ("%0d, ", out);
    end

    nr30 = 8'h80; 
    nr31 = 8'h00;
    nr32 = 8'h40; // A = A/2
    nr33 = 8'hBC; // Lower frequency
    nr34 = 8'hC2; // timed mode
 
    repeat (2) @ (negedge clk);
    nr34 = 8'h02; // timed mode

    for ( i = 0; i < 5000; i = i+1) begin
      #5120 $display ("%0d, ", out);
    end
  
    //#25_000_000; // 596ms, dmg_clock
    //*/  

    //test2
    /*
    nr30 = 8'h80; 
    nr31 = 8'h8A; // L2
    nr32 = 8'h20;
    nr33 = 8'hBC;
    nr34 = 8'h43; // timer mode

    repeat (2) @ (negedge clk);
    rst = 1'b0;
    #25_000_000;

    nr30 = 8'h80; 
    nr31 = 8'h00; // L2
    nr32 = 8'h60; // A = A/4
    nr33 = 8'hBC; // Lower frequency
    nr34 = 8'hC2; 

    repeat (2) @ (negedge clk);
    nr34 = 8'h02; // continuous mode
    #25_000_000;    
    */

    $finish;
  end
  
endmodule
