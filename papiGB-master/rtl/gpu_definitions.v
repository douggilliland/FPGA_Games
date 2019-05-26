//`timescale 1ns / 1ps
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



`ifndef GPU_DEFINITIONS_V
`define GPU_DEFINITIONS_V

`define GPU_UOP_SZ      23
`define GPU_OP_RNG      22:18
`define GPU_DST_RNG     17:12
`define GPU_S1_RNG      11:6
`define GPU_S0_RNG      5:0
`define GPU_LIT_RNG     9:0

`define GPU_S1_RNG_SEL_BIT  11
`define GPU_S1_RNG_H        10:6
`define GPU_S1_RNG_L        9:6

`define GPU_S0_RNG_SEL_BIT  5
`define GPU_S0_RNG_H        4:0
`define GPU_S0_RNG_L        3:0



`define SPRITE_COLOR_TRANSPARENT 2'b0
`define SCANLINE_VRAM_READ       12'd3


//Operations
`define gnop       5'd0
`define gwrl       5'd1
`define gwrr       5'd2
`define gadd       5'd3
`define gsub       5'd4
`define gaddl      5'd5
`define gjnz       5'd6
`define gwfbuffer  5'd7
`define gsubl      5'd8
`define grvmem     5'd9
`define gshl       5'd10
`define ggoto      5'd11
`define gjz        5'd12
`define gand       5'd13
`define gsprtt     5'd14   //Test if sprite is within (or partially in) current tile rectangle
`define ginfbaddr  5'd16   //Increment the FrameBuffer write pointer
`define gwx        5'd17
`define gwy        5'd18
//Registers
`define gnull                      6'd0

`define lcdc				               6'd0
`define state                      6'd1
`define scx                        6'd2
`define scy                        6'd3
`define ly                         6'd4
`define lyc                        6'd5
`define dma                        6'd6
`define bgp                        6'd7
`define obp0                       6'd8
`define obp1                       6'd9
`define wx                         6'd10
`define wy                         6'd11
`define vmem_addr                  6'd12
`define bh                         6'd13
`define bl                         6'd14
`define fbuffer_addr               6'd15
`define cur_tile                   6'd16
`define sprite_current_row_offset  6'd17
`define sprite_x_coord             6'd18
`define sprite_y_coord             6'd19
`define tile_row                   6'd20
`define sh                         6'd21 //Sprite MSByte
`define sl                         6'd22 //Sprite MSByte
`define r0                         6'd23
`define r1                         6'd24
`define r2                         6'd25
`define r3                         6'd26
`define r4                         6'd27
`define r5                         6'd28
`define r6                         6'd29
`define WinTile                    6'd30
`define sprite_info		             6'd31
`define bgmoffset                  6'd32
`define bgtoffset                  6'd33
`define vmem_data                  6'd34
`define bg_row_offset              6'd35
`define ly_mod_8                   6'd36
`define r8191                      6'd37
`define	oam_offset			           6'd38
`define vmem_data_shl_4            6'd39
`define scy_shl_5__plus_scx        6'd40
`define scy_tile_row_offset        6'd41
`define IsThisTileWin              6'd42
`define Win_index                  6'd43
`define Winmoffset                 6'd44
`define Window_render              6'd23 //save window render in r0
//Jump labels
`define get_next_sprite     18'd51
`define skip_the_sprites	  18'd54 //remember to change during testing of new uop
`define skip_the_window     18'd84
`define render_window       18'd68
`define initialize_window   18'd66
`endif
