module	pulsodisplay	(
				input			DONE,
				input		[7:0]	d,
				input			CLKOUTseg,
				output	reg		pulse,
				output	reg	[7:0]	distancia
			);
	reg	Doit;
	reg	NoDoit;
	//assign pulse=(Doit && ~NoDoit);
	
	initial
	begin
		Doit=0;
		NoDoit=0;
	end

	always@(DONE or posedge CLKOUTseg)
	begin
		if(!DONE)
		begin
			Doit=0;
			NoDoit=0;
			pulse=(Doit && ~NoDoit);
		end
		else
		begin
			if(DONE)
			begin
				Doit<=1'b1;
			end
			if(DONE && Doit)
			begin
				NoDoit<=1'b1;
				distancia=d;
			end
			pulse=(Doit && ~NoDoit);
		end
	end
endmodule
