// este periferico lee la dpRAM, obtieniendo asi los 6 primeros terminos de fibonnacci, luego los escribe de nuevo en la dpRAM en orden invertido;

module core_peripheric(clk, addr, d_in, d_out,  wr,  rd); 
  
  input clk;

  input [15:0]d_in;
  output reg [15:0]d_out;

  output reg [7:0]addr; // 8 LSB from j1_io_addr

  output reg rd;
  output reg wr;


reg [15:0] F_1, F_2, F_3, F_4, F_5, F_6; // aqui se almacenan los terminos de la serie de fibonacci
reg [3:0] estado;

 initial begin
  d_out = 0;
  addr = 0;
  rd = 0;
  wr = 0;
  estado = 0;
  F_1=0;
  F_2=0;
  F_3=0;
  F_4=0;
  F_5=0;
  F_6=0;
 end

always @(posedge clk) begin// definicion de la logica del estado  siguiente

if (rd) begin
case (addr)	 // lectura de los terminos de fibonnacci
8'h00: F_1=d_in;
8'h02: F_2=d_in;
8'h04: F_3=d_in;
8'h06: F_4=d_in;
8'h08: F_5=d_in;
8'h0A: F_6=d_in;
default: F_1=F_1;
endcase
end
else F_1= F_1;

case(estado)
00: begin
  if (d_in==13)	estado =1;
  else estado=0;
end
01:  estado=2;
02:  estado=3;
03:  estado=4;
04:  estado=5;
05:  estado=6;
06:  estado=7;
07:  estado=8;
08:  estado=9;
09:  estado=10;
10:  estado=11;
11:  estado=12;
12:  estado=13;
13:  estado=13;
default: estado=0;
endcase

end


always @(*) begin// Definicion de las salidas
case(estado)
00: begin addr=8'h0A; d_out=16'h0000;  wr=0;  rd=1; end // lectura de los terminos de fibonnacci
01: begin addr=8'h00; d_out=16'h0000;  wr=0;  rd=1; end
02: begin addr=8'h02; d_out=16'h0000;  wr=0;  rd=1; end
03: begin addr=8'h04; d_out=16'h0000;  wr=0;  rd=1; end
04: begin addr=8'h06; d_out=16'h0000;  wr=0;  rd=1; end
05: begin addr=8'h08; d_out=16'h0000;  wr=0;  rd=1; end
06: begin addr=8'h0A; d_out=16'h0000;  wr=0;  rd=1; end

07: begin addr=8'h00; d_out=F_6;  wr=1;  rd=0; end // escritura de los terminos de fibonacci en orden invertido
08: begin addr=8'h02; d_out=F_5;  wr=1;  rd=0; end
09: begin addr=8'h04; d_out=F_4;  wr=1;  rd=0; end
10: begin addr=8'h06; d_out=F_3;  wr=1;  rd=0; end
11: begin addr=8'h08; d_out=F_2;  wr=1;  rd=0; end
12: begin addr=8'h0A; d_out=F_1;  wr=1;  rd=0; end

13: begin addr=8'h0A; d_out=16'h0000;  wr=0;  rd=0; end

default: begin addr=8'h00; d_out=16'h0000;  wr=0;  rd=0; end
endcase
end

endmodule

/*
  always @(negedge clk)
  begin
	if (addr==8'h0B)
		addr=0;
	else
		addr = addr+1;
  end

  reg [15:0] F_1, F_2, F_3, F_4, F_5, F_6; // aqui se almacenan los terminos de la serie de fibonacci


always @(posedge clk)
begin

      
      case (addr)
        8'h00: begin rd<=1;  F_1 <= d_in; end
        8'h02: begin rd<=1;  F_2 <= d_in; end
        8'h04: begin rd<=1;  F_3 <= d_in; end
        8'h06: begin rd<=1;  F_4 <= d_in; end
        8'h08: begin rd<=1;  F_5 <= d_in; end
        8'h0A: begin rd<=1;  F_6 <= d_in; end
	default: begin rd<=0;  end
      endcase

    if (F_6==8'h000D) begin
      case (addr)
        8'h00: begin d_out <= F_6; wr <= 1;  end
        8'h02: begin d_out <= F_5; wr <= 1;  end
        8'h04: begin d_out <= F_4; wr <= 1;  end
        8'h06: begin d_out <= F_3; wr <= 1;  end
        8'h08: begin d_out <= F_2; wr <= 1;  end
        8'h0A: begin d_out <= F_1; wr <= 1;  end
	default:  begin wr <= 0; end
      endcase
    end

end


endmodule
*/
