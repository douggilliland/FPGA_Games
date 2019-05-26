
module Display16bitHexNumber(input uclk,
									  input [15:0] display_value,
									  output [3:0] AN,
									  output A,
									  output B,
									  output C,
									  output D,
									  output E,
									  output F,
									  output G,
									  output DecimalPoint);
									  
	// =======================================================================
	// Wires
	// =======================================================================
	wire [3:0] bits_value_to_show;
	wire [1:0] display_element;

	// =======================================================================
	// Module instantiations
	// =======================================================================
	
	Mux16to4 bitsToShow(.Input(display_value),
							  .Selector(display_element),
							  .Output(bits_value_to_show));
	
	DisplayScanCounter scanCounter(.clk(uclk),
											 .reset(reset),
											 .DisplayElement(display_element));
	
	DisplayElement2to4Selector dispE2to4(.DisplayElementSelect(display_element),
													 .AN(AN));
	
	SevenSegmentDisplayDecoder sevenSegDecoder(.hexValue(bits_value_to_show),
															 .A(A),
															 .B(B),
															 .C(C),
															 .D(D),
															 .E(E),
															 .F(F),
															 .G(G),
															 .DecimalPoint(DecimalPoint));


endmodule
