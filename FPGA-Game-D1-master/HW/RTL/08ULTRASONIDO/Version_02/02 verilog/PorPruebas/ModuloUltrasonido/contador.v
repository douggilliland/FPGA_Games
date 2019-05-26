module contador		(
				output	wire	[7:0] count,
				output	reg	pulse,
				output	reg	calculate,
				input		ECHO,
				input		ENABLE,
				input		CLKOUT,
				input		reset
			);
	reg [7:0] count0;
	reg logico;
	//reg calculate;
	initial 
	begin
		count0=0;
		pulse=0;
		calculate=0;
	end
	
	always@(reset or posedge CLKOUT or ENABLE)
	begin
		logico=(count0[7]||count0[6]||count0[5]||count0[4]||count0[3]||count0[2]||count0[1]||count0[0]);
		if(reset)
		begin
			count0=0;
			calculate=0;
			pulse=0;
		end
		//	Da la orden de mandar un pulso
		else
		begin
			if(ENABLE)
			begin
				pulse=1'b1;
			end
			//
			//	Cuenta el rango que tiene el pulso del ECHO del sensor
			//
			if(ECHO)
			begin
				count0=count0+1;
			end
			if(!ECHO && logico)
			begin
				calculate = 1;
			end
		end
	end
	assign count = count0;
endmodule
