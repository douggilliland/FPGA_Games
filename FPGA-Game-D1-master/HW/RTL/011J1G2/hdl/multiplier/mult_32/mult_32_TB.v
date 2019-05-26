`timescale 1ns / 1ps

`define SIMULATION


module mult_32_TB;

   reg  clk;
   reg  rst;
   reg  reset;
   reg  start;
   reg  [15:0]in_A;
   reg  [15:0]in_B;
   wire [31:0] pp;
   wire done;

   mult_32 uut (.clk(clk) , .rst(rst) , .init(start) , .A(in_A) , .B(in_B) , .pp(pp) , .done(done));

   parameter PERIOD          = 20;
   parameter real DUTY_CYCLE = 0.5;
   parameter OFFSET          = 0;
   reg [20:0] i;
   event reset_trigger;




   initial begin  // Initialize Inputs
      clk = 0; reset = 1; start = 0; in_A = 16'h0005; in_B = 16'h0003;//in_A = 16'hFA00; in_B = 16'hFA00; //in_A = 8'hAA; in_B = 8'h24;
   end

   initial  begin  // Process for clk
     #OFFSET;
     forever
       begin
         clk = 1'b0;
         #(PERIOD-(PERIOD*DUTY_CYCLE)) clk = 1'b1;
         #(PERIOD*DUTY_CYCLE);
       end
   end

   initial begin // Reset the system, Start the image capture process
      forever begin 
        @ (reset_trigger);
        @ (posedge clk);
        start = 0;
        @ (posedge clk);
        start = 1;

       for(i=0; i<2; i=i+1) begin
         @ (posedge clk);
       end
          start = 0;
      end
   end
	 

   initial begin: TEST_CASE
     $dumpfile("mult_32_TB.vcd");
     $dumpvars(-1, uut);
	
     #10 -> reset_trigger;
     #((PERIOD*DUTY_CYCLE)*120) $finish;
   end

endmodule

