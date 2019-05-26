module Microfono(RESET,CLK,ENABLE,D_IN,BCLK,WS,D_OUT,DONE, D_AMP);

	input wire RESET;
	input wire CLK;
	input wire ENABLE;
	input wire D_IN;
	output wire BCLK;
	output wire WS;
	output wire [17:0] D_OUT;
	output wire DONE;
	output wire D_AMP;

	wire COUNT18;
	wire COUNT32;
	wire RESET_INT;
	wire EN_BCLK;
	wire [5:0] COUNT;
	wire [17:0] DATA;

	assign D_AMP = D_IN;

	FSM _FSM(
		.RESET(RESET),
		.CLK(CLK),
		.ENABLE(ENABLE),
		.COUNT18(COUNT18),
		.COUNT32(COUNT32),
		.RESET_INT(RESET_INT),
		.DONE(DONE),
		.EN_BCLK(EN_BCLK)
	);

	DivFreq _DivFrec(
		.RESET(RESET_INT),
		.CLK(CLK),
		.EN_CLK(EN_BCLK),
		.BCLK(BCLK)
	);

	RegAcum _RegAcum(
		.RESET(RESET_INT),
		.BCLK(BCLK),
		.SET(COUNT32),
		.COUNT(COUNT)
	);

	Comp _Comp(
		.COUNT(COUNT),
		.COUNT18(COUNT18),
		.COUNT32(COUNT32)
	);

	RegWS _RegWS(
		.RESET(RESET_INT),
		.SET32(COUNT32),
		.WS(WS)
	);

	RegDes _RegDes(
		.RESET(RESET_INT),
		.BCLK(BCLK),
		.D_IN(D_IN),
		.DATA(DATA)
	);

	RegSal _RegSal(
		.RESET(RESET_INT),
		.LOAD(COUNT18),
		.DATA(DATA),
		.D_OUT(D_OUT)
	);

endmodule
