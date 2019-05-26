import re
from sys import argv

reg_names = ['SP', 'B', 'C', 'D', 'E', 'H', 'L', 'A', 'Flags']
#                PC      SP    B    C    D    E     H    L   A    Flags
#                 0x0000 LD SP, $0xFFFE
bios_checker = {'00000003': ['fffe', '*', '*', '*', '*', '*', '*', '*', '*'],
                # 0x0003 XOR A
                '00000004': ['*', '*', '*', '*', '*', '*', '*', '00', '*'],
                # 0x000C  LD HL, $0xFF26 # load 0xFF26 to HL
                '0000000f': ['*', '*', '*', '*', '*', 'ff', '26', '*', '*'],
                # 0x000F  LD C, $0x11 # load 0x11 to C
                '00000011': ['*', '*', '11', '*', '*', '*', '*', '*', '*'],
                # 0x0011  LD A, $0x80 # load 0x80 to A
                '00000013': ['*', '*', '*', '*', '*', '*', '*', '80', '*'],
                # 0x0013  LD (HL-), A # load A [HL], HL--
                '00000015': ['*', '*', '*', '*', '*', 'ff', '25', '*', '*'],
                # 0x0015  INC C # increment C register
                '00000016': ['*', '*', '12', '*', '*', '*', '*', '*', '*'],
                # 0x0016  LD A, $0xF3 # load 0xF3 to A
                '00000018': ['*', '*', '*', '*', '*', '*', '*', 'f3', '*'],
                # 0x001A  LD A, $0x77 # load 0x77 to A
                '0000001c': ['*', '*', '*', '*', '*', '*', '*', '77', '*'],
                # 0x001D LD A, $0xFC # A represents the color number mappings
                '0000001f': ['*', '*', '*', '*', '*', '*', '*', 'fc', '*'],
                # 0x0021 LD DE, $0x0104 # pointer to Nintendo Logo
                '00000024': ['*', '*', '*', '01', '04', '*', '*', '*', '*'],
                # 0x0024 LD HL, $0x8010 # pointer to Video RAM
                '00000027': ['*', '*', '*', '*', '*', '80', '10', '*', '*'],
                # 0x0027 LD A, (DE) # load next byte from Nintendo Logo
                '00000028': ['*', '*', '*', '*', '*', '*', '*', 'ce', '*'],
                # 0x0028 CALL $0x0095 # decompress, scale
                # 0x0095 LD C, A # load A to C
                '00000096': ['*', '*', 'ce', '*', '*', '*', '*', 'ce', '*'],
                # 0x0096 LD B, $0x4 #
                '00000098': ['*', '04', '*', '*', '*', '*', '*', '*', '*'],
                # 0x0099 RL C # rotate left register C through carry flag
                '0000009b': ['*', '*', '9c', '*', '*', '*', '*', '*', '00010000'],
                }


script, filename = argv

with open(filename, "r") as file:
    for line in file:
        if (not re.match("^\[regs\]", line)):
            continue

        regs = re.split("\s+", line)
        pc = regs[1]
        regs = regs[2:]

        if (pc not in bios_checker):
            continue

        print(line)
        for reg, value, name in zip(regs, bios_checker[pc], reg_names):
            if (value == '*'):
                continue

            print(("pc {0}. {1} {2} found {3}").format(pc, name, value, reg))
            if (value != reg):
                raise Exception(("Register mismatch\n"))
