module	bloqueultrasonido	(
					output	[7:0]	d,
					output 		trigg,
					output 		DONE,
					input		clk,
                                  	input		orden,
					input 		ECHO
				);
maquinadeestados		maquinadeestados0	(
								.orden	(		orden		),
								.clk	(		clk		),
								.ENABLE	(		ENABLE		),
								.reset	(		reset		)
							);
ultrasonido			ultrasonido0		(
								.clk	(		clk		),
								.ENABLE	(		ENABLE		),
								.reset	(		reset		),
								.ECHO	(		ECHO		),
								.d	(		d		),
								.trigg	(		trigg		),
								.DONE	(		DONE		)
							);
endmodule
