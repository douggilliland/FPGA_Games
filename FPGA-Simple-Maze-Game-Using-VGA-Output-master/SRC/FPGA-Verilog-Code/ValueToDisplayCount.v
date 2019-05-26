
module ValueToDisplayCount(input clk,
									input reset,
									input direction,
									output [15:0] value);
	
	reg [50:0] clock_counter;
	reg [15:0] current_value;
		
	assign value = current_value;
		
	always @(clk)
	begin
	
		if (reset)
		begin
				current_value = 0;
		end
	
		if (clock_counter >= 200000000)
		begin
			clock_counter = 0;
			current_value = current_value + 1;
		end
		else
			clock_counter = clock_counter + 1;
		
	end
	
	

endmodule
