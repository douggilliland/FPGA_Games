module peripheral_ultra(clk , rst , d_in , cs , addr , rd , wr, d_out,  trigg, echo );
  
  input clk;
  input rst;
  input [15:0]d_in;
  input cs;
  input [3:0]addr; // 4 LSB from j1_io_addr
  input rd;
  input wr;
  output reg [15:0]d_out;
  output trigg;
   input echo;

//------------------------------------ regs and wires-------------------------------

reg [5:0] s; 	//selector mux_4  and demux_4

reg enable;

wire [7:0] dout; // distancia
wire done;

//------------------------------------ regs and wires-------------------------------


ultrasonido ultra(.clk(clk), .reset(rst),.d(dout), .trigg(trigg), .ECHO(echo), .ENABLE(enable), .DONE(done));


always @(*) begin//----address_decoder------------------
case (addr)
4'h0:begin s = (cs && wr) ? 5'b00001 : 5'b00000 ;end //enable
4'h2:begin s = (cs && rd) ? 5'b00010 : 5'b00000 ;end //done
4'h4:begin s = (cs && rd) ? 5'b00100 : 5'b00000 ;end //data
default:begin s=5'b00000 ; end
endcase
end//-----------------address_decoder--------------------






always @(negedge clk) begin//-------------------- escritura de registros


	if (s[0]==1) 
	begin
		enable=d_in[0];
	end
end//------------------------------------------- escritura de registros	




always @(negedge clk) begin//-----------------------mux_4 :  multiplexa salidas del periferico
case (s)	
5'b00010: d_out[0]= done;	
	5'b00100: d_out[7:0]= dout;

default: d_out=0;
endcase
end//----------------------------------------------mux_4

									//(addr != 4'h4): se hace para evitar escrituras fantasm

endmodule
