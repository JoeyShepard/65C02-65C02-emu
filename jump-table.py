#Generated by spreadsheet - no need to edit manually
OP_INFO = { 

0:("BRK","IMP","BRK_IMP","","",""),
1:("ORA","IX","LDA_A","OP_ADDRESS_F","STA_A",""),
4:("TSB","ZP","TSB_ZP","","",""),
5:("ORA","ZP","LDA_A","OP_ZP_F","STA_A",""),
6:("ASL","ZP","LDA_ZP","OP_IMP_F","STA_ZP",""),
7:("RMB0","ZP","LDA_BIT0_INV","AND_ZP","STA_ZP",""),
8:("PHP","IMP","PLA_PHA","PUSH","",""),
9:("ORA","IMMED","LDA_A","OP_IMMED_F","STA_A",""),
10:("ASL","IMP","LDA_A","OP_IMP_F","STA_A",""),
12:("TSB","ABS","TSB_ABS","","",""),
13:("ORA","ABS","LDA_A","OP_ADDRESS_F","STA_A",""),
14:("ASL","ABS","LDA_ADDRESS","OP_IMP_F","STA_ADDRESS",""),
15:("BBR0","ZP","LDA_BIT0","BBR_BB","",""),
16:("BPL","REL","BRANCH_REL","","",""),
17:("ORA","IY","LDA_A","OP_ADDRESS_F","STA_A",""),
18:("ORA","IZP","LDA_A","OP_ADDRESS_F","STA_A",""),
20:("TRB","ZP","TRB_ZP","","",""),
21:("ORA","ZPX","LDA_A","OP_ZP_F","STA_A",""),
22:("ASL","ZPX","LDA_ZP","OP_IMP_F","STA_ZP",""),
23:("RMB1","ZP","LDA_BIT1_INV","AND_ZP","STA_ZP",""),
24:("CLC","IMP","OP_F","","",""),
25:("ORA","ABSY","LDA_A","OP_ADDRESS_F","STA_A",""),
26:("INC","IMP","LDA_A","OP_IMP_F","STA_A",""),
28:("TRB","ABS","TRB_ABS","","",""),
29:("ORA","ABSX","LDA_A","OP_ADDRESS_F","STA_A",""),
30:("ASL","ABSX","LDA_ADDRESS","OP_IMP_F","STA_ADDRESS",""),
31:("BBR1","ZP","LDA_BIT1","BBR_BB","",""),
32:("JSR","ABS_CUST","JSR_ABS","","",""),
33:("AND","IX","LDA_A","OP_ADDRESS_F","STA_A",""),
36:("BIT","ZP","LDA_ZP","STA_TEMP","LDA_A","BIT_TEMP_F"),
37:("AND","ZP","LDA_A","OP_ZP_F","STA_A",""),
38:("ROL","ZP","LDA_ZP","OP_IMP_F","STA_ZP",""),
39:("RMB2","ZP","LDA_BIT2_INV","AND_ZP","STA_ZP",""),
40:("PLP","IMP","PLP_IMP","","",""),
41:("AND","IMMED","LDA_A","OP_IMMED_F","STA_A",""),
42:("ROL","IMP","LDA_A","OP_IMP_F","STA_A",""),
44:("BIT","ABS","LDA_ADDRESS","STA_TEMP","LDA_A","BIT_TEMP_F"),
45:("AND","ABS","LDA_A","OP_ADDRESS_F","STA_A",""),
46:("ROL","ABS","LDA_ADDRESS","OP_IMP_F","STA_ADDRESS",""),
47:("BBR2","ZP","LDA_BIT2","BBR_BB","",""),
48:("BMI","REL","BRANCH_REL","","",""),
49:("AND","IY","LDA_A","OP_ADDRESS_F","STA_A",""),
50:("AND","IZP","LDA_A","OP_ADDRESS_F","STA_A",""),
52:("BIT","ZPX","LDA_ZP","STA_TEMP","LDA_A","BIT_TEMP_F"),
53:("AND","ZPX","LDA_A","OP_ZP_F","STA_A",""),
54:("ROL","ZPX","LDA_ZP","OP_IMP_F","STA_ZP",""),
55:("RMB3","ZP","LDA_BIT3_INV","AND_ZP","STA_ZP",""),
56:("SEC","IMP","OP_F","","",""),
57:("AND","ABSY","LDA_A","OP_ADDRESS_F","STA_A",""),
58:("DEC","IMP","LDA_A","OP_IMP_F","STA_A",""),
60:("BIT","ABSX","LDA_ADDRESS","STA_TEMP","LDA_A","BIT_TEMP_F"),
61:("AND","ABSX","LDA_A","OP_ADDRESS_F","STA_A",""),
62:("ROL","ABSX","LDA_ADDRESS","OP_IMP_F","STA_ADDRESS",""),
63:("BBR3","ZP","LDA_BIT3","BBR_BB","",""),
64:("RTI","IMP","UNIMPLEMENTED","","",""),
65:("EOR","IX","LDA_A","OP_ADDRESS_F","STA_A",""),
69:("EOR","ZP","LDA_A","OP_ZP_F","STA_A",""),
70:("LSR","ZP","LDA_ZP","OP_IMP_F","STA_ZP",""),
71:("RMB4","ZP","LDA_BIT4_INV","AND_ZP","STA_ZP",""),
72:("PHA","IMP","LDA_A","PUSH","",""),
73:("EOR","IMMED","LDA_A","OP_IMMED_F","STA_A",""),
74:("LSR","IMP","LDA_A","OP_IMP_F","STA_A",""),
76:("JMP","ABS_CUST","JMP_ABS","","",""),
77:("EOR","ABS","LDA_A","OP_ADDRESS_F","STA_A",""),
78:("LSR","ABS","LDA_ADDRESS","OP_IMP_F","STA_ADDRESS",""),
79:("BBR4","ZP","LDA_BIT4","BBR_BB","",""),
80:("BVC","REL","BRANCH_REL","","",""),
81:("EOR","IY","LDA_A","OP_ADDRESS_F","STA_A",""),
82:("EOR","IZP","LDA_A","OP_ADDRESS_F","STA_A",""),
85:("EOR","ZPX","LDA_A","OP_ZP_F","STA_A",""),
86:("LSR","ZPX","LDA_ZP","OP_IMP_F","STA_ZP",""),
87:("RMB5","ZP","LDA_BIT5_INV","AND_ZP","STA_ZP",""),
88:("CLI","IMP","OP_F","","",""),
89:("EOR","ABSY","LDA_A","OP_ADDRESS_F","STA_A",""),
90:("PHY","IMP","LDA_A","PUSH","",""),
93:("EOR","ABSX","LDA_A","OP_ADDRESS_F","STA_A",""),
94:("LSR","ABSX","LDA_ADDRESS","OP_IMP_F","STA_ADDRESS",""),
95:("BBR5","ZP","LDA_BIT5","BBR_BB","",""),
96:("RTS","IMP","RTS_IMP","","",""),
97:("ADC","IX","LDA_A","OP_ADDRESS_F","STA_A",""),
100:("STZ","ZP","LDA_0","STA_ZP","",""),
101:("ADC","ZP","LDA_A","OP_ZP_F","STA_A",""),
102:("ROR","ZP","LDA_ZP","OP_IMP_F","STA_ZP",""),
103:("RMB6","ZP","LDA_BIT6_INV","AND_ZP","STA_ZP",""),
104:("PLA","IMP","PULL_F","STA_A","",""),
105:("ADC","IMMED","LDA_A","OP_IMMED_F","STA_A",""),
106:("ROR","IMP","LDA_A","OP_IMP_F","STA_A",""),
108:("JMP","INDIRECT_CUST","JMP_INDIRECT","","",""),
109:("ADC","ABS","LDA_A","OP_ADDRESS_F","STA_A",""),
110:("ROR","ABS","LDA_ADDRESS","OP_IMP_F","STA_ADDRESS",""),
111:("BBR6","ZP","LDA_BIT6","BBR_BB","",""),
112:("BVS","REL","BRANCH_REL","","",""),
113:("ADC","IY","LDA_A","OP_ADDRESS_F","STA_A",""),
114:("ADC","IZP","LDA_A","OP_ADDRESS_F","STA_A",""),
116:("STZ","ZPX","LDA_0","STA_ZP","",""),
117:("ADC","ZPX","LDA_A","OP_ZP_F","STA_A",""),
118:("ROR","ZPX","LDA_ZP","OP_IMP_F","STA_ZP",""),
119:("RMB7","ZP","LDA_BIT7_INV","AND_ZP","STA_ZP",""),
120:("SEI","IMP","OP_F","","",""),
121:("ADC","ABSY","LDA_A","OP_ADDRESS_F","STA_A",""),
122:("PLY","IMP","PULL_F","STA_Y","",""),
124:("JMP","IAX_CUST","JMP_IAX","","",""),
125:("ADC","ABSX","LDA_A","OP_ADDRESS_F","STA_A",""),
126:("ROR","ABSX","LDA_ADDRESS","OP_IMP_F","STA_ADDRESS",""),
127:("BBR7","ZP","LDA_BIT7","BBR_BB","",""),
128:("BRA","REL","BRANCH_REL","","",""),
129:("STA","IX","LDA_A","STA_ADDRESS","",""),
132:("STY","ZP","LDA_Y","STA_ZP","",""),
133:("STA","ZP","LDA_A","STA_ZP","",""),
134:("STX","ZP","LDA_X","STA_ZP","",""),
135:("SMB0","ZP","LDA_BIT0","ORA_ZP","STA_ZP",""),
136:("DEY","IMP","DEY_F","","",""),
137:("BIT","IMMED","LDA_A","BIT_IMMED_F","",""),
138:("TXA","IMP","LDA_X_F","STA_A","",""),
140:("STY","ABS","LDA_Y","STA_ADDRESS","",""),
141:("STA","ABS","LDA_A","STA_ADDRESS","",""),
142:("STX","ABS","LDA_X","STA_ADDRESS","",""),
143:("BBS0","ZP","LDA_BIT0","BBS_BB","",""),
144:("BCC","REL","BRANCH_REL","","",""),
145:("STA","IY","LDA_A","STA_ADDRESS","",""),
146:("STA","IZP","LDA_A","STA_ADDRESS","",""),
148:("STY","ZPX","LDA_Y","STA_ZP","",""),
149:("STA","ZPX","LDA_A","STA_ZP","",""),
150:("STX","ZPY","LDA_X","STA_ZP","",""),
151:("SMB1","ZP","LDA_BIT1","ORA_ZP","STA_ZP",""),
152:("TYA","IMP","LDA_Y_F","STA_A","",""),
153:("STA","ABSY","LDA_A","STA_ADDRESS","",""),
154:("TXS","IMP","LDA_X","STA_SP","",""),
156:("STZ","ABS","LDA_0","STA_ADDRESS","",""),
157:("STA","ABSX","LDA_A","STA_ADDRESS","",""),
158:("STZ","ABSX","LDA_0","STA_ADDRESS","",""),
159:("BBS1","ZP","LDA_BIT1","BBS_BB","",""),
160:("LDY","IMMED","LDA_IMMED_F","STA_Y","",""),
161:("LDA","IX","LDA_ADDRESS_F","STA_A","",""),
162:("LDX","IMMED","LDA_IMMED_F","STA_X","",""),
164:("LDY","ZP","LDA_ZP_F","STA_Y","",""),
165:("LDA","ZP","LDA_ZP_F","STA_A","",""),
166:("LDX","ZP","LDA_ZP_F","STA_X","",""),
167:("SMB2","ZP","LDA_BIT2","ORA_ZP","STA_ZP",""),
168:("TAY","IMP","LDA_A_F","STA_Y","",""),
169:("LDA","IMMED","LDA_IMMED_F","STA_A","",""),
170:("TAX","IMP","LDA_A_F","STA_X","",""),
172:("LDY","ABS","LDA_ADDRESS_F","STA_Y","",""),
173:("LDA","ABS","LDA_ADDRESS_F","STA_A","",""),
174:("LDX","ABS","LDA_ADDRESS_F","STA_X","",""),
175:("BBS2","ZP","LDA_BIT2","BBS_BB","",""),
176:("BCS","REL","BRANCH_REL","","",""),
177:("LDA","IY","LDA_ADDRESS_F","STA_A","",""),
178:("LDA","IZP","LDA_ADDRESS_F","STA_A","",""),
180:("LDY","ZPX","LDA_ZP_F","STA_Y","",""),
181:("LDA","ZPX","LDA_ZP_F","STA_A","",""),
182:("LDX","ZPY","LDA_ZP_F","STA_X","",""),
183:("SMB3","ZP","LDA_BIT3","ORA_ZP","STA_ZP",""),
184:("CLV","IMP","OP_F","","",""),
185:("LDA","ABSY","LDA_ADDRESS_F","STA_A","",""),
186:("TSX","IMP","LDA_SP_F","STA_X","",""),
188:("LDY","ABSX","LDA_ADDRESS_F","STA_Y","",""),
189:("LDA","ABSX","LDA_ADDRESS_F","STA_A","",""),
190:("LDX","ABSY","LDA_ADDRESS_F","STA_X","",""),
191:("BBS3","ZP","LDA_BIT3","BBS_BB","",""),
192:("CPY","IMMED","LDA_Y","CMP_IMMED_F","",""),
193:("CMP","IX","LDA_A","CMP_ADDRESS_F","",""),
196:("CPY","ZP","LDA_Y","CMP_ZP_F","",""),
197:("CMP","ZP","LDA_A","CMP_ZP_F","",""),
198:("DEC","ZP","LDA_ZP","OP_IMP_F","STA_ZP",""),
199:("SMB4","ZP","LDA_BIT4","ORA_ZP","STA_ZP",""),
200:("INY","IMP","INY_F","","",""),
201:("CMP","IMMED","LDA_A","CMP_IMMED_F","",""),
202:("DEX","IMP","DEX_F","","",""),
203:("WAI","IMP","UNIMPLEMENTED","","",""),
204:("CPY","ABS","LDA_Y","CMP_ADDRESS_F","",""),
205:("CMP","ABS","LDA_A","CMP_ADDRESS_F","",""),
206:("DEC","ABS","LDA_ADDRESS","OP_IMP_F","STA_ADDRESS",""),
207:("BBS4","ZP","LDA_BIT4","BBS_BB","",""),
208:("BNE","REL","BRANCH_REL","","",""),
209:("CMP","IY","LDA_A","CMP_ADDRESS_F","",""),
210:("CMP","IZP","LDA_A","CMP_ADDRESS_F","",""),
213:("CMP","ZPX","LDA_A","CMP_ZP_F","",""),
214:("DEC","ZPX","LDA_ZP","OP_IMP_F","STA_ZP",""),
215:("SMB5","ZP","LDA_BIT5","ORA_ZP","STA_ZP",""),
216:("CLD","IMP","OP_F","","",""),
217:("CMP","ABSY","LDA_A","CMP_ADDRESS_F","",""),
218:("PHX","IMP","LDA_A","PUSH","",""),
219:("STP","IMP","UNIMPLEMENTED","","",""),
221:("CMP","ABSX","LDA_A","CMP_ADDRESS_F","",""),
222:("DEC","ABSX","LDA_ADDRESS","OP_IMP_F","STA_ADDRESS",""),
223:("BBS5","ZP","LDA_BIT5","BBS_BB","",""),
224:("CPX","IMMED","LDA_X","CMP_IMMED_F","",""),
225:("SBC","IX","LDA_A","OP_ADDRESS_F","STA_A",""),
228:("CPX","ZP","LDA_X","CMP_ZP_F","",""),
229:("SBC","ZP","LDA_A","OP_ZP_F","STA_A",""),
230:("INC","ZP","LDA_ZP","OP_IMP_F","STA_ZP",""),
231:("SMB6","ZP","LDA_BIT6","ORA_ZP","STA_ZP",""),
232:("INX","IMP","INX_F","","",""),
233:("SBC","IMMED","LDA_A","OP_IMMED_F","STA_A",""),
234:("NOP","IMP","","","",""),
236:("CPX","ABS","LDA_X","CMP_ADDRESS_F","",""),
237:("SBC","ABS","LDA_A","OP_ADDRESS_F","STA_A",""),
238:("INC","ABS","LDA_ADDRESS","OP_IMP_F","STA_ADDRESS",""),
239:("BBS6","ZP","LDA_BIT6","BBS_BB","",""),
240:("BEQ","REL","BRANCH_REL","","",""),
241:("SBC","IY","LDA_A","OP_ADDRESS_F","STA_A",""),
242:("SBC","IZP","LDA_A","OP_ADDRESS_F","STA_A",""),
245:("SBC","ZPX","LDA_A","OP_ZP_F","STA_A",""),
246:("INC","ZPX","LDA_ZP","OP_IMP_F","STA_ZP",""),
247:("SMB7","ZP","LDA_BIT7","ORA_ZP","STA_ZP",""),
248:("SED","IMP","SED_F","","",""),
249:("SBC","ABSY","LDA_A","OP_ADDRESS_F","STA_A",""),
250:("PLX","IMP","PULL_F","STA_X","",""),
253:("SBC","ABSX","LDA_A","OP_ADDRESS_F","STA_A",""),
254:("INC","ABSX","LDA_ADDRESS","OP_IMP_F","STA_ADDRESS",""),
255:("BBS7","ZP","LDA_BIT7","BBS_BB","","")

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