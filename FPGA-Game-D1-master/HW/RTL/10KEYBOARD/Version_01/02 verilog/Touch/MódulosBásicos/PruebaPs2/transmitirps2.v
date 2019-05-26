module transmitirps2  (
                        input       [7:0] d_in    ,
                        input             enable  ,
                        input             CLKOUT  ,
                        output  reg       Rx
                      );
  reg       i;
  reg [7:0] DATA;
  wire       logico;
  assign logico = (DATA[7]||DATA[6]||DATA[5]||DATA[4]||DATA[3]||DATA[2]||DATA[1]||DATA[0]);
  initial
  begin
    Rx <= 1;
    DATA = 0;
    i=0;
  end
  always@(posedge CLKOUT)
  
  begin
    if(enable)
    begin
      DATA = d_in;
    end
    if(enable && logico)
    begin
      Rx      <=  d_in[i];
      i       <=  i+1;
      if(i==9)
      begin
        DATA   = 0;
      end
    end
  end
endmodule
