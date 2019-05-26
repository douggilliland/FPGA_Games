module RegDes (RESET,BCLK,D_IN,DATA);

	// ENTRADAS Y SALIDAS DEL SISTEMA

	input wire RESET;
	input wire BCLK;
	input wire D_IN;
	output reg [17:0] DATA;

	//-- Registro

	always @(posedge BCLK)
		begin
		  if (RESET)
			begin
				DATA=0;
			end	
		  else
			begin
				DATA = DATA << 1;
				DATA[0] = D_IN;
			end
		end
endmodule
