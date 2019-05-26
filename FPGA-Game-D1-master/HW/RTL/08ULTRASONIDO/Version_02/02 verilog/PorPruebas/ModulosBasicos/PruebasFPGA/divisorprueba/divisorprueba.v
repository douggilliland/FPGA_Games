module	divisorprueba	(
				input			reset,
				input		[7:0]	count,
				input			calculate,
				input			clk,
				output		[3:0]	an,
				output		[6:0]	seg
			);
	//wire	[7:0]	count;
	wire	[7:0]	d;
	wire	[3:0]	centenas;
	wire	[3:0]	decenas;
	wire	[3:0]	unidades;
	divisor		divisor0		(	
							.reset		(	reset		),
							.count		(	count		),
							.calculate	(	calculate	),
							.CLKOUTD	(	CLKOUTD		),
							.DONE		(	DONE		),
							.d		(	d		)
						);
	divisorfrecd	divisorfrecd0		(	
							.clk		(	clk		),
							.CLKOUTD	(	CLKOUTD		)
						);
	anteconmutador	anteconmutador0		(
							.clk		(	clk		),
							.d		(	d		),
							.DONE		(	DONE		),
							.centenas	(	centenas	),
							.decenas	(	decenas		),
							.unidades	(	unidades	),
							.C		(	C		),
							.De		(	De		),
							.U		(	U		)
						);
	conmutacion	conmutacion0		(
							.centenas	(	centenas	),
							.decenas	(	decenas		),
							.unidades	(	unidades	),
							.C		(	C		),
							.De		(	De		),
							.U		(	U		),
							.CLKOUTseg	(	CLKOUTseg	),
							.mostrar	(	mostrar		),
							.digito		(	digito		)
						);
	display		display0		(
							.mostrar	(	mostrar		),
							.digito		(	digito		),
							.an		(	an		),
							.seg		(	seg		)
						);
	divisorfrecdisp	divisorfrecdisp0	(
							.clk		(	clk		),
							.CLKOUTseg	(	CLKOUTseg	)
						);	
endmodule
