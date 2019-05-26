
module FinalProjectMainWrapper(input uclk,
				  input [4:0] btn,
				  output hsync,
				  output vsync,
				  output reg [2:0] RED,
				  output reg [2:0] GREEN,
				  output reg [1:0] BLUE
				  
				  /*output [3:0] AN,
				  output A,
				  output B,
				  output C,
				  output D,
				  output E,
				  output F,
				  output G,
				  output DecimalPoint*/);
	 
	 wire clk_50mhz;
	 wire hsync_out;
	 wire vsync_out;
	 wire vidon;
	 
	 wire [10:0] PixelX;
	 wire [10:0] PixelY;
	 
	 wire [2:0] ImageMazeR;
	 wire [2:0] ImageMazeG;
	 wire [1:0] ImageMazeB;
	 
	 
	 assign hsync = ~hsync_out;
	 assign vsync = ~vsync_out;
	 
	 //assign Led[4:0] = btn[4:0];
	 //assign Led[7:5] = {clk_red_test, clk_red_test, clk_red_test};
	 
	 
	// =======================================================================
	// Time to complete
	// =======================================================================
	
	/*wire [15:0] counter_value;
	wire [3:0] bits_value_to_show;
	wire [1:0] display_element;
	
	ValueToDisplayCount vtdCount (.clk(uclk),
											.reset(btn[0]),
											.direction(1'b0),
											.value(counter_value));
	
	Mux16to4 bitsToShow(.Input(counter_value),
							  .Selector(display_element),
							  .Output(bits_value_to_show));
	
	DisplayScanCounter scanCounter(.clk(uclk),
											 .reset(btn[0]),
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
															 .DecimalPoint(DecimalPoint));*/
	 
	 
	 always @(clk_50mhz)
	 begin
		
		if (vidon)
		begin
			
			RED[2:0] = ImageMazeR;
				GREEN[2:0] = ImageMazeG;
				BLUE[1:0] = ImageMazeB;
		
		end
		else
		begin
			
			RED[2:0] = 3'b000;
			GREEN[2:0] = 3'b000;
			BLUE[1:0] = 2'b00;
		
		end
		
		
	 end
	 
	 
	 GameLogic gameLogic(.uclk(uclk),
						 .PixelX(PixelX),
						 .PixelY(PixelY),
						 .reset(btn[0]),
						 .BtnLeft(btn[2]),
						 .BtnRight(btn[4]),
						 .BtnTop(btn[1]),
						 .BtnBottom(btn[3]),
						 .R(ImageMazeR),
						 .G(ImageMazeG),
						 .B(ImageMazeB));
	 
	 
	 
	 vga_800x600(.clk(clk_50mhz),
	             .clr(btn[0]),
					 .hsync(hsync_out),
					 .vsync(vsync_out),
					 .PixelX(PixelX),
					 .PixelY(PixelY),
					 .vidon(vidon));
	 

	  Clock clk50 (.CLK_IN1(uclk),
						.CLK_OUT1(clk_50mhz));

endmodule
