;Defining constants - looks better than not allowing indentation
DEFINE MACRO symbol, value
symbol set value
	ENDM

DEFINE_EQU MACRO symbol, value
symbol equ value
	ENDM

;Zero page variables
ZP_START MACRO ptr
	DEFINE zp_begin, ptr
	DEFINE zp_address, ptr
	ENDM
			
ZP MACRO var
	DEFINE var, zp_address
	DEFINE zp_address, zp_address+1
	ENDM
	
ZP_END MACRO
	DEFINE zp_end, zp_address
	DEFINE zp_size, zp_address-zp_begin
	ENDM
	
;Local variables - each emu level gets a copy
	DEFINE locals_block_counter, 0

LOCALS_START MACRO ptr
	DEFINE locals_begin, ptr
	DEFINE local_address, ptr
	ENDM

LOCAL MACRO var
	DEFINE var, local_address
	DEFINE local_address, local_address+1
	ENDM

LOCALS_END MACRO
	DEFINE locals_end, local_address
	DEFINE locals_size, locals_end-locals_begin
	DEFINE locals_block_counter, locals_block_counter+1
	DEFINE temp, "\{locals_block_counter}"
	DEFINE_EQU locals_end_{temp}, *
	ENDM



;Advance emulated PC
PC_NEXT MACRO
	INC emu_PC,X
	BNE .skip
		INC emu_PC_hi,X
	.skip:
	ENDM

;Emulator instruction steps
PRE_OP MACRO amode
	SWITCH "amode"
	CASE "IMP"
		;Nothing to do!
	CASE "IMMED"
		PC_NEXT
	CASE "ZP"
		PC_NEXT
		LDA (emu_PC,X)
		STA emu_ZP,X
	CASE "ZPX"
		PC_NEXT
		LDA (emu_PC,X)
		CLC
		ADC emu_X,X
		STA emu_ZP,X
	CASE "ZPY"
		PC_NEXT
		LDA (emu_PC,X)
		CLC
		ADC emu_Y,X
		STA emu_ZP,X
	CASE "ABS"
		PC_NEXT
		LDA (emu_PC,X)
		STA emu_address,X
		PC_NEXT
		LDA (emu_PC,X)
		STA emu_address_hi,X
	CASE "ABSX"
		PC_NEXT
		LDA (emu_PC,X)
		CLC
		ADC emu_X,X
		STA emu_address,X
		PC_NEXT
		LDA (emu_PC,X)
		ADC #0
		STA emu_address_hi,X
	CASE "ABSY"
		PC_NEXT
		LDA (emu_PC,X)
		CLC
		ADC emu_Y,X
		STA emu_address,X
		PC_NEXT
		LDA (emu_PC,X)
		ADC #0
		STA emu_address_hi,X
	CASE "IZP"
		PC_NEXT
		LDA (emu_PC,X)
		STA emu_ZP,X
		LDA (emu_ZP,X)
		STA emu_address,X
		INC emu_ZP,X
		LDA (emu_ZP,X)
		STA emu_address_hi,X
	CASE "IX"
		PC_NEXT
		LDA (emu_PC,X)
		CLC
		ADC emu_X,X
		STA emu_ZP,X
		LDA (emu_ZP,X)
		STA emu_address,X
		INC emu_ZP,X
		LDA (emu_ZP,X)
		STA emu_address_hi,X
	CASE "IY"
		PC_NEXT
		LDA (emu_PC,X)
		STA emu_ZP,X
		LDA (emu_ZP,X)
		CLC
		ADC emu_Y,X
		STA emu_address,X
		INC emu_ZP,X
		LDA (emu_ZP,X)
		ADC #0
		STA emu_address_hi,X
	CASE "REL"
		PC_NEXT
	CASE "ABS_CUST"
		;Let JMP and JSR handle PC in OP_STEP below
	CASE "INDIRECT_CUST"
		;Let JMP (Absolute) handle PC in OP_STEP below
	CASE "IAX_CUST"
		;Let JMP (Absolute,X) handle PC in OP_STEP below
	ELSECASE
		fatal "Addressing mode not found: amode"
	ENDCASE
	ENDM

