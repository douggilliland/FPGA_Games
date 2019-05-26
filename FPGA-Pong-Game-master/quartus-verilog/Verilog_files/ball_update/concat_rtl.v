
//------> ./rtl_mgc_ioport.v 
//------------------------------------------------------------------
//                M G C _ I O P O R T _ C O M P S
//------------------------------------------------------------------

//------------------------------------------------------------------
//                       M O D U L E S
//------------------------------------------------------------------

//------------------------------------------------------------------
//-- INPUT ENTITIES
//------------------------------------------------------------------

module mgc_in_wire (d, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output [width-1:0] d;
  input  [width-1:0] z;

  wire   [width-1:0] d;

  assign d = z;

endmodule

//------------------------------------------------------------------

module mgc_in_wire_en (ld, d, lz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  output [width-1:0] d;
  output             lz;
  input  [width-1:0] z;

  wire   [width-1:0] d;
  wire               lz;

  assign d = z;
  assign lz = ld;

endmodule

//------------------------------------------------------------------

module mgc_in_wire_wait (ld, vd, d, lz, vz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  output             vd;
  output [width-1:0] d;
  output             lz;
  input              vz;
  input  [width-1:0] z;

  wire               vd;
  wire   [width-1:0] d;
  wire               lz;

  assign d = z;
  assign lz = ld;
  assign vd = vz;

endmodule
//------------------------------------------------------------------

module mgc_chan_in (ld, vd, d, lz, vz, z, size, req_size, sizez, sizelz);

  parameter integer rscid = 1;
  parameter integer width = 8;
  parameter integer sz_width = 8;

  input              ld;
  output             vd;
  output [width-1:0] d;
  output             lz;
  input              vz;
  input  [width-1:0] z;
  output [sz_width-1:0] size;
  input              req_size;
  input  [sz_width-1:0] sizez;
  output             sizelz;


  wire               vd;
  wire   [width-1:0] d;
  wire               lz;
  wire   [sz_width-1:0] size;
  wire               sizelz;

  assign d = z;
  assign lz = ld;
  assign vd = vz;
  assign size = sizez;
  assign sizelz = req_size;

endmodule


//------------------------------------------------------------------
//-- OUTPUT ENTITIES
//------------------------------------------------------------------

module mgc_out_stdreg (d, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input    [width-1:0] d;
  output   [width-1:0] z;

  wire     [width-1:0] z;

  assign z = d;

endmodule

//------------------------------------------------------------------

module mgc_out_stdreg_en (ld, d, lz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  input  [width-1:0] d;
  output             lz;
  output [width-1:0] z;

  wire               lz;
  wire   [width-1:0] z;

  assign z = d;
  assign lz = ld;

endmodule

//------------------------------------------------------------------

module mgc_out_stdreg_wait (ld, vd, d, lz, vz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  input              ld;
  output             vd;
  input  [width-1:0] d;
  output             lz;
  input              vz;
  output [width-1:0] z;

  wire               vd;
  wire               lz;
  wire   [width-1:0] z;

  assign z = d;
  assign lz = ld;
  assign vd = vz;

endmodule

//------------------------------------------------------------------

module mgc_out_prereg_en (ld, d, lz, z);

    parameter integer rscid = 1;
    parameter integer width = 8;

    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;

    wire               lz;
    wire   [width-1:0] z;

    assign z = d;
    assign lz = ld;

endmodule

//------------------------------------------------------------------
//-- INOUT ENTITIES
//------------------------------------------------------------------

module mgc_inout_stdreg_en (ldin, din, ldout, dout, lzin, lzout, z);

    parameter integer rscid = 1;
    parameter integer width = 8;

    input              ldin;
    output [width-1:0] din;
    input              ldout;
    input  [width-1:0] dout;
    output             lzin;
    output             lzout;
    inout  [width-1:0] z;

    wire   [width-1:0] din;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;

    assign lzin = ldin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = ldout;
    assign z = ldout ? dout : {width{1'bz}};

endmodule

//------------------------------------------------------------------
module hid_tribuf( I_SIG, ENABLE, O_SIG);
  parameter integer width = 8;

  input [width-1:0] I_SIG;
  input ENABLE;
  inout [width-1:0] O_SIG;

  assign O_SIG = (ENABLE) ? I_SIG : { width{1'bz}};

endmodule
//------------------------------------------------------------------

module mgc_inout_stdreg_wait (ldin, vdin, din, ldout, vdout, dout, lzin, vzin, lzout, vzout, z);

    parameter integer rscid = 1;
    parameter integer width = 8;

    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output             lzin;
    input              vzin;
    output             lzout;
    input              vzout;
    inout  [width-1:0] z;

    wire               vdin;
    wire   [width-1:0] din;
    wire               vdout;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;
    wire   ldout_and_vzout;

    assign lzin = ldin;
    assign vdin = vzin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = ldout;
    assign vdout = vzout ;
    assign ldout_and_vzout = ldout && vzout ;

    hid_tribuf #(width) tb( .I_SIG(dout),
                            .ENABLE(ldout_and_vzout),
                            .O_SIG(z) );

endmodule

//------------------------------------------------------------------

module mgc_inout_buf_wait (clk, en, arst, srst, ldin, vdin, din, ldout, vdout, dout, lzin, vzin, lzout, vzout, z);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter         ph_clk  =  1'b1; // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   =  1'b1; // clock enable polarity
    parameter         ph_arst =  1'b1; // async reset polarity
    parameter         ph_srst =  1'b1; // sync reset polarity

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output             lzin;
    input              vzin;
    output             lzout;
    input              vzout;
    inout  [width-1:0] z;

    wire               lzout_buf;
    wire               vzout_buf;
    wire   [width-1:0] z_buf;
    wire               vdin;
    wire   [width-1:0] din;
    wire               vdout;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;

    assign lzin = ldin;
    assign vdin = vzin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = lzout_buf & ~ldin;
    assign vzout_buf = vzout & ~ldin;
    hid_tribuf #(width) tb( .I_SIG(z_buf),
                            .ENABLE((lzout_buf && (!ldin) && vzout) ),
                            .O_SIG(z)  );

    mgc_out_buf_wait
    #(
        .rscid   (rscid),
        .width   (width),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst)
    )
    BUFF
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (ldout),
        .vd      (vdout),
        .d       (dout),
        .lz      (lzout_buf),
        .vz      (vzout_buf),
        .z       (z_buf)
    );


endmodule

module mgc_inout_fifo_wait (clk, en, arst, srst, ldin, vdin, din, ldout, vdout, dout, lzin, vzin, lzout, vzout, z);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer fifo_sz = 8; // fifo depth
    parameter         ph_clk  = 1'b1;  // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   = 1'b1;  // clock enable polarity
    parameter         ph_arst = 1'b1;  // async reset polarity
    parameter         ph_srst = 1'b1;  // sync reset polarity
    parameter integer ph_log2 = 3;     // log2(fifo_sz)
    parameter integer pwropt  = 0;     // pwropt

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output             lzin;
    input              vzin;
    output             lzout;
    input              vzout;
    inout  [width-1:0] z;

    wire               lzout_buf;
    wire               vzout_buf;
    wire   [width-1:0] z_buf;
    wire               comb;
    wire               vdin;
    wire   [width-1:0] din;
    wire               vdout;
    wire               lzin;
    wire               lzout;
    wire   [width-1:0] z;

    assign lzin = ldin;
    assign vdin = vzin;
    assign din = ldin ? z : {width{1'bz}};
    assign lzout = lzout_buf & ~ldin;
    assign vzout_buf = vzout & ~ldin;
    assign comb = (lzout_buf && (!ldin) && vzout);

    hid_tribuf #(width) tb2( .I_SIG(z_buf), .ENABLE(comb), .O_SIG(z)  );

    mgc_out_fifo_wait
    #(
        .rscid   (rscid),
        .width   (width),
        .fifo_sz (fifo_sz),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst),
        .ph_log2 (ph_log2),
        .pwropt  (pwropt)
    )
    FIFO
    (
        .clk   (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (ldout),
        .vd      (vdout),
        .d       (dout),
        .lz      (lzout_buf),
        .vz      (vzout_buf),
        .z       (z_buf)
    );

endmodule

//------------------------------------------------------------------
//-- I/O SYNCHRONIZATION ENTITIES
//------------------------------------------------------------------

module mgc_io_sync (ld, lz);

    input  ld;
    output lz;

    assign lz = ld;

endmodule

module mgc_bsync_rdy (rd, rz);

    parameter integer rscid   = 0; // resource ID
    parameter ready = 1;
    parameter valid = 0;

    input  rd;
    output rz;

    wire   rz;

    assign rz = rd;

endmodule

module mgc_bsync_vld (vd, vz);

    parameter integer rscid   = 0; // resource ID
    parameter ready = 0;
    parameter valid = 1;

    output vd;
    input  vz;

    wire   vd;

    assign vd = vz;

endmodule

module mgc_bsync_rv (rd, vd, rz, vz);

    parameter integer rscid   = 0; // resource ID
    parameter ready = 1;
    parameter valid = 1;

    input  rd;
    output vd;
    output rz;
    input  vz;

    wire   vd;
    wire   rz;

    assign rz = rd;
    assign vd = vz;

endmodule

//------------------------------------------------------------------

module mgc_sync (ldin, vdin, ldout, vdout);

  input  ldin;
  output vdin;
  input  ldout;
  output vdout;

  wire   vdin;
  wire   vdout;

  assign vdin = ldout;
  assign vdout = ldin;

endmodule

///////////////////////////////////////////////////////////////////////////////
// dummy function used to preserve funccalls for modulario
// it looks like a memory read to the caller
///////////////////////////////////////////////////////////////////////////////
module funccall_inout (d, ad, bd, z, az, bz);

  parameter integer ram_id = 1;
  parameter integer width = 8;
  parameter integer addr_width = 8;

  output [width-1:0]       d;
  input  [addr_width-1:0]  ad;
  input                    bd;
  input  [width-1:0]       z;
  output [addr_width-1:0]  az;
  output                   bz;

  wire   [width-1:0]       d;
  wire   [addr_width-1:0]  az;
  wire                     bz;

  assign d  = z;
  assign az = ad;
  assign bz = bd;

endmodule


///////////////////////////////////////////////////////////////////////////////
// inlinable modular io not otherwise found in mgc_ioport
///////////////////////////////////////////////////////////////////////////////

module modulario_en_in (vd, d, vz, z);

  parameter integer rscid = 1;
  parameter integer width = 8;

  output             vd;
  output [width-1:0] d;
  input              vz;
  input  [width-1:0] z;

  wire   [width-1:0] d;
  wire               vd;

  assign d = z;
  assign vd = vz;

endmodule

//------> ./rtl_mgc_ioport_v2001.v 
//------------------------------------------------------------------

module mgc_out_reg_pos (clk, en, arst, srst, ld, d, lz, z);

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;

    reg                lz;
    reg    [width-1:0] z;

    generate
    if (ph_arst == 1'b0)
    begin: NEG_ARST
        always @(posedge clk or negedge arst)
        if (arst == 1'b0)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    else
    begin: POS_ARST
        always @(posedge clk or posedge arst)
        if (arst == 1'b1)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    endgenerate

endmodule

//------------------------------------------------------------------

module mgc_out_reg_neg (clk, en, arst, srst, ld, d, lz, z);

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;

    reg                lz;
    reg    [width-1:0] z;

    generate
    if (ph_arst == 1'b0)
    begin: NEG_ARST
        always @(negedge clk or negedge arst)
        if (arst == 1'b0)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    else
    begin: POS_ARST
        always @(negedge clk or posedge arst)
        if (arst == 1'b1)
        begin: B1
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (srst == ph_srst)
        begin: B2
            lz <= 1'b0;
            z  <= {width{1'b0}};
        end
        else if (en == ph_en)
        begin: B3
            lz <= ld;
            z  <= (ld) ? d : z;
        end
    end
    endgenerate

endmodule

//------------------------------------------------------------------

module mgc_out_reg (clk, en, arst, srst, ld, d, lz, z); // Not Supported

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_clk  =  1'b1;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    input  [width-1:0] d;
    output             lz;
    output [width-1:0] z;


    generate
    if (ph_clk == 1'b0)
    begin: NEG_EDGE

        mgc_out_reg_neg
        #(
            .rscid   (rscid),
            .width   (width),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        mgc_out_reg_neg_inst
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (ld),
            .d       (d),
            .lz      (lz),
            .z       (z)
        );

    end
    else
    begin: POS_EDGE

        mgc_out_reg_pos
        #(
            .rscid   (rscid),
            .width   (width),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        mgc_out_reg_pos_inst
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (ld),
            .d       (d),
            .lz      (lz),
            .z       (z)
        );

    end
    endgenerate

endmodule




//------------------------------------------------------------------

module mgc_out_buf_wait (clk, en, arst, srst, ld, vd, d, vz, lz, z); // Not supported

    parameter integer rscid   = 1;
    parameter integer width   = 8;
    parameter         ph_clk  =  1'b1;
    parameter         ph_en   =  1'b1;
    parameter         ph_arst =  1'b1;
    parameter         ph_srst =  1'b1;

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ld;
    output             vd;
    input  [width-1:0] d;
    output             lz;
    input              vz;
    output [width-1:0] z;

    wire               filled;
    wire               filled_next;
    wire   [width-1:0] abuf;
    wire               lbuf;


    assign filled_next = (filled & (~vz)) | (filled & ld) | (ld & (~vz));

    assign lbuf = ld & ~(filled ^ vz);

    assign vd = vz | ~filled;

    assign lz = ld | filled;

    assign z = (filled) ? abuf : d;

    wire dummy;
    wire dummy_bufreg_lz;

    // Output registers:
    mgc_out_reg
    #(
        .rscid   (rscid),
        .width   (1'b1),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst)
    )
    STATREG
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (filled_next),
        .d       (1'b0),       // input d is unused
        .lz      (filled),
        .z       (dummy)            // output z is unused
    );

    mgc_out_reg
    #(
        .rscid   (rscid),
        .width   (width),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst)
    )
    BUFREG
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (lbuf),
        .d       (d),
        .lz      (dummy_bufreg_lz),
        .z       (abuf)
    );

endmodule

//------------------------------------------------------------------

module mgc_out_fifo_wait (clk, en, arst, srst, ld, vd, d, lz, vz,  z);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer fifo_sz = 8; // fifo depth
    parameter         ph_clk  = 1'b1; // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   = 1'b1; // clock enable polarity
    parameter         ph_arst = 1'b1; // async reset polarity
    parameter         ph_srst = 1'b1; // sync reset polarity
    parameter integer ph_log2 = 3; // log2(fifo_sz)
    parameter integer pwropt  = 0; // pwropt


    input                 clk;
    input                 en;
    input                 arst;
    input                 srst;
    input                 ld;    // load data
    output                vd;    // fifo full active low
    input     [width-1:0] d;
    output                lz;    // fifo ready to send
    input                 vz;    // dest ready for data
    output    [width-1:0] z;

    wire    [31:0]      size;


      // Output registers:
 mgc_out_fifo_wait_core#(
        .rscid   (rscid),
        .width   (width),
        .sz_width (32),
        .fifo_sz (fifo_sz),
        .ph_clk  (ph_clk),
        .ph_en   (ph_en),
        .ph_arst (ph_arst),
        .ph_srst (ph_srst),
        .ph_log2 (ph_log2),
        .pwropt  (pwropt)
        ) CORE (
        .clk (clk),
        .en (en),
        .arst (arst),
        .srst (srst),
        .ld (ld),
        .vd (vd),
        .d (d),
        .lz (lz),
        .vz (vz),
        .z (z),
        .size (size)
        );

endmodule



module mgc_out_fifo_wait_core (clk, en, arst, srst, ld, vd, d, lz, vz,  z, size);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer sz_width = 8; // size of port for elements in fifo
    parameter integer fifo_sz = 8; // fifo depth
    parameter         ph_clk  =  1'b1; // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   =  1'b1; // clock enable polarity
    parameter         ph_arst =  1'b1; // async reset polarity
    parameter         ph_srst =  1'b1; // sync reset polarity
    parameter integer ph_log2 = 3; // log2(fifo_sz)
    parameter integer pwropt  = 0; // pwropt

   localparam integer  fifo_b = width * fifo_sz;

    input                 clk;
    input                 en;
    input                 arst;
    input                 srst;
    input                 ld;    // load data
    output                vd;    // fifo full active low
    input     [width-1:0] d;
    output                lz;    // fifo ready to send
    input                 vz;    // dest ready for data
    output    [width-1:0] z;
    output    [sz_width-1:0]      size;

    reg      [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] stat_pre;
    wire     [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] stat;
    reg      [( (fifo_b > 0) ? fifo_b : 1)-1:0] buff_pre;
    wire     [( (fifo_b > 0) ? fifo_b : 1)-1:0] buff;
    reg      [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] en_l;
    reg      [(((fifo_sz > 0) ? fifo_sz : 1)-1)/8:0] en_l_s;

    reg       [width-1:0] buff_nxt;

    reg                   stat_nxt;
    reg                   stat_before;
    reg                   stat_after;
    reg                   en_l_var;

    integer               i;
    genvar                eni;

    wire [32:0]           size_t;
    reg [31:0]            count;
    reg [31:0]            count_t;
    reg [32:0]            n_elem;
// pragma translate_off
    reg [31:0]            peak;
// pragma translate_on

    wire [( (fifo_sz > 0) ? fifo_sz : 1)-1:0] dummy_statreg_lz;
    wire [( (fifo_b > 0) ? fifo_b : 1)-1:0] dummy_bufreg_lz;

    generate
    if ( fifo_sz > 0 )
    begin: FIFO_REG
      assign vd = vz | ~stat[0];
      assign lz = ld | stat[fifo_sz-1];
      assign size_t = (count - (vz && stat[fifo_sz-1])) + ld;
      assign size = size_t[sz_width-1:0];
      assign z = (stat[fifo_sz-1]) ? buff[fifo_b-1:width*(fifo_sz-1)] : d;

      always @(*)
      begin: FIFOPROC
        n_elem = 33'b0;
        for (i = fifo_sz-1; i >= 0; i = i - 1)
        begin
          if (i != 0)
            stat_before = stat[i-1];
          else
            stat_before = 1'b0;

          if (i != (fifo_sz-1))
            stat_after = stat[i+1];
          else
            stat_after = 1'b1;

          stat_nxt = stat_after &
                    (stat_before | (stat[i] & (~vz)) | (stat[i] & ld) | (ld & (~vz)));

          stat_pre[i] = stat_nxt;
          en_l_var = 1'b1;
          if (!stat_nxt)
            begin
              buff_nxt = {width{1'b0}};
              en_l_var = 1'b0;
            end
          else if (vz && stat_before)
            buff_nxt[0+:width] = buff[width*(i-1)+:width];
          else if (ld && !((vz && stat_before) || ((!vz) && stat[i])))
            buff_nxt = d;
          else
            begin
              if (pwropt == 0)
                buff_nxt[0+:width] = buff[width*i+:width];
              else
                buff_nxt = {width{1'b0}};
              en_l_var = 1'b0;
            end

          if (ph_en != 0)
            en_l[i] = en & en_l_var;
          else
            en_l[i] = en | ~en_l_var;

          buff_pre[width*i+:width] = buff_nxt[0+:width];

          if ((stat_after == 1'b1) && (stat[i] == 1'b0))
            n_elem = ($unsigned(fifo_sz) - 1) - i;
        end

        if (ph_en != 0)
          en_l_s[(((fifo_sz > 0) ? fifo_sz : 1)-1)/8] = 1'b1;
        else
          en_l_s[(((fifo_sz > 0) ? fifo_sz : 1)-1)/8] = 1'b0;

        for (i = fifo_sz-1; i >= 7; i = i - 1)
        begin
          if ((i%'d2) == 0)
          begin
            if (ph_en != 0)
              en_l_s[(i/8)-1] = en & (stat[i]|stat_pre[i-1]);
            else
              en_l_s[(i/8)-1] = en | ~(stat[i]|stat_pre[i-1]);
          end
        end

        if ( stat[fifo_sz-1] == 1'b0 )
          count_t = 32'b0;
        else if ( stat[0] == 1'b1 )
          count_t = { {(32-ph_log2){1'b0}}, fifo_sz};
        else
          count_t = n_elem[31:0];
        count = count_t;
// pragma translate_off
        if ( peak < count )
          peak = count;
// pragma translate_on
      end

      if (pwropt == 0)
      begin: NOCGFIFO
        // Output registers:
        mgc_out_reg
        #(
            .rscid   (rscid),
            .width   (fifo_sz),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        STATREG
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (stat_pre),
            .lz      (dummy_statreg_lz[0]),
            .z       (stat)
        );
        mgc_out_reg
        #(
            .rscid   (rscid),
            .width   (fifo_b),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
        )
        BUFREG
        (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (buff_pre),
            .lz      (dummy_bufreg_lz[0]),
            .z       (buff)
        );
      end
      else
      begin: CGFIFO
        // Output registers:
        if ( pwropt > 1)
        begin: CGSTATFIFO2
          for (eni = fifo_sz-1; eni >= 0; eni = eni - 1)
          begin: pwroptGEN1
            mgc_out_reg
            #(
              .rscid   (rscid),
              .width   (1),
              .ph_clk  (ph_clk),
              .ph_en   (ph_en),
              .ph_arst (ph_arst),
              .ph_srst (ph_srst)
            )
            STATREG
            (
              .clk     (clk),
              .en      (en_l_s[eni/8]),
              .arst    (arst),
              .srst    (srst),
              .ld      (1'b1),
              .d       (stat_pre[eni]),
              .lz      (dummy_statreg_lz[eni]),
              .z       (stat[eni])
            );
          end
        end
        else
        begin: CGSTATFIFO
          mgc_out_reg
          #(
            .rscid   (rscid),
            .width   (fifo_sz),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
          )
          STATREG
          (
            .clk     (clk),
            .en      (en),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (stat_pre),
            .lz      (dummy_statreg_lz[0]),
            .z       (stat)
          );
        end
        for (eni = fifo_sz-1; eni >= 0; eni = eni - 1)
        begin: pwroptGEN2
          mgc_out_reg
          #(
            .rscid   (rscid),
            .width   (width),
            .ph_clk  (ph_clk),
            .ph_en   (ph_en),
            .ph_arst (ph_arst),
            .ph_srst (ph_srst)
          )
          BUFREG
          (
            .clk     (clk),
            .en      (en_l[eni]),
            .arst    (arst),
            .srst    (srst),
            .ld      (1'b1),
            .d       (buff_pre[width*eni+:width]),
            .lz      (dummy_bufreg_lz[eni]),
            .z       (buff[width*eni+:width])
          );
        end
      end
    end
    else
    begin: FEED_THRU
      assign vd = vz;
      assign lz = ld;
      assign z = d;
      assign size = ld && !vz;
    end
    endgenerate

endmodule

//------------------------------------------------------------------
//-- PIPE ENTITIES
//------------------------------------------------------------------
/*
 *
 *             _______________________________________________
 * WRITER    |                                               |          READER
 *           |           MGC_PIPE                            |
 *           |           __________________________          |
 *        --<| vdout  --<| vd ---------------  vz<|-----ldin<|---
 *           |           |      FIFO              |          |
 *        ---|>ldout  ---|>ld ---------------- lz |> ---vdin |>--
 *        ---|>dout -----|>d  ---------------- dz |> ----din |>--
 *           |           |________________________|          |
 *           |_______________________________________________|
 */
// two clock pipe
module mgc_pipe (clk, en, arst, srst, ldin, vdin, din, ldout, vdout, dout, size, req_size);

    parameter integer rscid   = 0; // resource ID
    parameter integer width   = 8; // fifo width
    parameter integer sz_width = 8; // width of size of elements in fifo
    parameter integer fifo_sz = 8; // fifo depth
    parameter integer log2_sz = 3; // log2(fifo_sz)
    parameter         ph_clk  = 1'b1;  // clock polarity 1=rising edge, 0=falling edge
    parameter         ph_en   = 1'b1;  // clock enable polarity
    parameter         ph_arst = 1'b1;  // async reset polarity
    parameter         ph_srst = 1'b1;  // sync reset polarity
    parameter integer pwropt  = 0; // pwropt

    input              clk;
    input              en;
    input              arst;
    input              srst;
    input              ldin;
    output             vdin;
    output [width-1:0] din;
    input              ldout;
    output             vdout;
    input  [width-1:0] dout;
    output [sz_width-1:0]      size;
    input              req_size;


    mgc_out_fifo_wait_core
    #(
        .rscid    (rscid),
        .width    (width),
        .sz_width (sz_width),
        .fifo_sz  (fifo_sz),
        .ph_clk   (ph_clk),
        .ph_en    (ph_en),
        .ph_arst  (ph_arst),
        .ph_srst  (ph_srst),
        .ph_log2  (log2_sz),
        .pwropt   (pwropt)
    )
    FIFO
    (
        .clk     (clk),
        .en      (en),
        .arst    (arst),
        .srst    (srst),
        .ld      (ldout),
        .vd      (vdout),
        .d       (dout),
        .lz      (vdin),
        .vz      (ldin),
        .z       (din),
        .size    (size)
    );

endmodule


//------> ./rtl.v 
// ----------------------------------------------------------------------
//  HLS HDL:        Verilog Netlister
//  HLS Version:    2011a.126 Production Release
//  HLS Date:       Wed Aug  8 00:52:07 PDT 2012
// 
//  Generated by:   wjw13@EEWS104A-029
//  Generated date: Thu May 14 15:23:56 2015
// ----------------------------------------------------------------------

// 
// ------------------------------------------------------------------
//  Design Unit:    ball_update_core
// ------------------------------------------------------------------


module ball_update_core (
  clk, en, arst_n, video_in_rsc_mgc_in_wire_d, vga_xy_rsc_mgc_in_wire_d, video_out_rsc_mgc_out_stdreg_d,
      ball_x_out_rsc_mgc_out_stdreg_d, ball_y_out_rsc_mgc_out_stdreg_d, switch1_rsc_mgc_in_wire_d,
      switch2_rsc_mgc_in_wire_d, left_rsc_mgc_out_stdreg_d, right_rsc_mgc_out_stdreg_d
);
  input clk;
  input en;
  input arst_n;
  input [29:0] video_in_rsc_mgc_in_wire_d;
  input [19:0] vga_xy_rsc_mgc_in_wire_d;
  output [29:0] video_out_rsc_mgc_out_stdreg_d;
  reg [29:0] video_out_rsc_mgc_out_stdreg_d;
  output [9:0] ball_x_out_rsc_mgc_out_stdreg_d;
  reg [9:0] ball_x_out_rsc_mgc_out_stdreg_d;
  output [9:0] ball_y_out_rsc_mgc_out_stdreg_d;
  reg [9:0] ball_y_out_rsc_mgc_out_stdreg_d;
  input switch1_rsc_mgc_in_wire_d;
  input switch2_rsc_mgc_in_wire_d;
  output [2:0] left_rsc_mgc_out_stdreg_d;
  reg [2:0] left_rsc_mgc_out_stdreg_d;
  output [2:0] right_rsc_mgc_out_stdreg_d;
  reg [2:0] right_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations
  wire else_24_else_if_and_tmp;
  wire else_24_if_nor_1_tmp;
  wire [2:0] mux1h_6_tmp;
  wire [2:0] mux1h_3_tmp;
  wire not_tmp_9;
  wire and_dcpl_1;
  wire and_dcpl_5;
  wire and_dcpl_6;
  wire and_dcpl_8;
  reg [19:0] counter_sva;
  reg if_7_land_lpi_1_dfm;
  reg if_11_land_lpi_1_dfm;
  reg else_24_land_lpi_1_dfm;
  reg else_24_else_else_land_lpi_1_dfm;
  reg [29:0] io_read_video_in_rsc_d_cse_sva_1;
  reg [2:0] state_sva_dfm_15;
  reg slc_3_svs_1;
  reg slc_4_svs_1;
  reg [9:0] ball_x_sva_dfm_7;
  reg [9:0] ball_y_sva_dfm_7;
  reg [1:0] left_miss_1_sva_dfm_4;
  reg [1:0] right_miss_1_sva_dfm_4;
  reg [2:0] k_lpi_1_dfm_3;
  reg nor_12_itm_1;
  reg and_18_itm_1;
  reg or_4_itm_1;
  reg if_25_nor_1_itm_1;
  wire or_15_cse;
  wire [9:0] ball_x_sva_dfm_mx0;
  wire [10:0] aif_5_acc_2;
  wire [11:0] nl_aif_5_acc_2;
  wire [8:0] if_7_acc_6;
  wire [9:0] nl_if_7_acc_6;
  wire [7:0] if_7_acc_8;
  wire [8:0] nl_if_7_acc_8;
  wire else_24_else_else_land_lpi_1_dfm_mx0;
  wire nor_9_m1c_1;
  wire [2:0] state_sva_dfm_16;
  wire if_7_land_sva_2;
  wire equal_tmp_4;
  wire nor_tmp_8;
  wire nor_8_m1c_1;
  wire or_m1c_1;
  wire equal_tmp_5;
  wire nor_tmp_9;
  wire [8:0] if_7_if_acc_sdt_sva;
  wire [9:0] nl_if_7_if_acc_sdt_sva;
  wire [9:0] ball_y_sva_dfm_mx0;
  reg reg_asn_222_itm_cse;
  wire nand_3_cse;
  wire or_dcpl;
  wire and_dcpl;
  wire [8:0] if_18_acc_3_itm;
  wire [9:0] nl_if_18_acc_3_itm;
  wire [5:0] if_15_acc_3_itm;
  wire [6:0] nl_if_15_acc_3_itm;
  wire [6:0] if_7_acc_2_itm;
  wire [7:0] nl_if_7_acc_2_itm;
  wire [7:0] if_11_acc_1_itm;
  wire [8:0] nl_if_11_acc_1_itm;
  wire [3:0] if_11_acc_itm;
  wire [4:0] nl_if_11_acc_itm;
  wire [8:0] if_7_acc_1_itm;
  wire [9:0] nl_if_7_acc_1_itm;
  wire [8:0] if_1_acc_itm;
  wire [9:0] nl_if_1_acc_itm;
  wire [2:0] if_15_acc_itm;
  wire [3:0] nl_if_15_acc_itm;
  wire [2:0] if_18_acc_itm;
  wire [3:0] nl_if_18_acc_itm;
  wire [2:0] state_sva_dfm_12;
  wire else_24_else_else_land_lpi_1_dfm_mx0w0;
  wire else_24_land_lpi_1_dfm_mx0w0;
  wire else_24_land_lpi_1_dfm_mx0;
  wire [19:0] counter_sva_mx0;
  wire [9:0] ball_y_sva_dfm_6;
  wire [9:0] ball_x_sva_dfm_6;
  wire land_9_lpi_1_dfm;
  wire and_4_cse;
  wire and_31_cse;
  wire else_24_else_and_cse;
  wire and_32_cse;
  wire if_7_land_lpi_1_dfm_mx0;
  wire [9:0] acc_2_psp_1_sva;
  wire [10:0] nl_acc_2_psp_1_sva;
  wire if_11_land_lpi_1_dfm_mx0;
  wire else_20_land_lpi_1_dfm;
  wire land_8_lpi_1_dfm;
  wire [14:0] acc_10_sdt_1;
  wire [15:0] nl_acc_10_sdt_1;
  wire [2:0] state_sva_dfm_mx0;
  wire [2:0] state_sva_dfm_4;
  wire nor_tmp_2;
  wire equal_tmp_2;
  wire nor_tmp_3;
  wire equal_tmp_3;
  wire [1:0] right_miss_1_sva_dfm_1_mx0;
  wire else_20_else_land_lpi_1_dfm;
  wire nand_2_tmp;
  wire nand_tmp;
  wire [6:0] else_2_if_acc_itm;
  wire [7:0] nl_else_2_if_acc_itm;
  wire [17:0] acc_itm;
  wire [18:0] nl_acc_itm;

  wire[7:0] mux_14_nl;
  wire[0:0] mux_27_nl;
  wire[0:0] mux_26_nl;

  // Interconnect Declarations for Component Instantiations 
  assign nand_3_cse = ~((if_7_acc_6[8]) & (aif_5_acc_2[10]));
  assign state_sva_dfm_16 = MUX1HOT_v_3_3_2({3'b100 , 3'b11 , state_sva_dfm_15},
      {nor_12_itm_1 , and_18_itm_1 , or_4_itm_1});
  assign state_sva_dfm_12 = MUX1HOT_v_3_3_2({state_sva_dfm_16 , (conv_u2u_2_3(state_sva_dfm_16[1:0])
      + 3'b1) , 3'b1}, {(~ slc_3_svs_1) , ((~ (state_sva_dfm_16[2])) & slc_3_svs_1)
      , ((state_sva_dfm_16[2]) & slc_3_svs_1)});
  assign else_24_else_else_land_lpi_1_dfm_mx0w0 = (counter_sva[18]) & (counter_sva[15])
      & (counter_sva[14]) & (counter_sva[11]) & (counter_sva[8]) & else_24_if_nor_1_tmp
      & (mux1h_6_tmp[2]) & (~((mux1h_6_tmp[1]) | (mux1h_6_tmp[0])));
  assign else_24_else_else_land_lpi_1_dfm_mx0 = MUX_s_1_2_2({else_24_else_else_land_lpi_1_dfm_mx0w0
      , else_24_else_else_land_lpi_1_dfm}, and_dcpl_1 | else_24_else_if_and_tmp);
  assign else_24_else_if_and_tmp = (counter_sva[18]) & (counter_sva[15]) & (counter_sva[14])
      & (counter_sva[11]) & (counter_sva[8]) & else_24_if_nor_1_tmp & (mux1h_6_tmp[1])
      & (mux1h_6_tmp[0]) & (~ (mux1h_6_tmp[2]));
  assign else_24_land_lpi_1_dfm_mx0w0 = (counter_sva[18]) & (counter_sva[15]) & (counter_sva[14])
      & (counter_sva[11]) & (counter_sva[8]) & else_24_if_nor_1_tmp & (mux1h_6_tmp[1])
      & (~((mux1h_6_tmp[2]) | (mux1h_6_tmp[0])));
  assign else_24_land_lpi_1_dfm_mx0 = MUX_s_1_2_2({else_24_land_lpi_1_dfm_mx0w0 ,
      else_24_land_lpi_1_dfm}, and_dcpl_8 & and_dcpl_6 & and_dcpl_5);
  assign counter_sva_mx0 = MUX_v_20_2_2({counter_sva , ((counter_sva & (signext_20_1(~
      else_24_else_else_land_lpi_1_dfm_mx0w0)) & (signext_20_1(~ else_24_else_if_and_tmp))
      & (signext_20_1(~ else_24_land_lpi_1_dfm_mx0w0)) & (signext_20_1(~ land_9_lpi_1_dfm)))
      + 20'b1)}, reg_asn_222_itm_cse);
  assign else_24_if_nor_1_tmp = ~((counter_sva[19]) | (counter_sva[17]) | (counter_sva[16])
      | (counter_sva[13]) | (counter_sva[12]) | (counter_sva[10]) | (counter_sva[9])
      | (counter_sva[7]) | (counter_sva[6]) | (counter_sva[5]) | (counter_sva[4])
      | (counter_sva[3]) | (counter_sva[2]) | (counter_sva[1]) | (counter_sva[0]));
  assign mux1h_6_tmp = MUX1HOT_v_3_3_2({(conv_u2u_2_3(state_sva_dfm_12[1:0]) + 3'b1)
      , 3'b1 , state_sva_dfm_12}, {(~((state_sva_dfm_12[2]) | slc_4_svs_1)) , ((state_sva_dfm_12[2])
      & (~ slc_4_svs_1)) , slc_4_svs_1});
  assign ball_y_sva_dfm_6 = MUX1HOT_v_10_3_2({(readslicef_11_10_1((({ball_y_sva_dfm_7
      , 1'b1}) + ({7'b1111111 , (~ k_lpi_1_dfm_3) , 1'b1})))) , (ball_y_sva_dfm_7
      + conv_u2u_3_10(k_lpi_1_dfm_3)) , ball_y_sva_dfm_7}, {(land_9_lpi_1_dfm | else_24_else_and_cse)
      , (and_4_cse | and_31_cse) , and_32_cse});
  assign ball_x_sva_dfm_6 = MUX1HOT_v_10_3_2({(ball_x_sva_dfm_7 + conv_u2u_3_10(k_lpi_1_dfm_3))
      , (readslicef_11_10_1((({ball_x_sva_dfm_7 , 1'b1}) + ({7'b1111111 , (~ k_lpi_1_dfm_3)
      , 1'b1})))) , ball_x_sva_dfm_7}, {(land_9_lpi_1_dfm | and_4_cse) , (and_31_cse
      | else_24_else_and_cse) , and_32_cse});
  assign land_9_lpi_1_dfm = (counter_sva[18]) & (counter_sva[15]) & (counter_sva[14])
      & (counter_sva[11]) & (counter_sva[8]) & if_25_nor_1_itm_1 & (mux1h_6_tmp[0])
      & (~((mux1h_6_tmp[2]) | (mux1h_6_tmp[1])));
  assign and_4_cse = else_24_land_lpi_1_dfm_mx0 & (~ land_9_lpi_1_dfm);
  assign and_31_cse = else_24_else_if_and_tmp & nor_9_m1c_1;
  assign else_24_else_and_cse = else_24_else_else_land_lpi_1_dfm_mx0 & (~ else_24_else_if_and_tmp)
      & nor_9_m1c_1;
  assign and_32_cse = (~(else_24_else_else_land_lpi_1_dfm_mx0 | else_24_else_if_and_tmp))
      & nor_9_m1c_1;
  assign nor_9_m1c_1 = ~(else_24_land_lpi_1_dfm_mx0 | land_9_lpi_1_dfm);
  assign mux_14_nl = MUX_v_8_2_2({8'b1111000 , (ball_x_sva_dfm_6[9:2])}, reg_asn_222_itm_cse
      & (~ (if_15_acc_3_itm[5])));
  assign nl_if_18_acc_3_itm = conv_u2u_8_9(mux_14_nl) + 9'b101011011;
  assign if_18_acc_3_itm = nl_if_18_acc_3_itm[8:0];
  assign nl_if_15_acc_3_itm = (ball_x_sva_dfm_mx0[9:4]) + 6'b110001;
  assign if_15_acc_3_itm = nl_if_15_acc_3_itm[5:0];
  assign mux1h_3_tmp = MUX1HOT_v_3_3_2({3'b1 , 3'b10 , state_sva_dfm_4}, {(~(equal_tmp_2
      | nor_tmp_2 | nand_tmp)) , (equal_tmp_2 & (~ nand_tmp)) , (nor_tmp_2 | nand_tmp)});
  assign nl_else_2_if_acc_itm = conv_u2u_6_7(ball_y_sva_dfm_mx0[9:4]) + 7'b1100111;
  assign else_2_if_acc_itm = nl_else_2_if_acc_itm[6:0];
  assign ball_y_sva_dfm_mx0 = MUX_v_10_2_2({10'b11111010 , ball_y_sva_dfm_6}, reg_asn_222_itm_cse);
  assign if_7_land_sva_2 = ball_y_sva_dfm_mx0 == (vga_xy_rsc_mgc_in_wire_d[19:10]);
  assign if_7_land_lpi_1_dfm_mx0 = MUX_s_1_2_2({(if_7_land_sva_2 & (~((({(if_7_if_acc_sdt_sva[7:0])
      , (ball_x_sva_dfm_mx0[1:0])}) != (vga_xy_rsc_mgc_in_wire_d[9:0])) | (if_7_if_acc_sdt_sva[8]))))
      , if_7_land_lpi_1_dfm}, nand_3_cse | (if_7_acc_8[7]) | (if_7_acc_1_itm[8])
      | (~ (if_7_acc_2_itm[6])));
  assign nl_if_7_if_acc_sdt_sva = conv_u2u_8_9(ball_x_sva_dfm_mx0[9:2]) + 9'b111111011;
  assign if_7_if_acc_sdt_sva = nl_if_7_if_acc_sdt_sva[8:0];
  assign ball_x_sva_dfm_mx0 = MUX_v_10_2_2({10'b111100000 , ball_x_sva_dfm_6}, reg_asn_222_itm_cse);
  assign nl_acc_2_psp_1_sva = (acc_itm[17:8]) + conv_u2s_1_10(acc_itm[7]);
  assign acc_2_psp_1_sva = nl_acc_2_psp_1_sva[9:0];
  assign nl_if_7_acc_2_itm = conv_u2u_6_7(vga_xy_rsc_mgc_in_wire_d[9:4]) + 7'b1110001;
  assign if_7_acc_2_itm = nl_if_7_acc_2_itm[6:0];
  assign if_11_land_lpi_1_dfm_mx0 = MUX_s_1_2_2({(if_7_land_sva_2 & (ball_x_sva_dfm_mx0
      == (vga_xy_rsc_mgc_in_wire_d[9:0]))) , if_11_land_lpi_1_dfm}, nand_3_cse |
      (if_11_acc_itm[3]) | (~ (if_11_acc_1_itm[7])) | (if_7_acc_8[7]));
  assign nl_if_11_acc_1_itm = ({1'b1 , (vga_xy_rsc_mgc_in_wire_d[8:2])}) + 8'b1011011;
  assign if_11_acc_1_itm = nl_if_11_acc_1_itm[7:0];
  assign else_20_land_lpi_1_dfm = switch2_rsc_mgc_in_wire_d & (~ switch1_rsc_mgc_in_wire_d);
  assign land_8_lpi_1_dfm = ~(switch2_rsc_mgc_in_wire_d | switch1_rsc_mgc_in_wire_d);
  assign nl_if_11_acc_itm = conv_u2u_3_4(vga_xy_rsc_mgc_in_wire_d[9:7]) + 4'b1011;
  assign if_11_acc_itm = nl_if_11_acc_itm[3:0];
  assign nl_if_7_acc_1_itm = conv_u2u_8_9(vga_xy_rsc_mgc_in_wire_d[9:2]) + 9'b111001001;
  assign if_7_acc_1_itm = nl_if_7_acc_1_itm[8:0];
  assign nl_if_1_acc_itm = conv_u2u_8_9(ball_y_sva_dfm_mx0[9:2]) + 9'b111011101;
  assign if_1_acc_itm = nl_if_1_acc_itm[8:0];
  assign nl_acc_itm = ({(conv_u2u_10_11(video_in_rsc_mgc_in_wire_d[29:20]) + conv_s2u_9_11({1'b1
      , (acc_10_sdt_1[14:7])})) , (acc_10_sdt_1[6:0])}) + ({conv_u2u_34_17(conv_u2s_10_17(video_in_rsc_mgc_in_wire_d[19:10])
      * 17'b11111111111001011) , 1'b1});
  assign acc_itm = nl_acc_itm[17:0];
  assign nl_acc_10_sdt_1 = conv_s2s_30_15(conv_u2s_10_15(video_in_rsc_mgc_in_wire_d[9:0])
      * 15'b111111111101011) + conv_s2s_11_15({1'b1 , (~ (video_in_rsc_mgc_in_wire_d[29:20]))});
  assign acc_10_sdt_1 = nl_acc_10_sdt_1[14:0];
  assign nor_tmp_9 = ~(((state_sva_dfm_mx0[2]) & (~((state_sva_dfm_mx0[1]) | (state_sva_dfm_mx0[0]))))
      | equal_tmp_5);
  assign equal_tmp_5 = (state_sva_dfm_mx0[0]) & (~((state_sva_dfm_mx0[2]) | (state_sva_dfm_mx0[1])));
  assign state_sva_dfm_mx0 = MUX_v_3_2_2({3'b1 , mux1h_6_tmp}, reg_asn_222_itm_cse);
  assign nor_tmp_8 = ~(((state_sva_dfm_mx0[1]) & (state_sva_dfm_mx0[0]) & (~ (state_sva_dfm_mx0[2])))
      | equal_tmp_4);
  assign equal_tmp_4 = (state_sva_dfm_mx0[1]) & (~((state_sva_dfm_mx0[2]) | (state_sva_dfm_mx0[0])));
  assign state_sva_dfm_4 = MUX1HOT_v_3_5_2({3'b100 , 3'b1 , mux1h_6_tmp , 3'b11 ,
      3'b10}, {((~(equal_tmp_4 | nor_tmp_8)) & nor_8_m1c_1) , ((equal_tmp_4 & nor_8_m1c_1)
      | ((~ reg_asn_222_itm_cse) & or_m1c_1)) , (reg_asn_222_itm_cse & or_m1c_1)
      , ((~(equal_tmp_5 | nor_tmp_9)) & (if_1_acc_itm[8])) , (equal_tmp_5 & (if_1_acc_itm[8]))});
  assign nor_tmp_2 = ~(((state_sva_dfm_4[2]) & (~((state_sva_dfm_4[1]) | (state_sva_dfm_4[0]))))
      | equal_tmp_2);
  assign equal_tmp_2 = (state_sva_dfm_4[1]) & (state_sva_dfm_4[0]) & (~ (state_sva_dfm_4[2]));
  assign nor_tmp_3 = ~(((mux1h_3_tmp[0]) & (~((mux1h_3_tmp[2]) | (mux1h_3_tmp[1]))))
      | equal_tmp_3);
  assign equal_tmp_3 = (mux1h_3_tmp[1]) & (~((mux1h_3_tmp[2]) | (mux1h_3_tmp[0])));
  assign right_miss_1_sva_dfm_1_mx0 = (right_miss_1_sva_dfm_4 | (signext_2_1(~((if_15_acc_itm[2])
      | (~ (if_15_acc_3_itm[5])))))) & (signext_2_1(~((~ (if_15_acc_itm[2])) & (if_15_acc_3_itm[5]))));
  assign else_20_else_land_lpi_1_dfm = ~(switch2_rsc_mgc_in_wire_d | (~ switch1_rsc_mgc_in_wire_d));
  assign nand_2_tmp = ~(if_11_land_lpi_1_dfm_mx0 & (aif_5_acc_2[10]) & (if_7_acc_6[8])
      & (~ (if_7_acc_8[7])) & (if_11_acc_1_itm[7]) & (~ (if_11_acc_itm[3])));
  assign nand_tmp = ~(if_7_land_lpi_1_dfm_mx0 & (aif_5_acc_2[10]) & (if_7_acc_6[8])
      & (~ (if_7_acc_8[7])) & (if_7_acc_2_itm[6]) & (~ (if_7_acc_1_itm[8])));
  assign nor_8_m1c_1 = ~((else_2_if_acc_itm[6]) | (if_1_acc_itm[8]));
  assign or_m1c_1 = (nor_tmp_8 & nor_8_m1c_1) | ((else_2_if_acc_itm[6]) & (~ (if_1_acc_itm[8])))
      | (nor_tmp_9 & (if_1_acc_itm[8]));
  assign nl_if_7_acc_6 = conv_u2u_8_9(vga_xy_rsc_mgc_in_wire_d[19:12]) + 9'b110010111;
  assign if_7_acc_6 = nl_if_7_acc_6[8:0];
  assign nl_if_7_acc_8 = conv_u2u_7_8(vga_xy_rsc_mgc_in_wire_d[19:13]) + 8'b11110001;
  assign if_7_acc_8 = nl_if_7_acc_8[7:0];
  assign nl_aif_5_acc_2 = ({(~ (conv_s2s_3_4(acc_2_psp_1_sva[9:7]) + 4'b1)) , (~
      (acc_2_psp_1_sva[6:0]))}) + 11'b100101101;
  assign aif_5_acc_2 = nl_aif_5_acc_2[10:0];
  assign nl_if_15_acc_itm = ({1'b1 , left_miss_1_sva_dfm_4}) + 3'b1;
  assign if_15_acc_itm = nl_if_15_acc_itm[2:0];
  assign nl_if_18_acc_itm = ({1'b1 , right_miss_1_sva_dfm_1_mx0}) + 3'b1;
  assign if_18_acc_itm = nl_if_18_acc_itm[2:0];
  assign or_15_cse = (~ reg_asn_222_itm_cse) | (if_15_acc_3_itm[5]) | (~ (if_18_acc_3_itm[8]));
  assign not_tmp_9 = ~((mux1h_6_tmp[0]) & (counter_sva[18]) & (counter_sva[15]) &
      (counter_sva[14]) & (counter_sva[11]) & (counter_sva[8]) & if_25_nor_1_itm_1);
  assign mux_26_nl = MUX_s_1_2_2({not_tmp_9 , ((mux1h_6_tmp[0]) | (~((counter_sva[18])
      & (counter_sva[15]) & (counter_sva[14]) & (counter_sva[11]) & (counter_sva[8]))))},
      mux1h_6_tmp[1]);
  assign mux_27_nl = MUX_s_1_2_2({((mux1h_6_tmp[1]) | not_tmp_9) , (mux_26_nl)},
      else_24_if_nor_1_tmp);
  assign and_dcpl_1 = ~((mux_27_nl) | (mux1h_6_tmp[2]));
  assign and_dcpl_5 = (counter_sva[18]) & (mux1h_6_tmp[0]) & (~((mux1h_6_tmp[1])
      | (mux1h_6_tmp[2])));
  assign and_dcpl_6 = (counter_sva[14]) & (counter_sva[15]);
  assign and_dcpl_8 = if_25_nor_1_itm_1 & (counter_sva[8]) & (counter_sva[11]);
  assign or_dcpl = (if_18_acc_3_itm[8]) | (if_18_acc_itm[2]);
  assign and_dcpl = ~((if_18_acc_3_itm[8]) | (if_18_acc_itm[2]));
  always @(posedge clk or negedge arst_n) begin
    if ( ~ arst_n ) begin
      right_rsc_mgc_out_stdreg_d <= 3'b0;
      left_rsc_mgc_out_stdreg_d <= 3'b0;
      ball_y_out_rsc_mgc_out_stdreg_d <= 10'b0;
      ball_x_out_rsc_mgc_out_stdreg_d <= 10'b0;
      video_out_rsc_mgc_out_stdreg_d <= 30'b0;
      ball_y_sva_dfm_7 <= 10'b0;
      k_lpi_1_dfm_3 <= 3'b0;
      ball_x_sva_dfm_7 <= 10'b0;
      else_24_else_else_land_lpi_1_dfm <= 1'b0;
      else_24_land_lpi_1_dfm <= 1'b0;
      counter_sva <= 20'b0;
      right_miss_1_sva_dfm_4 <= 2'b0;
      left_miss_1_sva_dfm_4 <= 2'b0;
      io_read_video_in_rsc_d_cse_sva_1 <= 30'b0;
      if_25_nor_1_itm_1 <= 1'b0;
      slc_4_svs_1 <= 1'b0;
      slc_3_svs_1 <= 1'b0;
      nor_12_itm_1 <= 1'b0;
      and_18_itm_1 <= 1'b0;
      state_sva_dfm_15 <= 3'b0;
      or_4_itm_1 <= 1'b0;
      if_7_land_lpi_1_dfm <= 1'b0;
      if_11_land_lpi_1_dfm <= 1'b0;
      reg_asn_222_itm_cse <= 1'b0;
    end
    else begin
      if ( en ) begin
        right_rsc_mgc_out_stdreg_d <= MUX_v_3_2_2({right_rsc_mgc_out_stdreg_d , ({1'b0
            , right_miss_1_sva_dfm_4})}, reg_asn_222_itm_cse);
        left_rsc_mgc_out_stdreg_d <= MUX_v_3_2_2({left_rsc_mgc_out_stdreg_d , ({1'b0
            , left_miss_1_sva_dfm_4})}, reg_asn_222_itm_cse);
        ball_y_out_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({ball_y_out_rsc_mgc_out_stdreg_d
            , ball_y_sva_dfm_6}, reg_asn_222_itm_cse);
        ball_x_out_rsc_mgc_out_stdreg_d <= MUX_v_10_2_2({ball_x_out_rsc_mgc_out_stdreg_d
            , ball_x_sva_dfm_6}, reg_asn_222_itm_cse);
        video_out_rsc_mgc_out_stdreg_d <= MUX_v_30_2_2({video_out_rsc_mgc_out_stdreg_d
            , io_read_video_in_rsc_d_cse_sva_1}, reg_asn_222_itm_cse);
        ball_y_sva_dfm_7 <= MUX_v_10_2_2({ball_y_sva_dfm_6 , 10'b11111010}, or_15_cse);
        k_lpi_1_dfm_3 <= MUX1HOT_v_3_4_2({3'b100 , 3'b11 , 3'b10 , 3'b1}, {(~(else_20_else_land_lpi_1_dfm
            | else_20_land_lpi_1_dfm | land_8_lpi_1_dfm)) , (else_20_else_land_lpi_1_dfm
            & (~ else_20_land_lpi_1_dfm) & (~ land_8_lpi_1_dfm)) , (else_20_land_lpi_1_dfm
            & (~ land_8_lpi_1_dfm)) , land_8_lpi_1_dfm});
        ball_x_sva_dfm_7 <= MUX_v_10_2_2({ball_x_sva_dfm_6 , 10'b111100000}, or_15_cse);
        else_24_else_else_land_lpi_1_dfm <= MUX_s_1_2_2({else_24_else_else_land_lpi_1_dfm_mx0w0
            , else_24_else_else_land_lpi_1_dfm}, and_dcpl_1 | else_24_else_if_and_tmp
            | (~ reg_asn_222_itm_cse));
        else_24_land_lpi_1_dfm <= MUX_s_1_2_2({else_24_land_lpi_1_dfm_mx0w0 , else_24_land_lpi_1_dfm},
            ~((~(and_dcpl_8 & and_dcpl_6 & and_dcpl_5)) & reg_asn_222_itm_cse));
        counter_sva <= counter_sva_mx0;
        right_miss_1_sva_dfm_4 <= MUX_v_2_2_2({((right_miss_1_sva_dfm_1_mx0 & (signext_2_1(if_18_acc_itm[2])))
            + 2'b1) , right_miss_1_sva_dfm_1_mx0}, if_18_acc_3_itm[8]);
        left_miss_1_sva_dfm_4 <= ~((~((MUX_v_2_2_2({left_miss_1_sva_dfm_4 , ((left_miss_1_sva_dfm_4
            & (signext_2_1(if_15_acc_itm[2]))) + 2'b1)}, (if_15_acc_3_itm[5]) & or_dcpl))
            | (signext_2_1(~(or_dcpl | and_dcpl))))) | ({{1{and_dcpl}}, and_dcpl}));
        io_read_video_in_rsc_d_cse_sva_1 <= video_in_rsc_mgc_in_wire_d;
        if_25_nor_1_itm_1 <= ~((counter_sva_mx0[19]) | (counter_sva_mx0[17]) | (counter_sva_mx0[16])
            | (counter_sva_mx0[13]) | (counter_sva_mx0[12]) | (counter_sva_mx0[10])
            | (counter_sva_mx0[9]) | (counter_sva_mx0[7]) | (counter_sva_mx0[6])
            | (counter_sva_mx0[5]) | (counter_sva_mx0[4]) | (counter_sva_mx0[3])
            | (counter_sva_mx0[2]) | (counter_sva_mx0[1]) | (counter_sva_mx0[0]));
        slc_4_svs_1 <= if_18_acc_3_itm[8];
        slc_3_svs_1 <= if_15_acc_3_itm[5];
        nor_12_itm_1 <= ~(equal_tmp_3 | nor_tmp_3 | nand_2_tmp);
        and_18_itm_1 <= equal_tmp_3 & (~ nand_2_tmp);
        state_sva_dfm_15 <= mux1h_3_tmp;
        or_4_itm_1 <= nor_tmp_3 | nand_2_tmp;
        if_7_land_lpi_1_dfm <= if_7_land_lpi_1_dfm_mx0;
        if_11_land_lpi_1_dfm <= if_11_land_lpi_1_dfm_mx0;
        reg_asn_222_itm_cse <= 1'b1;
      end
    end
  end

  function [2:0] MUX1HOT_v_3_3_2;
    input [8:0] inputs;
    input [2:0] sel;
    reg [2:0] result;
    integer i;
  begin
    result = inputs[0+:3] & {3{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*3+:3] & {3{sel[i]}});
    MUX1HOT_v_3_3_2 = result;
  end
  endfunction


  function [0:0] MUX_s_1_2_2;
    input [1:0] inputs;
    input [0:0] sel;
    reg [0:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[1:1];
      end
      1'b1 : begin
        result = inputs[0:0];
      end
      default : begin
        result = inputs[1:1];
      end
    endcase
    MUX_s_1_2_2 = result;
  end
  endfunction


  function [19:0] MUX_v_20_2_2;
    input [39:0] inputs;
    input [0:0] sel;
    reg [19:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[39:20];
      end
      1'b1 : begin
        result = inputs[19:0];
      end
      default : begin
        result = inputs[39:20];
      end
    endcase
    MUX_v_20_2_2 = result;
  end
  endfunction


  function [19:0] signext_20_1;
    input [0:0] vector;
  begin
    signext_20_1= {{19{vector[0]}}, vector};
  end
  endfunction


  function [9:0] MUX1HOT_v_10_3_2;
    input [29:0] inputs;
    input [2:0] sel;
    reg [9:0] result;
    integer i;
  begin
    result = inputs[0+:10] & {10{sel[0]}};
    for( i = 1; i < 3; i = i + 1 )
      result = result | (inputs[i*10+:10] & {10{sel[i]}});
    MUX1HOT_v_10_3_2 = result;
  end
  endfunction


  function [9:0] readslicef_11_10_1;
    input [10:0] vector;
    reg [10:0] tmp;
  begin
    tmp = vector >> 1;
    readslicef_11_10_1 = tmp[9:0];
  end
  endfunction


  function [7:0] MUX_v_8_2_2;
    input [15:0] inputs;
    input [0:0] sel;
    reg [7:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[15:8];
      end
      1'b1 : begin
        result = inputs[7:0];
      end
      default : begin
        result = inputs[15:8];
      end
    endcase
    MUX_v_8_2_2 = result;
  end
  endfunction


  function [9:0] MUX_v_10_2_2;
    input [19:0] inputs;
    input [0:0] sel;
    reg [9:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[19:10];
      end
      1'b1 : begin
        result = inputs[9:0];
      end
      default : begin
        result = inputs[19:10];
      end
    endcase
    MUX_v_10_2_2 = result;
  end
  endfunction


  function [2:0] MUX_v_3_2_2;
    input [5:0] inputs;
    input [0:0] sel;
    reg [2:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[5:3];
      end
      1'b1 : begin
        result = inputs[2:0];
      end
      default : begin
        result = inputs[5:3];
      end
    endcase
    MUX_v_3_2_2 = result;
  end
  endfunction


  function [2:0] MUX1HOT_v_3_5_2;
    input [14:0] inputs;
    input [4:0] sel;
    reg [2:0] result;
    integer i;
  begin
    result = inputs[0+:3] & {3{sel[0]}};
    for( i = 1; i < 5; i = i + 1 )
      result = result | (inputs[i*3+:3] & {3{sel[i]}});
    MUX1HOT_v_3_5_2 = result;
  end
  endfunction


  function [1:0] signext_2_1;
    input [0:0] vector;
  begin
    signext_2_1= {{1{vector[0]}}, vector};
  end
  endfunction


  function [29:0] MUX_v_30_2_2;
    input [59:0] inputs;
    input [0:0] sel;
    reg [29:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[59:30];
      end
      1'b1 : begin
        result = inputs[29:0];
      end
      default : begin
        result = inputs[59:30];
      end
    endcase
    MUX_v_30_2_2 = result;
  end
  endfunction


  function [2:0] MUX1HOT_v_3_4_2;
    input [11:0] inputs;
    input [3:0] sel;
    reg [2:0] result;
    integer i;
  begin
    result = inputs[0+:3] & {3{sel[0]}};
    for( i = 1; i < 4; i = i + 1 )
      result = result | (inputs[i*3+:3] & {3{sel[i]}});
    MUX1HOT_v_3_4_2 = result;
  end
  endfunction


  function [1:0] MUX_v_2_2_2;
    input [3:0] inputs;
    input [0:0] sel;
    reg [1:0] result;
  begin
    case (sel)
      1'b0 : begin
        result = inputs[3:2];
      end
      1'b1 : begin
        result = inputs[1:0];
      end
      default : begin
        result = inputs[3:2];
      end
    endcase
    MUX_v_2_2_2 = result;
  end
  endfunction


  function  [2:0] conv_u2u_2_3 ;
    input [1:0]  vector ;
  begin
    conv_u2u_2_3 = {1'b0, vector};
  end
  endfunction


  function  [9:0] conv_u2u_3_10 ;
    input [2:0]  vector ;
  begin
    conv_u2u_3_10 = {{7{1'b0}}, vector};
  end
  endfunction


  function  [8:0] conv_u2u_8_9 ;
    input [7:0]  vector ;
  begin
    conv_u2u_8_9 = {1'b0, vector};
  end
  endfunction


  function  [6:0] conv_u2u_6_7 ;
    input [5:0]  vector ;
  begin
    conv_u2u_6_7 = {1'b0, vector};
  end
  endfunction


  function signed [9:0] conv_u2s_1_10 ;
    input [0:0]  vector ;
  begin
    conv_u2s_1_10 = {{9{1'b0}}, vector};
  end
  endfunction


  function  [3:0] conv_u2u_3_4 ;
    input [2:0]  vector ;
  begin
    conv_u2u_3_4 = {1'b0, vector};
  end
  endfunction


  function  [10:0] conv_u2u_10_11 ;
    input [9:0]  vector ;
  begin
    conv_u2u_10_11 = {1'b0, vector};
  end
  endfunction


  function  [10:0] conv_s2u_9_11 ;
    input signed [8:0]  vector ;
  begin
    conv_s2u_9_11 = {{2{vector[8]}}, vector};
  end
  endfunction


  function  [16:0] conv_u2u_34_17 ;
    input [33:0]  vector ;
  begin
    conv_u2u_34_17 = vector[16:0];
  end
  endfunction


  function signed [16:0] conv_u2s_10_17 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_17 = {{7{1'b0}}, vector};
  end
  endfunction


  function signed [14:0] conv_s2s_30_15 ;
    input signed [29:0]  vector ;
  begin
    conv_s2s_30_15 = vector[14:0];
  end
  endfunction


  function signed [14:0] conv_u2s_10_15 ;
    input [9:0]  vector ;
  begin
    conv_u2s_10_15 = {{5{1'b0}}, vector};
  end
  endfunction


  function signed [14:0] conv_s2s_11_15 ;
    input signed [10:0]  vector ;
  begin
    conv_s2s_11_15 = {{4{vector[10]}}, vector};
  end
  endfunction


  function  [7:0] conv_u2u_7_8 ;
    input [6:0]  vector ;
  begin
    conv_u2u_7_8 = {1'b0, vector};
  end
  endfunction


  function signed [3:0] conv_s2s_3_4 ;
    input signed [2:0]  vector ;
  begin
    conv_s2s_3_4 = {vector[2], vector};
  end
  endfunction

endmodule

// ------------------------------------------------------------------
//  Design Unit:    ball_update
//  Generated from file(s):
//    2) $PROJECT_HOME/May12_ball_update.c
// ------------------------------------------------------------------


module ball_update (
  video_in_rsc_z, vga_xy_rsc_z, video_out_rsc_z, ball_x_out_rsc_z, ball_y_out_rsc_z,
      switch1_rsc_z, switch2_rsc_z, left_rsc_z, right_rsc_z, clk, en, arst_n
);
  input [29:0] video_in_rsc_z;
  input [19:0] vga_xy_rsc_z;
  output [29:0] video_out_rsc_z;
  output [9:0] ball_x_out_rsc_z;
  output [9:0] ball_y_out_rsc_z;
  input switch1_rsc_z;
  input switch2_rsc_z;
  output [2:0] left_rsc_z;
  output [2:0] right_rsc_z;
  input clk;
  input en;
  input arst_n;


  // Interconnect Declarations
  wire [29:0] video_in_rsc_mgc_in_wire_d;
  wire [19:0] vga_xy_rsc_mgc_in_wire_d;
  wire [29:0] video_out_rsc_mgc_out_stdreg_d;
  wire [9:0] ball_x_out_rsc_mgc_out_stdreg_d;
  wire [9:0] ball_y_out_rsc_mgc_out_stdreg_d;
  wire switch1_rsc_mgc_in_wire_d;
  wire switch2_rsc_mgc_in_wire_d;
  wire [2:0] left_rsc_mgc_out_stdreg_d;
  wire [2:0] right_rsc_mgc_out_stdreg_d;


  // Interconnect Declarations for Component Instantiations 
  mgc_in_wire #(.rscid(1),
  .width(30)) video_in_rsc_mgc_in_wire (
      .d(video_in_rsc_mgc_in_wire_d),
      .z(video_in_rsc_z)
    );
  mgc_in_wire #(.rscid(2),
  .width(20)) vga_xy_rsc_mgc_in_wire (
      .d(vga_xy_rsc_mgc_in_wire_d),
      .z(vga_xy_rsc_z)
    );
  mgc_out_stdreg #(.rscid(3),
  .width(30)) video_out_rsc_mgc_out_stdreg (
      .d(video_out_rsc_mgc_out_stdreg_d),
      .z(video_out_rsc_z)
    );
  mgc_out_stdreg #(.rscid(4),
  .width(10)) ball_x_out_rsc_mgc_out_stdreg (
      .d(ball_x_out_rsc_mgc_out_stdreg_d),
      .z(ball_x_out_rsc_z)
    );
  mgc_out_stdreg #(.rscid(5),
  .width(10)) ball_y_out_rsc_mgc_out_stdreg (
      .d(ball_y_out_rsc_mgc_out_stdreg_d),
      .z(ball_y_out_rsc_z)
    );
  mgc_in_wire #(.rscid(6),
  .width(1)) switch1_rsc_mgc_in_wire (
      .d(switch1_rsc_mgc_in_wire_d),
      .z(switch1_rsc_z)
    );
  mgc_in_wire #(.rscid(7),
  .width(1)) switch2_rsc_mgc_in_wire (
      .d(switch2_rsc_mgc_in_wire_d),
      .z(switch2_rsc_z)
    );
  mgc_out_stdreg #(.rscid(8),
  .width(3)) left_rsc_mgc_out_stdreg (
      .d(left_rsc_mgc_out_stdreg_d),
      .z(left_rsc_z)
    );
  mgc_out_stdreg #(.rscid(9),
  .width(3)) right_rsc_mgc_out_stdreg (
      .d(right_rsc_mgc_out_stdreg_d),
      .z(right_rsc_z)
    );
  ball_update_core ball_update_core_inst (
      .clk(clk),
      .en(en),
      .arst_n(arst_n),
      .video_in_rsc_mgc_in_wire_d(video_in_rsc_mgc_in_wire_d),
      .vga_xy_rsc_mgc_in_wire_d(vga_xy_rsc_mgc_in_wire_d),
      .video_out_rsc_mgc_out_stdreg_d(video_out_rsc_mgc_out_stdreg_d),
      .ball_x_out_rsc_mgc_out_stdreg_d(ball_x_out_rsc_mgc_out_stdreg_d),
      .ball_y_out_rsc_mgc_out_stdreg_d(ball_y_out_rsc_mgc_out_stdreg_d),
      .switch1_rsc_mgc_in_wire_d(switch1_rsc_mgc_in_wire_d),
      .switch2_rsc_mgc_in_wire_d(switch2_rsc_mgc_in_wire_d),
      .left_rsc_mgc_out_stdreg_d(left_rsc_mgc_out_stdreg_d),
      .right_rsc_mgc_out_stdreg_d(right_rsc_mgc_out_stdreg_d)
    );
endmodule



