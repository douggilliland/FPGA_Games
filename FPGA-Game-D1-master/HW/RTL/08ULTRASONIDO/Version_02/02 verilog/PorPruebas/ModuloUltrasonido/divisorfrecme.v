module	divisorfrecme	#(
				parameter top=12'b101110111000;// top=100MHz/100kHz=1000
			 )
			(
				input           clk,
				input		        ENABLE,
				output          CLKOUT2
			);
	reg [11:0] count_3000;
	//
	initial
	begin
		CLKOUT1=1'b0;
		count_3000=0;
	end
	//
	always @(posedge clk) 
	begin
			count_3000 <= count_3000 + 1;
			if(count_3000 == top)
			begin
				count_3000<=0;
				CLKOUT1 <= ~CLKOUT1;
			end
	end
endmodule