BRANCH_MACRO MACRO
	LDY #0
	LDA (emu_PC,X)
	BPL .positive
	LDY #$FF
	.positive:
	CLC
	ADC emu_PC,X
	STA emu_PC,X
	TYA
	ADC emu_PC_hi,X
	STA emu_PC_hi
	ENDM
	
OP_STEP MACRO op, stepname	

	SWITCH "stepname"
	CASE "BBR_BB"
		PC_NEXT
		AND (emu_ZP,X)
		BNE .skip
			BRANCH_MACRO
		.skip:
	CASE "BBS_BB"
		PC_NEXT
		AND (emu_ZP,X)
		BEQ .skip
			BRANCH_MACRO
		.skip:
	CASE "BIT_TEMP_F"
		PLP
		BIT emu_temp,X
		PHP
	CASE "BRANCH_REL"
		PLP
		PHP
		SWITCH "op"
		CASE "BCS"
			BCC .skip
		CASE "BCC"
			BCS .skip
		CASE "BEQ"
			BNE .skip
		CASE "BNE"
			BEQ .skip
		CASE "BMI"
			BPL .skip
		CASE "BPL"
			BMI .skip
		CASE "BVS"
			BVC .skip
		CASE "BVC"
			BVS .skip
		CASE "BRA"
			;Always branch - no skip
		ENDCASE
			BRANCH_MACRO
		.skip:
	CASE "BRK_IMP"
		;TODO: set B flag?
		BRK
		BRK
		PC_NEXT
	CASE "CMP_ADDRESS_F"
		PLP
		CMP (emu_address,X)
		PHP
	CASE "CMP_IMMED_F"
		PLP
		CMP (emu_PC,X)
		PHP
	CASE "CMP_ZP_F"
		PLP
		CMP (emu_ZP,X)
		PHP	
	CASE "DEX_F"
		PLP
		DEC emu_X,X
		PHP
	CASE "DEY_F"
		PLP
		DEC emu_Y,X
		PHP
	CASE "INX_F"
		PLP
		INC emu_X,X
		PHP
	CASE "INY_F"
		PLP
		INC emu_Y,X
		PHP
	CASE "JMP_ABS"
		;Custom address loader - slightly smaller than PRE_OP of ABS
		PC_NEXT
		LDA (emu_PC,X)
		TAY
		PC_NEXT
		LDA (emu_PC,X)
		STY emu_PC,X
		STA emu_PC_hi,X
	CASE "JMP_INDIRECT"
		;Custom address loader
		PC_NEXT
		LDA (emu_PC,X)
		STA emu_temp,X
		PC_NEXT
		LDA (emu_PC,X)
		STA emu_temp_hi,X
		LDA (emu_temp,X)
		STA emu_PC,X
		INC emu_temp,X
		BNE .skip
			inc emu_temp_hi
		.skip:
		LDA (emu_temp,X)
		STA emu_PC_hi
	CASE "JMP_IAX"
		;Custom address loader
		PC_NEXT
		LDA (emu_PC,X)
		CLC
		ADC emu_X,X
		STA emu_temp,X
		PC_NEXT
		LDA (emu_PC,X)
		ADC #0
		STA emu_temp_hi,X
		LDA (emu_temp,X)
		STA emu_PC,X
		INC emu_temp,X
		BNE .skip
			inc emu_temp_hi
		.skip:
		LDA (emu_temp,X)
		STA emu_PC_hi
	CASE "JSR_ABS"
		;Custom address loader
		PC_NEXT
		LDA (emu_PC,X)
		TAY
		PC_NEXT
		LDA emu_PC,X
		STA (emu_SP,X)
		DEC emu_SP,X
		LDA emu_PC_hi,X
		STA (emu_SP,X)
		DEC emu_SP,X
		LDA (emu_PC,X)
		STY emu_PC,X
		STA emu_PC_hi,X
	CASE "LDA_0"
		LDA #0
	CASE "LDA_A"
		LDA emu_A,X
	CASE "LDA_A_F"
		PLP
		LDA emu_A,X
		PHP
	CASE "LDA_X"
		LDA emu_X,X
	CASE "LDA_X_F"
		PLP
		LDA emu_X,X
		PHP
	CASE "LDA_Y"
		LDA emu_Y,X
	CASE "LDA_Y_F"
		PLP
		LDA emu_Y,X
		PHP
	CASE "LDA_SP_F"
		PLP
		LDA emu_SP,X
		PHP
	CASE "LDA_ADDRESS"
		LDA (emu_address,X)
	CASE "LDA_ADDRESS_F"
		PLP
		LDA (emu_address,X)
		PHP
	CASE "LDA_IMMED"
		LDA (emu_PC,X)
	CASE "LDA_IMMED_F"
		PLP
		LDA (emu_PC,X)
		PHP
	CASE "LDA_ZP"
		LDA (emu_ZP,X)
	CASE "LDA_ZP_F"
		PLP
		LDA (emu_ZP,X)
		PHP
	CASE "LDA_BIT0"
		LDA #$01
	CASE "LDA_BIT1"
		LDA #$02
	CASE "LDA_BIT2"
		LDA #$04
	CASE "LDA_BIT3"
		LDA #$08
	CASE "LDA_BIT4"
		LDA #$10
	CASE "LDA_BIT5"
		LDA #$20
	CASE "LDA_BIT6"
		LDA #$40
	CASE "LDA_BIT7"
		LDA #$80
	CASE "OP_F"
		PLP
		op
		PHP
	CASE "OP_ADDRESS_F"
		PLP
		op (emu_address,X)
		PHP
	CASE "OP_IMMED_F"
		PLP
		op (emu_PC,X)
		PHP
	CASE "OP_IMP_F"
		PLP
		op
		PHP
	CASE "OP_ZP_F"
		PLP
		op (emu_ZP,X)
		PHP
	CASE "PLA_PHA"
		PLA
		PHA
	CASE "PLP_IMP"
		INC emu_SP,X
		PLA ; drop flags from stack
		LDA (emu_SP,X)
		PHA
	CASE "PULL_F"
		INC emu_SP,X
		PLP
		LDA (emu_SP,X)
		PHP
	CASE "PUSH"
		STA (emu_SP,X)
		DEC emu_SP,X
	CASE "RTS_IMP"
		INC emu_SP,X
		LDA (emu_SP,X)
		STA emu_PC_hi
		INC emu_SP,X
		LDA (emu_SP,X)
		;STA emu_PC
		
		;Custom PC_NEXT - slightly faster
		;INC emu_PC,X
		INC
		STA emu_PC
		BNE .skip
			INC emu_PC_hi,X
		.skip:
	CASE "SED_F"
		PLP
		SED
		PHP
		CLD
	CASE "STA_A"
		STA emu_A,X
	CASE "STA_X"
		STA emu_X,X
	CASE "STA_Y"
		STA emu_Y,X
	CASE "STA_SP"
		STA emu_SP,X
	CASE "STA_ADDRESS"
		STA (emu_address,X)
	CASE "STA_TEMP"
		STA emu_temp,X
	CASE "STA_ZP"
		STA (emu_ZP,X)
	CASE "TRB_ABS"
		LDA (emu_address,X)
		STA emu_temp,X
		LDA emu_A,X
		PLP
		BIT emu_temp,X
		PHP
		EOR #$FF
		AND emu_temp,X
		STA (emu_address,X)
	CASE "TRB_ZP"
		LDA (emu_ZP,X)
		STA emu_temp,X
		LDA emu_A,X
		PLP
		BIT emu_temp,X
		PHP
		EOR #$FF
		AND emu_temp,X
		STA (emu_ZP,X)
	CASE "TSB_ABS"
		LDA (emu_address,X)
		STA emu_temp,X
		LDA emu_A,X
		PLP
		BIT emu_temp,X
		PHP
		ORA emu_temp,X
		STA (emu_address,X)
	CASE "TSB_ZP"
		LDA (emu_ZP,X)
		STA emu_temp,X
		LDA emu_A,X
		PLP
		BIT emu_temp,X
		PHP
		ORA emu_temp,X
		STA (emu_ZP,X)
	CASE "UNIMPLEMENTED"
		;Instruction not implemented - loop forever
		JMP *
	CASE ""
		;Do nothing
	ELSECASE
		fatal "Op step not found: stepname"
	ENDCASE
	ENDM

