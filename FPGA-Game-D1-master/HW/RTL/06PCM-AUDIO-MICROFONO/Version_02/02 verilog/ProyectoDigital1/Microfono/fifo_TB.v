//----------------------------------------------------------------------------
`timescale 1 ns / 100 ps

module fifo_TB;

//----------------------------------------------------------------------------
// Parameter (may differ for physical synthesis)
//----------------------------------------------------------------------------
parameter tck              = 2;       // clock period in ns
//----------------------------------------------------------------------------
//----------------------------------------------------------------------------

reg clk;
reg rst;

reg rd,wr;
reg [7:0] data_in;

//----------------------------------------------------------------------------
// Device Under Test 
//------------------------------------------------------------------

fifo  uut(.reset(rst),.clk(clk),.rd(rd),.wr(wr),.data_in(data_in));


/* Clocking device */
initial begin
	clk <= 0;
	rst <=1;
	#(2*tck) rst=0;
	rd <=0;
	wr<=0;
end

always #(tck/2) clk <= ~clk;


initial begin
#4;
data_in="h"; #1 wr=1; #2 wr=0;
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

data_in="a"; #1 wr=1; #2 wr=0;
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
     $dumpvars(-1, uut);
     #(200) $finish;
   end

endmodule //
