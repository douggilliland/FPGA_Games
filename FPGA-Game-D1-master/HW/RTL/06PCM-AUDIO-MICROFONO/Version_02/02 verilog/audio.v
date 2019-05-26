module audio
 (//declaracion de variables
	input             clk,
	input		  enable,
	input      [15:0] d_in,
	input		  reset,
	output            bclk,
	output            lrclk,
	output            done,
	output      d_out

);

//Divisor de frecuencias
div_f A1(.clk(clk),.reset(reset),.bclk(bclk));

//Registro acumulador
m_ra A2(.reset(reset),.bclk(bclk),.lrclk(lrclk),.done(done));

//comparador
//m_c A3(.COUNT(COUNT),.COMPA(COMPA),.BCLK(BCLK));

//Registro LRCLK	
//m_lr A4(.RESET(RESET),.COMPA(COMPA),.LRCLK(LRCLK),.DONE(DONE));

//Registro de desplazamiento
m_rd A5(.reset(reset),.bclk(bclk),.d_in(d_in),.data(data));

//Registro de salida
salida A6(.reset(reset),.bclk(bclk),.data(data),.d_out(d_out));


endmodule
