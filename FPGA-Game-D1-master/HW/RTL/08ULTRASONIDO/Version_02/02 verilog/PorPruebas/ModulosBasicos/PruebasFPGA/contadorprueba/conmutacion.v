module conmutacion	(
				input		[3:0]	centenas,
				input		[3:0]	decenas,
				input		[3:0]	unidades,
				input			C,
				input			De,
				input			U,
				input			CLKOUTseg,
				output	reg	[1:0]	mostrar,
				output	reg	[3:0]	digito
			);


	reg		logic0;
	reg	[1:0]	titileo;
	initial
	begin
		titileo = 0;
	end
	always@(posedge CLKOUTseg)
	begin
		if(C && De && U)
		begin
			/*if(titileo == 3)
			begin
				titileo <= 1;
			end*/
			titileo	<= titileo + 1;
		end
		else
		begin
			if(De && U)
			begin
				/*if(titileo == 1)
				begin
					titileo <= 1;
				end*/
				titileo	<= titileo + 1;
			end
			else
			begin
				if(U)
				begin
					titileo	<= 1;
				end
				else
				begin
					titileo <= 0;
				end
			end
		end
	end
	always@(posedge CLKOUTseg)
	begin
			case(titileo)
				2'b00:
				begin
					mostrar = 2'b01;
					digito	= 0;
				end
				2'b01:
				begin
					mostrar = 2'b01;
					digito	= unidades;
				end
				2'b10:
				begin
					mostrar = 2'b10;
					digito	= decenas; 
				end
				2'b11:
				begin
					mostrar = 2'b11;
					digito	= centenas;
				end
			endcase	
	end


endmodule
