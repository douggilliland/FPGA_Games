`timescale 1ns / 1ps
`include "../rtl/aDefinitions.v"
`include "../rtl/gpu_definitions.v"
`include "../rtl/z80_opcode_definitions.v"
////////////////////////////////////////////////////////////////////////////////////
//
// pGB, yet another FPGA fully functional and super fun GB classic clone!
// Copyright (C) 2015-2016  Diego Valverde (diego.valverde.g@gmail.com)
//
// This program is free software; you can redistribute it and/or
// modify it under the terms of the GNU General Public License
// as published by the Free Software Foundation; either version 2
// of the License, or (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
//
////////////////////////////////////////////////////////////////////////////////////




module tb_simple_dzcpu;

  // Inputs
  reg iClock;
  reg iReset;
  reg rResetDone;
  wire [15:0] wFramBufferData, wFrameBufferAddress;
  wire wFramBufferWe;
  reg [15:0] rCurrentTileRow;

  // Instantiate the Unit Under Test (UUT)
  pGB uut (
    .iClock(iClock),
    .iReset(iReset),
    .oFrameBufferWe( wFramBufferWe ),
    .oFrameBufferData( wFramBufferData ),
    .oFrameBufferAddr( wFrameBufferAddress )

  );


//Instantiate a dummy frame buffer. In real life this goes in the LCD board

reg [15:0] rFrameBuffer[8191:0];
integer log, glog, trace, sound_trace, i,Pc, vram_log_8000_8fff, vram_log_9800_9bff;
integer frame_count = 0, k, frame;
reg rSimulationDone;
reg [63:0] InstCount;


  //---------------------------------------------
  //generate the clock signal here
  always begin
    #`CLOCK_CYCLE  iClock =  ! iClock;

  end
  //---------------------------------------------
  //Update writes to the framebuffer
  always @ ( posedge iClock )
  begin

      if ( wFramBufferWe )
      begin
         rFrameBuffer[ wFrameBufferAddress ] = wFramBufferData;

      end
end //always

  reg [255:1] FrameDumpName;
  integer FrameDumpCount = 0;

  always @ ( posedge iClock )
  begin


      if ( wFrameBufferAddress == 16'd8191 && wFramBufferWe == 1'b1)//8191
      begin

          $swrite(FrameDumpName,"generated_frames/frame.%01d.ppm",FrameDumpCount);
          frame = $fopen(FrameDumpName);
          $fwrite(frame,"P2\n");
          $fwrite(frame,"256 256\n");
          $fwrite(frame,"4\n");

          $fwrite(frame,"#SCY %04x SCX %04x LY %04x wSC_Tile %04x\n",
          uut.GPU.oSCY,     uut.GPU.oSCX,         uut.GPU.oLY, uut.GPU.wSC_Tile);

          for (k = 0; k < 8191; k=k+1)
          begin
            rCurrentTileRow = rFrameBuffer[k];

            $fwrite(frame, "%01x %01x %01x %01x %01x %01x %01x %01x  ",
            rCurrentTileRow[15:14],
            rCurrentTileRow[13:12],
            rCurrentTileRow[11:10],
            rCurrentTileRow[9:8],
            rCurrentTileRow[7:6],
            rCurrentTileRow[5:4],
            rCurrentTileRow[3:2],
            rCurrentTileRow[1:0]);

            if ((k+1) % 32 == 0)
                $fwrite(frame,"\n#%d\n",k/32);


          end

          $fclose(frame);
          FrameDumpCount = FrameDumpCount + 1;

          `ifdef STOP_AFTER_FIRST_FRAME
              $fwrite(log,"**** First frame complete. Stopping Simulation **** \n");
              $display("**** First frame complete. Stopping Simulation **** \n");
              rSimulationDone = 1;
          `endif

      end
  end



