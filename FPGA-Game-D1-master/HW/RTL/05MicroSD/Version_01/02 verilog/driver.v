module driver
(
	input     clk,
	input      [15:0]  DataIN,
	input      [7:0]  Addr,
	input     Enable,
	input     R/W,
	output    Done,
	output     [15:0]  DataOUT
);

endmodule
