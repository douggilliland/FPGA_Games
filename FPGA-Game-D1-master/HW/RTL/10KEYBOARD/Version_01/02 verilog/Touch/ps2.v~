module	ps2	(
			input		Rx,
			input		CLKOUT,
			output	reg	Rx_error,
			output	[7:0]	DATA,
			output	reg	DONE
		);
	reg	[8:0]	regis;
	reg	[7:0]	regis0;
	reg	[3:0]	i;
	reg	[3:0]	j;
	reg	init;
	initial
	begin
		i=0;
		j=0;
		init=0;
		regis=0;
		regis0=0;
		Rx_error=0;
		DONE=0;
	end
	always@(posedge CLKOUT)
	begin
		if(!Rx&&!i)
		begin
			init<=1;
		end
//		lectura			//
//		lectura			//
//		lectura			//
		if(init)
		begin
			regis[i]=Rx;
			i<=i+1;
			if(regis[i])
			begin
				j=j+1;
			end
		end
//		finalizar		//
//		finalizar		//
//		finalizar		//
		if(i==9)
		begin
			if(!(j%2)&&(regis[8]))
			begin
				i<=0;
				init=0;
				Rx_error=0;
				regis0={regis[7:0]};
				DONE=1;
			end
			else
			begin
				Rx_error=1;
				regis0=0;
				init=0;
				i<=0;
				DONE=0;
			end
		end
	end
	assign	DATA=regis0;
endmodule
