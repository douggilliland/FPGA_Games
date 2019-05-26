module DivFreq (reset,clk,bclk);

	// ENTRADAS Y SALIDAS DEL SISTEMA

	input wire reset;
	input wire clk;
	output wire bclk;

	reg [5:0] count = 0;
	reg clock = 1'b0;

	assign bclk = clock;

	//-- Registro

	always @(posedge clk)
		begin
		  if (reset)
			begin
				count = 0;
				clock = 1'b1;
			end	
		  else
			if (count == 50)
				begin
					count = 1;
					clock = ~clock;
				end
			else
				begin
					count = count + 1;
					clock = clock;
				end

		end
		
endmodule
