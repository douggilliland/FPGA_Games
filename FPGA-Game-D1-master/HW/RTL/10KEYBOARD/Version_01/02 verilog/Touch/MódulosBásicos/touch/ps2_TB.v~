`timescale 1ns / 1ps
module ps2_TB;

	reg		Rx;
	reg		CLKOUT;
	ps2  uut(.CLKOUT(CLKOUT),.Rx(Rx));

	always
	begin
		CLKOUT =1'b1;
		#1;
		CLKOUT =1'b0;
		#1;
	end
	initial
	begin
		Rx=1;
		#10;
		Rx=0;
		#2;
		Rx=0;//1
		#2;
		Rx=0;
		#2;
		Rx=0;
		#2;
		Rx=1;
		#2;
		Rx=1;
		#2;
		Rx=1;
		#2;
		Rx=0;
		#2;
		Rx=0;//8
		#2;
		Rx=1;
		#2;
		Rx=1;
		#2;
		Rx=1;
		#10;
//	Otro
		Rx=0;
		#2;
		Rx=0;//1
		#2;
		Rx=0;
		#2;
		Rx=1;
		#2;
		Rx=1;
		#2;
		Rx=0;
		#2;
		Rx=0;
		#2;
		Rx=1;
		#2;
		Rx=0;//8
		#2;
		Rx=1;
		#2;
		Rx=1;
		#2;
		Rx=1;
		#10;
//	Seguidos
		Rx=0;
		#2;
		Rx=1;//1
		#2;
		Rx=0;
		#2;
		Rx=0;
		#2;
		Rx=1;
		#2;
		Rx=0;
		#2;
		Rx=0;
		#2;
		Rx=1;
		#2;
		Rx=1;//8
		#2;
		Rx=1;
		#2;
//	Continuación
		Rx=0;
		#2;
		Rx=1;//1
		#2;
		Rx=1;
		#2;
		Rx=1;
		#2;
		Rx=0;
		#2;
		Rx=0;
		#2;
		Rx=0;
		#2;
		Rx=0;
		#2;
		Rx=0;//8
		#2;
		Rx=1;
		#2;

//	Continuación
		Rx=0;
		#2;
		Rx=0;//1
		#2;
		Rx=0;
		#2;
		Rx=1;
		#2;
		Rx=1;
		#2;
		Rx=0;
		#2;
		Rx=0;
		#2;
		Rx=1;
		#2;
		Rx=0;//8
		#2;
		Rx=1;
		#2;

//	Continuación
		Rx=0;
		#2;
		Rx=0;//1
		#2;
		Rx=0;
		#2;
		Rx=1;
		#2;
		Rx=1;
		#2;
		Rx=0;
		#2;
		Rx=0;
		#2;
		Rx=1;
		#2;
		Rx=0;//8
		#2;
		Rx=1;
		#2;
	end

initial begin: TEST_CASE
     $dumpfile("ps2_TB.vcd");
     $dumpvars(-1, uut);
     #(400) $finish;
   end

endmodule //
