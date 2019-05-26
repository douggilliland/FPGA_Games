
module SevenSegmentDisplayDecoder(input [3:0] hexValue,
											 output reg A,
											 output reg B,
											 output reg C,
											 output reg D,
											 output reg E,
											 output reg F,
											 output reg G,
											 output reg DecimalPoint);
											 
		 	
	always @(*)
	begin
	
		case (hexValue)
			0: begin
					A = 0;
					B = 0;
					C = 0;
					D = 0;
					E = 0;
					F = 0;
					G = 1;
					DecimalPoint = 1;
				end
			1: begin
					A = 1;
					B = 0;
					C = 0;
					D = 1;
					E = 1;
					F = 1;
					G = 1;
					DecimalPoint = 1;
				end
			2: begin
					A = 0;
					B = 0;
					C = 1;
					D = 0;
					E = 0;
					F = 1;
					G = 0;
					DecimalPoint = 1;
				end
			3: begin
					A = 0;
					B = 0;
					C = 0;
					D = 0;
					E = 1;
					F = 1;
					G = 0;
					DecimalPoint = 1;
				end
			4: begin
					A = 1;
					B = 0;
					C = 0;
					D = 1;
					E = 1;
					F = 0;
					G = 0;
					DecimalPoint = 1;
				end
			5: begin
					A = 0;
					B = 1;
					C = 0;
					D = 0;
					E = 1;
					F = 0;
					G = 0;
					DecimalPoint = 1;
				end
			6: begin
					A = 0;
					B = 1;
					C = 0;
					D = 0;
					E = 0;
					F = 0;
					G = 0;
					DecimalPoint = 1;
				end
			7: begin
					A = 0;
					B = 0;
					C = 0;
					D = 1;
					E = 1;
					F = 1;
					G = 1;
					DecimalPoint = 1;
				end
			8: begin
					A = 0;
					B = 0;
					C = 0;
					D = 0;
					E = 0;
					F = 0;
					G = 0;
					DecimalPoint = 1;
				end
			9: begin
					A = 0;
					B = 0;
					C = 0;
					D = 0;
					E = 1;
					F = 0;
					G = 0;
					DecimalPoint = 1;
				end
			10: begin
					A = 0;
					B = 0;
					C = 0;
					D = 1;
					E = 0;
					F = 0;
					G = 0;
					DecimalPoint = 1;
				end
			11: begin
					A = 1;
					B = 1;
					C = 0;
					D = 0;
					E = 0;
					F = 0;
					G = 0;
					DecimalPoint = 1;
				end
			12: begin
					A = 0;
					B = 1;
					C = 1;
					D = 0;
					E = 0;
					F = 0;
					G = 1;
					DecimalPoint = 1;
				end
			13: begin
					A = 1;
					B = 0;
					C = 0;
					D = 0;
					E = 0;
					F = 1;
					G = 0;
					DecimalPoint = 1;
				end
			14: begin
					A = 0;
					B = 1;
					C = 1;
					D = 0;
					E = 0;
					F = 0;
					G = 0;
					DecimalPoint = 1;
				end
			15: begin
					A = 0;
					B = 1;
					C = 1;
					D = 1;
					E = 0;
					F = 0;
					G = 0;
					DecimalPoint = 1;
				end
		endcase
	
	end

endmodule
