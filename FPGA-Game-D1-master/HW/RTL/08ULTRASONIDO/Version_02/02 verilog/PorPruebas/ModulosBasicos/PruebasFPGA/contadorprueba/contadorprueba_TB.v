module contadorprueba_TB;

	reg		[7:0]	cantidad;
	reg			entrada;
	reg			ENABLE;
	reg			clk;
	reg			reset;
	wire		[3:0]	an;
	wire		[6:0]	seg;
	wire			pulse;
	contadorprueba uut	(
					.cantidad	(	cantidad	),
					.entrada	(	entrada		),
					.ENABLE		(	ENABLE		),
					.clk		(	clk		),
					.reset		(	reset		)
				);

	always
	begin
		clk =1'b1;
		#1;
		clk=1'b0;
		#1;
	end

	initial 
	begin
		cantidad = 50;
		entrada	= 0;
		#10000;
		entrada	= 1;
		#10000;
		ENABLE = 1;
		#10000;
		
	end


initial begin: TEST_CASE
     $dumpfile("contadorprueba_TB.vcd");
     $dumpvars(-1, uut);
     #(1000000) $finish;
   end

endmodule //
