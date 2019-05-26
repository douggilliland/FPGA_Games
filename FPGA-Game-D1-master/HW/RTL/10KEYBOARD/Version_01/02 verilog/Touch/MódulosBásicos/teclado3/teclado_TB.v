`timescale 1ns / 1ps
module teclado_TB;

	reg		Rx;
	reg		clk;
	teclado  uut(.clk(clk),.Rx(Rx));
  parameter num=2*13'd7692;
	always
	begin
		clk =1'b1;
		#1;
		clk =1'b0;
		#1;
	end
	initial
	begin
		Rx=1;
		#num;
		Rx=0;
		#num;
		Rx=0;//1
		#num;
		Rx=0;
		#num;
		Rx=0;
		#num;
		Rx=1;
		#num;
		Rx=1;
		#num;
		Rx=1;
		#num;
		Rx=0;
		#num;
		Rx=0;//8
		#num;
		Rx=1;
		#num;
		Rx=1;
		#num;
		Rx=1;
		#num;
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

//	La Otra Prueba
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
		Rx=1;
		#2;
		Rx=0;
		#2;
		Rx=1;
		#2;
		Rx=0;//8
		#2;
		Rx=1;
		#2;
		Rx=0;
		#2;
		Rx=0;//1
		#2;
		Rx=1;
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
     $dumpfile("teclado_TB.vcd");
     $dumpvars(-1, uut);
     #(1000000) $finish;
   end

endmodule //
