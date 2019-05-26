module	genpulsosprueba	(
				input		pulse,
				input		clk,
				input		reset,
				output		trigg,
				output		CLKOUT1,
				output		ledpul0,
				output		ledpul1
			);
	genpulsos	genpulsos0		(
							.pulse		(	pulse	),
							.CLKOUT1	(	CLKOUT1	),
							.reset		(	reset	),
							.trigg		(	trigg	),
							.ledpul0	(	ledpul0	),
							.ledpul1	(	ledpul1	)
						);

	divisorfrecgen	divisorfrecgen0		(
							.clk			(	clk	),
							.CLKOUT1		(	CLKOUT1	)
						);
endmodule
