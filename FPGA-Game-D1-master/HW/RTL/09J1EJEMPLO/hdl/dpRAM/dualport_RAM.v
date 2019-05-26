module dualport_RAM(clk, d_in_1, d_out_1, addr_1, rd_1, wr_1, d_in_2, d_out_2, addr_2, rd_2, wr_2);
  
  input clk;

  input [15:0]d_in_1;
  output reg [15:0]d_out_1=0;
  input [7:0]addr_1; // 8 LSB from address
  input rd_1;
  input wr_1;

  input [15:0]d_in_2;
  output reg [15:0]d_out_2=0;
  input [7:0]addr_2; // 8 LSB from address
  input rd_2;
  input wr_2;


  // Declare the RAM variable
  reg [15:0] ram [255:0]; // 256-bit x 8-bit RAM


always @(negedge clk)
begin

//------------------ port 1	: 	core J1---------------------

	if (rd_1) begin
		d_out_1<= ram[addr_1];
	end
	else if(wr_1) begin
		ram[addr_1] <= d_in_1;
	end

//------------------ port 1	: 	core J1---------------------
end

always @(negedge clk)
begin
//------------------ port 2	:	core peripheric-------------

	/*else*/ if (rd_2) begin
		d_out_2 <= ram[addr_2];
	end
	else if(wr_2) begin
		ram[addr_2] <= d_in_2;
	end
//	else
//		ram[addr_2] <= ram[addr_2];

//------------------ port 2	:	core peripheric-------------
end




endmodule
