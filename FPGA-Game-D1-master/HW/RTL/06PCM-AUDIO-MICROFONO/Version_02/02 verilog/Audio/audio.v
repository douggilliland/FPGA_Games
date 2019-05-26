module audio
 (//declaracion de variables
	input             clk,
	input		  enable,
	input      [15:0] d_in,
	input		  reset,
	output            bclk,
	output        	  lrclk,
	output            done,
	output		  d_out

);


//Divisor de frecuencias
div_f A1(.clk(clk),.reset(reset),.bclk(bclk));

//Registro acumulador
m_ra A2(.reset(reset),.bclk(bclk),.lrclk(lrclk),.done(done),.act(act));

//Registro de salida
salida A6(.act(act),.done(done), .enable(enable),.reset(reset),.bclk(bclk),.data(d_in),.d_out(d_out));


endmodule
