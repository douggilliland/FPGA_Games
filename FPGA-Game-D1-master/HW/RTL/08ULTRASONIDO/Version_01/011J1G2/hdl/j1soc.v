module j1soc#(
              //parameter   bootram_file     = "../../firmware/hello_world/j1.mem"    // For synthesis            
              parameter   bootram_file     = "../firmware/Hello_World/j1.mem"       // For simulation         
)
    (uart_tx, ledout,
   sys_clk_i, sys_rst_i,ledres,micLRSel,trigg,echo);

   input sys_clk_i, sys_rst_i;
   output uart_tx;
   output ledout;
    output ledres;
    output micLRSel;
    output trigg;
    input echo;

//------------------------------------ regs and wires-------------------------------

   wire                 j1_io_rd;//********************** J1
   wire                 j1_io_wr;//********************** J1
   wire                 [15:0] j1_io_addr;//************* J1
   reg                  [15:0] j1_io_din;//************** J1
   wire                 [15:0] j1_io_dout;//************* J1


 
	reg [1:5]cs;  // CHIP-SELECT

   wire			[15:0] mult_dout;  
   wire			[15:0] div_dout;
   wire			uart_dout;	// misma señal que uart_busy from uart.v
   wire			[15:0] dp_ram_dout;
   wire		[15:0] ultra_dout;
 

//------------------------------------ regs and wires-------------------------------


  j1 #(bootram_file)  cpu0(sys_clk_i, sys_rst_i, j1_io_din, j1_io_rd, j1_io_wr, j1_io_addr, j1_io_dout);

	peripheral_mult  per_m (.clk(sys_clk_i), .rst(sys_rst_i), .d_in(j1_io_dout), .cs(cs[2]), .addr(j1_io_addr[3:0]), .rd(j1_io_rd), .wr(j1_io_wr), .d_out(mult_dout) );

	peripheral_div  per_d (.clk(sys_clk_i), .rst(sys_rst_i), .d_in(j1_io_dout), .cs(cs[3]), .addr(j1_io_addr[3:0]), .rd(j1_io_rd), .wr(j1_io_wr), .d_out(div_dout));

	peripheral_uart  per_u (.clk(sys_clk_i), .rst(sys_rst_i), .d_in(j1_io_dout), .cs(cs[4]), .addr(j1_io_addr[3:0]), .rd(j1_io_rd), .wr(j1_io_wr), .d_out(uart_dout), .uart_tx(uart_tx), .ledout(ledout));

  peripheral_ultra per_ultra ( .clk(sys_clk_i) , .rst(sys_rst_i) , .d_in(j1_io_dout) , .cs(cs[1]) , .addr(j1_io_addr[3:0]) , .rd(j1_io_rd) , .wr(j1_io_wr), .d_out(ultra_dout),  .trigg(trigg), .echo(echo) );


	dpRAM_interface dpRm(.clk(sys_clk_i), .d_in(j1_io_dout), .cs(cs[5]), .addr(j1_io_addr[7:0]), .rd(j1_io_rd), .wr(j1_io_wr), .d_out(dp_ram_dout));


  // ============== Chip_Select (Addres decoder) ========================  // se hace con los 8 bits mas significativos de j1_io_addr
  always @*
  begin
      case (j1_io_addr[15:8])	// direcciones - chip_select

        8'h64: cs= 7'b10000; 		//ultra
        8'h67: cs= 7'b01000; 		//mult
        8'h68: cs= 7'b00100;		//div
        8'h69: cs= 7'b00010;		//uart
        8'h70: cs= 7'b00001;		//dp_ram
        default: cs= 3'b000;
      endcase
  end
  // ============== Chip_Select (Addres decoder) ========================  //




  // ============== MUX ========================  // se encarga de lecturas del J1
  always @*
  begin
      case (cs)  
        5'b10000: j1_io_din = ultra_dout; 
        5'b0001000: j1_io_din = mult_dout; 
        5'b0000100: j1_io_din = div_dout;
        5'b0000010: j1_io_din = uart_dout; 
        5'b0000001: j1_io_din = dp_ram_dout; 
        default: j1_io_din = 16'h0666;
      endcase
  end
 // ============== MUX ========================  // 

endmodule // top
