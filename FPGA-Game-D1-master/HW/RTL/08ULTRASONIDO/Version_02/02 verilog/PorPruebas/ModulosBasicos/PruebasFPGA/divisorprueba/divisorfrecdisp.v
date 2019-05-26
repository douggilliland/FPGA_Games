module	divisorfrecdisp	#(
				parameter top=17'd100000// top=100MHz/34.2kHz=2924, error: 0.0132%
			)
			(
				input           clk,
				output	reg	CLKOUTseg
			);
	reg [16:0] count_100000;
	
	initial
	begin
		CLKOUTseg=1'b1;
		count_100000=0;
	end
	
	always @(posedge clk) 
	begin
		count_100000 <= count_100000 + 1;
		if(count_100000 == top)
		begin
			count_100000<=0;
			CLKOUTseg <= ~CLKOUTseg;
		end
	end
endmodule
