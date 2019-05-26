`timescale 1ns / 1ps

`define SIMULATION


module div_16_TB;

   reg  clk;
   reg  rst;
   reg  reset;
   reg  start;
   reg  init_in;
   reg  [15:0]A;
   reg  [15:0]B;
   wire [15:0] Result;
   wire done;

   div_16 uut (.clk(clk) , .rst(rst) , .init_in(start) , .A(A) , .B(B) , .Result(Result) , .done(done));

   parameter PERIOD          = 20;
   parameter real DUTY_CYCLE = 0.5;
   parameter OFFSET          = 0;
   reg [20:0] i;
   event reset_trigger;




   initial begin  // Initialize Inputs
      clk = 0; reset = 1; start = 0; A = 16'd35; B = 16'd5; //in_A = 8'hAA; in_B = 8'h24;   41/9  = 4*9 +5
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
     $dumpfile("div_16_TB.vcd");
     $dumpvars(-1, uut);
	
     #10 -> reset_trigger;
     #((PERIOD*DUTY_CYCLE)*120) $finish;
   end

endmodule

