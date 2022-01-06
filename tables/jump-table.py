OP_INFO = { 0:("BRK","",1),
            1:("ORA","IX",2),
            5:("ORA","ZP",2),
            6:("ASL","ZP",2),
            8:("PHP","",1),
            9:("ORA","IMMED_A",2),
            10:("ASL","A",1),
            13:("ORA","ABS",3),
            14:("ASL","ABS",3),
            16:("BPL","REL",2),
            17:("ORA","IY",2),
            21:("ORA","ZPX",2),
            22:("ASL","ZPX",2),
            24:("CLC","",1),
            25:("ORA","ABSY",3),
            29:("ORA","ABSX",3),
            30:("ASL","ABSX",3),
            32:("JSR","ABS",3),
            33:("AND","IX",2),
            36:("BIT","ZP",2),
            37:("AND","ZP",2),
            38:("ROL","ZP",2),
            40:("PLP","",1),
            41:("AND","IMMED_A",2),
            42:("ROL","A",1),
            44:("BIT","ABS",3),
            45:("AND","ABS",3),
            46:("ROL","ABS",3),
            48:("BMI","REL",2),
            49:("AND","IY",2),
            53:("AND","ZPX",2),
            54:("ROL","ZPX",2),
            56:("SEC","",1),
            57:("AND","ABSY",3),
            61:("AND","ABSX",3),
            62:("ROL","ABSX",3),
            64:("RTI","",1),
            65:("EOR","IX",2),
            69:("EOR","ZP",2),
            70:("LSR","ZP",2),
            72:("PHA","",1),
            73:("EOR","IMMED_A",2),
            74:("LSR","A",1),
            76:("JMP","ABS",3),
            77:("EOR","ABS",3),
            78:("LSR","ABS",3),
            80:("BVC","REL",2),
            81:("EOR","IY",2),
            85:("EOR","ZPX",2),
            86:("LSR","ZPX",2),
            88:("CLI","",1),
            89:("EOR","ABSY",3),
            93:("EOR","ABSX",3),
            94:("LSR","ABSX",3),
            96:("RTS","",1),
            97:("ADC","IX",2),
            101:("ADC","ZP",2),
            102:("ROR","ZP",2),
            104:("PLA","",1),
            105:("ADC","IMMED_A",2),
            106:("ROR","A",1),
            108:("JMP","I",3),
            109:("ADC","ABS",3),
            110:("ROR","ABS",3),
            112:("BVS","REL",2),
            113:("ADC","IY",2),
            117:("ADC","ZPX",2),
            118:("ROR","ZPX",2),
            120:("SEI","",1),
            121:("ADC","ABSY",3),
            125:("ADC","ABSX",3),
            126:("ROR","ABSX",3),
            129:("STA","IX",2),
            132:("STY","ZP",2),
            133:("STA","ZP",2),
            134:("STX","ZP",2),
            136:("DEY","",1),
            138:("TXA","",1),
            140:("STY","ABS",3),
            141:("STA","ABS",3),
            142:("STX","ABS",3),
            144:("BCC","REL",2),
            145:("STA","IY",2),
            148:("STY","ZPX",2),
            149:("STA","ZPX",2),
            150:("STX","ZPY",2),
            152:("TYA","",1),
            153:("STA","ABSY",3),
            154:("TXS","",1),
            157:("STA","ABSX",3),
            160:("LDY","IMMED_XY",2),
            161:("LDA","IX",2),
            162:("LDX","IMMED_XY",2),
            164:("LDY","ZP",2),
            165:("LDA","ZP",2),
            166:("LDX","ZP",2),
            168:("TAY","",1),
            169:("LDA","IMMED_A",2),
            170:("TAX","",1),
            172:("LDY","ABS",3),
            173:("LDA","ABS",3),
            174:("LDX","ABS",3),
            176:("BCS","REL",2),
            177:("LDA","IY",2),
            180:("LDY","ZPX",2),
            181:("LDA","ZPX",2),
            182:("LDX","ZPY",2),
            184:("CLV","",1),
            185:("LDA","ABSY",3),
            186:("TSX","",1),
            188:("LDY","ABSX",3),
            189:("LDA","ABSX",3),
            190:("LDX","ABSY",3),
            192:("CPY","IMMED_XY",2),
            193:("CMP","IX",2),
            196:("CPY","ZP",2),
            197:("CMP","ZP",2),
            198:("DEC","ZP",2),
            200:("INY","",1),
            201:("CMP","IMMED_A",2),
            202:("DEX","",1),
            204:("CPY","ABS",3),
            205:("CMP","ABS",3),
            206:("DEC","ABS",3),
            208:("BNE","REL",2),
            209:("CMP","IY",2),
            213:("CMP","ZPX",2),
            214:("DEC","ZPX",2),
            216:("CLD","",1),
            217:("CMP","ABSY",3),
            221:("CMP","ABSX",3),
            222:("DEC","ABSX",3),
            224:("CPX","IMMED_XY",2),
            225:("SBC","IX",2),
            228:("CPX","ZP",2),
            229:("SBC","ZP",2),
            230:("INC","ZP",2),
            232:("INX","",1),
            233:("SBC","IMMED_A",2),
            234:("NOP","",1),
            236:("CPX","ABS",3),
            237:("SBC","ABS",3),
            238:("INC","ABS",3),
            240:("BEQ","REL",2),
            241:("SBC","IY",2),
            245:("SBC","ZPX",2),
            246:("INC","ZPX",2),
            248:("SED","",1),
            249:("SBC","ABSY",3),
            253:("SBC","ABSX",3),
            254:("INC","ABSX",3)
            }

