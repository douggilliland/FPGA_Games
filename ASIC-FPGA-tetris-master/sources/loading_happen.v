`timescale 1ns / 1ps
module loading_happen
	(clk, rst_n, move_right, move_left, row_addr_sig, blue,
	 start_sig, enable_moving, h, v, enable_little, loading_square, little_square_num, over_out,
	 verticalspeed_out,score_out, level_up
	);	
	input clk;
	input rst_n;
	input move_right;
	input move_left;
	input[10:0] row_addr_sig;
	input blue;
	input start_sig;
	input[15:0] enable_moving;
	input verticalspeed_out;
	output[10:0] h;
	output[10:0] v;
	output[499:0] enable_little;
	output loading_square;
	output[8:0] little_square_num;
	output over_out;
	output[15:0] score_out;
	output level_up;
	
	/**************************************************/
	 
reg inc10_n;
reg[499:0] enable_little_r;
reg[8:0] little_square_num_r;
reg[10:0] ish;
reg[10:0] isv;
reg dec10_n;
wire[19:0] sub_line;
wire sub_line_total;
wire temp;
wire v10_enable;
reg loading_square_r;

	
parameter T1S = 26'd25_000_000;	 
parameter speedup = 26'd10_000_000;
parameter one_per_four=26'd3_000_000;
	
	
/*************************************************/
wire[25:0] vs;
reg[15:0] score;
reg flag1;
reg flag2;
reg flag3;
reg flag4;
assign levelup = score > 0;
assign vs = verticalspeed_out ? one_per_four : (levelup ? speedup : T1S);
assign level_up = levelup;

reg[25:0] count_down;
	
always @ ( posedge clk or negedge rst_n )
	begin 
		
		if( !rst_n )
			count_down	<=	26'd0;
		else if( count_down >= vs )
			count_down	<=	26'd0;
		else if( start_sig )
			count_down	<=	count_down + 1'b1;
	end
		
	/**************************************************/
reg[7:0] rand_num; 
	
always@(posedge clk or negedge rst_n)
begin
	if(!rst_n)
		begin
			rand_num	<= 8'b1111_1111;
		end			
	else
		begin
			rand_num[0]	<=	rand_num[7];
			rand_num[1]	<=	rand_num[0];
			rand_num[2]	<=	rand_num[1];
			rand_num[3]	<=	rand_num[2];
			rand_num[4]	<=	rand_num[3]^rand_num[7];
			rand_num[5]	<=	rand_num[4]^rand_num[7];
			rand_num[6]	<=	rand_num[5]^rand_num[7];
			rand_num[7]	<=	rand_num[6];
		end
				
end
	
always @ ( posedge clk or negedge rst_n )
	begin 
		if( !rst_n )
			little_square_num_r	<=	9'd10;
		else if( loading_square_r )
			little_square_num_r	<=	rand_num % 8 + 3'd5;
		 
		else if( move_right == 1'b1 )
			begin
				if( !inc10_n )
					little_square_num_r	<=	little_square_num_r + 1'b1;
			end
		else if( move_left == 1'b1 )	
			begin
				if( !dec10_n )
					little_square_num_r	<=	little_square_num_r - 1'b1;
			end
		else if( v10_enable )
			little_square_num_r	<=	little_square_num_r + 9'd20;//每一排有20个方块，到时候可以调节这个参数
		else
			little_square_num_r	<=	little_square_num_r;
		end						


always @ ( posedge clk or negedge rst_n )
	begin 
		if( !rst_n )
			ish	<=	11'd504;
		else if( loading_square_r )
			ish	<=	11'd404+(rand_num%8)*20;
		else if( move_right == 1'b1 )
			begin
				if( !inc10_n )
					ish	<=	ish + 11'd20;
				else 
					ish	<=	ish;
			end
		else if( move_left == 1'b1 )
			begin
				if( !dec10_n )
					ish	<=	ish - 11'd20;
				else 
				ish	<=	ish;
			end
		else 
			ish	<=	ish;	
	end
					
	/**************************************************/	
	

	
	always @ ( posedge clk or negedge rst_n )
		begin 
		if( !rst_n )
			isv	<=	11'd41;
		else if( loading_square_r )
			isv	<=	11'd41;
		else if( v10_enable )
			isv	<=	isv + 11'd20;
		else 
			isv	<=	isv;
		end
	 
	/**************************************************/ 

	//判断能否左移
	always @ ( posedge clk or negedge rst_n )
		begin
		if( !rst_n )
			inc10_n	<=	1'b1;
		else 
			inc10_n	<=	( (enable_moving[0] && enable_little_r[little_square_num_r + 9'd1]) ||
						(enable_moving[1] && enable_little_r[little_square_num_r + 9'd2]) ||		 
						(enable_moving[2] && enable_little_r[little_square_num_r + 9'd3]) ||
						(enable_moving[3] && enable_little_r[little_square_num_r + 9'd4]) ||
						(enable_moving[4] && enable_little_r[little_square_num_r + 9'd21]) ||
						(enable_moving[5] && enable_little_r[little_square_num_r + 9'd22]) ||
						(enable_moving[6] && enable_little_r[little_square_num_r + 9'd23]) ||
						(enable_moving[7] && enable_little_r[little_square_num_r + 9'd24]) ||
						(enable_moving[8] && enable_little_r[little_square_num_r + 9'd41]) ||
						(enable_moving[9] && enable_little_r[little_square_num_r + 9'd42]) ||
						(enable_moving[10] && enable_little_r[little_square_num_r + 9'd43]) ||
						(enable_moving[11] && enable_little_r[little_square_num_r + 9'd44]) ||
						(enable_moving[12] && enable_little_r[little_square_num_r + 9'd61]) ||
						(enable_moving[13] && enable_little_r[little_square_num_r + 9'd62]) ||
						(enable_moving[14] && enable_little_r[little_square_num_r + 9'd63]) ||
						(enable_moving[15] && enable_little_r[little_square_num_r + 9'd64]) );
		end
		
	/**************************************************/
	
//判断能否右移
	
	always @ ( posedge clk or negedge rst_n )
		begin
		if( !rst_n )
			dec10_n	<=	1'b1;
		else 
			dec10_n	<=	( (enable_moving[0] && enable_little_r[little_square_num_r - 9'd1]) ||
						(enable_moving[1] && enable_little_r[little_square_num_r]) ||		 
						(enable_moving[2] && enable_little_r[little_square_num_r + 9'd1]) ||
						(enable_moving[3] && enable_little_r[little_square_num_r + 9'd2]) ||
						(enable_moving[4] && enable_little_r[little_square_num_r + 9'd19]) ||
						(enable_moving[5] && enable_little_r[little_square_num_r + 9'd20]) ||
						(enable_moving[6] && enable_little_r[little_square_num_r + 9'd21]) ||
						(enable_moving[7] && enable_little_r[little_square_num_r + 9'd22]) ||
						(enable_moving[8] && enable_little_r[little_square_num_r + 9'd39]) ||
						(enable_moving[9] && enable_little_r[little_square_num_r + 9'd40]) ||
						(enable_moving[10] && enable_little_r[little_square_num_r + 9'd41]) ||
						(enable_moving[11] && enable_little_r[little_square_num_r + 9'd42]) ||
						(enable_moving[12] && enable_little_r[little_square_num_r + 9'd59]) ||
						(enable_moving[13] && enable_little_r[little_square_num_r + 9'd60]) ||
						(enable_moving[14] && enable_little_r[little_square_num_r + 9'd61]) ||
						(enable_moving[15] && enable_little_r[little_square_num_r + 9'd62]) );
		end							
								
	/**************************************************/
	

	/***********************************/
	always@(posedge clk or negedge rst_n)
	begin
	if(!rst_n)
	begin
	score[3:0] <= 0;
	flag1 <= 0;
	end
	else 
	begin
	if((score[3:0]+sub_line[0]+sub_line[1]+sub_line[2]+sub_line[3]+sub_line[4]+
			sub_line[5]+sub_line[6]+sub_line[7]+sub_line[8]+sub_line[9]+
			 sub_line[10]+sub_line[11]+sub_line[12]+sub_line[13]+sub_line[14]+
			 sub_line[15]+sub_line[16]+sub_line[17]+sub_line[18]+sub_line[19])>9)
		begin
		score[3:0] <= score[3:0]+sub_line[0]+sub_line[1]+sub_line[2]+sub_line[3]+sub_line[4]+
			sub_line[5]+sub_line[6]+sub_line[7]+sub_line[8]+sub_line[9]+
			 sub_line[10]+sub_line[11]+sub_line[12]+sub_line[13]+sub_line[14]+
			 sub_line[15]+sub_line[16]+sub_line[17]+sub_line[18]+sub_line[19]-4'd10;
		flag1 <= 1;
		end
		else
		begin
		score[3:0] <= score[3:0]+sub_line[0]+sub_line[1]+sub_line[2]+sub_line[3]+sub_line[4]+
			sub_line[5]+sub_line[6]+sub_line[7]+sub_line[8]+sub_line[9]+
			 sub_line[10]+sub_line[11]+sub_line[12]+sub_line[13]+sub_line[14]+
			 sub_line[15]+sub_line[16]+sub_line[17]+sub_line[18]+sub_line[19];
	 flag1 <= 0;
		end
		
	end
	end
	//***************************************************************************************
	always@(posedge clk or negedge rst_n)
	begin
	if(!rst_n)
	begin
	score[7:4] <= 0;
	flag2 <= 0;
	end
	else 
	begin
	if((score[7:4]+flag1)>9)
		begin
		score[7:4] <= score[7:4]+flag1-4'd10;
		flag2 <= 1;
		end
		else
		begin
		score[7:4] <= score[7:4]+flag1;
		flag2 <= 0;
		end
		
	end
	end
	//******************************
	
	 always@(posedge clk or negedge rst_n)
	begin
	if(!rst_n)
	begin
	score[11:8] <= 0;
	flag3 <= 0;
	end
	else 
	begin
	if((score[11:8]+flag2)>9)
		begin
		score[11:8] <=	score[11:8]+flag2-4'd10;
		flag3 <= 1;
		end
		else
		begin
		score[11:8] <= score[11:8]+flag2;
		flag3 <= 0;
		end
		
	end
	end
	//********************************
		always@(posedge clk or negedge rst_n)
	begin
	if(!rst_n)
	begin
	score[15:12] <= 0;
	flag4 <= 0;
	end
	else 
	begin
	if((score[15:12]+flag3)>9)
		begin
		score[15:12] <=	score[15:12]+flag3-4'd10;
		flag4 <= 1;
		end
		else
		begin
		score[15:12] <= score[15:12]+flag3;
		flag4 <= 0;
		end
		
	end
	end
	//********************************
	assign score_out=score;
	
	
	
	//判断能否消除行

	
	assign sub_line[0] = & enable_little_r[14:5];
	assign sub_line[1] = & enable_little_r[34:25];
	assign sub_line[2] = & enable_little_r[54:45];
	assign sub_line[3] = & enable_little_r[74:65];
	assign sub_line[4] = & enable_little_r[94:85];
	assign sub_line[5] = & enable_little_r[114:105];
	assign sub_line[6] = & enable_little_r[134:125];
	assign sub_line[7] = & enable_little_r[154:145];
	assign sub_line[8] = & enable_little_r[174:165];
	assign sub_line[9] = & enable_little_r[194:185];
	assign sub_line[10] = & enable_little_r[214:205];
	assign sub_line[11] = & enable_little_r[234:225];
	assign sub_line[12] = & enable_little_r[254:245];
	assign sub_line[13] = & enable_little_r[274:265];
	assign sub_line[14] = & enable_little_r[294:285];
	assign sub_line[15] = & enable_little_r[314:305];
	assign sub_line[16] = & enable_little_r[334:325];
	assign sub_line[17] = & enable_little_r[354:345];
	assign sub_line[18] = & enable_little_r[374:365];
	assign sub_line[19] = & enable_little_r[394:385];
	assign sub_line_total = | sub_line[19:0];
	
	/**************************************************/ 
//判断能否下移的logic
	wire v10_enable2;
	reg v10_enable2_dly;
	assign temp = ( (enable_moving[0] && enable_little_r[little_square_num_r + 9'd20]) ||
					(enable_moving[1] && enable_little_r[little_square_num_r + 9'd21]) ||		 
					(enable_moving[2] && enable_little_r[little_square_num_r + 9'd22]) ||
					(enable_moving[3] && enable_little_r[little_square_num_r + 9'd23]) ||
						
					(enable_moving[4] && enable_little_r[little_square_num_r + 9'd40]) ||
					(enable_moving[5] && enable_little_r[little_square_num_r + 9'd41]) ||
					(enable_moving[6] && enable_little_r[little_square_num_r + 9'd42]) ||
					(enable_moving[7] && enable_little_r[little_square_num_r + 9'd43]) ||
						
					(enable_moving[8] && enable_little_r[little_square_num_r + 9'd60]) ||
					(enable_moving[9] && enable_little_r[little_square_num_r + 9'd61]) ||
					(enable_moving[10] && enable_little_r[little_square_num_r + 9'd62]) ||
					(enable_moving[11] && enable_little_r[little_square_num_r + 9'd63]) ||
					(enable_moving[12] && enable_little_r[little_square_num_r + 9'd80]) ||
					(enable_moving[13] && enable_little_r[little_square_num_r + 9'd81]) ||
					(enable_moving[14] && enable_little_r[little_square_num_r + 9'd82]) ||
					(enable_moving[15] && enable_little_r[little_square_num_r + 9'd83]) );
	assign v10_enable = (count_down==vs) && ( ~temp );				
	 
	assign v10_enable2 = (count_down==vs) && ( temp );
	 always @ ( posedge clk or negedge rst_n )
		begin
		if( !rst_n )
			v10_enable2_dly	<=	1'b0;
		else 
			v10_enable2_dly	<=	v10_enable2;
		end
	/**************************************************/
	
	reg v10_enable_dly;
	
	always @ ( posedge clk or negedge rst_n )
		begin
		if( !rst_n )
			v10_enable_dly	<=	1'b0;
		else 
			v10_enable_dly	<=	v10_enable;
		end
		
	/**************************************************/
	

	
	always @ ( posedge clk or negedge rst_n )
		begin
		if( !rst_n )
			loading_square_r	<=	1'b0;
		else 
			loading_square_r	<=	(v10_enable_dly && temp)||v10_enable2_dly;	
		end
		
	/**************************************************/
	
	
	always @ ( posedge clk or negedge rst_n )
		begin
		if( !rst_n ) 
			begin
			//方块边界赋初值
			 enable_little_r[4:0]	<=	5'b11111;
			 enable_little_r[24:20]	<=	5'b11111;
			 enable_little_r[44:40]	<=	5'b11111;
			 enable_little_r[64:60]	<=	5'b11111;
			 enable_little_r[84:80]	<=	5'b11111;
			 
			 enable_little_r[104:100]	<=	5'b11111;
			 enable_little_r[124:120]	<=	5'b11111;
			 enable_little_r[144:140]	<=	5'b11111;
			 enable_little_r[164:160]	<=	5'b11111;
			 enable_little_r[184:180]	<=	5'b11111;
			 
			 enable_little_r[204:200]	<=	5'b11111;
			 enable_little_r[224:220]	<=	5'b11111;
			 enable_little_r[244:240]	<=	5'b11111;
			 enable_little_r[264:260]	<=	5'b11111;
			 enable_little_r[284:280]	<=	5'b11111;
			 
			 enable_little_r[304:300]	<=	5'b11111;
			 enable_little_r[324:320]	<=	5'b11111;
			 enable_little_r[344:340]	<=	5'b11111;
			 enable_little_r[364:360]	<=	5'b11111;
			 enable_little_r[384:380]	<=	5'b11111;
			 
			 
			 
			 
			 
			 enable_little_r[19:15]	<=	5'b11111;
			 enable_little_r[39:35]	<=	5'b11111;
			 enable_little_r[59:55]	<=	5'b11111;
			 enable_little_r[79:75]	<=	5'b11111;
			 enable_little_r[99:95]	<=	5'b11111;
			 
			 enable_little_r[119:115]	<=	5'b11111;
			 enable_little_r[139:135]	<=	5'b11111;
			 enable_little_r[159:155]	<=	5'b11111;
			 enable_little_r[179:175]	<=	5'b11111;
			 enable_little_r[199:195]	<=	5'b11111;
			 
			 enable_little_r[219:215]	<=	5'b11111;
			 enable_little_r[239:235]	<=	5'b11111;
			 enable_little_r[259:255]	<=	5'b11111;
			 enable_little_r[279:275]	<=	5'b11111;
			 enable_little_r[299:295]	<=	5'b11111;
			 
			 enable_little_r[319:315]	<=	5'b11111;
			 enable_little_r[339:335]	<=	5'b11111; 
			 enable_little_r[359:355]	<=	5'b11111;
			 enable_little_r[379:375]	<=	5'b11111;
			 enable_little_r[399:395]	<=	5'b11111;
			 
			 
			 enable_little_r[419:400]	<=	20'b1111_1111_1111_1111_1111;
			 enable_little_r[439:420]	<=	20'b1111_1111_1111_1111_1111;
			 enable_little_r[459:440]	<=	20'b1111_1111_1111_1111_1111;
			 enable_little_r[479:460]	<=	20'b1111_1111_1111_1111_1111;
			 enable_little_r[499:480]	<=	20'b1111_1111_1111_1111_1111;
			 
			 
			 
			 //方块界面清空
			 enable_little_r[14:5]	<=	10'b0;
			 enable_little_r[34:25]	<=	10'b0;
			 enable_little_r[54:45]	<=	10'b0;
			 enable_little_r[74:65]	<=	10'b0;
			 enable_little_r[94:85]	<=	10'b0;
			 
			 enable_little_r[114:105]	<=	10'b0;
			 enable_little_r[134:125]	<=	10'b0;
			 enable_little_r[154:145]	<=	10'b0;
			 enable_little_r[174:165]	<=	10'b0;
			 enable_little_r[194:185]	<=	10'b0;
			 
			 enable_little_r[214:205]	<=	10'b0;
			 enable_little_r[234:225]	<=	10'b0;
			 enable_little_r[254:245]	<=	10'b0;
			 enable_little_r[274:265]	<=	10'b0;
			 enable_little_r[294:285]	<=	10'b0;
			 
			 enable_little_r[314:305]	<=	10'b0;
			 enable_little_r[334:325]	<=	10'b0;
			 enable_little_r[354:345]	<=	10'b0;
			 enable_little_r[374:365]	<=	10'b0;
			 enable_little_r[394:385]	<=	10'b0;
			end 
			
			
			
		else if( sub_line_total )
			begin 
			//消除行
			 if( sub_line[0] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[34:25];
					enable_little_r[54:45]	<=	enable_little_r[54:45];
					enable_little_r[74:65]	<=	enable_little_r[74:65];
					enable_little_r[94:85]	<=	enable_little_r[94:85];
					enable_little_r[114:105]	<=	enable_little_r[114:105];
					enable_little_r[134:125]	<=	enable_little_r[134:125];
					enable_little_r[154:145]	<=	enable_little_r[154:145];
					enable_little_r[174:165]	<=	enable_little_r[174:165];
					enable_little_r[194:185]	<=	enable_little_r[194:185];
					enable_little_r[214:205]	<=	enable_little_r[214:205];
					enable_little_r[234:225]	<=	enable_little_r[234:225];
					enable_little_r[254:245]	<=	enable_little_r[254:245];
					enable_little_r[274:265]	<=	enable_little_r[274:265];
					enable_little_r[294:285]	<=	enable_little_r[294:285];			 
					enable_little_r[314:305]	<=	enable_little_r[314:305];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

					
				end
			 if( sub_line[1] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[54:45];
					enable_little_r[74:65]	<=	enable_little_r[74:65];
					enable_little_r[94:85]	<=	enable_little_r[94:85];
					enable_little_r[114:105]	<=	enable_little_r[114:105];
					enable_little_r[134:125]	<=	enable_little_r[134:125];
					enable_little_r[154:145]	<=	enable_little_r[154:145];
					enable_little_r[174:165]	<=	enable_little_r[174:165];
					enable_little_r[194:185]	<=	enable_little_r[194:185];
					enable_little_r[214:205]	<=	enable_little_r[214:205];
					enable_little_r[234:225]	<=	enable_little_r[234:225];
					enable_little_r[254:245]	<=	enable_little_r[254:245];
					enable_little_r[274:265]	<=	enable_little_r[274:265];
					enable_little_r[294:285]	<=	enable_little_r[294:285];			 
					enable_little_r[314:305]	<=	enable_little_r[314:305];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end 
			 if( sub_line[2] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[74:65];
					enable_little_r[94:85]	<=	enable_little_r[94:85];
					enable_little_r[114:105]	<=	enable_little_r[114:105];
					enable_little_r[134:125]	<=	enable_little_r[134:125];
					enable_little_r[154:145]	<=	enable_little_r[154:145];
					enable_little_r[174:165]	<=	enable_little_r[174:165];
					enable_little_r[194:185]	<=	enable_little_r[194:185];
					enable_little_r[214:205]	<=	enable_little_r[214:205];
					enable_little_r[234:225]	<=	enable_little_r[234:225];
					enable_little_r[254:245]	<=	enable_little_r[254:245];
					enable_little_r[274:265]	<=	enable_little_r[274:265];
					enable_little_r[294:285]	<=	enable_little_r[294:285];			 
					enable_little_r[314:305]	<=	enable_little_r[314:305];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end		
			 if( sub_line[3] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[94:85];
					enable_little_r[114:105]	<=	enable_little_r[114:105];
					enable_little_r[134:125]	<=	enable_little_r[134:125];
					enable_little_r[154:145]	<=	enable_little_r[154:145];
					enable_little_r[174:165]	<=	enable_little_r[174:165];
					enable_little_r[194:185]	<=	enable_little_r[194:185];
					enable_little_r[214:205]	<=	enable_little_r[214:205];
					enable_little_r[234:225]	<=	enable_little_r[234:225];
					enable_little_r[254:245]	<=	enable_little_r[254:245];
					enable_little_r[274:265]	<=	enable_little_r[274:265];
					enable_little_r[294:285]	<=	enable_little_r[294:285];			 
					enable_little_r[314:305]	<=	enable_little_r[314:305];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end
			 if( sub_line[4] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[114:105];
					enable_little_r[134:125]	<=	enable_little_r[134:125];
					enable_little_r[154:145]	<=	enable_little_r[154:145];
					enable_little_r[174:165]	<=	enable_little_r[174:165];
					enable_little_r[194:185]	<=	enable_little_r[194:185];
					enable_little_r[214:205]	<=	enable_little_r[214:205];
					enable_little_r[234:225]	<=	enable_little_r[234:225];
					enable_little_r[254:245]	<=	enable_little_r[254:245];
					enable_little_r[274:265]	<=	enable_little_r[274:265];
					enable_little_r[294:285]	<=	enable_little_r[294:285];			 
					enable_little_r[314:305]	<=	enable_little_r[314:305];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end
			 if( sub_line[5] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[94:85];
					enable_little_r[134:125]	<=	enable_little_r[134:125];
					enable_little_r[154:145]	<=	enable_little_r[154:145];
					enable_little_r[174:165]	<=	enable_little_r[174:165];
					enable_little_r[194:185]	<=	enable_little_r[194:185];
					enable_little_r[214:205]	<=	enable_little_r[214:205];
					enable_little_r[234:225]	<=	enable_little_r[234:225];
					enable_little_r[254:245]	<=	enable_little_r[254:245];
					enable_little_r[274:265]	<=	enable_little_r[274:265];
					enable_little_r[294:285]	<=	enable_little_r[294:285];			 
					enable_little_r[314:305]	<=	enable_little_r[314:305];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end 
			 if( sub_line[6] )
				begin
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[94:85];
					enable_little_r[134:125]	<=	enable_little_r[114:105];
					enable_little_r[154:145]	<=	enable_little_r[154:145];
					enable_little_r[174:165]	<=	enable_little_r[174:165];
					enable_little_r[194:185]	<=	enable_little_r[194:185];
					enable_little_r[214:205]	<=	enable_little_r[214:205];
					enable_little_r[234:225]	<=	enable_little_r[234:225];
					enable_little_r[254:245]	<=	enable_little_r[254:245];
					enable_little_r[274:265]	<=	enable_little_r[274:265];
					enable_little_r[294:285]	<=	enable_little_r[294:285];			 
					enable_little_r[314:305]	<=	enable_little_r[314:305];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end	
			 if( sub_line[7] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[94:85];
					enable_little_r[134:125]	<=	enable_little_r[114:105];
					enable_little_r[154:145]	<=	enable_little_r[134:125];
					enable_little_r[174:165]	<=	enable_little_r[174:165];
					enable_little_r[194:185]	<=	enable_little_r[194:185];
					enable_little_r[214:205]	<=	enable_little_r[214:205];
					enable_little_r[234:225]	<=	enable_little_r[234:225];
					enable_little_r[254:245]	<=	enable_little_r[254:245];
					enable_little_r[274:265]	<=	enable_little_r[274:265];
					enable_little_r[294:285]	<=	enable_little_r[294:285];			 
					enable_little_r[314:305]	<=	enable_little_r[314:305];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end	
			 if( sub_line[8] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[94:85];
					enable_little_r[134:125]	<=	enable_little_r[114:105];
					enable_little_r[154:145]	<=	enable_little_r[134:125];
					enable_little_r[174:165]	<=	enable_little_r[154:145];
					enable_little_r[194:185]	<=	enable_little_r[194:185];
					enable_little_r[214:205]	<=	enable_little_r[214:205];
					enable_little_r[234:225]	<=	enable_little_r[234:225];
					enable_little_r[254:245]	<=	enable_little_r[254:245];
					enable_little_r[274:265]	<=	enable_little_r[274:265];
					enable_little_r[294:285]	<=	enable_little_r[294:285];			 
					enable_little_r[314:305]	<=	enable_little_r[314:305];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end	
			 if( sub_line[9] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[94:85];
					enable_little_r[134:125]	<=	enable_little_r[114:105];
					enable_little_r[154:145]	<=	enable_little_r[134:125];
					enable_little_r[174:165]	<=	enable_little_r[154:145];
					enable_little_r[194:185]	<=	enable_little_r[174:165];
					enable_little_r[214:205]	<=	enable_little_r[214:205];
					enable_little_r[234:225]	<=	enable_little_r[234:225];
					enable_little_r[254:245]	<=	enable_little_r[254:245];
					enable_little_r[274:265]	<=	enable_little_r[274:265];
					enable_little_r[294:285]	<=	enable_little_r[294:285];			 
					enable_little_r[314:305]	<=	enable_little_r[314:305];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end	 
			 if( sub_line[10] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[94:85];
					enable_little_r[134:125]	<=	enable_little_r[114:105];
					enable_little_r[154:145]	<=	enable_little_r[134:125];
					enable_little_r[174:165]	<=	enable_little_r[154:145];
					enable_little_r[194:185]	<=	enable_little_r[174:165];
					enable_little_r[214:205]	<=	enable_little_r[194:185];
					enable_little_r[234:225]	<=	enable_little_r[234:225];
					enable_little_r[254:245]	<=	enable_little_r[254:245];
					enable_little_r[274:265]	<=	enable_little_r[274:265];
					enable_little_r[294:285]	<=	enable_little_r[294:285];			 
					enable_little_r[314:305]	<=	enable_little_r[314:305];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end	
			 if( sub_line[11] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[94:85];
					enable_little_r[134:125]	<=	enable_little_r[114:105];
					enable_little_r[154:145]	<=	enable_little_r[134:125];
					enable_little_r[174:165]	<=	enable_little_r[154:145];
					enable_little_r[194:185]	<=	enable_little_r[174:165];
					enable_little_r[214:205]	<=	enable_little_r[194:185];
					enable_little_r[234:225]	<=	enable_little_r[214:205];
					enable_little_r[254:245]	<=	enable_little_r[254:245];
					enable_little_r[274:265]	<=	enable_little_r[274:265];
					enable_little_r[294:285]	<=	enable_little_r[294:285];			 
					enable_little_r[314:305]	<=	enable_little_r[314:305];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end 
			 if( sub_line[12] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[94:85];
					enable_little_r[134:125]	<=	enable_little_r[114:105];
					enable_little_r[154:145]	<=	enable_little_r[134:125];
					enable_little_r[174:165]	<=	enable_little_r[154:145];
					enable_little_r[194:185]	<=	enable_little_r[174:165];
					enable_little_r[214:205]	<=	enable_little_r[194:185];
					enable_little_r[234:225]	<=	enable_little_r[214:205];
					enable_little_r[254:245]	<=	enable_little_r[234:225];
					enable_little_r[274:265]	<=	enable_little_r[274:265];
					enable_little_r[294:285]	<=	enable_little_r[294:285];			 
					enable_little_r[314:305]	<=	enable_little_r[314:305];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end 
			 if( sub_line[13] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[94:85];
					enable_little_r[134:125]	<=	enable_little_r[114:105];
					enable_little_r[154:145]	<=	enable_little_r[134:125];
					enable_little_r[174:165]	<=	enable_little_r[154:145];
					enable_little_r[194:185]	<=	enable_little_r[174:165];
					enable_little_r[214:205]	<=	enable_little_r[194:185];
					enable_little_r[234:225]	<=	enable_little_r[214:205];
					enable_little_r[254:245]	<=	enable_little_r[234:225];
					enable_little_r[274:265]	<=	enable_little_r[254:245];
					enable_little_r[294:285]	<=	enable_little_r[294:285];			 
					enable_little_r[314:305]	<=	enable_little_r[314:305];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end 
			 if( sub_line[14] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[94:85];
					enable_little_r[134:125]	<=	enable_little_r[114:105];
					enable_little_r[154:145]	<=	enable_little_r[134:125];
					enable_little_r[174:165]	<=	enable_little_r[154:145];
					enable_little_r[194:185]	<=	enable_little_r[174:165];
					enable_little_r[214:205]	<=	enable_little_r[194:185];
					enable_little_r[234:225]	<=	enable_little_r[214:205];
					enable_little_r[254:245]	<=	enable_little_r[234:225];
					enable_little_r[274:265]	<=	enable_little_r[254:245];
					enable_little_r[294:285]	<=	enable_little_r[274:265];			 
					enable_little_r[314:305]	<=	enable_little_r[314:305];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end
			 if( sub_line[15] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[94:85];
					enable_little_r[134:125]	<=	enable_little_r[114:105];
					enable_little_r[154:145]	<=	enable_little_r[134:125];
					enable_little_r[174:165]	<=	enable_little_r[154:145];
					enable_little_r[194:185]	<=	enable_little_r[174:165];
					enable_little_r[214:205]	<=	enable_little_r[194:185];
					enable_little_r[234:225]	<=	enable_little_r[214:205];
					enable_little_r[254:245]	<=	enable_little_r[234:225];
					enable_little_r[274:265]	<=	enable_little_r[254:245];
					enable_little_r[294:285]	<=	enable_little_r[274:265];			 
					enable_little_r[314:305]	<=	enable_little_r[294:285];
					enable_little_r[334:325]	<=	enable_little_r[334:325];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end
			 if( sub_line[16] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[94:85];
					enable_little_r[134:125]	<=	enable_little_r[114:105];
					enable_little_r[154:145]	<=	enable_little_r[134:125];
					enable_little_r[174:165]	<=	enable_little_r[154:145];
					enable_little_r[194:185]	<=	enable_little_r[174:165];
					enable_little_r[214:205]	<=	enable_little_r[194:185];
					enable_little_r[234:225]	<=	enable_little_r[214:205];
					enable_little_r[254:245]	<=	enable_little_r[234:225];
					enable_little_r[274:265]	<=	enable_little_r[254:245];
					enable_little_r[294:285]	<=	enable_little_r[274:265];			 
					enable_little_r[314:305]	<=	enable_little_r[294:285];
					enable_little_r[334:325]	<=	enable_little_r[314:305];
					enable_little_r[354:345]	<=	enable_little_r[354:345];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end
			 if( sub_line[17] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[94:85];
					enable_little_r[134:125]	<=	enable_little_r[114:105];
					enable_little_r[154:145]	<=	enable_little_r[134:125];
					enable_little_r[174:165]	<=	enable_little_r[154:145];
					enable_little_r[194:185]	<=	enable_little_r[174:165];
					enable_little_r[214:205]	<=	enable_little_r[194:185];
					enable_little_r[234:225]	<=	enable_little_r[214:205];
					enable_little_r[254:245]	<=	enable_little_r[234:225];
					enable_little_r[274:265]	<=	enable_little_r[254:245];
					enable_little_r[294:285]	<=	enable_little_r[274:265];			 
					enable_little_r[314:305]	<=	enable_little_r[294:285];
					enable_little_r[334:325]	<=	enable_little_r[314:305];
					enable_little_r[354:345]	<=	enable_little_r[334:325];
					enable_little_r[374:365]	<=	enable_little_r[374:365];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end
			 if( sub_line[18] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[94:85];
					enable_little_r[134:125]	<=	enable_little_r[114:105];
					enable_little_r[154:145]	<=	enable_little_r[134:125];
					enable_little_r[174:165]	<=	enable_little_r[154:145];
					enable_little_r[194:185]	<=	enable_little_r[174:165];
					enable_little_r[214:205]	<=	enable_little_r[194:185];
					enable_little_r[234:225]	<=	enable_little_r[214:205];
					enable_little_r[254:245]	<=	enable_little_r[234:225];
					enable_little_r[274:265]	<=	enable_little_r[254:245];
					enable_little_r[294:285]	<=	enable_little_r[274:265];			 
					enable_little_r[314:305]	<=	enable_little_r[294:285];
					enable_little_r[334:325]	<=	enable_little_r[314:305];
					enable_little_r[354:345]	<=	enable_little_r[334:325];
					enable_little_r[374:365]	<=	enable_little_r[354:345];
					enable_little_r[394:385]	<=	enable_little_r[394:385];

				end
				if( sub_line[19] )
				begin 
					enable_little_r[14:5]	<=	10'b0;
					enable_little_r[34:25]	<=	enable_little_r[14:5];
					enable_little_r[54:45]	<=	enable_little_r[34:25];
					enable_little_r[74:65]	<=	enable_little_r[54:45];
					enable_little_r[94:85]	<=	enable_little_r[74:65];
					enable_little_r[114:105]	<=	enable_little_r[94:85];
					enable_little_r[134:125]	<=	enable_little_r[114:105];
					enable_little_r[154:145]	<=	enable_little_r[134:125];
					enable_little_r[174:165]	<=	enable_little_r[154:145];
					enable_little_r[194:185]	<=	enable_little_r[174:165];
					enable_little_r[214:205]	<=	enable_little_r[194:185];
					enable_little_r[234:225]	<=	enable_little_r[214:205];
					enable_little_r[254:245]	<=	enable_little_r[234:225];
					enable_little_r[274:265]	<=	enable_little_r[254:245];
					enable_little_r[294:285]	<=	enable_little_r[274:265];			 
					enable_little_r[314:305]	<=	enable_little_r[294:285];
					enable_little_r[334:325]	<=	enable_little_r[314:305];
					enable_little_r[354:345]	<=	enable_little_r[334:325];
					enable_little_r[374:365]	<=	enable_little_r[354:345];
					enable_little_r[394:385]	<=	enable_little_r[374:365];

				end
			end
		else if( loading_square_r )
		 //加载小方块，要加载新的方块，原来的这个就停留在这个位置
			begin
			 enable_little_r[little_square_num_r]	<=	enable_moving[0] || enable_little_r[little_square_num_r];
			 enable_little_r[little_square_num_r + 8'd1]	<=	enable_moving[1] || enable_little_r[little_square_num_r + 8'd1];
			 enable_little_r[little_square_num_r + 8'd2]	<=	enable_moving[2] || enable_little_r[little_square_num_r + 8'd2];
			 enable_little_r[little_square_num_r + 8'd3]	<=	enable_moving[3] || enable_little_r[little_square_num_r + 8'd3];
			 
			 enable_little_r[little_square_num_r + 8'd20]	<=	enable_moving[4] || enable_little_r[little_square_num_r + 8'd20];
			 enable_little_r[little_square_num_r + 8'd21]	<=	enable_moving[5] || enable_little_r[little_square_num_r + 8'd21];
			 enable_little_r[little_square_num_r + 8'd22]	<=	enable_moving[6] || enable_little_r[little_square_num_r + 8'd22];
			 enable_little_r[little_square_num_r + 8'd23]	<=	enable_moving[7] || enable_little_r[little_square_num_r + 8'd23];
			 
			 enable_little_r[little_square_num_r + 8'd40]	<=	enable_moving[8] || enable_little_r[little_square_num_r + 8'd40];
			 enable_little_r[little_square_num_r + 8'd41]	<=	enable_moving[9] || enable_little_r[little_square_num_r + 8'd41];
			 enable_little_r[little_square_num_r + 8'd42]	<=	enable_moving[10] || enable_little_r[little_square_num_r + 8'd42];
			 enable_little_r[little_square_num_r + 8'd43]	<=	enable_moving[11] || enable_little_r[little_square_num_r + 8'd43];
			 
			 enable_little_r[little_square_num_r + 8'd60]	<=	enable_moving[12] || enable_little_r[little_square_num_r + 8'd60];
			 enable_little_r[little_square_num_r + 8'd61]	<=	enable_moving[13] || enable_little_r[little_square_num_r + 8'd61];
			 enable_little_r[little_square_num_r + 8'd62]	<=	enable_moving[14] || enable_little_r[little_square_num_r + 8'd62];
			 enable_little_r[little_square_num_r + 8'd63]	<=	enable_moving[15] || enable_little_r[little_square_num_r + 8'd63];
			end
		else 
			enable_little_r	<=	enable_little_r;
		end 
		
	/**************************************************/
	wire check_over;
	
	assign check_over=((enable_moving[0]&&enable_little_r[little_square_num_r])||
						(enable_moving[1]&&enable_little_r[little_square_num_r + 8'd1])||	
						(enable_moving[2]&&enable_little_r[little_square_num_r + 8'd2])||
							(enable_moving[3]&&enable_little_r[little_square_num_r + 8'd3])||
							
							(enable_moving[4]&&enable_little_r[little_square_num_r + 8'd20])||
							(enable_moving[5]&&enable_little_r[little_square_num_r + 8'd21])||
							(enable_moving[6]&&enable_little_r[little_square_num_r + 8'd22])||
							(enable_moving[7]&&enable_little_r[little_square_num_r + 8'd23])||
							
							(enable_moving[8]&&enable_little_r[little_square_num_r + 8'd40])||
							(enable_moving[9]&&enable_little_r[little_square_num_r + 8'd41])||
							(enable_moving[10]&&enable_little_r[little_square_num_r + 8'd42])||
							(enable_moving[11]&&enable_little_r[little_square_num_r + 8'd43])||
							
							(enable_moving[12]&&enable_little_r[little_square_num_r + 8'd60])||
							(enable_moving[13]&&enable_little_r[little_square_num_r + 8'd61])||
							(enable_moving[14]&&enable_little_r[little_square_num_r + 8'd62])||
							(enable_moving[15]&&enable_little_r[little_square_num_r + 8'd63])
							
							);
										 


	



	parameter T1_frame = 20'd307_199;	 //640*480
	
	reg over_out_r;

//判断游戏是否结束的信号
	always @ ( posedge clk or negedge rst_n )
		begin
		if( !rst_n )
			over_out_r	<=	1'b0;
		else if(check_over)
			over_out_r	<=	1'b1; 
		end
		
	/**************************************************/	
	
	assign h = ish;
	assign v = isv;
	assign enable_little = enable_little_r;
	assign loading_square = loading_square_r;
	assign little_square_num = little_square_num_r;
	assign over_out = over_out_r;
	 
	/**************************************************/
	
	endmodule
	