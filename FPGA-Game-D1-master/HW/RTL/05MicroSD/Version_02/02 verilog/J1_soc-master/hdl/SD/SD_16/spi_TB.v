`timescale 1ns / 1ns

module spi_TB;
parameter N=8;
reg en;
reg reset;
reg clk;
reg miso;
reg [N-1:0] datain;
wire [N-1:0] dataout;
wire sclkn;
wire cs;
wire done;
wire mosi;
wire sclk;

spi uut(.datain(datain),.en(en),.reset(reset),.clk(clk),.miso(miso),.dataout(dataout),.done(done),.mosi(mosi),.cs(cs),.sclk(sclk));


reg [N-1:0] dataEn;


always
	begin
	clk=0;
	#1;
	clk=1;
	#1;
	end




initial
	begin
	en=0;
	reset=1;
	miso=1;
	datain=8'haa;
	dataEn=8'h56;
	#200;
	reset=0;
	#1000;
	en=1;
	#80000;
	en=0;
	datain=8'ha4;
	dataEn=8'hA1;
	#1000;
	en=1;

	#80000;
	en=0;
	

	end




integer count=0;

always @(negedge sclk)
	begin
		if(count==8)
			count<=0;
		else
			count<=count+1'b1;
	end



always @(count)
	begin

	case(count)
	0: miso<=dataEn[0];
	1: miso<=dataEn[1];
	2: miso<=dataEn[2];
	3: miso<=dataEn[3];
	4: miso<=dataEn[4];
	5: miso<=dataEn[5];
	6: miso<=dataEn[6];
	7: miso<=dataEn[7];
	endcase
	end


initial begin: TEST_CASE	
     $dumpfile("spi_TB.vcd");
     $dumpvars(-1, uut);
     #(500000) $finish;
   end

endmodule
