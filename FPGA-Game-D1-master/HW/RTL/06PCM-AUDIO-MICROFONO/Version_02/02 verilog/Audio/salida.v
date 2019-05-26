module salida (act, done, enable, reset,bclk,data,d_out);

	// Declaracion de variables

	input wire reset;
	input wire bclk;
	input  [15:0] data;
	output reg d_out;
	input enable;
	input done;
	input act;
	//Registro Audio

	reg [15:0] dd;
 			
	
	always @(posedge bclk or posedge reset)
		begin
		  if (reset)
			begin
				d_out=0;
				dd =0;
			end	
		  else				
			begin
			if (act)
			begin
				dd =data;
			end 
			else
				dd=(dd>>1); 
				d_out = dd[0];
			end
		end
endmodule
