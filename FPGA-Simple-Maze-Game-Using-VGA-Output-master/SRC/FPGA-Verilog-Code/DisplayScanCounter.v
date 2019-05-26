
module DisplayScanCounter(input clk,
								  input reset,
								  output [1:0] DisplayElement);
								  
	reg [1:0] current_value = 0;
	reg [18:0] clock_counter;
	
	assign DisplayElement = current_value;
	
	always @(clk)
	begin
		
		if (reset)
			current_value = 0;
		
		if (clock_counter == 800000)
		begin
			clock_counter = 0;
			current_value = current_value + 1;
		end
		else
			clock_counter = clock_counter + 1;
			
	end

endmodule
