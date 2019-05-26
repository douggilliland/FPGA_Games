`timescale 1ns / 1ns

module peripheral_SD_TB;
reg clk;
reg reset;
reg [15:0] d_in;
reg cs;
reg [3:0]addr;
reg rd;
reg wr;
wire [15:0] d_out;


peripheral_SD uut(.clk(clk) , .reset(reset) , .d_in(d_in) , .cs(cs) , .addr(addr) , .rd(rd) , .wr(wr), .d_out(d_out));



always
	begin
	clk=0;
	#1;
	clk=1;
	#1;
	end

initial
	begin
	reset=1;
	d_in=16'h0000;
	addr=16'h0002;
	wr=1;
	cs=1;
	#1000;
	reset=0;
	#1000;
	d_in = 16'h0062;
	addr = 16'h0000;
	rd = 0;
	wr = 1;
	#1000;
	d_in = 16'h0001;
	addr = 16'h0002;
	#10000;
	wr=0;
	rd=1;
	addr =16'h0004;

	end



initial begin: TEST_CASE	
     $dumpfile("peripheral_SD_TB.vcd");
     $dumpvars(-1, uut);
     #(500000) $finish;
   end

endmodule
