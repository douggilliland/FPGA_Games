module m_ra (reset,bclk,done,lrclk);

	// Declaracion de variables

	input wire reset;
	input wire bclk;
	output reg done=0;
	output reg lrclk=0;
	output reg [16:0]count;

	//Registro ACUMULADOR

	always @(posedge bclk)
		begin
		if (reset)
			begin
				count<=0;
			end
		else	
			begin
			if(count<=15)
				begin
				count<= count+1;
				end
			else
				begin
				lrclk=!lrclk;     
				count<=0;   
				done<=1;
				end 
			end
		end
endmodule
