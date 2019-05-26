module Comp (count,count18,count32);

	// ENTRADAS Y SALIDAS DEL SISTEMA

	input wire [5:0] count;
	output wire count18;
	output wire count32;

	assign count18=(count==18)?1'b1:1'b0;
	assign count32=(count==32)?1'b1:1'b0;

endmodule