//-----------------------------------------------------------------
  always @ (posedge iClock)
  begin
    wait(iReset != 1);


    if (rSimulationDone == 1'b1)
    begin
      vram_log_8000_8fff = $fopen("papi_vram_8000_8fff.dump");
      vram_log_9800_9bff = $fopen("papi_vram_9800_9bff.dump");


      $display("Stopping Simulation and dumping memory");

      $fwrite(log, "=== WORK MEMORY C000 - DFFFF ===\n");
      $fwrite(log,"%02x: ",16'hc000);
      for (i = 0; i <  (16'hdfff-16'hc000); i = i + 1)
      begin
          $fwrite(log,"%02x ", uut.MMU.WORK_RAM.Ram[i]);
          if ((i+1) % 16 == 0)
              $fwrite(log,"\n %h: ", (16'hc000+i+1));

      end

      $fwrite(log,"\n\n=== PAGEZERO MEMORY ===\n\n");
      for (i = 16'hff80; i <= 16'hffff; i = i + 1)
      begin
        if (i % 16 == 0)
          $fwrite(log,"\n %h : ", i );

        $fwrite(log,"%02h ",uut.MMU.ZERO_PAGE.Ram[i-16'hff80]);
      end

      //Dump the VMEM
      $fwrite(log,"\n\n=== VIDEO MEMORY ===\n\n");
      for (i = 16'h8000; i <= 16'h9fff; i = i + 1)
      begin

        if (i % 16 == 0)
        begin
          $fwrite(log,"\n %h : ", i );
          if ( i <= 16'h8fff)
            $fwrite(vram_log_8000_8fff,"\n %h : ", i );

          if ( i >= 16'h9800 && i <= 16'h9bff)
            $fwrite(vram_log_9800_9bff,"\n %h : ", i );
        end

        $fwrite(log,"%02h ",uut.MMU.VMEM.Ram[i- 16'h8000]);
        if ( i <= 16'h8fff)
          $fwrite(vram_log_8000_8fff,"%02h ",uut.MMU.VMEM.Ram[i- 16'h8000]);

        if ( i >= 16'h9800 && i <= 16'h9bff)
          $fwrite(vram_log_9800_9bff,"%02h ",uut.MMU.VMEM.Ram[i- 16'h8000]);
      end

      $fwrite(log,"\n\nTEST_RET_VAL %04h\n\n", {uut.MMU.ZERO_PAGE.Ram[ 16'hfffd - 16'hff80 ],uut.MMU.ZERO_PAGE.Ram[ 16'hfffc - 16'hff80 ]} );

      $fwrite(log,"Simulation ended at time %dns\n", $time);

`ifdef ENABLE_CPU_LOG
      $fclose( log );
`endif

`ifdef ENABLE_GPU_LOG
      $fclose( glog );
`endif

`ifdef ENABLE_SOUND_TRACE
      $fclose( sound_trace );
`endif

      $fclose( vram_log_8000_8fff );
      $fclose( vram_log_9800_9bff );
      $finish();
    end

  end
//-----------------------------------------------------------------
  initial begin
    // Initialize Inputs
InstCount = 64'b0;

`ifdef ENABLE_CPU_LOG
    log = $fopen("pgb_cpu.log");
`endif

`ifdef ENABLE_GPU_LOG
    glog = $fopen("pgb_gpu.log");
`endif

`ifdef ENABLE_INSN_TRACE
  trace = $fopen("pgb_trace.dump");
`endif

`ifdef ENABLE_SOUND_TRACE
  sound_trace = $fopen("pgb_sound_trace.dump");
`endif

`ifdef VMEM_DUMP_PATH
$readmemh(
  `VMEM_DUMP_PATH, uut.MMU.VMEM.Ram);

      $fwrite(glog,"\n\n=== VIDEO MEMORY FROM FILE: %s===\n\n", `VMEM_DUMP_PATH);
      for (i = 16'h8000; i <= 16'h9fff; i = i + 1)
      begin
        if (i % 16 == 0)
            $fwrite(glog,"\n %h : ", i );
        $fwrite(glog,"%02h ",uut.MMU.VMEM.Ram[i- 16'h8000]);
      end


`endif



`ifdef OAM_DUMP_PATH
  $readmemh(
  `OAM_DUMP_PATH, uut.MMU.OAM.Ram);

  $fwrite(glog,"\n\n=== OAM MEMORY FROM FILE: %s===\n\n", `OAM_DUMP_PATH);
  for (i = 16'hfe00; i <= 16'hfe9f; i = i + 1)
  begin
    if (i % 16 == 0)
        $fwrite(glog,"\n %h : ", i );
    $fwrite(glog,"%02h ",uut.MMU.OAM.Ram[i- 16'hfe00]);
  end

  $fwrite(glog,"\n\n");

`endif
    rResetDone = 1'b0;
    $dumpfile("tb_simple_dzcpu.vcd");
    $dumpvars(0,tb_simple_dzcpu);
    $fwrite(log,"Simulation started at time %dns\n", $time);
`ifdef START_DUMP_INSN
	$dumpoff;
`endif
    rSimulationDone = 0;
    iClock = 0;
    iReset = 0;



    // Wait 100 ns for global reset to finish
    #100;
    iReset = 1;
    #10
    iReset = 0;
    `ifdef SKIP_BIOS
      uut.MMU.FF_0x50.Q = 8'b1;
    `endif

    `ifdef REG_TAC
      uut.TIMERS.FF_TAC.Q = `REG_TAC;
    `endif

    `ifdef REG_TMA
      uut.TIMERS.rModulo = `REG_TMA;
    `endif

    `ifdef REG_IF
       uut.INTERRUPTS.FF_IF.Q = `REG_IF;
    `endif

    `ifdef REG_A
        uut.DZCPU.FFA.Q = `REG_A;
    `endif

    `ifdef REG_F
        uut.DZCPU.FFFLAGS.Q = `REG_F;
    `endif

    `ifdef REG_B
        uut.DZCPU.FFB.Q = `REG_B;
    `endif

    `ifdef REG_C
        uut.DZCPU.FFC.Q = `REG_C;
    `endif

    `ifdef REG_H
        uut.DZCPU.FFH.Q = `REG_H;
    `endif

    `ifdef REG_L
        uut.DZCPU.FFL.Q = `REG_L;
    `endif

    `ifdef REG_D
        uut.DZCPU.FFD.Q = `REG_D;
    `endif

    `ifdef REG_E
        uut.DZCPU.FFE.Q = `REG_E;
    `endif

    `ifdef REG_SPL
        uut.DZCPU.FFSPL.Q = `REG_SPL;
    `endif

    `ifdef REG_SPH
        uut.DZCPU.FFSPH.Q = `REG_SPH;
    `endif

    `ifdef REG_LCDC
        uut.GPU.FF_LCDC.Q = `REG_LCDC;
    `endif


    `ifdef REG_BGP
        uut.GPU.FFS_BGP.Q = `REG_BGP;
    `endif

    `ifdef REG_DIFF
       uut.TIMERS.rMTime = `REG_DIFF;
    `endif


    `ifdef DISABLE_CPU
      //Force GPU to start

      uut.GPU.FF_SCX.Q = 8'h0;
      uut.GPU.FF_SCY.Q = 8'h0;
      uut.GPU.FF_LY.Q = 8'h0;
      uut.GPU.FFS_OBP0.Q = 8'he4;
      uut.GPU.FFS_OBP1.Q = 8'hc4;
      uut.GPU.FFS_WY.Q = 8'h80;
      uut.GPU.FFX_WX.Q =8'h06;
    `endif

    // Add stimulus here
    //#500
    #1000
    rResetDone = 1'b1;
    //#5000000

  `ifdef SIMULATION_TIME_OUT
     #`SIMULATION_TIME_OUT
 `else
    #500000000
  `endif

    $fwrite(log, "Simulation reached MAX time %hns",$time);
    $display( "Simulation reached MAX time %hns",$time);
    rSimulationDone = 1;
  end


integer row_count=0;

`ifdef ENABLE_GPU_LOG
always @ ( posedge iClock )
begin


   if (uut.GPU.wGpuActive)
   begin
         $fwrite(glog,"%05dns [GPU] IP:%d  %h .",$time, uut.GPU.wIp, uut.GPU.wUop[`GPU_OP_RNG] );
   case (uut.GPU.wUop[`GPU_OP_RNG])
         `gnop: $fwrite(glog, "nop  \n");
        `gwrl: $fwrite(glog, "gwrl r[%h] = %h\n",uut.GPU.wUop[`GPU_DST_RNG],uut.GPU.wUop[`GPU_LIT_RNG]);
        `gwrr: $fwrite(glog, "gwrr \n");
        `gadd: $fwrite(glog, "gadd %h + %h = %h\n", uut.GPU.wOp1, uut.GPU.wOp0, uut.GPU.rResult);
        `gsub: $fwrite(glog, "gsub %h - %h = %h\n",uut.GPU.wOp1, uut.GPU.wOp0, uut.GPU.rResult);
        `gaddl: $fwrite(glog, "gaddl %h += %h = %h\n", uut.GPU.wOp1, uut.GPU.wUop[`GPU_LIT_RNG], uut.GPU.rResult );
        `gjnz: $fwrite(glog, "gjnz \n");
        `gwfbuffer: $fwrite(glog, "gwfbuffer \n");
        `gsubl: $fwrite(glog, "gsubl %h -= %h = %h\n", uut.GPU.wOp1, uut.GPU.wUop[`GPU_LIT_RNG], uut.GPU.rResult);
        `grvmem: $fwrite(glog,"grvmem @ %h\n", uut.GPU.oMcuAddr);
        `gshl:   $fwrite(glog,"gshl  \n");
        `gand: $fwrite(glog, "gand %h & %h = %h\n", uut.GPU.wOp1, uut.GPU.wOp0, uut.GPU.rResult);
        `gjz: $fwrite(glog, "gjz \n");
        `gsprtt: $fwrite(glog, " >>> gsprtt tile_row: %d tile_idx: %d sprite [%d , %d] , tile [%d %d ] = %h\n",
                          uut.GPU.wCurrentTileRow/2, uut.GPU.wCurrentTile,
                          uut.GPU.wSpriteCoordX, uut.GPU.wSpriteCoordY,
                          uut.GPU.wTileCoordX, uut.GPU.wTileCoordY, uut.GPU.wIsSpriteInCurrentTile);
    endcase

      //Print the Registers
      $fwrite(glog,"\n     %05s  %05s %05s %05s %05s %05s %05s %05s %05s %05s %05s %05s %05s %05s %05s\n",
      "Ip",   "oAddr", "iData", "STAT",
      "LCDC", "SCY",   "SCX" ,  "LY",
      "LYC",  "DMA",   "BGP",   "BP0",
      "BP1",  "WY", "WX");
      $fwrite(glog,"[regs] %04d %04x  %02x     %02x    %02x     %02x    %02x     %02x   %02x    %02x    %02x    %02x    %02x     %02x    %02x\n",
      uut.GPU.wIp,    uut.GPU.oMcuAddr, uut.GPU.iMcuReadData, uut.GPU.oSTAT,
      uut.GPU.oLCDC,  uut.GPU.oSCY,     uut.GPU.oSCX,         uut.GPU.oLY,
      uut.GPU.oLYC,   uut.GPU.oDMA,     uut.GPU.oBGP,         uut.GPU.oOBP0,
      uut.GPU.oOBP1,   uut.GPU.oWY,      uut.GPU.oWX );

      $fwrite(glog, "%04s %04s %04s %04s %06s %10s %10s %10s %10s %10s %10s\n", "Sh", "Sl","Bh", "Bl", "Bsel", "cur_tile", "tile_row", "fb_addr", "vmem_data", "sprite_x", "sprite_y");
      $fwrite(glog, "0x%02x 0x%02x 0x%02x 0x%02x 0x%04x 0x%08x 0x%08x 0d%08d 0x%08x 0d%08d %08d\n",
      uut.GPU.wSh, uut.GPU.wSl,uut.GPU.wBh, uut.GPU.wBl, uut.GPU.wR2, uut.GPU.wCurrentTile, uut.GPU.wCurrentTileRow, wFrameBufferAddress, uut.GPU.iMcuReadData, uut.GPU.wSpriteCoordX, uut.GPU.wSpriteCoordY);

      $fwrite(glog, "\nBackground Tile Pixel Row:\n");
      $fwrite(glog, "%02x %02x %02x %02x %02x %02x %02x %02x\n",
      uut.GPU.wBgPixel7,uut.GPU.wBgPixel6,uut.GPU.wBgPixel5,uut.GPU.wBgPixel4,uut.GPU.wBgPixel3,uut.GPU.wBgPixel2,uut.GPU.wBgPixel1,uut.GPU.wBgPixel0);

      $fwrite(glog, "\nSprite Tile Pixel Row:\n");
      $fwrite(glog, "%02x %02x %02x %02x %02x %02x %02x %02x\n",
      uut.GPU.wSprtPixel7,uut.GPU.wSprtPixel6,uut.GPU.wSprtPixel5,uut.GPU.wSprtPixel4,uut.GPU.wSprtPixel3,uut.GPU.wSprtPixel2,uut.GPU.wSprtPixel1,uut.GPU.wSprtPixel0);

      $fwrite(glog, "\nFrame buffer Pixel Row:\n");
      $fwrite(glog, "%02x %02x %02x %02x %02x %02x %02x %02x\n",
      uut.GPU.wPixel7,uut.GPU.wPixel6,uut.GPU.wPixel5,uut.GPU.wPixel4,uut.GPU.wPixel3,uut.GPU.wPixel2,uut.GPU.wPixel1,uut.GPU.wPixel0);


      $fwrite(glog,"\n\n\n");


   end //if
end //always
`endif


`ifdef ENABLE_SOUND_TRACE
always @ ( posedge iClock )
begin

    if (uut.MMU.iCpuWe)
    begin
          if (uut.MMU.iCpuAddr >= 16'hff10 && uut.MMU.iCpuAddr <= 16'hff23 )
          begin
                  $fwrite(sound_trace,"%dns %04x @ %04x \n",  $time, uut.MMU.iCpuData,uut.MMU.iCpuAddr   );
                  $display("%dns %04x @ %04x \n",  $time, uut.MMU.iCpuData,uut.MMU.iCpuAddr   );
          end

    end
end //always

`endif


`ifdef ENABLE_INSN_TRACE
always @ ( posedge iClock )
begin
  wait(iReset != 1);
  if (uut.DZCPU.rCurrentState == `DZCPU_START_FLOW & ~uut.DZCPU.wInterruptRoutineJumpDetected)
    begin

      $fwrite(trace,"pc: %04x opcode: %x sp: %x HL: %04x AF: %04x BC: %04x DE: %04x div: %04d tima: %04d div: %04d tac: %04x ie: %04x if: %04x",
      uut.DZCPU.wPc, uut.DZCPU.iMCUData, {uut.DZCPU.wSpH,uut.DZCPU.wSpL},
      {uut.DZCPU.wH,uut.DZCPU.wL},
      {uut.DZCPU.wA,uut.DZCPU.wFlags},
      {uut.DZCPU.wB,uut.DZCPU.wC},
      {uut.DZCPU.wD,uut.DZCPU.wE},
      uut.TIMERS.wDiv,
      uut.TIMERS.wTima,
      uut.TIMERS.oDiv,
      uut.TIMERS.oTac,
      uut.MMU.iInterruptEnable,
      uut.MMU.iInterruptFlag
      );
    end

    if (uut.TIMERS.rIncTimer)
      begin
      $fwrite(trace," deltaC: %04d\n",
      (uut.TIMERS.wDelta*4 ));
      end
end
`endif


`ifdef ENABLE_CPU_LOG
  always @ ( posedge iClock )
  begin
    wait(iReset != 1);

    //if (uut.DZCPU.wPc == 16'h204)//16'h0fc // || uut.GPU.oLY == 8'hff)  //This instructrion finishes copying the little (R)
      //rSimulationDone = 1;
`ifdef START_DUMP_INSN
if (InstCount > `START_DUMP_INSN)
    $dumpon;
`endif


`ifdef PRESS_A_KEY_AFTER
  if (InstCount == `PRESS_A_KEY_AFTER)
  begin
    uut.IO.FFD_oHack.Q = 6'b111110;
  end
`endif

    if (uut.DZCPU.rCurrentState == `DZCPU_START_FLOW)
    begin

      Pc = uut.DZCPU.wPc;

      $fwrite(log,"InsnCount: %d\n ", InstCount);


      `ifdef PRINT_STACK
            $fwrite(log, "=== WORK MEMORY C000 - DFFFF ===\n");
            $fwrite(log,"%02h: ",16'hcff0);
            for (i = 16'hff0; i <  16'h100f; i = i + 1)
            begin
                $fwrite(log,"%02h ", uut.MMU.WORK_RAM.Ram[i]);
                if ((i+1) % 16 == 0)
                    $fwrite(log,"\n %h: ", (16'hc000+i));

            end
            $fwrite(log,"\n");
      `endif


      case (uut.DZCPU.wuOpFlowIdx)
      1:  $fwrite(log,"=== LDSPnn === %h \n", uut.DZCPU.iMCUData );
      5:  $fwrite(log,"=== LDHLnn === %h \n", uut.DZCPU.iMCUData );
      9:  $fwrite(log,"=== LDHLDA === %h \n", uut.DZCPU.iMCUData );
      13: $fwrite(log,"=== MAPcb === %h \n", uut.DZCPU.iMCUData );
      17: $fwrite(log,"=== JRNZn === %h \n", uut.DZCPU.iMCUData );
      23: $fwrite(log,"=== LDrn_c === %h \n", uut.DZCPU.iMCUData );
      26: $fwrite(log,"=== LDrn_a === %h \n", uut.DZCPU.iMCUData );
      29: $fwrite(log,"=== LDIOCA === %h \n", uut.DZCPU.iMCUData );
      32: $fwrite(log,"=== INCr_c === %h \n", uut.DZCPU.iMCUData );
      33: $fwrite(log,"=== LDHLmr_a === %h \n", uut.DZCPU.iMCUData );
      526: $fwrite(log,"=== LDIOnA  === %h \n", uut.DZCPU.iMCUData );
      43: $fwrite(log,"=== LDDEnn  === %h \n", uut.DZCPU.iMCUData );
      94: $fwrite(log,"=== LDADEm  === %h \n", uut.DZCPU.iMCUData );
      49: $fwrite(log,"=== CALLnn === %h \n", uut.DZCPU.iMCUData );
      60: $fwrite(log,"=== LDrn_b === %h \n", uut.DZCPU.iMCUData );
      63: $fwrite(log,"=== PUSHBC === %h \n", uut.DZCPU.iMCUData );
      70: $fwrite(log,"=== RLA === %h \n", uut.DZCPU.iMCUData );
      71: $fwrite(log,"=== POPBC === %h \n", uut.DZCPU.iMCUData );
      300: $fwrite(log,"=== DECr_b === %h \n", uut.DZCPU.iMCUData );
      78: $fwrite(log,"=== LDHLIA === %h \n", uut.DZCPU.iMCUData );
      82: $fwrite(log,"=== INCHL === %h \n", uut.DZCPU.iMCUData );
      252/*83*/: $fwrite(log,"=== RET === %h \n", uut.DZCPU.iMCUData );
      89: $fwrite(log,"=== INCDE === %h \n", uut.DZCPU.iMCUData );
      90: $fwrite(log,"=== CPn === %h \n", uut.DZCPU.iMCUData );
      98: $fwrite(log,"=== LDmmA === %h \n", uut.DZCPU.iMCUData );
      47: $fwrite(log,"=== DECr_a === %h \n", uut.DZCPU.iMCUData );
      48: $fwrite(log,"=== DECr_c === %h \n", uut.DZCPU.iMCUData );
      106: $fwrite(log,"=== JRZn === %h \n", uut.DZCPU.iMCUData );
      112: $fwrite(log,"=== LDrn_l  === %h \n", uut.DZCPU.iMCUData );
      115: $fwrite(log,"=== JRn  === %h \n", uut.DZCPU.iMCUData );
      161: $fwrite(log,"=== INCr_b  === %h \n", uut.DZCPU.iMCUData );
      121: $fwrite(log,"=== LDrn_e  === %h \n", uut.DZCPU.iMCUData );
      534: $fwrite(log,"=== LDAIOn  === %h \n", uut.DZCPU.iMCUData );
      312: $fwrite(log,"=== INCr_h  === %h \n", uut.DZCPU.iMCUData );
      132: $fwrite(log,"=== SUBr_b  === %h \n", uut.DZCPU.iMCUData );
      135: $fwrite(log,"=== DECr_d  === %h \n", uut.DZCPU.iMCUData );
      136: $fwrite(log,"=== LDrn_d  === %h \n", uut.DZCPU.iMCUData );
      139: $fwrite(log,"=== JPnn  === %h \n", uut.DZCPU.iMCUData );
      146: $fwrite(log,"=== LDrn_h  === %h \n", uut.DZCPU.iMCUData );
      149: $fwrite(log,"=== LDAHLI  === %h \n", uut.DZCPU.iMCUData );
      154: $fwrite(log,"=== LDHLmn  === %h \n", uut.DZCPU.iMCUData );
      162: $fwrite(log,"=== NOP  ===  \n");
      163: $fwrite(log,"=== DI  ===  \n", uut.DZCPU.iMCUData );
      164: $fwrite(log,"=== INCr_d  === %h \n", uut.DZCPU.iMCUData );
      250/*165*/: $fwrite(log,"=== INCr_e  === %h \n", uut.DZCPU.iMCUData );
      166: $fwrite(log,"=== DECr_e  === %h \n", uut.DZCPU.iMCUData );
      168: $fwrite(log,"=== DECDE  === %h \n", uut.DZCPU.iMCUData );
      169: $fwrite(log,"=== DECBC === %h \n", uut.DZCPU.iMCUData );
      170: $fwrite(log,"=== DECr_h  === %h \n", uut.DZCPU.iMCUData );
      172: $fwrite(log,"=== DECHL  === %h \n", uut.DZCPU.iMCUData );
      302: $fwrite(log,"=== INCr_a  === %h \n", uut.DZCPU.iMCUData );
      304: $fwrite(log,"=== INCSP === %h \n", uut.DZCPU.iMCUData ); //Increment SP
      306: $fwrite(log,"=== DECSP === %h \n", uut.DZCPU.iMCUData );
      308: $fwrite(log,"=== INCr_l  === %h \n", uut.DZCPU.iMCUData );
      310: $fwrite(log,"=== DECr_l  === %h \n", uut.DZCPU.iMCUData );
      175: $fwrite(log,"=== ADDr_a  === %h \n", uut.DZCPU.iMCUData );
      178: $fwrite(log,"=== ADDr_b  === %h \n", uut.DZCPU.iMCUData );
      184: $fwrite(log,"=== ADDr_c  === %h \n", uut.DZCPU.iMCUData );
      181: $fwrite(log,"=== SUBr_c  === %h \n", uut.DZCPU.iMCUData );
      187: $fwrite(log,"=== ADDr_d  === %h \n", uut.DZCPU.iMCUData );
      190: $fwrite(log,"=== ADDr_e  === %h \n", uut.DZCPU.iMCUData );
      193: $fwrite(log,"=== ADDr_h  === %h \n", uut.DZCPU.iMCUData );
      196: $fwrite(log,"=== ADDr_l  === %h \n", uut.DZCPU.iMCUData );
      199: $fwrite(log,"=== SUBr_d  === %h \n", uut.DZCPU.iMCUData );
      202: $fwrite(log,"=== SUBr_e  === %h \n", uut.DZCPU.iMCUData );
      205: $fwrite(log,"=== SUBr_h  === %h \n", uut.DZCPU.iMCUData );
      208: $fwrite(log,"=== SUBr_l  === %h \n", uut.DZCPU.iMCUData );
      211: $fwrite(log,"=== SUBr_a  === %h \n", uut.DZCPU.iMCUData );
      214: $fwrite(log,"=== PUSHDE  === %h \n", uut.DZCPU.iMCUData );
      220: $fwrite(log,"=== PUSHHL  === %h \n", uut.DZCPU.iMCUData );
      226: $fwrite(log,"=== POPDE === %h \n", uut.DZCPU.iMCUData );
      232: $fwrite(log,"=== POPHL === %h \n", uut.DZCPU.iMCUData );
      238: $fwrite(log,"=== LDHLmr_b === %h \n", uut.DZCPU.iMCUData );
      241: $fwrite(log,"=== LDHLmr_c === %h \n", uut.DZCPU.iMCUData );
      244: $fwrite(log,"=== LDHLmr_d === %h \n", uut.DZCPU.iMCUData );
      247: $fwrite(log,"=== LDDEmA === %h \n", uut.DZCPU.iMCUData );
      261: $fwrite(log,"=== PUSHAF === %h \n", uut.DZCPU.iMCUData );
      267: $fwrite(log,"=== POPAF === %h \n", uut.DZCPU.iMCUData );
      273: $fwrite(log,"=== LDBCnn === %h \n", uut.DZCPU.iMCUData );
      83: $fwrite(log,"=== INCBC === %h \n", uut.DZCPU.iMCUData );
      280: $fwrite(log,"=== LDAmm === %h \n", uut.DZCPU.iMCUData );
      85:  $fwrite(log,"=== ANDn === %h\n", uut.DZCPU.iMCUData );
      289: $fwrite(log,"=== CALLNZnn === %h\n",uut.DZCPU.iMCUData );
      314: $fwrite(log,"=== ADDn === %h\n",uut.DZCPU.iMCUData );
      319: $fwrite(log,"=== SUBn === %h\n",uut.DZCPU.iMCUData );
      324: $fwrite(log,"=== CPr_c === %h\n",uut.DZCPU.iMCUData );
      327: $fwrite(log,"=== LDrHLm_b === %h\n",uut.DZCPU.iMCUData );
      331: $fwrite(log,"=== LDrHLm_c === %h\n",uut.DZCPU.iMCUData );
      335: $fwrite(log,"=== LDrHLm_d === %h\n",uut.DZCPU.iMCUData );
      339: $fwrite(log,"=== XORHL === %h\n",uut.DZCPU.iMCUData );
      345: $fwrite(log,"=== ADCn === %h\n",uut.DZCPU.iMCUData );
      351: $fwrite(log,"=== ADDHLDE === %h\n",uut.DZCPU.iMCUData );
      414: $fwrite(log,"=== JRNCn === %h\n",uut.DZCPU.iMCUData );
      359: $fwrite(log,"=== XORn === %h\n",uut.DZCPU.iMCUData );
      363: $fwrite(log,"=== RRA === %h\n",uut.DZCPU.iMCUData );
      365: $fwrite(log,"=== RETNC === %h\n",uut.DZCPU.iMCUData );
      377: $fwrite(log,"=== RETZ === %h\n",uut.DZCPU.iMCUData );
      387: $fwrite(log,"=== ORHL === %h\n",uut.DZCPU.iMCUData );
      391: $fwrite(log,"=== DECHLm === %h\n",uut.DZCPU.iMCUData );
      397: $fwrite(log,"=== LDrHLm_l === %h\n",uut.DZCPU.iMCUData );
      401: $fwrite(log,"=== RETNZ === %h\n",uut.DZCPU.iMCUData );
      411: $fwrite(log,"=== ADDHLHL === %h\n",uut.DZCPU.iMCUData );
      420: $fwrite(log,"=== ANDHL === %h\n",uut.DZCPU.iMCUData );
      424: $fwrite(log,"=== LDHLmr_e === %h \n", uut.DZCPU.iMCUData );
      427: $fwrite(log,"=== LDHLmr_h === %h \n", uut.DZCPU.iMCUData );
      430: $fwrite(log,"=== LDHLmr_l === %h \n", uut.DZCPU.iMCUData );
      433: $fwrite(log,"=== LDABCm  === %h \n", uut.DZCPU.iMCUData );
      437: $fwrite(log,"=== LDrHLm_a  === %h \n", uut.DZCPU.iMCUData );
      441: $fwrite(log,"=== LDrHLm_e  === %h \n", uut.DZCPU.iMCUData );
      445: $fwrite(log,"=== LDrHLm_h  === %h \n", uut.DZCPU.iMCUData );
      449: $fwrite(log,"=== ADCr_a  === %h \n", uut.DZCPU.iMCUData );
      453: $fwrite(log,"=== ADCr_b  === %h \n", uut.DZCPU.iMCUData );
      457: $fwrite(log,"=== ADCr_c  === %h \n", uut.DZCPU.iMCUData );
      461: $fwrite(log,"=== ADCr_d  === %h \n", uut.DZCPU.iMCUData );
      465: $fwrite(log,"=== ADCr_e  === %h \n", uut.DZCPU.iMCUData );
      469: $fwrite(log,"=== ADCr_h  === %h \n", uut.DZCPU.iMCUData );
      473: $fwrite(log,"=== ADCr_l  === %h \n", uut.DZCPU.iMCUData );
      477: $fwrite(log,"=== SBCr_a  === %h \n", uut.DZCPU.iMCUData );
      481: $fwrite(log,"=== SBCr_b  === %h \n", uut.DZCPU.iMCUData );
      485: $fwrite(log,"=== SBCr_c  === %h \n", uut.DZCPU.iMCUData );
      489: $fwrite(log,"=== SBCr_d  === %h \n", uut.DZCPU.iMCUData );
      493: $fwrite(log,"=== SBCr_e  === %h \n", uut.DZCPU.iMCUData );
      497: $fwrite(log,"=== SBCr_h  === %h \n", uut.DZCPU.iMCUData );
      501: $fwrite(log,"=== SBCr_l  === %h \n", uut.DZCPU.iMCUData );
      173:  $fwrite(log,"=== JPHL  === %h \n", uut.DZCPU.iMCUData );
      511:  $fwrite(log,"=== EI  === %h \n", uut.DZCPU.iMCUData );
      354:  $fwrite(log,"=== JPNZnn  === %h \n", uut.DZCPU.iMCUData );
      542:  $fwrite(log,"=== JPZnn  === %h \n", uut.DZCPU.iMCUData );
      512: $fwrite(log,"=== LDHLSPn  === %h \n", uut.DZCPU.iMCUData );
      516: $fwrite(log,"=== DISPATCH_INTERRUPT  === %h \n", uut.DZCPU.iMCUData );
      547: $fwrite(log,"=== HALT  === %h \n", uut.DZCPU.iMCUData );
      549: $fwrite(log,"=== RETC  === %h \n", uut.DZCPU.iMCUData );
      559: $fwrite(log,"=== JPCnn  === %h \n", uut.DZCPU.iMCUData );
      564: $fwrite(log,"=== INCHLm  === %h \n", uut.DZCPU.iMCUData );
      570: $fwrite(log,"=== RETI  === %h \n", uut.DZCPU.iMCUData );
      580: $fwrite(log,"=== ADDHLSP  === %h \n", uut.DZCPU.iMCUData );
      583: $fwrite(log,"=== ADDHLBC  === %h \n", uut.DZCPU.iMCUData );
      586: $fwrite(log,"=== RLCA  === %h \n", uut.DZCPU.iMCUData );
      589: $fwrite(log,"=== LDmmSP  === %h \n", uut.DZCPU.iMCUData );
      601: $fwrite(log,"=== LDSPHL  === %h \n", uut.DZCPU.iMCUData );
      603: $fwrite(log,"=== ORn  === %h \n", uut.DZCPU.iMCUData );
      607: $fwrite(log,"=== JRCn === %h \n", uut.DZCPU.iMCUData );
      613: $fwrite(log,"=== STOP === %h \n", uut.DZCPU.iMCUData );
      616: $fwrite(log,"=== SBCn === %h \n", uut.DZCPU.iMCUData );
      621: $fwrite(log,"=== LDAIOC  === %h \n", uut.DZCPU.iMCUData );
      default:
          case (uut.DZCPU.iMCUData)
              `LDrr_aa: $fwrite(log,"=== LDrr_aa  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_bb: $fwrite(log,"=== LDrr_bb  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_bc: $fwrite(log,"=== LDrr_bc  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_bd: $fwrite(log,"=== LDrr_bd  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_be: $fwrite(log,"=== LDrr_be  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_bh: $fwrite(log,"=== LDrr_bh  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_bl: $fwrite(log,"=== LDrr_bl  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_eb: $fwrite(log,"=== LDrr_eb === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ee: $fwrite(log,"=== LDrr_ee === %h \n", uut.DZCPU.iMCUData );
              `LDrr_eh: $fwrite(log,"=== LDrr_eh === %h \n", uut.DZCPU.iMCUData );
              `LDrr_el: $fwrite(log,"=== LDrr_el === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ed: $fwrite(log,"=== LDrr_ed === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ec: $fwrite(log,"=== LDrr_ec === %h \n", uut.DZCPU.iMCUData );
              `LDrr_la: $fwrite(log,"=== LDrr_la === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ll: $fwrite(log,"=== LDrr_ll === %h \n", uut.DZCPU.iMCUData );
              `LDrr_lh: $fwrite(log,"=== LDrr_lh === %h \n", uut.DZCPU.iMCUData );
              `LDrr_le: $fwrite(log,"=== LDrr_le === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ld: $fwrite(log,"=== LDrr_ld === %h \n", uut.DZCPU.iMCUData );
              `LDrr_lc: $fwrite(log,"=== LDrr_lc === %h \n", uut.DZCPU.iMCUData );
              `LDrr_lb: $fwrite(log,"=== LDrr_lb === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ba: $fwrite(log,"=== LDrr_ba === %h \n", uut.DZCPU.iMCUData );
              `LDrr_cb: $fwrite(log,"=== LDrr_cb === %h \n", uut.DZCPU.iMCUData );
              `LDrr_cc: $fwrite(log,"=== LDrr_cc === %h \n", uut.DZCPU.iMCUData );
              `LDrr_cd: $fwrite(log,"=== LDrr_cd === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ce: $fwrite(log,"=== LDrr_ce === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ch: $fwrite(log,"=== LDrr_ch === %h \n", uut.DZCPU.iMCUData );
              `LDrr_cl: $fwrite(log,"=== LDrr_cl === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ac: $fwrite(log,"=== LDrr_ac === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ad: $fwrite(log,"=== LDrr_ad === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ae: $fwrite(log,"=== LDrr_ae === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ha: $fwrite(log,"=== LDrr_ha  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_hd: $fwrite(log,"=== LDrr_hd  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_da: $fwrite(log,"=== LDrr_da  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ea: $fwrite(log,"=== LDrr_ea  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ca: $fwrite(log,"=== LDrr_ca  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ah: $fwrite(log,"=== LDrr_ah  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_al: $fwrite(log,"=== LDrr_al  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_ab: $fwrite(log,"=== LDrr_ab  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_de: $fwrite(log,"=== LDrr_de  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_db: $fwrite(log,"=== LDrr_db  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_dc: $fwrite(log,"=== LDrr_dc  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_dd: $fwrite(log,"=== LDrr_dd  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_dh: $fwrite(log,"=== LDrr_dh  === %h \n", uut.DZCPU.iMCUData );
              `LDrr_dl: $fwrite(log,"=== LDrr_dl  === %h \n", uut.DZCPU.iMCUData );

              `LDrr_ha: $fwrite(log,"=== LDrr_ha === %h \n", uut.DZCPU.iMCUData );
              `LDrr_hb: $fwrite(log,"=== LDrr_hb === %h \n", uut.DZCPU.iMCUData );
              `LDrr_hc: $fwrite(log,"=== LDrr_hc === %h \n", uut.DZCPU.iMCUData );
              `LDrr_hd: $fwrite(log,"=== LDrr_hd === %h \n", uut.DZCPU.iMCUData );
              `LDrr_he: $fwrite(log,"=== LDrr_he === %h \n", uut.DZCPU.iMCUData );
              `LDrr_hl: $fwrite(log,"=== LDrr_hl === %h \n", uut.DZCPU.iMCUData );
              `LDrr_hh: $fwrite(log,"=== LDrr_hh === %h \n", uut.DZCPU.iMCUData );

              `XORr_a: $fwrite(log,"=== XORr_a  === %h \n", uut.DZCPU.iMCUData );
              `XORr_b: $fwrite(log,"=== XORr_b  === %h \n", uut.DZCPU.iMCUData );
              `XORr_c: $fwrite(log,"=== XORr_c  === %h \n", uut.DZCPU.iMCUData );
              `XORr_d: $fwrite(log,"=== XORr_d  === %h \n", uut.DZCPU.iMCUData );
              `XORr_e: $fwrite(log,"=== XORr_e  === %h \n", uut.DZCPU.iMCUData );
              `XORr_l: $fwrite(log,"=== XORr_l  === %h \n", uut.DZCPU.iMCUData );
              `XORr_h: $fwrite(log,"=== XORr_h  === %h \n", uut.DZCPU.iMCUData );
              `ORr_b: $fwrite(log,"=== ORr_b  === %h \n", uut.DZCPU.iMCUData );
              `ORr_c: $fwrite(log,"=== ORr_c  === %h \n", uut.DZCPU.iMCUData );
              `ORr_a: $fwrite(log,"=== ORr_a  === %h \n", uut.DZCPU.iMCUData );
							`ORr_d: $fwrite(log,"=== ORr_d  === %h \n", uut.DZCPU.iMCUData );
							`ORr_e: $fwrite(log,"=== ORr_e  === %h \n", uut.DZCPU.iMCUData );
							`ORr_h: $fwrite(log,"=== ORr_h  === %h \n", uut.DZCPU.iMCUData );
							`ORr_l: $fwrite(log,"=== ORr_l  === %h \n", uut.DZCPU.iMCUData );
							`ANDr_b: $fwrite(log,"=== ANDr_b  === %h \n", uut.DZCPU.iMCUData );
							`ANDr_c: $fwrite(log,"=== ANDr_c  === %h \n", uut.DZCPU.iMCUData );
							`ANDr_a: $fwrite(log,"=== ANDr_a  === %h \n", uut.DZCPU.iMCUData );
							`ANDr_d: $fwrite(log,"=== ANDr_d  === %h \n", uut.DZCPU.iMCUData );
							`ANDr_e: $fwrite(log,"=== ANDr_e  === %h \n", uut.DZCPU.iMCUData );
							`ANDr_h: $fwrite(log,"=== ANDr_h  === %h \n", uut.DZCPU.iMCUData );
							`ANDr_l: $fwrite(log,"=== ANDr_l  === %h \n", uut.DZCPU.iMCUData );
							`ANDn: $fwrite(log,"=== ANDn  === %h \n", uut.DZCPU.iMCUData );
              `NOP: $fwrite(log,"=== NOP  === %h \n", uut.DZCPU.iMCUData );
              default:
              begin
                  if (rResetDone)
                  begin
                      $display("=== Unknown Flow. Insns %h\n",uut.DZCPU.iMCUData);
                      $fwrite(log,"=== Unknown Flow. Insns %h\n",uut.DZCPU.iMCUData);
                      rSimulationDone = 1'b1;
                  end
              end
        endcase

      endcase

      InstCount = InstCount + 64'b1;




      `ifdef STOP_AFTER_INSN_COUNT
        if (InstCount >= `STOP_AFTER_INSN_COUNT)
        begin
          rSimulationDone = 1;
          $display("**** InsnCount = %d. Stopping Simulation **** \n", InstCount);
          $fwrite(log,"**** InsnCount = %d. Stopping Simulation **** \n", InstCount);
        end
      `endif
    end





    if (uut.MMU.iGpuReadRequest)
    begin
      $fwrite(log,"%dns [MMU] Gpu requesting read @ %h (%h)\n ", $time, uut.MMU.iGpuAddr, uut.MMU.wVmemReadAddr);
      $fwrite(glog,"%dns [MMU] Gpu requesting read @ %h (%h)\n ", $time, uut.MMU.iGpuAddr, uut.MMU.wVmemReadAddr);
    end



    if (uut.DZCPU.rFlowEnable)
    begin
      $fwrite(log,"%05dns [DZCPU] %d (%h) .",$time, uut.DZCPU.wuPc, uut.DZCPU.wuCmd);
      case (uut.DZCPU.wuCmd)
        `nop: $fwrite(log,"nop \n");
        `hlt: $fwrite(log,"halt \n");
        `sma: $fwrite(log,"sma %h\n", uut.DZCPU.oMCUAddr);
        `srm:
        begin
          $fwrite(log,"srm %h %h\n", uut.DZCPU.wUopSrc, uut.DZCPU.iMCUData);
          $fwrite(log,"[MMU] reading %h @ %h,\n", uut.MMU.oCpuData,uut.MMU.iCpuAddr);
        end
        `jcb:
         begin
              $fwrite(log,"jcb %h \n", uut.DZCPU.iMCUData);
         end
        `smw: $fwrite(log,"smw %h %h\n", uut.DZCPU.oMCUAddr, uut.DZCPU.oMCUData);
        `bit: $fwrite(log,"bit %h & %b\n", uut.DZCPU.wRegData, uut.DZCPU.wBitMask);
        `addx16:$fwrite(log,"addx16 %h += %h\n", uut.DZCPU.wX16, uut.DZCPU.wRegData);
        `addx16u:$fwrite(log,"addx16u %h += %h\n", uut.DZCPU.wX16, uut.DZCPU.wRegData);
        `spc: $fwrite(log,"spc %h\n", uut.DZCPU.wRegData);
        `sx16r: $fwrite(log,"sx16r %h\n", uut.DZCPU.wRegData);
        `sx8r: $fwrite(log,"sx8r %h\n", uut.DZCPU.wRegData);
        `inc16:$fwrite(log,"inc16 %h\n", uut.DZCPU.wRegData);
        `dec16: $fwrite(log,"dec16 %h\n", uut.DZCPU.wRegData);
        `srx8:$fwrite(log,"srx8 %h\n", uut.DZCPU.wRegData);
        `shl: $fwrite(log,"shl %h << 1 + %h\n", uut.DZCPU.wRegData, uut.DZCPU.wFlags[`flag_c] );
        `subx16: $fwrite(log,"subx16 %h -= %h = %h\n", uut.DZCPU.wX16, uut.DZCPU.wRegData, uut.DZCPU.rUopDstRegData);
        `srx16: $fwrite(log,"srx16 %h\n", uut.DZCPU.wRegData);
        `ceti: $fwrite(log,"ceti %h\n", uut.DZCPU.wRegData);
        `jint: $fwrite(log,"jint %h\n", uut.DZCPU.wRegData);
        `seti: $fwrite(log,"set %h\n", uut.DZCPU.wRegData);
        `anda: $fwrite(log,"anda %h\n", uut.DZCPU.wRegData);
        `ora: $fwrite(log,"ora %h\n", uut.DZCPU.wRegData);
        `xorx16: $fwrite(log,"xorx16 %h\n", uut.DZCPU.wRegData);
        `rrot:   $fwrite(log,"rrot %h\n", uut.DZCPU.wRegData);
        `xora:   $fwrite(log,"xora %h\n", uut.DZCPU.wRegData);
        `addx16c: $fwrite(log,"addx16rc %h + %h + %h = %h\n", uut.DZCPU.wX16, uut.DZCPU.wRegData,uut.DZCPU.wCarry, uut.DZCPU.rUopDstRegData);
        `shr: $fwrite(log,"shr %h >> 1 + %h\n", uut.DZCPU.wRegData, uut.DZCPU.wFlags[`flag_c] );
        `shl8: $fwrite(log, "shl8  \n");
        `addx16c_ext: $fwrite(log, "addx16c_ext  \n");
        `z801bop:
        begin
          case (uut.DZCPU.iMCUData[7:3])
            5'b10100:  $fwrite(log,"%05dns a &= %h = %h\n", $time, uut.DZCPU.wRegData, uut.DZCPU.rZ80Result );
            5'b10101:  $fwrite(log,"%05dns a ^= %h = %h\n", $time, uut.DZCPU.wRegData, uut.DZCPU.rZ80Result );

          endcase
        end
        default:
        begin
          $fwrite(log,"unknow uop %d Stopping Simulation\n", uut.DZCPU.wuCmd);
          $display( "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
          $display("\n===== ERROR: unknow uop %d Stopping Simulation\n", uut.DZCPU.wuCmd);
          $display( "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n");
          rSimulationDone = 1;
        end
      endcase
    end



    if (uut.MMU.iCpuWe)
    begin
      $fwrite(log,"%05dns [MMU] ", $time);

      if (uut.MMU.iCpuAddr >= 16'hff00 && uut.MMU.iCpuAddr <= 16'hff7f )
        $fwrite(log," [IO] ");

      if (uut.MMU.iCpuAddr >= 16'hff10 && uut.MMU.iCpuAddr <= 16'hff23 )
        $fwrite(log," [SOUND] ");

      if (uut.MMU.iCpuAddr >= 16'hff40 && uut.MMU.iCpuAddr <= 16'hff4B )
        $fwrite(log," [LCD] ");

      if (uut.MMU.iCpuAddr >= 16'hff80 && uut.MMU.iCpuAddr <= 16'hffff )
        $fwrite(log," [PAGEZERO] ");

      if (uut.MMU.iCpuAddr >= 16'h8000 && uut.MMU.iCpuAddr <= 16'h87ff )
        $fwrite(log," [VMEM Tiles 0] ");

      if (uut.MMU.iCpuAddr >= 16'h8800 && uut.MMU.iCpuAddr <= 16'h8fff )
        $fwrite(log," [VMEM Tiles 1] ");

      if (uut.MMU.iCpuAddr >= 16'h9800 && uut.MMU.iCpuAddr <= 16'h9BFF)
        $fwrite(log," [VMEM TileMap 0] ");

      if (uut.MMU.iCpuAddr >= 16'h9C00 && uut.MMU.iCpuAddr <= 16'h9FFF)
        $fwrite(log," [VMEM TileMap 1] ");


       $fwrite(log,"Writting %h @ %h\n", uut.MMU.iCpuData,uut.MMU.iCpuAddr);
    end


    if (uut.DZCPU.wEof )
    begin
      $fwrite(log,"\n             %04s %04s %02s %02s %02s %02s %02s %02s %02s %02s %02s %02s\n", "PC", "SP", "B", "C", "D" ,"E", "H", "L", "A", "F", "Flags", "x8", "x16");
      $fwrite(log,"[regs] %04x %04x %02x %02x %02x %02x %02x %02x %02x %02x %b %02x %02x\n", Pc, {uut.DZCPU.wSpH,uut.DZCPU.wSpL}, uut.DZCPU.wB, uut.DZCPU.wC, uut.DZCPU.wD, uut.DZCPU.wE ,uut.DZCPU.wH, uut.DZCPU.wL, uut.DZCPU.wA,uut.DZCPU.wFlags, uut.DZCPU.wFlags, uut.DZCPU.wX8, uut.DZCPU.wX16);


      $fwrite(log,"\n\n         %05s %05s %05s %05s %05s %05s %05s %05s %05s %05s %05s %05s\n",
      "STAT", "LCDC", "SCY",   "SCX" ,  "LY",
      "LYC",  "DMA",   "BGP",   "BP0",
      "BP1",  "WY", "WX");

      $fwrite(log,"[regs]      %02x   %02x     %02x    %02x    %02x   %02x    %02x    %02x    %02x    %02x     %02x    %02x\n",
      uut.GPU.oSTAT,  uut.GPU.oLCDC,  uut.GPU.oSCY,     uut.GPU.oSCX,         uut.GPU.oLY,
      uut.GPU.oLYC,   uut.GPU.oDMA,     uut.GPU.oBGP,         uut.GPU.oOBP0,
      uut.GPU.oOBP1,   uut.GPU.oWY,      uut.GPU.oWX );


      `ifdef CPU_TRACE_WORK_MEMORY

      $fwrite(log, "=== WORK MEMORY C000 - DFFFF ===\n");
      $fwrite(log,"%02h: ",16'hc000);
      for (i = 0; i <  5*16; i = i + 1)
      begin
          $fwrite(log,"%02h ", uut.MMU.WORK_RAM.Ram[i]);
          if ((i+1) % 16 == 0)
              $fwrite(log,"\n %h: ", (16'hc000+i));

      end

      for (i = 8176; i <  8176+15*16; i = i + 1)
      begin
          $fwrite(log,"*%02x ", uut.MMU.WORK_RAM.Ram[i]);
          if ((i+1) % 16 == 0)
              $fwrite(log,"\n");

      end
      `endif

      if (uut.GPU.oLY == 144)
        $fwrite(log,"[SCREEN_FRAME_COMPLETED]\n");
      $fwrite(log,"\n\n\n");

    end
  end
`endif  //ENABLE_CPU_LOG

endmodule
