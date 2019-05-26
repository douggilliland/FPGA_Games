module	anteconmutador	(
					input			clk,
					input		[7:0]	d,
					input			DONE,
					output	reg	[3:0]	centenas,
					output	reg	[3:0]	decenas,
					output	reg	[3:0]	unidades,
					output	reg		C,
					output	reg		De,
					output	reg		U
			);
	reg	[7:0]	digitT;
	reg		i;
	
	initial
	begin
		digitT = 0;
		C = 0;
		De = 0;
		U = 0;
		centenas = 0;
		decenas	 = 0;
		unidades = 0;
		i = 1;
	end
	always@(posedge clk)
	begin	
		if(DONE)
		begin
			if(i)
			begin
				digitT = d;
				i = 0;
			end
			if(digitT>7'b1100011)
			begin
				digitT	 = digitT - 7'b1100100;
				centenas = centenas + 1;
				
			end
			else
			begin
				if(digitT>7'b0001001)
				begin
					digitT	= digitT - 7'b0001010;
					decenas	= decenas + 1;
				end
				else
				begin
					unidades = {digitT[3:0]};
					if(centenas >= 1)
					begin
						C = 1;
					end
					if(decenas  >= 1)
					begin
						De = 1;
					end
					if(unidades >= 1)
					begin
						U = 1;
					end
				end
			end
		end
		else
		begin
			if(!DONE)
			begin
				digitT = 0;
				C = 0;
				De = 0;
				U = 0;
				i = 1;
				centenas = 0;
				decenas	 = 0;
				unidades = 0;
			end
		end
	end
endmodule
