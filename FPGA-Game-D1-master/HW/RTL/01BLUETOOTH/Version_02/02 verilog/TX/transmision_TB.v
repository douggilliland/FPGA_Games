module transmision_TB;
reg clk_in=0;
reg enable = 0;
reg [7:0] din = 0;
reg reset;
wire busy;
wire done;
wire tx;

transmision dut(.clk_in(clk_in),.enable(enable),.din(din),.busy(busy),.done(done),.tx(tx),.reset(reset));
initial clk_in=0;

always #1 clk_in = ~clk_in;

initial begin
din = 8'b00110011;
reset=1'b0; 
enable = 1; #10;
enable=0;
end

initial begin

  $dumpfile("transmision_TB.vcd");
  $dumpvars(0, transmision_TB);

  $display("FIN de la simulacion");
  #200000 $finish;
end
endmodule

