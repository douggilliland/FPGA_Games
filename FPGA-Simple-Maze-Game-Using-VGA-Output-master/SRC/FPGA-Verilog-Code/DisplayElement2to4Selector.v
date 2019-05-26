
module DisplayElement2to4Selector(input [1:0] DisplayElementSelect,
											 output reg [3:0] AN);
											 
	always @(*)
	begin
		case (DisplayElementSelect)
			0: begin
					AN[0] = 0;
					AN[1] = 1;
					AN[2] = 1;
					AN[3] = 1;
				end
			1:	begin
					AN[0] = 1;
					AN[1] = 0;
					AN[2] = 1;
					AN[3] = 1;
				end
			2:	begin
					AN[0] = 1;
					AN[1] = 1;
					AN[2] = 0;
					AN[3] = 1;
				end
			3:	begin
					AN[0] = 1;
					AN[1] = 1;
					AN[2] = 1;
					AN[3] = 0;
				end
		endcase
	end

endmodule
