module	divisorfrecgen	#(
				parameter top=10'b1111101000// top=100MHz/100kHz=1000
			 )
			(
				input           clk,
				output	reg	CLKOUT1
			);
	reg [9:0] count_1000;
	//
	initial
	begin
		CLKOUT1=1'b0;
		count_1000=0;
	end
	//
	always @(posedge clk) 
	begin
		count_1000 <= count_1000 + 1;
		if(count_1000 == top)
		begin
			count_1000<=0;
			CLKOUT1 <= ~CLKOUT1;
		end
	end
endmodule
