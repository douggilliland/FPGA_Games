module	divisorfrecd	#(
				parameter top=11'b10110110110// top=100MHz/34.2kHz=2924, error: 0.0132%
			)
			(
				input           clk,
				output	reg	CLKOUTD
			);
	reg [10:0] count_1462;
	
	initial
	begin
		CLKOUTD=1'b1;
		count_1462=0;
	end
	
	always @(posedge clk) 
	begin
		count_1462 <= count_1462 + 1;
		if(count_1462 == top)
		begin
			count_1462<=0;
			CLKOUTD <= ~CLKOUTD;
		end
	end
endmodule
