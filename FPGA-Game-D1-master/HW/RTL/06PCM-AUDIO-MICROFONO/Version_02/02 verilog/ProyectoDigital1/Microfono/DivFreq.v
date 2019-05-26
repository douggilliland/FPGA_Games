module DivFreq (reset,clk,en_clk,bclk);

	// ENTRADAS Y SALIDAS DEL SISTEMA

	input wire reset;
	input wire clk;
	input wire en_clk;
	output reg bclk;

	reg [5:0] count = 6'h00;

	//-- Registro

	always @(posedge clk)
		begin
		  if (reset)
			begin
				count = 6'h00;
				bclk = 1'b0;
			end	
		  else
			if (en_clk)
				if (count == 50)
					begin
						count = 6'h01;
						bclk = ~bclk;
					end
				else
					begin
						count = count + 6'h01;
						bclk = bclk;
					end
			else
				begin
					count = count;
					bclk = bclk;
				end
		end
		
endmodule
