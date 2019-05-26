module salida (reset,bclk,data,d_out);

	// Declaracion de variables

	input wire reset;
	input wire bclk;
	input wire [15:0]data;
	output reg [15:0]d_out;
	
	//Registro Audio

	always @(posedge bclk)
		begin
		  if (reset)
			begin
				d_out<=0;
			end	
		  else
			begin
				d_out = data;
			end
		end
endmodule
