module	genpulsos	(
				input		pulse,
				input		CLKOUT1,
				input		reset,
				output		trigg,
				output reg      ledpul0,
				output reg      ledpul1
			);
	reg	Doit;
	reg	NoDoit;
	assign trigg=(Doit && ~NoDoit);
	
	initial
	begin
		Doit<=0;
		NoDoit<=0;
		ledpul0<=0;
		ledpul1<=0;
	end

	always@(posedge CLKOUT1)
	begin
		if(reset)
		begin
			Doit<=0;
			NoDoit<=0;
			ledpul0<=0;
			ledpul1<=0;
		end
		else
		begin
			if(pulse)
			begin
				ledpul0<=1;
				Doit<=1'b1;
			end
			if(pulse && Doit)
			begin
				NoDoit<=1'b1;
				ledpul1<=1;
			end
		end
	end
endmodule
