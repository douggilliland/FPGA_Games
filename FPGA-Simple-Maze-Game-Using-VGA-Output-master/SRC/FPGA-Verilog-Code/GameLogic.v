
module GameLogic(input uclk,
							 input [10:0] PixelX,
							 input [10:0] PixelY,
							 input reset,
							 input BtnLeft,
							 input BtnRight,
							 input BtnTop,
							 input BtnBottom,							 
							 output reg [2:0] R,
							 output reg [2:0] G,
							 output reg [1:0] B
							 );
	
	/* ===============================================================================
	 *                             Parameters/Constants
	 * =============================================================================== */
	parameter PLAYER_BOX_WIDTH		  	= 30;
	parameter PLAYER_BOX_WIDTH_HALF	= PLAYER_BOX_WIDTH/2;
	
	parameter INITIAL_START_POS_X 	= 40;
	parameter INITIAL_START_POS_Y 	= 40;
	
	
	/* ===============================================================================
	 *                              Level selector
	 * =============================================================================== */
	
	//reg [3:0] CurrentLevel;	
	
	/* ===============================================================================
	 *                          Initial register values
	 * =============================================================================== */
	
	initial begin
			UserCurrentPositionX = INITIAL_START_POS_X + PLAYER_BOX_WIDTH_HALF;
			UserCurrentPositionY = INITIAL_START_POS_X + PLAYER_BOX_WIDTH_HALF;
	
			clk_reduced = 1;
	end
	
	
	/* ===============================================================================
	 *                                Position variables
	 * =============================================================================== */
	
	reg signed [11:0] UserCurrentPositionX;
	reg signed [11:0] UserCurrentPositionY;	
	
	// Image Maze values
	wire [2:0] ImageMazeR;
	wire [2:0] ImageMazeG;
	wire [1:0] ImageMazeB;	
	
	
	/* ===============================================================================
	 *                                Collision Detection
	 * =============================================================================== */
	
	
	wire [2:0] CollisionDetect_XRight_R, CollisionDetect_XLeft_R, CollisionDetect_YTop_R, CollisionDetect_YBottom_R;
	wire [2:0] CollisionDetect_XRight_G, CollisionDetect_XLeft_G, CollisionDetect_YTop_G, CollisionDetect_YBottom_G;
	wire [1:0] CollisionDetect_XRight_B, CollisionDetect_XLeft_B, CollisionDetect_YTop_B, CollisionDetect_YBottom_B;
	
	assign FlagCollisionDetected_Right  = (CollisionDetect_XRight_R == 3'b000 &&
													   CollisionDetect_XRight_G == 3'b000 &&
													   CollisionDetect_XRight_B == 2'b00);
													  
	assign FlagCollisionDetected_Left   = (CollisionDetect_XLeft_R == 3'b000 &&
													   CollisionDetect_XLeft_G == 3'b000 &&
													   CollisionDetect_XLeft_B == 2'b00);
													  
	assign FlagCollisionDetected_Top    = (CollisionDetect_YTop_R == 3'b000 &&
													   CollisionDetect_YTop_G == 3'b000 &&
													   CollisionDetect_YTop_B == 2'b00);
														
	assign FlagCollisionDetected_Bottom = (CollisionDetect_YBottom_R == 3'b000 &&
													   CollisionDetect_YBottom_G == 3'b000 &&
													   CollisionDetect_YBottom_B == 2'b00);
															
		
	/* ===============================================================================
	 *                          Reduced clock for movement
	 * =============================================================================== */
	 
	reg [30:0] clk_counter = 0;
	reg clk_reduced;
	
	always @(uclk)
	begin
		if (clk_counter >= 8000000)
		begin
			clk_counter = 0;
			clk_reduced = ~clk_reduced;		
		end
		else
		begin
			clk_counter = clk_counter + 1;
		end
	
	end
	
	
	/* ===============================================================================
	 *                                  Game logic
	 * =============================================================================== */
	
	
	always @(*)
	begin
	
	
		if (reset == 1)
		begin
			UserCurrentPositionX = INITIAL_START_POS_X + PLAYER_BOX_WIDTH_HALF;
			UserCurrentPositionY = INITIAL_START_POS_X + PLAYER_BOX_WIDTH_HALF;
		end
		else
		begin
		
			if (clk_counter == 1)
			begin
			
				if (BtnBottom == 1 && FlagCollisionDetected_Bottom == 0) begin
					UserCurrentPositionY = $signed(UserCurrentPositionY) + $signed(12'b000000000001);
				end
				
				if (BtnTop == 1 && FlagCollisionDetected_Top == 0) begin
					UserCurrentPositionY = $signed(UserCurrentPositionY) - $signed(12'b000000000001);
				end
				
				if (BtnRight == 1 && FlagCollisionDetected_Right == 0) begin
					UserCurrentPositionX = $signed(UserCurrentPositionX) + $signed(12'b000000000001);
				end
				
				if (BtnLeft == 1 && FlagCollisionDetected_Left == 0) begin
					UserCurrentPositionX = $signed(UserCurrentPositionX) - $signed(12'b000000000001);
				end
				
			
				if ($signed(UserCurrentPositionY) < $signed(0)) begin
						UserCurrentPositionY = $signed(0);
				end
				if ($signed(UserCurrentPositionY) > $signed(600)) begin
						UserCurrentPositionY = $signed(600);
				end
				if ($signed(UserCurrentPositionX) < $signed(0)) begin
						UserCurrentPositionX = $signed(0);
				end
				if ($signed(UserCurrentPositionX) > $signed(800)) begin
						UserCurrentPositionX = $signed(800);
				end
				
			end
				
		end
	
	
	end
	
	
	/* ===============================================================================
	 *                          Graphics output
	 * =============================================================================== */
	
	always @(uclk)
	begin
		
		if (PixelX >= (UserCurrentPositionX - PLAYER_BOX_WIDTH_HALF) &&
			 PixelX <= (UserCurrentPositionX + PLAYER_BOX_WIDTH_HALF) &&
			 PixelY >= (UserCurrentPositionY - PLAYER_BOX_WIDTH_HALF) &&
			 PixelY <= (UserCurrentPositionY + PLAYER_BOX_WIDTH_HALF))
		begin
			R[2:0] = 3'b000;
			G[2:0] = 3'b000;
			B[1:0] = 2'b11;
		end
		else
		begin
			R[2:0] = ImageMazeR[2:0];
			G[2:0] = ImageMazeG[2:0];
			B[1:0] = ImageMazeB[1:0];
		end
		
	end	


	/* ===============================================================================
	 *                               Module instantiations
	 * =============================================================================== */
	 
	 /*defparam isHeldFor4Seconds.SECONDS = 4;
	 IsHeldForXSeconds isHeldFor4Seconds(.uclk(uclk),
													 .reset(1'b0),
													 .btn(reset),
													 .val(reset_held_for_more_than_4_sec));*/
	 

	ImageMazeChannelValueROM ImageMazeROM(												
												.PixelX1(PixelX),
												.PixelY1(PixelY),
												.R1(ImageMazeR),
												.G1(ImageMazeG),
												.B1(ImageMazeB),
												
												.PixelX2(UserCurrentPositionX[10:0] + PLAYER_BOX_WIDTH_HALF),
												.PixelY2(UserCurrentPositionY[10:0]),
												.R2(CollisionDetect_XRight_R),
												.G2(CollisionDetect_XRight_G),
												.B2(CollisionDetect_XRight_B),
												
												.PixelX3(UserCurrentPositionX[10:0] - PLAYER_BOX_WIDTH_HALF),
												.PixelY3(UserCurrentPositionY[10:0]),
												.R3(CollisionDetect_XLeft_R),
												.G3(CollisionDetect_XLeft_G),
												.B3(CollisionDetect_XLeft_B),
												
												.PixelX4(UserCurrentPositionX[10:0]),
												.PixelY4(UserCurrentPositionY[10:0] - PLAYER_BOX_WIDTH_HALF),
												.R4(CollisionDetect_YTop_R),
												.G4(CollisionDetect_YTop_G),
												.B4(CollisionDetect_YTop_B),
												
												.PixelX5(UserCurrentPositionX[10:0]),
												.PixelY5(UserCurrentPositionY[10:0] + PLAYER_BOX_WIDTH_HALF),
												.R5(CollisionDetect_YBottom_R),
												.G5(CollisionDetect_YBottom_G),
												.B5(CollisionDetect_YBottom_B)
												
												);
												
	

endmodule
