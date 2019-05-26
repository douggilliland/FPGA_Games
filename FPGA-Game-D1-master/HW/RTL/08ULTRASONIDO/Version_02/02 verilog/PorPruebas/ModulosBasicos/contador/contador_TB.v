module contador_TB;

	reg ECHO;
	reg ENABLE;
	reg CLKOUT;
	reg reset;
	contador  uut(.ECHO(ECHO),.ENABLE(ENABLE),.reset(reset),.CLKOUT(CLKOUT));

	always
	begin
		CLKOUT =1'b1;
		#1;
		CLKOUT =1'b0;
		#1;
	end

	initial 
	begin
		ECHO= 0;
		reset=1;
		ENABLE =1;
		#4;
		reset=0;
		ENABLE =1;
		#5;
		ECHO = 1;
		#50;
		ECHO =0;
		#20;
		
	end


initial begin: TEST_CASE
     $dumpfile("contador_TB.vcd");
     $dumpvars(-1, uut);
     #(200) $finish;
   end

endmodule //
