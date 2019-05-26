module	cantidadecho	(
				input		[7:0]	cantidad,
				input			entrada,
				input			CLKOUT,
				input			reset,
				output	reg		ECHO
			);
	reg logico;
	reg recibido;
	//logico = (cantidad[7]||cantidad[6]||cantidad[5]||cantidad[4]||cantidad[3]||cantidad[2]||cantidad[1]||cantidad[0]);
	initial
	begin
		ECHO = 0;
		recibido = 0;
	end
	always@(posedge CLKOUT)
	begin
		if(reset)
		begin
			ECHO <= 0;
			recibido <= 0;
		end
		else
		begin
			if(entrada)
			begin
				recibido <= cantidad;
			end
			if(recibido>0)
			begin
				recibido <= recibido - 1;
				ECHO <= 1;
			end
			else
			begin
				ECHO <= 0;
			end
		end
	end
endmodule
