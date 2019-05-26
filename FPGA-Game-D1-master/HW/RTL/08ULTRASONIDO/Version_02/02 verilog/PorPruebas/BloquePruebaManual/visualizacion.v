module	visualizacion	(
				input			clk,
				input			ECHO,
				input			orden,
				output			trigg,
				output		[3:0]	anodo,
				output		[6:0]	seg
			);
	wire	[7:0]	d;
	wire	[7:0]	distancia;
	wire	[1:0]	mostrar;
	wire	[3:0]	digito;
	wire	[3:0]	anodo;
	wire	[6:0]	seg;
	wire	[3:0]	centenas;
	wire	[3:0]	decenas;
	wire	[3:0]	unidades;
	divisorfrecdisp	divisorfrecdisp0		(
								.clk		(	clk		),
								.CLKOUTseg	(	CLKOUTseg	)
							);
	/////////////////////////////////////////////
	anteconmutador	anteconmutador0			(
								.clk		(	clk		),
								.d		(	d		),
								.DONE		(	DONE		),
								.centenas	(	centenas	),
								.decenas	(	decenas		),
								.unidades	(	unidades	),
								.C		(	C		),
								.D		(	D		),
								.U		(	U		)
							);
	/////////////////////////////////////////////
	conmutacion	conmutacion0			(
								.centenas	(	centenas	),
								.decenas	(	decenas		),
								.unidades	(	unidades	),
								.C		(	C		),
								.D		(	D		),
								.U		(	U		),
								.CLKOUTseg	(	CLKOUTseg	),
								.mostrar	(	mostrar		),
								.digito		(	digito		)
							);
	
	/////////////////////////////////////////////
	display		display				(
								.mostrar	(	mostrar		),
								.digito		(	digito		),
								.anodo		(	anodo		),
								.seg		(	seg		)
							);/*
	/////////////////////////////////////////////
	pulsodisplay	pulsodisplay			(
								.DONE		(	DONE		),
								.d		(	d		),
								.CLKOUTseg	(	CLKOUTseg	),	// Esto Toca Cambiarlo
								.pulse		(	pulse		),
								.distancia	(	distancia	)
							);*/
	/////////////////////////////////////////////
	bloqueultrasonido	bloqueultrasonido	(
								.d		(	d	),
						 		.trigg		(	trigg	),
						 		.DONE		(	DONE	),
								.clk		(	clk	),
		                          			.orden		(	orden	),
						 		.ECHO		(	ECHO	)
							);
endmodule
