
VERILOGEX = .v # Verilog file extension

# testbench path TESTBENCH is passed from the command line
SCENEPATH =
TESTBENCH = tb_simple_dzcpu
TESTBENCHPATH = ../tb/${TESTBENCH}$(VERILOGEX)
SOURCEPATH = ../rtl
GPUCONFIGURATIONSCRIPT=../scripts/configure_gpu.pl
INPUTCONFIGURATIONSCRIPT=../scripts/configure_params.pl
#iverilog CONFIG
VERILOG_CMD = iverilog

# VVP (iverilog runtime engine)
VVP_CMD = vvp

#Simulation Vars
SIMDIR = .
DUMPTYPE = none
#Viewer
WAVEFORM_VIEWER = gtkwave # Waveform viewer executable
SIMFLAGS = -DSTOP_AFTER_FIRST_FRAME -DLCD_SCXY_DISABLED -DENABLE_CPU_LOG -DENABLE_GPU_LOG


all: compile run


testbench_checktestbench_check:
ifeq ($(strip $(TESTBENCH)),)
		@echo "TESTBENCH not set. Use TESTBENCH=value to set it."
		@exit 2
endif



check:
	$(VERILOG_CMD) -t null $(FILES)

# Setup up project directory
new :
	echo "Setting up project ${PROJECT}"
	mkdir rtl testbench simulation


compile :


	 $(VERILOG_CMD) $(SIMFLAGS) -o  $(SIMDIR)/$(TESTBENCH) $(TESTBENCHPATH) $(SOURCEPATH)/* -I $(SOURCEPATH)/ -Wall


run :
	$(VVP_CMD) ./$(TESTBENCH) -$(DUMPTYPE) $(VVP_FLAGS)

view :
	$(WAVEFORM_VIEWER)  $(SIMDIR)/$(TESTBENCH).vcd $(SIMDIR)/signals/$(TESTBENCH).gtkw

clean :
	rm -f $(SIMDIR)/$(TESTBENCH)
	rm -f *.vcd *.log *.dump 
	rm -f generated_frames/*.ppm
