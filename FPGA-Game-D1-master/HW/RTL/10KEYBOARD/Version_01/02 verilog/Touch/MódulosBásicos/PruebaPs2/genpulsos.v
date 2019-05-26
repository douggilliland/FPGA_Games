module	genpulsos	(
											input		  init,
											input		  CLKOUT1,
											input		  reset,
											output		enable
			            );
	reg	Doit;
	reg	NoDoit;
	assign	enable=(Doit && ~NoDoit);
	
	initial
	begin
		Doit=0;
		NoDoit=0;
	end

	always@(posedge CLKOUT1)
	begin
		if(reset)
		begin
			Doit      =   0;
			NoDoit    =   0;
		end
		else
		begin
			if(init)
			begin
				Doit    <=  1'b1;
			end
			if(init && Doit)
			begin
				NoDoit  <=  1'b1;
			end
		end
	end
	//assign	sign=ECHO;
endmodule
