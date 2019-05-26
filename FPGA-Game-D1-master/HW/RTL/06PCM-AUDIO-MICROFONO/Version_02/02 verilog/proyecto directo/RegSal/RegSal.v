module RegSal(RESET, LOAD, DATA, D_OUT);

	input wire RESET;
	input wire LOAD;
	input wire [17:0] DATA;
	output reg [17:0] D_OUT;

	always@(posedge LOAD)
	begin
		if(RESET)
			D_OUT = 18'b000000000000000000;
		else
			D_OUT = DATA;
	end

endmodule
