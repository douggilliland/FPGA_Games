module fifo_TB;

reg clk;
reg rst;
reg rd;
reg wr;
reg data_in;


fifo uttf(.rd(rd),.wr(wr),.din(data_in),.reset(rst),.clock(clk));

/* Clocking device */
always
begin

clk =1'b1;
#2;
clk=1'b0;
#2;
end

initial
begin
rst =1'b1;
#10000;
rst =1'b0;
end


initial begin
#4;
data_in=1'b1; #1 wr=1; #2 wr=0;
data_in="o"; #1 wr=1; #2 wr=0;
data_in="l"; #1 wr=1; #2 wr=0;
data_in="a"; #1 wr=1; #2 wr=0;
data_in=" "; #1 wr=1; #2 wr=0;
data_in="m"; #1 wr=1; #2 wr=0;
data_in="u"; #1 wr=1; #2 wr=0;
data_in="n"; #1 wr=1; #2 wr=0;
data_in="d"; #1 wr=1; #2 wr=0;
data_in="o"; #1 wr=1; #2 wr=0;
data_in="."; #1 wr=1; #2 wr=0;
data_in="1"; #1 wr=1; #2 wr=0;
data_in="2"; #1 wr=1; #2 wr=0;
data_in="3"; #1 wr=1; #2 wr=0;
data_in="4"; #1 wr=1; #2 wr=0;
data_in="5"; #1 wr=1; #2 wr=0;
data_in="6"; #1 wr=1; #2 wr=0;
data_in="7"; #1 wr=1; #2 wr=0;
data_in="8"; #1 wr=1; #2 wr=0;
data_in="9"; #1 wr=1; #2 wr=0;
data_in="0"; #1 wr=1; #2 wr=0;

#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;

data_in="a"; #1 wr=1; rd=0;#2 wr=0;rd=1;
data_in="b"; #1 wr=1; #2 wr=0;
data_in="c"; #1 wr=1; #2 wr=0;
data_in="d"; #1 wr=1; #2 wr=0;

#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;
#1 rd=1; #2 rd=0;


end
	
initial begin: TEST_CASE
     $dumpfile("fifo_TB.vcd");
     $dumpvars(-1, uttf);

     #(1000000) $finish;
   end

endmodule //

