module RegDes (reset,bclk,d_in,data);

	// ENTRADAS Y SALIDAS DEL SISTEMA

	input wire reset;
	input wire bclk;
	input wire d_in;
	output reg [17:0] data;

	//-- Registro

	always @(posedge bclk)
		begin
		  if (reset)
			begin
				data=0;
			end	
		  else
			begin
				data = data << 1;
				data[0] = d_in;
			end
		end
endmodule
