module ultrasonido(input reset, input clk, input echo, output reg done, output reg trigger, output reg [15:0] distance);
	//Período de la FPGA T=10nS (Código Alterno)  
	//Declaración de parámetros
	//Estos parámetros se encuentran  en nano segundos por el periodo de la FPGA 
	parameter divH = 1000; 
	parameter divL = 4000;
	
	//Contadores
	integer countF;
	integer countEcho;
	
	initial countF = 0;
	
	//Trigger
	always @(posedge clk) begin 
		if (reset) 
		begin 
			countF <= 0;
			trigger <= 0;
		end 
		else 
		begin
			countF <= countF +1; //en caso de no funcionar probar con begin end en cada if
			if (countF < divH+1)
				trigger <= 1;
			else
			if (countF < divL+1)
				trigger <= 0;
			else 
				countF <= 0;
		end
	end
	
	//echo
	always @(posedge clk) begin
		if (echo == 1) begin
			countEcho <= countEcho +1;
			done <= 0;
		end
		else
		begin
			if (echo == 0 & countEcho != 0)	
				distance <= (countEcho*340)/2000000;
				//distance <= countEcho/58000;
				countEcho <=0;
				done <= 1; 	
		end
		
	end
	
endmodule