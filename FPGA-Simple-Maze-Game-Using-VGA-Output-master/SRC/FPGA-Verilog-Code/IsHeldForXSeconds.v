module IsHeldForXSeconds(input uclk,
								 input reset,
								 input btn,
								 output reg val);

	parameter SECONDS = 1;
	

	reg [SECONDS*30:0] clk_counter = 0;
	reg clk_reduced;
	
	always @(uclk)
	begin
	
		if (btn == 1 && reset == 0)
		begin
			if (clk_counter >= (SECONDS*10000000))
			begin
				val = 1;
			end
			else
			begin
				clk_counter = clk_counter + 1;
				val = 1;
			end
		end
		else
		begin
			clk_counter = 0;
			val = 0;
		end
		
	end

endmodule
