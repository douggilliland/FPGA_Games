module Comp (COUNT,COUNT18,COUNT32);

	// ENTRADAS Y SALIDAS DEL SISTEMA

	input wire [5:0] COUNT;
	output wire COUNT18;
	output wire COUNT32;

	assign COUNT18=(COUNT==18)?1'b1:1'b0;
	assign COUNT32=(COUNT==32)?1'b1:1'b0;

endmodule
