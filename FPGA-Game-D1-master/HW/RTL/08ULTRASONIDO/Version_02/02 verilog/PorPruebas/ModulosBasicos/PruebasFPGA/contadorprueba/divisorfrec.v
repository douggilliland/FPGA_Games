module	divisorfrec	#(
				parameter top=12'b101101101100// top=100MHz/34.2kHz=2924, error: 0.0132%
			)
			(
				input           clk,
				output	reg	CLKOUT
			);
	reg [11:0] count_2924;
	
	initial
	begin
		CLKOUT=1'b1;
		count_2924=0;
	end
	
	always @(posedge clk) 
	begin
		count_2924 <= count_2924 + 1;
		if(count_2924 == top)
		begin
			count_2924<=0;
			CLKOUT <= ~CLKOUT;
		end
	end
endmodule
