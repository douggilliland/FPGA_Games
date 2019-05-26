module	divisor (
					input			reset,
					input		[7:0]	count,
					input			calculate,
					input			CLKOUTD,
					output	reg		DONE,
					output		[7:0]	d
							);
	reg	[7:0]	registro;
	reg	[7:0]	registro0;
	reg		logico;
	assign	d = registro;
	initial
	begin
		registro=0;
		registro0=0;
		DONE=0;
	end
	always@(posedge CLKOUTD)
	begin
		logico=(registro0[7]||registro0[6]||registro0[5]||registro0[4]||registro0[3]||registro0[2]||registro0[1]||registro0[0]);
		if(reset)
		begin
			registro=0;
			registro0=0;
			DONE=0;
		end
		else
		begin
			if(calculate)
			begin
				registro0 = {count[7:0]};
			end
			if(calculate && logico)
			begin
				registro  = registro0 >> 1;//{1'b0,registro0[7:1]};
				DONE = 1;
			end
		end
	end
endmodule
