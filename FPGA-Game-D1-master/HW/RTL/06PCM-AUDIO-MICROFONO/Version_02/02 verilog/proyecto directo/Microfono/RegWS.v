module RegWS(RESET, SET32, WS);

	input wire RESET;
	input wire SET32;
	output reg WS;

	always@(negedge SET32)
	begin
		if(RESET)
			WS = 1'b0;
		else
			WS = ~WS;
	end

endmodule
