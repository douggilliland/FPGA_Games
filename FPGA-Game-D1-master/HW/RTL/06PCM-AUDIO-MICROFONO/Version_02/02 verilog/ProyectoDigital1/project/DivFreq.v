module DivFreq (RESET,CLK,EN_CLK,BCLK);

	// ENTRADAS Y SALIDAS DEL SISTEMA

	input wire RESET;
	input wire CLK;
	input wire EN_CLK;
	output reg BCLK;

	reg [5:0] COUNT;

	//-- Registro

	always @(posedge CLK)
		begin
		  if (RESET)
			begin
				COUNT = 0;
				BCLK = 1'b0;
			end	
		  else
			if (EN_CLK)
				if (COUNT == 50)
					begin
						COUNT = 1;
						BCLK = ~BCLK;
					end
				else
					begin
						COUNT = COUNT + 1;
						BCLK = BCLK;
					end
			else
				begin
					COUNT = COUNT;
					BCLK = BCLK;
				end
		end
		
endmodule
