`timescale 1ns / 1ns
module audio_TB;

		reg clk;
		reg [15:0]d_in;
		reg enable;
		reg reset;
		wire bclk;
		wire d_out;
		wire done;
		wire act;
		
			

audio a1(.enable(enable),.d_in(d_in),.reset(reset),.clk(clk),.d_out(d_out));

		always
		begin
		#1 clk=~clk;
		end

		initial
		begin
		clk =1'b1;

		reset =1'b1;
		d_in=16'b000000000000000;
		enable=1'b1;
		#10;
		reset =1'b0;
		d_in=16'b101101001100000;
		enable=1'b1;
		end 

	
initial begin: TEST_CASE
     $dumpfile("audio_TB.vcd");
     $dumpvars(-1, a1);
     #(1000) $finish;
   end

endmodule


