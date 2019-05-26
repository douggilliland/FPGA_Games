module Registro audio (RESET,BCLK,D_IN,DATA);

	// Declaracion de variables

	input wire RESET;
	input wire BCLK;
	input wire D_IN;
	input reg [15:0] D_IN;
	output wire DATA;

	//Registro Audio

	always @(negedge BCLK)
		begin
		  if (RESET)
			begin
				DATA=0;
			end	
		  else
			begin
				DATA = DATA >> 1;
				DATA = D_IN[15];
			end
		end
endmodule
