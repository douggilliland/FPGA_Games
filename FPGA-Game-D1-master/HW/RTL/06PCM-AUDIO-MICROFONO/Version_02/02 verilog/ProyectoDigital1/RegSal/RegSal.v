module RegSal(reset, load, data, d_out);

	input wire reset;
	input wire load;
	input wire [17:0] data;
	output reg [17:0] d_out;

	always@(posedge load)
	begin
		if(reset)
			d_out = 18'b000000000000000000;
		else
			d_out = data;
	end

endmodule
