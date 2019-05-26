module	ultrasonido	(
				output [7:0]	d,
				output 		trigg,
				output 		DONE,
				input 		ENABLE,
				input 		ECHO,
				input		clk,
				input		reset

			 );
wire [7:0] count;

divisorfrec	divisorfrec0	(	
					.clk		(	clk		),
					.CLKOUT		(	CLKOUT		)
				);

divisorfrecgen	divisorfrecgen0	(	
					.clk		(	clk		),
					.CLKOUT1	(	CLKOUT1		)
				);

divisorfrecd	divisorfrecd0	(
					.clk		(	clk		),
					.CLKOUTD	(	CLKOUTD		)
				);

genpulsos	genpulsos0	(
					.ENABLE		(	ENABLE		),
					.CLKOUT1	(	CLKOUT1		),
					.reset		(	reset		),
					.trigg		(	trigg		)
				);


contador	contador0	(
					.reset		(	reset		),
					.count		(	count		),
					.calculate	(	calculate	),
					.ECHO		(	ECHO		),
					.CLKOUT		(	CLKOUT		)
				);



divisor		divisor0	(
					.reset		(	reset		),
					.count		(	count	),
					.calculate	(	calculate	),
					.DONE		(	DONE		),
					.d		(	d		),
					.CLKOUTD	(	CLKOUTD		)
				);

endmodule
