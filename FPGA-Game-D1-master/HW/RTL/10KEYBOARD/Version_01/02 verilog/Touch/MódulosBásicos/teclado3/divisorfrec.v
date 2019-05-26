module	divisorfrec	#(
				parameter top=13'd7692// top=100MHz/13kHz=7692, error: 0,0000400016%
			)
			(
				input           clk,
				output	reg	CLKOUT
			);
	reg [12:0] count;
	
	initial
	begin
		CLKOUT=1'b1;
		count=0;
	end
	
	always @(posedge clk) 
	begin
		count <= count + 1;
		if(count == top)
		begin
			count<=0;
			CLKOUT <= ~CLKOUT;
		end
	end
endmodule
