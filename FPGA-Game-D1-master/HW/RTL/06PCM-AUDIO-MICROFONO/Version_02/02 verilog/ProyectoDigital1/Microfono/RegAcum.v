module RegAcum (reset,bclk,set,count);

	// ENTRADAS Y SALIDAS DEL SISTEMA

	input wire reset;
	input wire bclk;
	input wire set;
	output reg [5:0] count = 6'h00;

	//-- Registro

	always @(posedge bclk)
		begin
		  if (reset)
			count = 6'h00;
		  else
			begin
				if (set)
					count = 6'h01;
				else
					count = count + 6'h01;				
			end
		end
endmodule
