module genpulsos_TB;

	reg		pulse;
	reg		CLKOUT1;
	reg		reset;
	genpulsos  uut(.pulse(pulse),.reset(reset),.CLKOUT1(CLKOUT1));

	always
	begin
		CLKOUT1 =1'b0;
		#2;
		CLKOUT1 =1'b1;
		#2;
	end

	initial 
	begin
		pulse= 0;
		reset=1;
		#4;
		reset =0;
		#5;
		pulse = 1;
		#10;
		reset =0;
		#10;
		reset=1;
		pulse=1;
		#10;
		reset=0;
		pulse=0;
		#10;
		pulse=1;
		#1;
		pulse=0;
		#6;
		pulse=1;
		#6;
		pulse=0;
		#6;
		pulse=1;
		#1;
		pulse=0;
		reset=1;
		#1;
		pulse=0;
		reset=0;
		#10;
		pulse=1;
		#1;
		reset=1;
		#1;
	end


initial begin: TEST_CASE
     $dumpfile("genpulsos_TB.vcd");
     $dumpvars(-1, uut);
     #(200) $finish;
   end

endmodule //
