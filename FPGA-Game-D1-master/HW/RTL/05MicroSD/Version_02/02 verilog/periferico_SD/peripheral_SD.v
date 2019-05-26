module peripheral_SD(clk , reset , d_in , cs , addr , rd , wr, d_out, sclk, mosi, miso, ss );
  
  input clk;
  input rst;
  input [15:0]d_in;
  input cs;
  input [3:0]addr; // 4 LSB from j1_io_addr
  input rd;
  input wr;
  output reg [15:0]d_out;
  input reset;
  output sclk;
  input miso;
  output mosi;
  output ss; 
	
//------------------------------------ regs and wires-------------------------------

reg [5:0] s; 	//selector mux_4  and write registers

reg [15:0] datain=0;//---mult_32 input registers
reg enable=0;

wire [15:0] dataout;	//mult_32 output Regs
wire done;


//------------------------------------ regs and wires-------------------------------

spi driver ( .clk(clk), .reset(reset), .datain(datain), .en(enable), .dataout(dataout), .done(done), .sclk(sclk), .mosi(mosi), .miso(miso), .ss(ss) );


always @(*) begin//------address_decoder------------------------------
case (addr)
4'h0:begin s = (cs && wr) ? 4'b0001 : 6'b0000 ;end //datain
4'h2:begin s = (cs && wr) ? 4'b0010 : 6'b0000 ;end //en

4'h4:begin s = (cs && rd) ? 4'b0100 : 6'b0000 ;end //done
4'h6:begin s = (cs && rd) ? 4'b1000 : 6'b0000 ;end //dataout
default:begin s = 6'b000000 ; end
endcase
end//------------------address_decoder--------------------------------




always @(negedge clk) begin//-------------------- escritura de registros 

datain    = (s[0]) ? d_in : datain;	//Write Registers
enable =    (s[1]) ? d_in[0] : enable;	//Write Registers

end//------------------------------------------- escritura de registros




always @(negedge clk) begin//-----------------------mux_2 :  multiplexa salidas del periferico
case (s)
4'b0100: d_out[0] = done ;
3'b1000: d_out    = dataout[15:0] ;
default: d_out   = 0 ;
endcase
end//-----------------------------------------------mux_2






endmodule
