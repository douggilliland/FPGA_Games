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

//Mío

#4;
data_in="D"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="a"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="m"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="i"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="t"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="a"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in=","; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in=" "; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="t"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="u"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in=" "; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="n"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="o"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="v"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="i"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="o"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in=" "; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="e"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="s"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in=" "; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="e"; #1 wr=1; rd=1; #2 wr=0; rd=0;


//Mío 2
#4;
rst=1;
#4;
rst=0;
#4;
data_in="s"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in=" "; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="e"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="l"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in=" "; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="h"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="o"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="m"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="b"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="r"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="e"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in=" "; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="m"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="a"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="s"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in=" "; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="a"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="f"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="o"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="r"; #1 wr=1; rd=1; #2 wr=0; rd=0;
data_in="t"; #1 wr=1; rd=1; #2 wr=0; rd=0;

//Mío 3

#4;
rst=1;
#4;
rst=0;
#4;
data_in="Q"; #1 wr=1; #2 wr=0;
data_in="u"; #1 wr=1; #2 wr=0;
data_in="e"; #1 wr=1; #2 wr=0;
data_in=" "; #1 wr=1; #2 wr=0;
data_in="l"; #1 wr=1; #2 wr=0;
data_in="a"; #1 wr=1; #2 wr=0;
data_in=" "; #1 wr=1; #2 wr=0;
data_in="v"; #1 wr=1; #2 wr=0;
data_in="i"; #1 wr=1; #2 wr=0;
data_in="d"; #1 wr=1; #2 wr=0;
data_in="a"; #1 wr=1; #2 wr=0;
data_in=" "; #1 wr=1; #2 wr=0;
data_in="s"; #1 wr=1; #2 wr=0;
data_in="e"; #1 wr=1; #2 wr=0;
data_in="a"; #1 wr=1; #2 wr=0;
data_in=" "; #1 wr=1; #2 wr=0;
data_in="m"; #1 wr=1; #2 wr=0;
data_in="a"; #1 wr=1; #2 wr=0;
data_in="s"; #1 wr=1; #2 wr=0;
data_in=" "; #1 wr=1; #2 wr=0;
data_in="p"; #1 wr=1; #2 wr=0;

//#1 rd=1; #2 rd=0;
//#1 rd=1; #2 rd=0;
//#1 rd=1; #2 rd=0;

//data_in="a"; #1 wr=1; #2 wr=0;
//data_in="b"; #1 wr=1; #2 wr=0;
//data_in="c"; #1 wr=1; #2 wr=0;
//data_in="d"; #1 wr=1; #2 wr=0;

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

#4;
data_in="Y"; #1 wr=1; #2 wr=0;
data_in="o"; #1 wr=1; #2 wr=0;
data_in=" "; #1 wr=1; #2 wr=0;
data_in="t"; #1 wr=1; #2 wr=0;
data_in="e"; #1 wr=1; #2 wr=0;
data_in=" "; #1 wr=1; #2 wr=0;
data_in="d"; #1 wr=1; #2 wr=0;
data_in="a"; #1 wr=1; #2 wr=0;
data_in="r"; #1 wr=1; #2 wr=0;
data_in="e"; #1 wr=1; #2 wr=0;
data_in=","; #1 wr=1; #2 wr=0;
data_in=" "; #1 wr=1; #2 wr=0;
data_in="t"; #1 wr=1; #2 wr=0;
data_in="e"; #1 wr=1; #2 wr=0;
data_in=" "; #1 wr=1; #2 wr=0;
data_in="d"; #1 wr=1; #2 wr=0;
data_in="a"; #1 wr=1; #2 wr=0;
data_in="r"; #1 wr=1; #2 wr=0;
data_in="e"; #1 wr=1; #2 wr=0;
data_in=" "; #1 wr=1; #2 wr=0;
data_in="m"; #1 wr=1; #2 wr=0;

//#1 rd=1; #2 rd=0;
//#1 rd=1; #2 rd=0;
//#1 rd=1; #2 rd=0;

