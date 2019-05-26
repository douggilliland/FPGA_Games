module RegAcum (RESET,BCLK,SET,COUNT);

	// ENTRADAS Y SALIDAS DEL SISTEMA

	input wire RESET;
	input wire BCLK;
	input wire SET;
	output reg [5:0] COUNT = 6'h00;

	//-- Registro

	always @(posedge BCLK)
		begin
		  if (RESET)
			COUNT = 6'h00;
		  else
			begin
				if (SET)
					COUNT = 6'h01;
				else
					COUNT = COUNT + 6'h01;				
			end
		end
endmodule
