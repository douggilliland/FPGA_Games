module Mux16to4(input [15:0] Input,
					 input [1:0] Selector,
					 output reg [3:0] Output);

	always @(*)
	begin
		
		case (Selector)
			0: Output = Input[3:0];
			1: Output = Input[7:4];
			2: Output = Input[11:8];
			3: Output = Input[15:12];
		endcase
	
	end

endmodule
