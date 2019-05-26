module RegWS(reset, set32, ws);

	input wire reset;
	input wire set32;
	output reg ws;

	always@(negedge set32)
	begin
		if(reset)
			ws = 1'b0;
		else
			ws = ~ws;
	end

endmodule
