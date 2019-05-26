![alt text](https://travis-ci.org/diegovalverde/papiGB.svg?branch=master)

From: https://github.com/diegovalverde/papiGB

# papiGB
Game Boy Classic fully functional FPGA implementation from scratch

###Requirements

`sudo apt-get install iverilog gtkwave`


##Compiling code
`cd sim/`

`make compile`

##Running a simulation

`cd sim/`

`make run`

Once the simulation completes, the following ASCII files are generated under the sim/ folder:

* pgb_cpu.log : Z80 macro instructions and their corresponding micro-code flows
* pgb_gpu.log:      GPU micro code dump
* generated_frames/*.ppm   : PPM representation of the video buffer frames at the time the simulation ended. (Open it with gimp)
* papi_vram_8000_8fff.dump : Memory dump for the Tile set region 0
* papi_vram_9800_9bff.dump : Memory dump for the Tile map region 0
* tb_simple_dzcpu : Simulation testbench executable

Simulations will not automatically generate a VCD dump file.
To generate a VCD dump do:

`make DUMPTYPE=vcd`

##Simulation Options
To control additional simulation options, use the SIMFLAGS flag. Valid values are:

* ``-DSTOP_AFTER_FIRST_FRAME`` : The simulation will stop once the first frame has been generated under the sim/generated_frames/ folder
* ``-DENABLE_CPU_LOG`` : Enables pgb_cpu.log generation (enabled by default)
* ``-DENABLE_GPU_LOG`` : Enables pgb_cpu.log generation (enabled by default)
* ``-DCARTRIGDE_DUMP_PATH`` : When LOAD_CARTRIDGE_FROM_FILE is set, then this flag specifies the path to the dump file
* ``-DSKIP_BIOS`` : Skips the BIOS code, first 256 instructions, effectively jumping directly to 0x100
* ``-DDISABLE_CPU``: Disables the CPU from running
* ``-DVMEM_DUMP_PATH``: When LOAD_VMEM_DUMP is set, then this flag specifies the path to the VMEME dump file.
* ``-DSIMULATION_TIME_OUT``: Specify a simulation timeout in nanoseconds
Example:

The following command will stop the simulation after the first frame, will generate GPU log, but will not generate CPU log.

`make SIMFLAGS="-DSTOP_AFTER_FIRST_FRAME -DENABLE_GPU_LOG"`

The following command will simulate RTL using a cartrigde file:

`make SIMFLAGS=" -DCARTRIGDE_DUMP_PATH='\"resources/tetris.dump\"'"`

The following command will disable the CPU and load VMEM data from a dump file:

`make SIMFLAGS="-DDISABLE_CPU -DVMEM_DUMP_PATH='\"resources/tetris_vmem_8000_9fff.dump\"' -DENABLE_GPU_LOG -DSTOP_AFTER_FIRST_FRAME"`


##Looking at simulation results

`cd sim/`

`make view`

##Cleaning up simulation files.
This also erases the vcd and the log files!

`make clean`

##Installing a game boy assembly

RGBDS is a great gameboy assembly (https://www.anjbe.name/rgbds/)

To install it do:

`git clone https://github.com/bentley/rgbds/`

`cd rgbds`

`sudo apt-get install bison flex`

`make`

`sudo make install`

To compile an assebly program called test_INCr_b.asm do:

`rgbasm -o test_INCr_b.obj test_INCr_b.asm`

`rgblink -m test_INCr_b.map -n test_INCr_b.sym -o test_INCr_b.gb test_INCr_b.obj`

The use hexdump to get the ASCII hex dump to load into the RTL simulation:

`hexdump -v test_INCr_b.gb > test_INCr_b.hex`


