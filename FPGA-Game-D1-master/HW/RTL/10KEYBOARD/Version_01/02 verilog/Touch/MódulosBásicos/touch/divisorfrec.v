module	divisorfrec	#(
				parameter top=12'b100000010010// top=100MHz/34.2kHz=2924, error: 0.0132%
			)
			(
				input           clk,
				output	reg	CLKOUT
			);
	reg [10:0] count_1042;
	
	initial
	begin
		CLKOUT=1'b1;
		count_1042=0;
	end
	
	always @(posedge clk) 
	begin
		count_1042 <= count_1042 + 1;
		if(count_1042 == top)
		begin
			count_1042<=0;
			CLKOUT <= ~CLKOUT;
		end
	end
endmodule
