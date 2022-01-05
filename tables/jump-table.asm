	;Jump table
	JUMP_TABLE_LO:
	FCB lo(BRK_IMP)
	FCB lo(ORA_IX)
	FCB lo(NOP_0x2)
	FCB lo(NOP_0x3)
	FCB lo(NOP_0x4)
	FCB lo(ORA_ZP)
	FCB lo(ASL_ZP)
	FCB lo(NOP_0x7)
	FCB lo(PHP_IMP)
	FCB lo(ORA_IMMED)
	FCB lo(ASL_A)
	FCB lo(NOP_0xB)
	FCB lo(NOP_0xC)
	FCB lo(ORA_ABS)
	FCB lo(ASL_ABS)
	FCB lo(NOP_0xF)
	FCB lo(BPL_REL)
	FCB lo(ORA_IY)
	FCB lo(NOP_0x12)
	FCB lo(NOP_0x13)
	FCB lo(NOP_0x14)
	FCB lo(ORA_ZPX)
	FCB lo(ASL_ZPX)
	FCB lo(NOP_0x17)
	FCB lo(CLC_IMP)
	FCB lo(ORA_ABSY)
	FCB lo(NOP_0x1A)
	FCB lo(NOP_0x1B)
	FCB lo(NOP_0x1C)
	FCB lo(ORA_ABSX)
	FCB lo(ASL_ABSX)
	FCB lo(NOP_0x1F)
	FCB lo(JSR_ABS)
	FCB lo(AND_IX)
	FCB lo(NOP_0x22)
	FCB lo(NOP_0x23)
	FCB lo(BIT_ZP)
	FCB lo(AND_ZP)
	FCB lo(ROL_ZP)
	FCB lo(NOP_0x27)
	FCB lo(PLP_IMP)
	FCB lo(AND_IMMED)
	FCB lo(ROL_A)
	FCB lo(NOP_0x2B)
	FCB lo(BIT_ABS)
	FCB lo(AND_ABS)
	FCB lo(ROL_ABS)
	FCB lo(NOP_0x2F)
	FCB lo(BMI_REL)
	FCB lo(AND_IY)
	FCB lo(NOP_0x32)
	FCB lo(NOP_0x33)
	FCB lo(NOP_0x34)
	FCB lo(AND_ZPX)
	FCB lo(ROL_ZPX)
	FCB lo(NOP_0x37)
	FCB lo(SEC_IMP)
	FCB lo(AND_ABSY)
	FCB lo(NOP_0x3A)
	FCB lo(NOP_0x3B)
	FCB lo(NOP_0x3C)
	FCB lo(AND_ABSX)
	FCB lo(ROL_ABSX)
	FCB lo(NOP_0x3F)
	FCB lo(RTI_IMP)
	FCB lo(EOR_IX)
	FCB lo(NOP_0x42)
	FCB lo(NOP_0x43)
	FCB lo(NOP_0x44)
	FCB lo(EOR_ZP)
	FCB lo(LSR_ZP)
	FCB lo(NOP_0x47)
	FCB lo(PHA_IMP)
	FCB lo(EOR_IMMED)
	FCB lo(LSR_A)
	FCB lo(NOP_0x4B)
	FCB lo(JMP_ABS)
	FCB lo(EOR_ABS)
	FCB lo(LSR_ABS)
	FCB lo(NOP_0x4F)
	FCB lo(BVC_REL)
	FCB lo(EOR_IY)
	FCB lo(NOP_0x52)
	FCB lo(NOP_0x53)
	FCB lo(NOP_0x54)
	FCB lo(EOR_ZPX)
	FCB lo(LSR_ZPX)
	FCB lo(NOP_0x57)
	FCB lo(CLI_IMP)
	FCB lo(EOR_ABSY)
	FCB lo(NOP_0x5A)
	FCB lo(NOP_0x5B)
	FCB lo(NOP_0x5C)
	FCB lo(EOR_ABSX)
	FCB lo(LSR_ABSX)
	FCB lo(NOP_0x5F)
	FCB lo(RTS_IMP)
	FCB lo(ADC_IX)
	FCB lo(NOP_0x62)
	FCB lo(NOP_0x63)
	FCB lo(NOP_0x64)
	FCB lo(ADC_ZP)
	FCB lo(ROR_ZP)
	FCB lo(NOP_0x67)
	FCB lo(PLA_IMP)
	FCB lo(ADC_IMMED)
	FCB lo(ROR_A)
	FCB lo(NOP_0x6B)
	FCB lo(JMP_I)
	FCB lo(ADC_ABS)
	FCB lo(ROR_ABS)
	FCB lo(NOP_0x6F)
	FCB lo(BVS_REL)
	FCB lo(ADC_IY)
	FCB lo(NOP_0x72)
	FCB lo(NOP_0x73)
	FCB lo(NOP_0x74)
	FCB lo(ADC_ZPX)
	FCB lo(ROR_ZPX)
	FCB lo(NOP_0x77)
	FCB lo(SEI_IMP)
	FCB lo(ADC_ABSY)
	FCB lo(NOP_0x7A)
	FCB lo(NOP_0x7B)
	FCB lo(NOP_0x7C)
	FCB lo(ADC_ABSX)
	FCB lo(ROR_ABSX)
	FCB lo(NOP_0x7F)
	FCB lo(NOP_0x80)
	FCB lo(STA_IX)
	FCB lo(NOP_0x82)
	FCB lo(NOP_0x83)
	FCB lo(STY_ZP)
	FCB lo(STA_ZP)
	FCB lo(STX_ZP)
	FCB lo(NOP_0x87)
	FCB lo(DEY_IMP)
	FCB lo(NOP_0x89)
	FCB lo(TXA_IMP)
	FCB lo(NOP_0x8B)
	FCB lo(STY_ABS)
	FCB lo(STA_ABS)
	FCB lo(STX_ABS)
	FCB lo(NOP_0x8F)
	FCB lo(BCC_REL)
	FCB lo(STA_IY)
	FCB lo(NOP_0x92)
	FCB lo(NOP_0x93)
	FCB lo(STY_ZPX)
	FCB lo(STA_ZPX)
	FCB lo(STX_ZPY)
	FCB lo(NOP_0x97)
	FCB lo(TYA_IMP)
	FCB lo(STA_ABSY)
	FCB lo(TXS_IMP)
	FCB lo(NOP_0x9B)
	FCB lo(NOP_0x9C)
	FCB lo(STA_ABSX)
	FCB lo(NOP_0x9E)
	FCB lo(NOP_0x9F)
	FCB lo(LDY_IMMED)
	FCB lo(LDA_IX)
	FCB lo(LDX_IMMED)
	FCB lo(NOP_0xA3)
	FCB lo(LDY_ZP)
	FCB lo(LDA_ZP)
	FCB lo(LDX_ZP)
	FCB lo(NOP_0xA7)
	FCB lo(TAY_IMP)
	FCB lo(LDA_IMMED)
	FCB lo(TAX_IMP)
	FCB lo(NOP_0xAB)
	FCB lo(LDY_ABS)
	FCB lo(LDA_ABS)
	FCB lo(LDX_ABS)
	FCB lo(NOP_0xAF)
	FCB lo(BCS_REL)
	FCB lo(LDA_IY)
	FCB lo(NOP_0xB2)
	FCB lo(NOP_0xB3)
	FCB lo(LDY_ZPX)
	FCB lo(LDA_ZPX)
	FCB lo(LDX_ZPY)
	FCB lo(NOP_0xB7)
	FCB lo(CLV_IMP)
	FCB lo(LDA_ABSY)
	FCB lo(TSX_IMP)
	FCB lo(NOP_0xBB)
	FCB lo(LDY_ABSX)
	FCB lo(LDA_ABSX)
	FCB lo(LDX_ABSY)
	FCB lo(NOP_0xBF)
	FCB lo(CPY_IMMED)
	FCB lo(CMP_IX)
	FCB lo(NOP_0xC2)
	FCB lo(NOP_0xC3)
	FCB lo(CPY_ZP)
	FCB lo(CMP_ZP)
	FCB lo(DEC_ZP)
	FCB lo(NOP_0xC7)
	FCB lo(INY_IMP)
	FCB lo(CMP_IMMED)
	FCB lo(DEX_IMP)
	FCB lo(NOP_0xCB)
	FCB lo(CPY_ABS)
	FCB lo(CMP_ABS)
	FCB lo(DEC_ABS)
	FCB lo(NOP_0xCF)
	FCB lo(BNE_REL)
	FCB lo(CMP_IY)
	FCB lo(NOP_0xD2)
	FCB lo(NOP_0xD3)
	FCB lo(NOP_0xD4)
	FCB lo(CMP_ZPX)
	FCB lo(DEC_ZPX)
	FCB lo(NOP_0xD7)
	FCB lo(CLD_IMP)
	FCB lo(CMP_ABSY)
	FCB lo(NOP_0xDA)
	FCB lo(NOP_0xDB)
	FCB lo(NOP_0xDC)
	FCB lo(CMP_ABSX)
	FCB lo(DEC_ABSX)
	FCB lo(NOP_0xDF)
	FCB lo(CPX_IMMED)
	FCB lo(SBC_IX)
	FCB lo(NOP_0xE2)
	FCB lo(NOP_0xE3)
	FCB lo(CPX_ZP)
	FCB lo(SBC_ZP)
	FCB lo(INC_ZP)
	FCB lo(NOP_0xE7)
	FCB lo(INX_IMP)
	FCB lo(SBC_IMMED)
	FCB lo(NOP_IMP)
	FCB lo(NOP_0xEB)
	FCB lo(CPX_ABS)
	FCB lo(SBC_ABS)
	FCB lo(INC_ABS)
	FCB lo(NOP_0xEF)
	FCB lo(BEQ_REL)
	FCB lo(SBC_IY)
	FCB lo(NOP_0xF2)
	FCB lo(NOP_0xF3)
	FCB lo(NOP_0xF4)
	FCB lo(SBC_ZPX)
	FCB lo(INC_ZPX)
	FCB lo(NOP_0xF7)
	FCB lo(SED_IMP)
	FCB lo(SBC_ABSY)
	FCB lo(NOP_0xFA)
	FCB lo(NOP_0xFB)
	FCB lo(NOP_0xFC)
	FCB lo(SBC_ABSX)
	FCB lo(INC_ABSX)
	FCB lo(NOP_0xFF)

	JUMP_TABLE_HI:
	FCB hi(BRK_IMP)
	FCB hi(ORA_IX)
	FCB hi(NOP_0x2)
	FCB hi(NOP_0x3)
	FCB hi(NOP_0x4)
	FCB hi(ORA_ZP)
	FCB hi(ASL_ZP)
	FCB hi(NOP_0x7)
	FCB hi(PHP_IMP)
	FCB hi(ORA_IMMED)
	FCB hi(ASL_A)
	FCB hi(NOP_0xB)
	FCB hi(NOP_0xC)
	FCB hi(ORA_ABS)
	FCB hi(ASL_ABS)
	FCB hi(NOP_0xF)
	FCB hi(BPL_REL)
	FCB hi(ORA_IY)
	FCB hi(NOP_0x12)
	FCB hi(NOP_0x13)
	FCB hi(NOP_0x14)
	FCB hi(ORA_ZPX)
	FCB hi(ASL_ZPX)
	FCB hi(NOP_0x17)
	FCB hi(CLC_IMP)
	FCB hi(ORA_ABSY)
	FCB hi(NOP_0x1A)
	FCB hi(NOP_0x1B)
	FCB hi(NOP_0x1C)
	FCB hi(ORA_ABSX)
	FCB hi(ASL_ABSX)
	FCB hi(NOP_0x1F)
	FCB hi(JSR_ABS)
	FCB hi(AND_IX)
	FCB hi(NOP_0x22)
	FCB hi(NOP_0x23)
	FCB hi(BIT_ZP)
	FCB hi(AND_ZP)
	FCB hi(ROL_ZP)
	FCB hi(NOP_0x27)
	FCB hi(PLP_IMP)
	FCB hi(AND_IMMED)
	FCB hi(ROL_A)
	FCB hi(NOP_0x2B)
	FCB hi(BIT_ABS)
	FCB hi(AND_ABS)
	FCB hi(ROL_ABS)
	FCB hi(NOP_0x2F)
	FCB hi(BMI_REL)
	FCB hi(AND_IY)
	FCB hi(NOP_0x32)
	FCB hi(NOP_0x33)
	FCB hi(NOP_0x34)
	FCB hi(AND_ZPX)
	FCB hi(ROL_ZPX)
	FCB hi(NOP_0x37)
	FCB hi(SEC_IMP)
	FCB hi(AND_ABSY)
	FCB hi(NOP_0x3A)
	FCB hi(NOP_0x3B)
	FCB hi(NOP_0x3C)
	FCB hi(AND_ABSX)
	FCB hi(ROL_ABSX)
	FCB hi(NOP_0x3F)
	FCB hi(RTI_IMP)
	FCB hi(EOR_IX)
	FCB hi(NOP_0x42)
	FCB hi(NOP_0x43)
	FCB hi(NOP_0x44)
	FCB hi(EOR_ZP)
	FCB hi(LSR_ZP)
	FCB hi(NOP_0x47)
	FCB hi(PHA_IMP)
	FCB hi(EOR_IMMED)
	FCB hi(LSR_A)
	FCB hi(NOP_0x4B)
	FCB hi(JMP_ABS)
	FCB hi(EOR_ABS)
	FCB hi(LSR_ABS)
	FCB hi(NOP_0x4F)
	FCB hi(BVC_REL)
	FCB hi(EOR_IY)
	FCB hi(NOP_0x52)
	FCB hi(NOP_0x53)
	FCB hi(NOP_0x54)
	FCB hi(EOR_ZPX)
	FCB hi(LSR_ZPX)
	FCB hi(NOP_0x57)
	FCB hi(CLI_IMP)
	FCB hi(EOR_ABSY)
	FCB hi(NOP_0x5A)
	FCB hi(NOP_0x5B)
	FCB hi(NOP_0x5C)
	FCB hi(EOR_ABSX)
	FCB hi(LSR_ABSX)
	FCB hi(NOP_0x5F)
	FCB hi(RTS_IMP)
	FCB hi(ADC_IX)
	FCB hi(NOP_0x62)
	FCB hi(NOP_0x63)
	FCB hi(NOP_0x64)
	FCB hi(ADC_ZP)
	FCB hi(ROR_ZP)
	FCB hi(NOP_0x67)
	FCB hi(PLA_IMP)
	FCB hi(ADC_IMMED)
	FCB hi(ROR_A)
	FCB hi(NOP_0x6B)
	FCB hi(JMP_I)
	FCB hi(ADC_ABS)
	FCB hi(ROR_ABS)
	FCB hi(NOP_0x6F)
	FCB hi(BVS_REL)
	FCB hi(ADC_IY)
	FCB hi(NOP_0x72)
	FCB hi(NOP_0x73)
	FCB hi(NOP_0x74)
	FCB hi(ADC_ZPX)
	FCB hi(ROR_ZPX)
	FCB hi(NOP_0x77)
	FCB hi(SEI_IMP)
	FCB hi(ADC_ABSY)
	FCB hi(NOP_0x7A)
	FCB hi(NOP_0x7B)
	FCB hi(NOP_0x7C)
	FCB hi(ADC_ABSX)
	FCB hi(ROR_ABSX)
	FCB hi(NOP_0x7F)
	FCB hi(NOP_0x80)
	FCB hi(STA_IX)
	FCB hi(NOP_0x82)
	FCB hi(NOP_0x83)
	FCB hi(STY_ZP)
	FCB hi(STA_ZP)
	FCB hi(STX_ZP)
	FCB hi(NOP_0x87)
	FCB hi(DEY_IMP)
	FCB hi(NOP_0x89)
	FCB hi(TXA_IMP)
	FCB hi(NOP_0x8B)
	FCB hi(STY_ABS)
	FCB hi(STA_ABS)
	FCB hi(STX_ABS)
	FCB hi(NOP_0x8F)
	FCB hi(BCC_REL)
	FCB hi(STA_IY)
	FCB hi(NOP_0x92)
	FCB hi(NOP_0x93)
	FCB hi(STY_ZPX)
	FCB hi(STA_ZPX)
	FCB hi(STX_ZPY)
	FCB hi(NOP_0x97)
	FCB hi(TYA_IMP)
	FCB hi(STA_ABSY)
	FCB hi(TXS_IMP)
	FCB hi(NOP_0x9B)
	FCB hi(NOP_0x9C)
	FCB hi(STA_ABSX)
	FCB hi(NOP_0x9E)
	FCB hi(NOP_0x9F)
	FCB hi(LDY_IMMED)
	FCB hi(LDA_IX)
	FCB hi(LDX_IMMED)
	FCB hi(NOP_0xA3)
	FCB hi(LDY_ZP)
	FCB hi(LDA_ZP)
	FCB hi(LDX_ZP)
	FCB hi(NOP_0xA7)
	FCB hi(TAY_IMP)
	FCB hi(LDA_IMMED)
	FCB hi(TAX_IMP)
	FCB hi(NOP_0xAB)
	FCB hi(LDY_ABS)
	FCB hi(LDA_ABS)
	FCB hi(LDX_ABS)
	FCB hi(NOP_0xAF)
	FCB hi(BCS_REL)
	FCB hi(LDA_IY)
	FCB hi(NOP_0xB2)
	FCB hi(NOP_0xB3)
	FCB hi(LDY_ZPX)
	FCB hi(LDA_ZPX)
	FCB hi(LDX_ZPY)
	FCB hi(NOP_0xB7)
	FCB hi(CLV_IMP)
	FCB hi(LDA_ABSY)
	FCB hi(TSX_IMP)
	FCB hi(NOP_0xBB)
	FCB hi(LDY_ABSX)
	FCB hi(LDA_ABSX)
	FCB hi(LDX_ABSY)
	FCB hi(NOP_0xBF)
	FCB hi(CPY_IMMED)
	FCB hi(CMP_IX)
	FCB hi(NOP_0xC2)
	FCB hi(NOP_0xC3)
	FCB hi(CPY_ZP)
	FCB hi(CMP_ZP)
	FCB hi(DEC_ZP)
	FCB hi(NOP_0xC7)
	FCB hi(INY_IMP)
	FCB hi(CMP_IMMED)
	FCB hi(DEX_IMP)
	FCB hi(NOP_0xCB)
	FCB hi(CPY_ABS)
	FCB hi(CMP_ABS)
	FCB hi(DEC_ABS)
	FCB hi(NOP_0xCF)
	FCB hi(BNE_REL)
	FCB hi(CMP_IY)
	FCB hi(NOP_0xD2)
	FCB hi(NOP_0xD3)
	FCB hi(NOP_0xD4)
	FCB hi(CMP_ZPX)
	FCB hi(DEC_ZPX)
	FCB hi(NOP_0xD7)
	FCB hi(CLD_IMP)
	FCB hi(CMP_ABSY)
	FCB hi(NOP_0xDA)
	FCB hi(NOP_0xDB)
	FCB hi(NOP_0xDC)
	FCB hi(CMP_ABSX)
	FCB hi(DEC_ABSX)
	FCB hi(NOP_0xDF)
	FCB hi(CPX_IMMED)
	FCB hi(SBC_IX)
	FCB hi(NOP_0xE2)
	FCB hi(NOP_0xE3)
	FCB hi(CPX_ZP)
	FCB hi(SBC_ZP)
	FCB hi(INC_ZP)
	FCB hi(NOP_0xE7)
	FCB hi(INX_IMP)
	FCB hi(SBC_IMMED)
	FCB hi(NOP_IMP)
	FCB hi(NOP_0xEB)
	FCB hi(CPX_ABS)
	FCB hi(SBC_ABS)
	FCB hi(INC_ABS)
	FCB hi(NOP_0xEF)
	FCB hi(BEQ_REL)
	FCB hi(SBC_IY)
	FCB hi(NOP_0xF2)
	FCB hi(NOP_0xF3)
	FCB hi(NOP_0xF4)
	FCB hi(SBC_ZPX)
	FCB hi(INC_ZPX)
	FCB hi(NOP_0xF7)
	FCB hi(SED_IMP)
	FCB hi(SBC_ABSY)
	FCB hi(NOP_0xFA)
	FCB hi(NOP_0xFB)
	FCB hi(NOP_0xFC)
	FCB hi(SBC_ABSX)
	FCB hi(INC_ABSX)
	FCB hi(NOP_0xFF)
