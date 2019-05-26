`timescale 1ns / 1ps

`define SIMULATION


module peripheral_audio_TB;

  
   reg clk;
   reg rst;
   reg  reset;
   reg  start;
   reg [15:0]d_in;
   reg cs;
   reg [1:0]addr;
   reg rd;
   reg wr;
   wire [15:0]d_out;
reg micData;  

peripheral_audio uut (.clk(clk) , .rst(reset) , .d_in(d_in) , .cs(cs) , .addr(addr) , .rd(rd) , .wr(wr), .d_out(d_out),.micData(micData) );


   parameter PERIOD          = 20;
   parameter real DUTY_CYCLE = 0.5;
   parameter OFFSET          = 0;
   reg [20:0] i;
   event reset_trigger;


	reg d;


   initial begin  // Initialize Inputs
      clk = 0; reset = 1; start = 0; d_in = 16'd0035; addr = 16'h0000; cs=1; rd=0; wr=1;
	
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
initial begin
micData = 1'b0;#64;
micData = 1'b1;#80;
micData = 1'b0;#75; 
micData = 1'b1;#34;
micData = 1'b0;#75;
micData = 1'b1;#80;
micData = 1'b0;#75;
micData = 1'b0;#450;
micData = 1'b1;#100;
micData = 1'b0;#64;
micData = 1'b1;#80;
micData = 1'b0;#75; 
micData = 1'b1;#34;
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

	#4 reset=0;
				// stimulus here

       for(i=0; i<4; i=i+1) begin
         @ (posedge clk);
       end

	//d_in = 16'h0001;	//envio 1
	addr = 16'h0000;
	cs=1; rd=0; wr=1;
	
	addr = 16'h0002;
	cs=1; rd=1; wr=0;
	
       for(i=0; i<40000; i=i+1) begin
         @ (posedge clk);
       end

	//d_in = 16'h0002;	//envio 1
	addr = 16'h0000;
	cs=1; rd=0; wr=1;

   end
	 
end
   initial begin: TEST_CASE
     $dumpfile("peripheral_audio_TB.vcd");
     $dumpvars(-1, uut);
	
     #10 -> reset_trigger;
     #((PERIOD*DUTY_CYCLE)*200000) $finish;
   end

endmodule

