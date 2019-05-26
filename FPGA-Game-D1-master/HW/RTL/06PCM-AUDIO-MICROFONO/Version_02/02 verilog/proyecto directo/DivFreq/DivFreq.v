module DivFreq (RESET,CLK,EN_CLK,BCLK);

	// ENTRADAS Y SALIDAS DEL SISTEMA

	input wire RESET;
	input wire CLK;
	input wire EN_CLK;
	output reg BCLK;

	reg [5:0] COUNT = 6'h00;

	//-- Registro

	always @(posedge CLK)
		begin
		  if (RESET)
			begin
				COUNT = 6'h00;
				BCLK = 1'b0;
			end	
		  else
			if (EN_CLK)
				if (COUNT == 50)
					begin
						COUNT = 6'h01;
						BCLK = ~BCLK;
					end
				else
					begin
						COUNT = COUNT + 6'h01;
						BCLK = BCLK;
					end
			else
				begin
					COUNT = COUNT;
					BCLK = BCLK;
				end
		end
		
endmodule
