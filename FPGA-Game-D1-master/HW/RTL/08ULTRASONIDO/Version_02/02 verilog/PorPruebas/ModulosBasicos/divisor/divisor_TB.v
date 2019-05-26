module divisor_TB;

	reg		reset;
	reg	[7:0]	count;
	reg		calculate;
	reg		CLKOUTD;
	divisor  uut(.count(count),.calculate(calculate),.reset(reset),.CLKOUTD(CLKOUTD));

	always
	begin
		CLKOUTD =1'b1;
		#0.5;
		CLKOUTD =1'b0;
		#0.5;
	end

	initial 
	begin
		count = 8'b00000000;
		#10;
		calculate =0;
		count = 8'b00101011;
		#50;
		calculate =1;
		#20;
		//count = 0;
		//#20;
		calculate =0;
		#20;
	end


initial begin: TEST_CASE
     $dumpfile("divisor_TB.vcd");
     $dumpvars(-1, uut);
     #(200) $finish;
   end

endmodule //
