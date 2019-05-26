module m_rd (reset,bclk,d_in,data);

	// Declaracion de variables

	input wire reset;
	input wire bclk;
	input wire d_in;
	output reg [15:0]data;

	//Registro Audio

	always @(posedge bclk)
		begin
		  if (reset)
			begin
				data=0;
			end	
		  else
			begin
				data <= data >> 1;
				data[15]<= d_in;
			end
		end
endmodule