OP_FULL_NAMES={}      
with open("instructions.asm","wt") as f:
    f.write("\t;Instruction routines\n")
    f.write("\tinstructions_begin:\n\n")
    for i in range(256):
        if i in OP_INFO:
            op_name=OP_INFO[i][0]
            op_mode=OP_INFO[i][1]
            if op_mode=="": op_mode="IMP"
            op_full=op_name+"_"+op_mode
            f.write(f"\t;0x{hex(i)[2:].upper()} - {op_name} {op_mode}\n")
            f.write(f"\t{op_full}:\n")
            f.write(f'\t\tOP_MACRO {i}, {op_name}, {op_mode}, {op_full}\n')
            f.write(f"\t\tNEXT_MACRO\n")
            f.write("\n")
        else:
            op_full="NOP_0x"+hex(i)[2:].upper()
            f.write(f"\t;0x{hex(i)[2:].upper()} - NOP\n")
            f.write(f"\t{op_full}:\n")
            f.write(f'\t\tOP_MACRO {i}, NOP, IMP, {op_full}\n')
            f.write(f"\t\tNEXT_MACRO\n")
            f.write("\n")
        OP_FULL_NAMES[i]=op_full
    f.write("\tinstructions_end:\n")
    f.write("instructions_size equ instructions_end-instructions_begin\n")

with open("jump-table.asm","wt") as f:
    f.write("\t;Jump table\n")
    f.write("\tjump_table_begin:\n\n")

    #Old format - Two aligned jump tables of 128 16-bit addresses each
    """    
    f.write("\tALIGN 256\n")
    for i in range(256):
        if i==0:
            f.write("\tJUMP_TABLE:\n")
        if i==128:
            f.write("\n\tJUMP_TABLE2:\n")
        f.write(f"\tFDB {OP_FULL_NAMES[i]}\n")
        """
    
    #One 256 byte table for each half of 256 16-bit addresses
    f.write("\tJUMP_TABLE_LO:\n")
    for i in range(256):
        f.write(f"\tFCB lo({OP_FULL_NAMES[i]})\n")
    f.write("\n");
    f.write("\tJUMP_TABLE_HI:\n")
    for i in range(256):
        f.write(f"\tFCB hi({OP_FULL_NAMES[i]})\n")
        
    f.write("\tjump_table_end:\n")   
    f.write("jump_table_size equ jump_table_end-jump_table_begin\n")