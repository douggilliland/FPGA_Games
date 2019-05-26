`timescale 1ns / 1ps

module automaton
 (clk, rst_n, over, start_sig, gameready_sig, over_sig
 );
 input clk;
 input rst_n;
 input over;
 output start_sig;
 output gameready_sig;
 output over_sig;
 
 /**************************************************/
 
parameter ready = 3'b001, game = 3'b010, game_over = 3'b100;
parameter T5S = 30'd125_000_000;
reg[29:0] count_T5S;
reg start;
 
always@(posedge clk or negedge rst_n)
begin
if(!rst_n) 
    begin
		start <= 0;
		count_T5S <= 0;
	end
else
	begin
		if(count_T5S < T5S)
			begin
				count_T5S <= count_T5S + 1'b1;
				start <= 0;
			end
		else if(count_T5S == T5S)
			begin
				count_T5S <= 0;
				start <= 1;
			end
		else
			begin
				count_T5S <= 0;
				start <= 0;
			end
	end 
 end
 
 /**************************************************/
 
 reg[2:0] game_current_process;
 reg[2:0] game_next_process;
 reg start_sig;
 reg gameready_sig;
 reg over_sig;
 
 always @ ( posedge clk or negedge rst_n )
   begin
     if( !rst_n )
        game_current_process <= ready;
     else 
        game_current_process <= game_next_process;
   end
   
 always @ ( game_current_process or start or over )
	begin
		case( game_current_process )
		ready:
		begin
			ready_out;
			if( start )
				game_next_process = game;
			else 
				game_next_process = ready;
		end 
		game:
		begin
			game_out;
			if( over )
				game_next_process = game_over;
			else 
				game_next_process = game;
		end
		game_over:
		begin
			over_out;
			game_next_process = game_over;
		end
		default:
		begin
			ready_out;
			game_next_process = ready;
		end
	endcase
   end	                           

 task ready_out;
 { gameready_sig, start_sig, over_sig } = 3'b100;
 endtask   

 task game_out;
 { gameready_sig, start_sig, over_sig } = 3'b010;
 endtask
 
 task over_out;
 { gameready_sig, start_sig, over_sig } = 3'b001;
 endtask
 
 /**************************************************/
 
 endmodule
 
