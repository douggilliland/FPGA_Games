module peripheral_ultrsnd (clk , reset , d_in , cs , addr , rd , wr, d_out, echo, done, trigger, [15:0]distance);
  
  	input clk;
  	input rst;
  	input [15:0]d_in;
  	input cs;
  	input [3:0]addr; // 4 LSB from j1_io_addr
  	input rd;
  	input wr;
  	output reg [15:0]d_out;
  	input echo;
	output trigger
	
//------------------------------------ regs and wires-------------------------------
	//selector mux_4  and write registers
	reg [5:0] s; 	
	
	//---mult_32 input registers--//
	reg echo = 0;	
	reg trigger = 0;
	
	//---mult_32 output Regs-----//
	wire [15:0]distance;	
	wire done;
	
//------------------------------------ regs and wires-------------------------------
	ultrasonido (.clk(clk),.reset(reset),.echo(echo),.trigger(trigger),.done(done),.distance(distance));
	//----------------address_decoder-------------------//
	always @(*) begin
		case (addr)
			4'h0:begin s = (cs && wr) ? 6'b000001 : 6'b000000; end //echo
			4'h2:begin s = (cs && wr) ? 6'b000010 : 6'b000000; end //trigger
			4'h4:begin s = (cs && wr) ? 6'b000100 : 6'b000000; end //distance
			4'h6:begin s = (cs && rd) ? 6'b001000 : 6'b000000; end //done
			default:begin s = 6'b000000 ; end
		endcase
	end
	//------------------address_decoder-----------------//
	
	
	//-----------------escritura de registros 
	always @(negedge clk) begin
		echo = (s[0]) ? d_in : echo;	//Write Registers
		trigger = (s[1]) ? d_in[0] : trigger;	//Write Registers
	end
	//-----------------escritura de registros
	
	
	//----------------mux_4 :  multiplexa salidas del periferico
	always @(negedge clk) begin
		case (s[5:3])
			4'b1000: d_out[0] = done;
			4'b0100: d_out = [15:0]distance;
			default: d_out = 0 ;
		endcase
	end
	//----------------mux_4
	
endmodule