//data_in="a"; #1 wr=1; #2 wr=0;
//data_in="b"; #1 wr=1; #2 wr=0;
//data_in="c"; #1 wr=1; #2 wr=0;
//data_in="d"; #1 wr=1; #2 wr=0;

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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////// 			    ////////////////////////////////////////////////////////////////////////////////
////////////////    Mío, Con mayor Control  ////////////////////////////////////////////////////////////////////////////////
////////////////		 	    ////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#4;
rst=1;
#4;
rst=0;
#4;
data_in="a"; #1 wr=1; #2 wr=0;//1
data_in="b"; #1 wr=1; #2 wr=0;//2
data_in="c"; #1 wr=1; #2 wr=0;//3
data_in="d"; #1 wr=1; #2 wr=0;//4
data_in="e"; #1 wr=1; #2 wr=0;//5
data_in="f"; #1 wr=1; #2 wr=0;//6
data_in="g"; #1 wr=1; #2 wr=0;//7
data_in="h"; #1 wr=1; #2 wr=0;//8
data_in="i"; #1 wr=1; #2 wr=0;//9
data_in="j"; #1 wr=1; #2 wr=0;//a
data_in="k"; #1 wr=1; #2 wr=0;//b
data_in="l"; #1 wr=1; #2 wr=0;//c
data_in="m"; #1 wr=1; #2 wr=0;//d
data_in="n"; #1 wr=1; #2 wr=0;//e
data_in="o"; #1 wr=1; #2 wr=0;//f
data_in="p"; #1 wr=1; #2 wr=0;//0


//#1 rd=1; #2 rd=0;
//#1 rd=1; #2 rd=0;
//#1 rd=1; #2 rd=0;

//data_in="a"; #1 wr=1; #2 wr=0;
//data_in="b"; #1 wr=1; #2 wr=0;
//data_in="c"; #1 wr=1; #2 wr=0;
//data_in="d"; #1 wr=1; #2 wr=0;

#1 rd=1; #2 rd=0;//0
#1 rd=1; #2 rd=0;//1
#1 rd=1; #2 rd=0;//2
#1 rd=1; #2 rd=0;//3
#1 rd=1; #2 rd=0;//4
#1 rd=1; #2 rd=0;//5
#1 rd=1; #2 rd=0;//6
#1 rd=1; #2 rd=0;//7
#1 rd=1; #2 rd=0;//8
#1 rd=1; #2 rd=0;//9
#1 rd=1; #2 rd=0;//a
#1 rd=1; #2 rd=0;//b
#1 rd=1; #2 rd=0;//c
#1 rd=1; #2 rd=0;//d
#1 rd=1; #2 rd=0;//e
#1 rd=1; #2 rd=0;//f

#1 rd=1; #2 rd=0;//0
#1 rd=1; #2 rd=0;//1
#1 rd=1; #2 rd=0;//2
#1 rd=1; #2 rd=0;//3
#1 rd=1; #2 rd=0;//4
#1 rd=1; #2 rd=0;//5
#1 rd=1; #2 rd=0;//6
#1 rd=1; #2 rd=0;//7
#1 rd=1; #2 rd=0;//8
#1 rd=1; #2 rd=0;//9
#1 rd=1; #2 rd=0;//a
#1 rd=1; #2 rd=0;//b
#1 rd=1; #2 rd=0;//c
#1 rd=1; #2 rd=0;//d
#1 rd=1; #2 rd=0;//e
#1 rd=1; #2 rd=0;//f

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////// 			    ////////////////////////////////////////////////////////////////////////////////
////////////////    Mío, Con mayor Control  ///////////////////////////             2              /////////////////////////
////////////////		 	    ////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
#4;
rst=1;
#4;
rst=0;
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

#4;
rst=1;
#4;
rst=0;

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

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////// 			    ////////////////////////////////////////////////////////////////////////////////
////////////////    Mío, Con mayor Control  ////////////////////////////////////////////////////////////////////////////////
////////////////		 	    ////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#4;
rst=1;
#4;
rst=0;
#4;
data_in="a"; #1 wr=1; #2 wr=0;//1
data_in="b"; #1 wr=1; #2 wr=0;//2
data_in="c"; #1 wr=1; #2 wr=0;//3
data_in="d"; #1 wr=1; #2 wr=0;//4
data_in="e"; #1 wr=1; #2 wr=0;//5

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
     #(1200) $finish;
   end

endmodule //
