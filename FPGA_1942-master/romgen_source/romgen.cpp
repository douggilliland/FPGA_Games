#include <stdio.h>
#include <stdlib.h>
#include <string>
#include <math.h>
#include <iostream>
#include <iomanip>
using namespace std;

#define VER_MAJ 3
#define VER_MIN 3
#define MAX_ROM_SIZE 0x4000

int main(int argc, char* argv[])

{
	cerr << "romgen by MikeJ v" <<VER_MAJ << "." << setw(2) << setfill('0') <<VER_MIN <<endl;
	// read file

	string buffer;
	FILE *fin;

	if(argc < 5)
	{
		cerr << "\nUsage: romgen <input file> <entity name> <number of address bits>\n";
		cerr << "                  <format> [registered] [enable]\n";
		cerr << "\n";
		cerr << "Now uses bit_vector generics for compatibilty with Xilinx UniSim library\n";
		cerr << "\n";
		cerr << "for the format paramater use :\n";
		cerr << "  a  - rtl model rom array \n";
		cerr << "  c  - rtl model case statement \n";
		cerr << "  b  - Xilinx block ram4  (registered output always)\n";
		cerr << "  l  - Xilinx block ram16 (registered output always)\n";
		cerr << "  d  - Xilinx distributed ram [not supported yet]\n";
		cerr << "  m  - Xilinx mem file\n";
		cerr << "\n";
		cerr << "for the registered paramater (optional) use :\n";
		cerr << "  r  - registered output (combinatorial otherwise) \n";
		cerr << "\n";
		cerr << "for the enable paramater (optional) use :\n";
		cerr << "  e  - clock enable generated \n";
		cerr << "\n";
		cerr << "note: generated roms are always 8 bits wide\n";
		cerr << "      max 12 address bits for block ram4s\n";
		cerr << "      max 14 address bits for block ram16s\n";
		cerr << "for example romgen fred.bin fred_rom 12 c r\n\n";
		return -1;
	}

	fin = fopen(argv[1],"rb");
	if (fin == NULL) {
		cerr << "ERROR : Could not open input file " << argv[1] <<"\n";
		return -1;
	}

	char rom_type = 0;
	char option_1 = 0;
	char option_2 = 0;
	sscanf(argv[4],"%c",&rom_type);
	if (argc > 5) sscanf(argv[5],"%c",&option_1);
	if (argc > 6) sscanf(argv[6],"%c",&option_2);

	bool format_case = false;
	bool format_array = false;
	bool format_block = false;
	bool format_dist = false;
	bool format_clock = false;
	bool format_ram16 = false;
	bool format_ena = false;
	bool format_mem = false;

	cerr << "INFO : creating entity : " << argv[2] << "\n";

	if (option_1 != 0) {
		if ((option_1 == 'r') || (option_1 == 'R'))
			format_clock = true;
		else if ((option_1 == 'e') || (option_1 == 'E'))
			format_ena = true;
		else {
			cerr << "ERROR : output option not supported\n";
			return -1;
		}
	}

	// lazy ...
	if (option_2 != 0) {
		if ((option_2 == 'r') || (option_2 == 'R'))
			format_clock = true;
		else if ((option_2 == 'e') || (option_2 == 'E'))
			format_ena = true;
		else {
			cerr << "ERROR : output option not supported\n";
			return -1;
		}
	}

	if ((rom_type == 'c') || (rom_type == 'C')) {
		cerr << "INFO : rtl model, case statement \n"; format_case = true; }
	else if ((rom_type == 'a') || (rom_type == 'A')) {
		cerr << "INFO : rtl model, rom array \n"; format_array = true; }
	else if ((rom_type == 'b') || (rom_type == 'B')) {
		cerr << "INFO : block4 ram, registered \n"; format_block = true; format_clock = true; }
	else if ((rom_type == 'l') || (rom_type == 'L')) {
		cerr << "INFO : block16 ram, registered \n"; format_block = true; format_clock = true; format_ram16 = true; }
	else if ((rom_type == 'm') || (rom_type == 'M')) {
		cerr << "INFO : mem file \n"; format_mem = true; format_clock = true; format_ram16 = true;}
	//else if ((rom_type == 'd') || (rom_type == 'D')) {
	//  cerr << "INFO : distributed ram, combinatorial; \n"; format_dist = true; }
	else {
		cerr << "ERROR : format not supported\n";
		return -1;
	}
	if (format_clock == true)
		cerr << "INFO : registered output\n\n";
	else
		cerr << "INFO : combinatorial output\n\n";

	// calc number of address bits required
	int addr_bits;
	int max_addr_bits = 16;
	int rom_inits = 16;

	if (format_block == true || format_mem == true) {
		if (format_ram16 == true) {
			max_addr_bits = 14;
			rom_inits = 64;
		}
		else
		max_addr_bits = 12;
	}

	sscanf(argv[3],"%d",&addr_bits);
	if (addr_bits < 1 || addr_bits > max_addr_bits) {
		cerr << "ERROR : illegal rom size, number of address bits must be between 1 and " << max_addr_bits << "\n";
		return -1;
	}
	// ram b16s
	// for  14 bits use ram_b16_s1 x data_width
	// for  13 bits use ram_b16_s2 x data_width/2
	// for  12 bits use ram_b16_s4 x data_width/4
	// for<=11 bits use ram_b16_s8 x data_width/8

	// ram b4s
	// for  12 bits use ram_b4_s1 x data_width
	// for  11 bits use ram_b4_s2 x data_width/2
	// for  10 bits use ram_b4_s4 x data_width/4
	// for <=9 bits use ram_b4_s8 x data_width/8
	int rom_size = (int) pow(2,addr_bits);

	int number_of_block_rams = 1;
	int block_ram_width = 8;
	int block_ram_pwidth = 0;
	int block_ram_abits = 9;

	if (format_ram16 == true) {
		block_ram_abits = 11; // default
		block_ram_pwidth = 1;
		// ram16s
		switch (addr_bits) {
			case 14 : number_of_block_rams = 8; block_ram_width = 1; block_ram_pwidth = 0; block_ram_abits = 14; break;
			case 13 : number_of_block_rams = 4; block_ram_width = 2; block_ram_pwidth = 0; block_ram_abits = 13; break;
			case 12 : number_of_block_rams = 2; block_ram_width = 4; block_ram_pwidth = 0; block_ram_abits = 12; break;
			default : ;
		}
	}
	else {
		// ram4s
		switch (addr_bits) {
			case 12 : number_of_block_rams = 8; block_ram_width = 1; block_ram_abits = 12; break;
			case 11 : number_of_block_rams = 4; block_ram_width = 2; block_ram_abits = 11; break;
			case 10 : number_of_block_rams = 2; block_ram_width = 4; block_ram_abits = 10; break;
			default : ;
		}
	}

	//printf("block ram w : %d ",block_ram_width);
	//printf("block ram n : %d ",number_of_block_rams);

	// process
	int mem[MAX_ROM_SIZE];
	string line;

	int i,j,k;


	int addr = 0;
	int last_nz_addr = 0;
	int offset = 0;
	int mask = 0;
	unsigned int data = 0;

	// clear mem
	for (i = 0; i < MAX_ROM_SIZE; i++) mem[i] = 0;

	// process file
	data = getc(fin);
	while (!feof(fin) && (addr < rom_size)) {
		if (addr >= MAX_ROM_SIZE) {
			cerr << "ERROR : file too large\n";
			return -1;
		}

		mem[addr] = data;
		// debug
		//if (addr % 16 == 0) printf("%04x : ",addr);
		//printf("%02x  ",data);
		//if (addr % 16 == 15) printf("\n");
		// end debug
		if (data) {
			// remember the last address that has non zero data
			last_nz_addr = addr;
		}
		addr ++;
		data = getc(fin);
	}
	fclose(fin);


	if (format_mem == true) {

		for (k = 0; k < number_of_block_rams; k ++){
		//printf("\trom%d : if true generate\n",k);

		for (j = 0; j < rom_inits; j++) {
			//printf("\t\tattribute INIT_%02X of inst : label is \042",j);
			switch (block_ram_width) {

			case 1 : // width 1
				mask = 0x1 << (k);
				//for (i = 0; i < 256; i+=8) {
				for (i = 248; i >= 0; i-=8) {
					data  = ((mem[(j*256) + (255 - i)] & mask) >> k);
					data <<= 1;
					data += ((mem[(j*256) + (254 - i)] & mask) >> k);
					data <<= 1;
					data += ((mem[(j*256) + (253 - i)] & mask) >> k);
					data <<= 1;
					data += ((mem[(j*256) + (252 - i)] & mask) >> k);
					data <<= 1;
					data += ((mem[(j*256) + (251 - i)] & mask) >> k);
					data <<= 1;
					data += ((mem[(j*256) + (250 - i)] & mask) >> k);
					data <<= 1;
					data += ((mem[(j*256) + (249 - i)] & mask) >> k);
					data <<= 1;
					data += ((mem[(j*256) + (248 - i)] & mask) >> k);
					printf("%02X ",data);
				}
				break;

			case 2 : // width 2
				//printf("case 2\n");
				mask = 0x3 << (k * 2);
				//for (i = 0; i < 128; i+=4) {
				for (i = 124; i >= 0; i-=4) {
					data  = ((mem[(j*128) + (127 - i)] & mask) >> k * 2);
					data <<= 2;
					data += ((mem[(j*128) + (126 - i)] & mask) >> k * 2);
					data <<= 2;
					data += ((mem[(j*128) + (125 - i)] & mask) >> k * 2);
					data <<= 2;
					data += ((mem[(j*128) + (124 - i)] & mask) >> k * 2);
					printf("%02X ",data);
				}
				break;

			case 4 : // width 4
				//printf("case 4\n");
				mask = 0xF << (k * 4);
				for (i = 62; i >= 0; i-=2) {
					data  = ((mem[(j*64) + (63 - i)] & mask) >> k * 4);
					data <<= 4;
					data += ((mem[(j*64) + (62 - i)] & mask) >> k * 4);
					printf("%02X ",data);
				}
			break;

			case 8 : // width 8
				//for (i = 0; i < 32; i++) {
				//printf("case 8\n");
				for (i = 31; i >= 0; i--) {
					data = ((mem[(j*32) + (31 - i)]));
					printf("%02X ",data);
				}
				break;
				} // end switch

			//printf("\042;\n");
		}

		// for (i = 0; i <= last_nz_addr; i ++ ) {
		// printf("%02X",i,mem[i]);
		}
		return 0;
	} // end case
	printf("-- generated with romgen v%d.%02d by MikeJ\n", VER_MAJ, VER_MIN);
	printf("library ieee;\n");
	printf("\tuse ieee.std_logic_1164.all;\n");
	printf("\tuse ieee.std_logic_unsigned.all;\n");
	printf("\tuse ieee.numeric_std.all;\n");
	printf("\n");
	printf("library UNISIM;\n");
	printf("\tuse UNISIM.Vcomponents.all;\n");
	printf("\n");
	printf("entity %s is\n",argv[2]);
	printf("port (\n");
	if (format_clock == true) printf("\tCLK  : in  std_logic;\n");
	if (format_ena == true)   printf("\tENA  : in  std_logic;\n");
	printf("\tADDR : in  std_logic_vector(%d downto 0);\n",addr_bits - 1);
	printf("\tDATA : out std_logic_vector(7 downto 0)\n");
	printf("\t);\n");
	printf("end;\n");
	printf("\n");
	printf("architecture RTL of %s is\n",argv[2]);
	printf("\n");

	// if blockram
	//{{{
	if (format_block == true) {
		printf("\tsignal rom_addr : std_logic_vector(%d downto 0);\n",block_ram_abits - 1);
		printf("\n");
	}
	//}}}

	//{{{
	if (format_array == true) {
		printf("\n");
		printf("\ttype ROM_ARRAY is array(0 to %d) of std_logic_vector(7 downto 0);\n",rom_size - 1);
		printf("\tconstant ROM : ROM_ARRAY := (\n");
		for (i = 0; i < rom_size; i ++ ) {
			if (i % 8 == 0) printf("\t\t");
			printf("x\042%02X\042",mem[i]);
			if (i  < (rom_size - 1)) printf(",");
			if (i == (rom_size - 1)) printf(" ");
			if (i % 8 == 7) printf(" -- 0x%04X\n",i - 7);
		}
		printf("\t);\n");
		printf("\n");
	} // end array
	//}}}

	//{{{
	if (format_case == true) {
		printf("\tsignal rom_addr : std_logic_vector(11 downto 0);\n");
		printf("\n");
	}
	//}}}

	printf("begin\n");
	printf("\n");
	//
	if ((format_block == true) || (format_case == true)) {
		printf("\tp_addr : process(ADDR)\n");
		printf("\tbegin\n");
		printf("\t\trom_addr <= (others => '0');\n");
		printf("\t\trom_addr(%d downto 0) <= ADDR;\n",addr_bits - 1);
		printf("\tend process;\n");
		printf("\n");
	}
	//
	//{{{
	if (format_block == true) {

		for (k = 0; k < number_of_block_rams; k ++){
			if (format_ram16 == true)
				printf("\t%s_%d : RAMB16_S%d\n",argv[2], k, block_ram_width + block_ram_pwidth);
			else
				printf("\t%s_%d : RAMB4_S%d\n",argv[2], k, block_ram_width);

			printf("\tgeneric map (\n");

			// parity bits
			if (block_ram_pwidth != 0) {
				for (i = 0; i< 8; i++) {
					printf("\t\tINITP_%02X => x\0420000000000000000000000000000000000000000000000000000000000000000\042",i);
					printf(",\n");
				}
				printf("\n");
			}

			for (j = 0; j < rom_inits; j++) {
				printf("\t\tINIT_%02X => x\042",j);
				switch (block_ram_width) {

					case 1 : // width 1
						mask = 0x1 << (k);
						for (i = 0; i < 256; i+=8) {
							data  = ((mem[(j*256) + (255 - i)] & mask) >> k);
							data <<= 1;
							data += ((mem[(j*256) + (254 - i)] & mask) >> k);
							data <<= 1;
							data += ((mem[(j*256) + (253 - i)] & mask) >> k);
							data <<= 1;
							data += ((mem[(j*256) + (252 - i)] & mask) >> k);
							data <<= 1;
							data += ((mem[(j*256) + (251 - i)] & mask) >> k);
							data <<= 1;
							data += ((mem[(j*256) + (250 - i)] & mask) >> k);
							data <<= 1;
							data += ((mem[(j*256) + (249 - i)] & mask) >> k);
							data <<= 1;
							data += ((mem[(j*256) + (248 - i)] & mask) >> k);
							printf("%02X",data);
						}
						break;

					case 2 : // width 2
						mask = 0x3 << (k * 2);
						for (i = 0; i < 128; i+=4) {
							data  = ((mem[(j*128) + (127 - i)] & mask) >> k * 2);
							data <<= 2;
							data += ((mem[(j*128) + (126 - i)] & mask) >> k * 2);
							data <<= 2;
							data += ((mem[(j*128) + (125 - i)] & mask) >> k * 2);
							data <<= 2;
							data += ((mem[(j*128) + (124 - i)] & mask) >> k * 2);
							printf("%02X",data);
						}
						break;

					case 4 : // width 4
					mask = 0xF << (k * 4);
					for (i = 0; i < 64; i+=2) {
						data  = ((mem[(j*64) + (63 - i)] & mask) >> k * 4);
						data <<= 4;
						data += ((mem[(j*64) + (62 - i)] & mask) >> k * 4);
						printf("%02X",data);
					}
					break;

					case 8 : // width 8
						for (i = 0; i < 32; i++) {
							data = ((mem[(j*32) + (31 - i)]));
							printf("%02X",data);
						}
						break;
				} // end switch

				printf("\042");
				if (j< (rom_inits - 1)) printf(",");
				printf("\n");
			}

			printf("\t)\n");
			printf("\tport map (\n");
			printf("\t\tDO   => DATA(%d downto %d),\n",((k+1) * block_ram_width)-1,k*block_ram_width);
			if (block_ram_pwidth != 0)
				printf("\t\tDOP  => open,\n");
			printf("\t\tADDR => rom_addr,\n");
			printf("\t\tCLK  => CLK,\n");
			printf("\t\tDI   => \042");
			for (i = 0; i < block_ram_width -1; i++) printf("0");
			printf("0\042,\n");
			if (block_ram_pwidth != 0) {
				printf("\t\tDIP  => \042");
				for (i = 0; i < block_ram_pwidth -1; i++) printf("0");
				printf("0\042,\n");
			}
			if (format_ena == true)
				printf("\t\tEN   => ENA,\n");
			else
				printf("\t\tEN   => '1',\n");
			//
			if (format_ram16 == true)
				printf("\t\tSSR  => '0',\n");
			else
				printf("\t\tRST  => '0',\n");
			printf("\t\tWE   => '0'\n");
			printf("\t);\n");
			printf("\n");
		}
		//} // end block ram
	//}}}
	}

	//{{{
	if (format_array == true) {
		if (format_clock == true)
			printf("\tp_rom : process\n");
		else
			printf("\tp_rom : process(ADDR)\n");
		printf("\tbegin\n");
		if (format_clock == true)
			printf("\t\twait until rising_edge(CLK);\n");
		if (format_ena == true)
			printf("\t\tif (ENA = '1') then\n  ");
		printf("\t\t\tDATA <= ROM(to_integer(unsigned(ADDR)));\n");
		if (format_ena == true)
			printf("\t\tend if;\n");
		printf("\tend process;\n");
	//}}}
	} // end array

	//{{{
	if (format_case == true) {
		if (format_clock == true)
			printf("\tp_rom : process\n");
		else
			printf("\tp_rom : process(rom_addr)\n");
		printf("\tbegin\n");
		if (format_clock == true)
			printf("\t\twait until rising_edge(CLK);\n");
		if (format_ena == true)
			printf("\t\tif (ENA = '1') then\n");

		printf("\t\t\tDATA <= (others => '0');\n");
		printf("\t\t\tcase rom_addr is\n");
		// stop generating RTL at the last non zero mem[] byte
		//the remaining addresses are covered by the default case statement
		for (i = 0; i <= last_nz_addr; i ++ ) {
			printf("\t\t\t\twhen x\042%03X\042 => DATA <= x\042%02X\042;\n",i,mem[i]);
		}
		printf("\t\t\t\twhen others => DATA <= (others => '0');\n");
		printf("\t\t\tend case;\n");
		if (format_ena == true)
			printf("\t\tend if;\n");
		printf("\tend process;\n");
	//}}}
	} // end case
	printf("end RTL;\n");

	return 0;
}
