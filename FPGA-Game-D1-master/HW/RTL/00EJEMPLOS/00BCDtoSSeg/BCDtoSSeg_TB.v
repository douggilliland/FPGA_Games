module BCDtoSSeg_TB;

  reg [3:0] BCD;
  wire [6:0] SSeg;

BCDtoSSeg uut(.inBCD(BCD), .SSeg(SSeg));

initial begin

  BCD = 0; #10;
  BCD = 1; #10;
  BCD = 2; #10;
  BCD = 3; #10;
  BCD = 4; #10;
  BCD = 5; #10;
  BCD = 6; #10;
  BCD = 7; #10;
  BCD = 8; #10;
  BCD = 9; #10;

end

initial begin: TEST_CASE
     $dumpfile("BCDtoSSeg_TB.vcd");
     $dumpvars(-1, uut);
     #(200) $finish;
   end

endmodule //
