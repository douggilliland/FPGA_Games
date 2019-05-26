module	contadorprueba	(
				input		[7:0]	cantidad,
				input			entrada,
				input			ENABLE,
				input			clk,
				input			reset,
				output		[3:0]	an,
				output		[6:0]	seg,
				output			pulse
			);
	wire	[7:0]	count;
	wire	[3:0]	centenas;
	wire	[3:0]	decenas;
	wire	[3:0]	unidades;
	wire	[1:0]	mostrar;
	wire	[3:0]	digito;
	cantidadecho	cantidadecho0		(
							.cantidad	(	cantidad	),
							.entrada	(	entrada		),
							.CLKOUT		(	CLKOUT		),
							.reset		(	reset		),
							.ECHO		(	ECHO		)
						);
	contador		contador0	(
							.count		(	count		),
							.pulse		(	pulse		),
							.calculate	(	calculate	),
							.ECHO		(	ECHO		),
							.ENABLE		(	ENABLE		),
							.CLKOUT		(	CLKOUT		),
							.reset		(	reset		)
						);
	divisorfrec		divisorfrec0	(
							.clk		(	clk		),
							.CLKOUT		(	CLKOUT		)
						);
	anteconmutador		anteconmutador0	(
							.clk		(	clk		),
							.count		(	count		),
							.calculate	(	calculate	),
							.centenas	(	centenas	),
							.decenas	(	decenas		),
							.unidades	(	unidades	),
							.C		(	C		),
							.De		(	De		),
							.U		(	U		)
						);
	conmutacion		conmutacion0	(
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
	display			display0	(
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