POST_OP MACRO name, mode
	PC_NEXT
	ENDM

;Called when each instruction is executed
OP_MACRO MACRO code, name, mode, full, step1, step2, step3, step4
	PRE_OP mode
	OP_STEP name, step1
	OP_STEP name, step2
	OP_STEP name, step3
	OP_STEP name, step4
	SWITCH "name"
	CASE "JMP","JSR","RTS"
		;No POST_OP - handled above
	ELSECASE
		POST_OP
	ENDCASE
	ENDM

;Advance to next instruction
NEXT_MACRO MACRO
	
	;Method 1 - 60 cycles
	;Jump table must be page aligned!!!
	;LDA (emu_PC,X)			;6
	;ASL					;2
	;STA emu_temp,X			;4
	;LDA #hi(JUMP_TABLE)	;2
	;ADC #0					;2
	;STA emu_temp+1,X		;4
	;LDA (emu_temp,X)		;6
	;STA emu_temp2,X			;4
	;INC emu_temp,X			;6
	;BCC .skip				;2
	;	INC emu_temp+1,X		;6
	;.skip:
	;LDA (emu_temp,X)		;6
	;STA emu_temp2+1,X		;4
	;JMP (emu_temp2,X)		;6
	
	;Method 2 - 46 cycles
	;Jump table must be page aligned!!!
	;LDA (emu_PC,X)			;6
	;STZ emu_temp+1,X		;4
	;ASL					;2
	;ROL emu_temp+1,X		;6
	;ASL					;2
	;ROL emu_temp+1,X		;6
	;STA emu_temp,X			;4				
	;LDA emu_temp+1,X		;4
	;ADC #hi(JUMP_TABLE)	;2
	;STA emu_temp+1,X		;4
	;JMP (emu_temp2,X)		;6
	
	;Method 3 - 30 cycles
	;TXA							;2
	;TAY							;2
	;LDA (emu_PC,X)					;6
	;ASL 							;2
	;BCS upper						;2
	;lower:
	;	ASL							;2
	;	TAX							;2
	;	BCS upper_lower				;2
	;	lower_lower:
	;		JMP (JUMP_TABLE1,X)		;6
	;	upper_lower:
	;		JMP (JUMP_TABLE2,X)
	;upper:
	;	ASL
	;	TAX
	;	BCS upper_upper
	;	lower_upper:
	;		JMP (JUMP_TABLE3,X)
	;	upper_upper:
	;		JMP (JUMP_TABLE4,X)
	;After jump:
	;TYA							;2
	;TAX							;2
	
	;Method 4 - 28 cycles
	;LDA (emu_PC,X)			;6
	;TAY					;2
	;LDA JUMP_TABLE,Y		;4
	;PHA					;3
	;LDA JUMP_TABLE2,Y		;4
	;PHA					;3
	;RTS					;6
	
	;Method 5 - 30 cycles
	LDA (emu_PC,X)			;6
	TAY						;2
	LDA JUMP_TABLE_LO,Y		;4
	STA emu_temp,X			;4
	LDA JUMP_TABLE_HI,Y		;4
	STA emu_temp+1,X		;4
	JMP (emu_temp,X)		;6
				
	ENDM
			
;Misc
halt MACRO
	BRK
	BRK
	ENDM
	
LOAD16 MACRO val
	LDA #lo(val)
	LDX #hi(val)
	ENDM
	
hi FUNCTION x,(x/256)
lo FUNCTION x,(x#256)
		