`timescale 1ns / 1ps

module square_gen
(clk, rst_n, 
rotate_r, rotate_l, loading_square, enable_little, little_square_num, enable_moving,square_type_out
);
input clk;
input rst_n;
input rotate_r;
input rotate_l;
input loading_square;
input[499:0] enable_little;
input[8:0] little_square_num;
output[15:0] enable_moving;
output[2:0] square_type_out;
/**************************************************/

wire rotate_en;
reg[15:0] enable_moving_r;
reg rotate_l_dly;
reg rotate_r_dly;

always @ ( posedge clk or negedge rst_n )
	begin 
	if( !rst_n )
		begin 
			rotate_r_dly <= 1'b0;
		end
	else 
		begin 
			rotate_r_dly <= rotate_r;
		end
	end
	
/**************************************************/

reg[15:0] enable_moving_rotate;

always @ ( posedge clk or negedge rst_n )
	begin
	if( !rst_n )
		enable_moving_rotate <= 16'b0000_0111_0010_0000;
	else if( rotate_r == 1'b1 )
		begin
		 enable_moving_rotate[0] <= enable_moving_rotate[12];
		 enable_moving_rotate[1] <= enable_moving_rotate[8];
		 enable_moving_rotate[2] <= enable_moving_rotate[4];
		 enable_moving_rotate[3] <= enable_moving_rotate[0];
		 enable_moving_rotate[4] <= enable_moving_rotate[13];
		 enable_moving_rotate[5] <= enable_moving_rotate[9];
		 enable_moving_rotate[6] <= enable_moving_rotate[5];
		 enable_moving_rotate[7] <= enable_moving_rotate[1];
		 enable_moving_rotate[8] <= enable_moving_rotate[14];
		 enable_moving_rotate[9] <= enable_moving_rotate[10];
		 enable_moving_rotate[10] <= enable_moving_rotate[6];
		 enable_moving_rotate[11] <= enable_moving_rotate[2];
		 enable_moving_rotate[12] <= enable_moving_rotate[15];
		 enable_moving_rotate[13] <= enable_moving_rotate[11];
		 enable_moving_rotate[14] <= enable_moving_rotate[7];
		 enable_moving_rotate[15] <= enable_moving_rotate[3];
		end
		 else if( rotate_r_dly && (~rotate_en) )
			begin
			enable_moving_rotate <= enable_moving_r;
		end
		else if(rotate_r_dly||rotate_r)
		begin
			enable_moving_rotate <= enable_moving_rotate;
		end
		else
			begin
		enable_moving_rotate <= enable_moving_r;		 
			end 
	end
	
/**************************************************/
//********************
reg[7:0] rand_num; 

always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		 begin
		rand_num <= 8'b1111_1111;
		end			
	else
		begin
			rand_num[0] <= rand_num[7];
			rand_num[1] <= rand_num[0];
			rand_num[2] <= rand_num[1];
			rand_num[3] <= rand_num[2];
			rand_num[4] <= rand_num[3]^rand_num[7];
			rand_num[5] <= rand_num[4]^rand_num[7];
			rand_num[6] <= rand_num[5]^rand_num[7];
			rand_num[7] <= rand_num[6];
		end
			
end


/**************************************************/

reg[2:0] square_type;
 always @ ( posedge clk or negedge rst_n )
	begin 
	if( !rst_n )
		square_type <= 3'd0;
	else if( loading_square )
		square_type<=rand_num[3:1];
	else 
		square_type <= square_type;
	end
							
/**************************************************/



always @ ( posedge clk or negedge rst_n )
	begin 
	if( !rst_n )
		enable_moving_r <= 16'b0000_0111_0010_0000;
	else if( rotate_r_dly && rotate_en )
		begin 
		 enable_moving_r[0] <= enable_moving_rotate[0];
		 enable_moving_r[1] <= enable_moving_rotate[1];
		 enable_moving_r[2] <= enable_moving_rotate[2];
		 enable_moving_r[3] <= enable_moving_rotate[3];
		 enable_moving_r[4] <= enable_moving_rotate[4];
		 enable_moving_r[5] <= enable_moving_rotate[5];
		 enable_moving_r[6] <= enable_moving_rotate[6];
		 enable_moving_r[7] <= enable_moving_rotate[7];
		 enable_moving_r[8] <= enable_moving_rotate[8];
		 enable_moving_r[9] <= enable_moving_rotate[9];
		 enable_moving_r[10] <= enable_moving_rotate[10];
		 enable_moving_r[11] <= enable_moving_rotate[11];
		 enable_moving_r[12] <= enable_moving_rotate[12];
		 enable_moving_r[13] <= enable_moving_rotate[13];
		 enable_moving_r[14] <= enable_moving_rotate[14];
		 enable_moving_r[15] <= enable_moving_rotate[15];
		end
			
		
	else if( loading_square )
		begin
		 case( square_type )
			3'b000: enable_moving_r <= 16'b0000_0111_0010_0000;
			3'b001: enable_moving_r <= 16'b0000_0110_0110_0000;
			3'b010: enable_moving_r <= 16'b0010_0010_0010_0010;
			3'b011: enable_moving_r <= 16'b0000_0011_0110_0000;
			3'b100: enable_moving_r <= 16'b0000_0110_0011_0000;
			3'b101: enable_moving_r <= 16'b0000_0011_0010_0010;
			3'b110: enable_moving_r <= 16'b0000_0011_0001_0001;
			default: enable_moving_r <= 16'b0000_0110_0110_0000;
		 endcase
		end
	else 
		enable_moving_r <= enable_moving_r;
	end
	
/**************************************************/



assign rotate_en = ~ ( (enable_moving_rotate[0] && enable_little[little_square_num]) ||
						(enable_moving_rotate[1] && enable_little[little_square_num + 9'd1]) ||	
						(enable_moving_rotate[2] && enable_little[little_square_num + 9'd2]) || 
						(enable_moving_rotate[3] && enable_little[little_square_num + 9'd3]) || 
						(enable_moving_rotate[4] && enable_little[little_square_num + 9'd20]) || 
						(enable_moving_rotate[5] && enable_little[little_square_num + 9'd21]) || 
						(enable_moving_rotate[6] && enable_little[little_square_num + 9'd22]) || 
						(enable_moving_rotate[7] && enable_little[little_square_num + 9'd23]) || 
						(enable_moving_rotate[8] && enable_little[little_square_num + 9'd40]) || 
						(enable_moving_rotate[9] && enable_little[little_square_num + 9'd41]) || 
						(enable_moving_rotate[10] && enable_little[little_square_num + 9'd42]) || 
						(enable_moving_rotate[11] && enable_little[little_square_num + 9'd43]) || 
						(enable_moving_rotate[12] && enable_little[little_square_num + 9'd60]) || 
						(enable_moving_rotate[13] && enable_little[little_square_num + 9'd61]) || 
						(enable_moving_rotate[14] && enable_little[little_square_num + 9'd62]) || 
						(enable_moving_rotate[15] && enable_little[little_square_num + 9'd63]) );
						
/**************************************************/

assign enable_moving = enable_moving_r;
assign square_type_out = square_type;

/**************************************************/

endmodule 