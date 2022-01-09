OP_INFO = { 

0:("BRK","IMP","BRK","","",""),
1:("ORA","IX","","","",""),
4:("TSB","ZP","TSB_ZP","","",""),
5:("ORA","ZP","LDA_A","OP_ZP_F","STA_A",""),
6:("ASL","ZP","LDA_ZP","OP_IMP_F","STA_ZP",""),
8:("PHP","IMP","","","",""),
9:("ORA","IMMED","LDA_A","OP_IMMED_F","STA_A",""),
10:("ASL","IMP","LDA_A","OP_IMP_F","STA_A",""),
12:("TSB","ABS","","","",""),
13:("ORA","ABS","","","",""),
14:("ASL","ABS","","","",""),
16:("BPL","REL","","","",""),
17:("ORA","IY","","","",""),
18:("ORA","IZP","","","",""),
20:("TRB","ZP","TRB_ZP","","",""),
21:("ORA","ZPX","","","",""),
22:("ASL","ZPX","","","",""),
24:("CLC","IMP","OP_F","","",""),
25:("ORA","ABSY","","","",""),
26:("INC","IMP","LDA_A","OP_IMP_F","STA_A",""),
28:("TRB","ABS","","","",""),
29:("ORA","ABSX","","","",""),
30:("ASL","ABSX","","","",""),
32:("JSR","ABS","","","",""),
33:("AND","IX","","","",""),
36:("BIT","ZP","LDA_ZP","STA_TEMP","LDA_A","BIT_TEMP_F"),
37:("AND","ZP","LDA_A","OP_ZP_F","STA_A",""),
38:("ROL","ZP","LDA_ZP","OP_IMP_F","STA_ZP",""),
40:("PLP","IMP","","","",""),
41:("AND","IMMED","LDA_A","OP_IMMED_F","STA_A",""),
42:("ROL","IMP","LDA_A","OP_IMP_F","STA_A",""),
44:("BIT","ABS","","","",""),
45:("AND","ABS","","","",""),
46:("ROL","ABS","","","",""),
48:("BMI","REL","","","",""),
49:("AND","IY","","","",""),
50:("AND","IZP","","","",""),
52:("BIT","ZPX","","","",""),
53:("AND","ZPX","","","",""),
54:("ROL","ZPX","","","",""),
56:("SEC","IMP","OP_F","","",""),
57:("AND","ABSY","","","",""),
58:("DEC","IMP","LDA_A","OP_IMP_F","STA_A",""),
60:("BIT","ABSX","","","",""),
61:("AND","ABSX","","","",""),
62:("ROL","ABSX","","","",""),
64:("RTI","IMP","","","",""),
65:("EOR","IX","","","",""),
69:("EOR","ZP","LDA_A","OP_ZP_F","STA_A",""),
70:("LSR","ZP","LDA_ZP","OP_IMP_F","STA_ZP",""),
72:("PHA","IMP","","","",""),
73:("EOR","IMMED","LDA_A","OP_IMMED_F","STA_A",""),
74:("LSR","IMP","LDA_A","OP_IMP_F","STA_A",""),
76:("JMP","ABS","","","",""),
77:("EOR","ABS","","","",""),
78:("LSR","ABS","","","",""),
80:("BVC","REL","","","",""),
81:("EOR","IY","","","",""),
82:("EOR","IZP","","","",""),
85:("EOR","ZPX","","","",""),
86:("LSR","ZPX","","","",""),
88:("CLI","IMP","OP_F","","",""),
89:("EOR","ABSY","","","",""),
90:("PHY","IMP","","","",""),
93:("EOR","ABSX","","","",""),
94:("LSR","ABSX","","","",""),
96:("RTS","IMP","","","",""),
97:("ADC","IX","","","",""),
100:("STZ","ZP","LDA_0","STA_ZP","",""),
101:("ADC","ZP","LDA_A","OP_ZP_F","STA_A",""),
102:("ROR","ZP","LDA_ZP","OP_IMP_F","STA_ZP",""),
104:("PLA","IMP","","","",""),
105:("ADC","IMMED","LDA_A","OP_IMMED_F","STA_A",""),
106:("ROR","IMP","LDA_A","OP_IMP_F","STA_A",""),
108:("JMP","I","","","",""),
109:("ADC","ABS","","","",""),
110:("ROR","ABS","","","",""),
112:("BVS","REL","","","",""),
113:("ADC","IY","","","",""),
114:("ADC","IZP","","","",""),
116:("STZ","ZPX","","","",""),
117:("ADC","ZPX","","","",""),
118:("ROR","ZPX","","","",""),
120:("SEI","IMP","OP_F","","",""),
121:("ADC","ABSY","","","",""),
122:("PLY","IMP","","","",""),
124:("JMP","IAX","","","",""),
125:("ADC","ABSX","","","",""),
126:("ROR","ABSX","","","",""),
128:("BRA","REL","","","",""),
129:("STA","IX","","","",""),
132:("STY","ZP","LDA_Y","STA_ZP","",""),
133:("STA","ZP","LDA_A","STA_ZP","",""),
134:("STX","ZP","LDA_X","STA_ZP","",""),
136:("DEY","IMP","","","",""),
137:("BIT","IMMED","LDA_IMMED","STA_TEMP","LDA_A","BIT_TEMP_F"),
138:("TXA","IMP","","","",""),
140:("STY","ABS","","","",""),
141:("STA","ABS","","","",""),
142:("STX","ABS","","","",""),
144:("BCC","REL","","","",""),
145:("STA","IY","","","",""),
146:("STA","IZP","","","",""),
148:("STY","ZPX","","","",""),
149:("STA","ZPX","","","",""),
150:("STX","ZPY","","","",""),
152:("TYA","IMP","","","",""),
153:("STA","ABSY","","","",""),
154:("TXS","IMP","","","",""),
156:("STZ","ABS","","","",""),
157:("STA","ABSX","","","",""),
158:("STZ","ABSX","","","",""),
160:("LDY","IMMED","LDA_IMMED_F","STA_Y","",""),
161:("LDA","IX","","","",""),
162:("LDX","IMMED","LDA_IMMED_F","STA_X","",""),
164:("LDY","ZP","LDA_ZP_F","STA_Y","",""),
165:("LDA","ZP","LDA_ZP_F","STA_A","",""),
166:("LDX","ZP","LDA_ZP_F","STA_X","",""),
168:("TAY","IMP","","","",""),
169:("LDA","IMMED","LDA_IMMED_F","STA_A","",""),
170:("TAX","IMP","","","",""),
172:("LDY","ABS","","","",""),
173:("LDA","ABS","","","",""),
174:("LDX","ABS","","","",""),
176:("BCS","REL","","","",""),
177:("LDA","IY","","","",""),
178:("LDA","IZP","","","",""),
180:("LDY","ZPX","","","",""),
181:("LDA","ZPX","","","",""),
182:("LDX","ZPY","","","",""),
184:("CLV","IMP","OP_F","","",""),
185:("LDA","ABSY","","","",""),
186:("TSX","IMP","","","",""),
188:("LDY","ABSX","","","",""),
189:("LDA","ABSX","","","",""),
190:("LDX","ABSY","","","",""),
192:("CPY","IMMED","LDA_Y","CMP_IMMED_F","",""),
193:("CMP","IX","","","",""),
196:("CPY","ZP","LDA_Y","CMP_ZP_F","",""),
197:("CMP","ZP","LDA_A","CMP_ZP_F","",""),
198:("DEC","ZP","LDA_ZP","OP_IMP_F","STA_ZP",""),
200:("INY","IMP","","","",""),
201:("CMP","IMMED","LDA_A","CMP_IMMED_F","",""),
202:("DEX","IMP","","","",""),
204:("CPY","ABS","","","",""),
205:("CMP","ABS","","","",""),
206:("DEC","ABS","","","",""),
208:("BNE","REL","","","",""),
209:("CMP","IY","","","",""),
210:("CMP","IZP","","","",""),
213:("CMP","ZPX","","","",""),
214:("DEC","ZPX","","","",""),
216:("CLD","IMP","OP_F","","",""),
217:("CMP","ABSY","","","",""),
218:("PHX","IMP","","","",""),
221:("CMP","ABSX","","","",""),
222:("DEC","ABSX","","","",""),
224:("CPX","IMMED","LDA_X","CMP_IMMED_F","",""),
225:("SBC","IX","","","",""),
228:("CPX","ZP","LDA_X","CMP_ZP_F","",""),
229:("SBC","ZP","LDA_A","OP_ZP_F","STA_A",""),
230:("INC","ZP","LDA_ZP","OP_IMP_F","STA_ZP",""),
232:("INX","IMP","","","",""),
233:("SBC","IMMED","LDA_A","OP_IMMED_F","STA_A",""),
234:("NOP","IMP","","","",""),
236:("CPX","ABS","","","",""),
237:("SBC","ABS","","","",""),
238:("INC","ABS","","","",""),
240:("BEQ","REL","","","",""),
241:("SBC","IY","","","",""),
242:("SBC","IZP","","","",""),
245:("SBC","ZPX","","","",""),
246:("INC","ZPX","","","",""),
248:("SED","IMP","OP_F","","",""),
249:("SBC","ABSY","","","",""),
250:("PLX","IMP","","","",""),
253:("SBC","ABSX","","","",""),
254:("INC","ABSX","","","","")

}


OP_FULL_NAMES={}      
with open("instructions.asm","wt") as f:
    f.write("\t;Instruction routines\n")
    f.write("\tinstructions_begin:\n\n")
    for i in range(256):
        if i in OP_INFO:
            op_name=OP_INFO[i][0]
            op_mode=OP_INFO[i][1]
            op_full=op_name+"_"+op_mode
            f.write(f"\t;0x{hex(i)[2:].upper()} - {op_name} {op_mode}\n")
            f.write(f"\t{op_full}:\n")
            f.write(f'\t\tOP_MACRO {i}, {op_name}, {op_mode}, {op_full}, ')
            for j in range(2,6):
                f.write(str(OP_INFO[i][j])+", ")
            f.write("\n")
            f.write(f"\t\tNEXT_MACRO\n")
            f.write("\n")
        else:
            op_full="NOP_0x"+hex(i)[2:].upper()
            f.write(f"\t;0x{hex(i)[2:].upper()} - NOP\n")
            f.write(f"\t{op_full}:\n")
            f.write(f'\t\tOP_MACRO {i}, NOP, IMP, {op_full}, , , , , \n')
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