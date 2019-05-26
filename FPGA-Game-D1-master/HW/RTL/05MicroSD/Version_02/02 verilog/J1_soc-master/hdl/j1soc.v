module j1soc#(
              //parameter   bootram_file     = "../../firmware/hello_world/j1.mem"    // For synthesis            
              parameter   bootram_file     = "../firmware/Hello_World/j1.mem"       // For simulation         
  )(
   sys_clk_i, sys_rst_i,
   miso, mosi, ss, sclk
   );

   input sys_clk_i, sys_rst_i,miso;
   output mosi, ss, sclk;


//------------------------------------ regs and wires-------------------------------

   wire                 j1_io_rd;//********************** J1
   wire                 j1_io_wr;//********************** J1
   wire                 [15:0] j1_io_addr;//************* J1
   reg                  [15:0] j1_io_din;//************** J1
   wire                 [15:0] j1_io_dout;//************* J1


 
   reg [1:4]cs;  // CHIP-SELECT

   wire			[15:0] sd_out;  

//   reg			mosi;
//   reg			sclk;
//   reg			ss;
//   wire			miso;
//   wire			[15:0] dp_ram_dout;
 

//------------------------------------ regs and wires-------------------------------


  j1 #(bootram_file)  cpu0(sys_clk_i, sys_rst_i, j1_io_din, j1_io_rd, j1_io_wr, j1_io_addr, j1_io_dout);
  
  peripheral_SD sd(.clk(sys_clk_i), .reset(sys_rst_i) , .d_in(j1_io_dout) , .cs(cs[1]) , .addr(j1_io_addr[3:0]) , .rd(j1_io_rd) , .wr(j1_io_wr), .d_out(sd_out), .sclk(sclk), .mosi(mosi), .miso(miso), .ss(ss) );



  dpRAM_interface dpRm(.clk(sys_clk_i), .d_in(j1_io_dout), .cs(cs[4]), .addr(j1_io_addr[7:0]), .rd(j1_io_rd), .wr(j1_io_wr), .d_out(dp_ram_dout));


  // ============== Chip_Select (Addres decoder) ========================  // se hace con los 8 bits mas significativos de j1_io_addr
  always @*
  begin
      case (j1_io_addr[15:8])	// direcciones - chip_select
        8'h67: cs= 4'b1000; 		//SD
        8'h68: cs= 4'b0100;		//div
 
        8'h70: cs= 4'b0001;		//dp_ram
        default: cs= 3'b000;
      endcase
  end
  // ============== Chip_Select (Addres decoder) ========================  //




  // ============== MUX ========================  // se encarga de lecturas del J1
  always @*
  begin
      case (cs)
        4'b1000: j1_io_din = sd_out; 
        4'b0001: j1_io_din = dp_ram_dout; 
        default: j1_io_din = 16'h0666;
      endcase
  end
 // ============== MUX ========================  // 

endmodule // top
