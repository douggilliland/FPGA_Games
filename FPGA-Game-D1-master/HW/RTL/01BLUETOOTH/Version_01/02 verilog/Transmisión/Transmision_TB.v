module Transmision_TB;
reg clk=0;
reg clk_f;
reg rw = 1;
reg [7:0] din = 0;
reg reset;
wire busy;
wire done;
wire tx;

Transmision dut(.clk(clk),.rw(rw),.din(din),.busy(busy),.done(done),.tx(tx),.reset(reset));
initial clk=0;

always #1 clk = ~clk;
initial begin
reset=1'b1;
#100
reset=1'b0;
#228000
reset=1'b1;
end

initial begin
#20
rw = 0;
din = 8'b01110001;
#4000
rw = 1;
end

initial begin

  $dumpfile("Transmision_TB.vcd");
  $dumpvars(0, Transmision_TB);

  $display("FIN de la simulacion");
  #1000000 $finish;
end
endmodule

