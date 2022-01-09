;Zero page variables
ZP_START MACRO ptr
zp_begin equ ptr
zp_address set ptr
	ENDM
			
ZP MACRO var
var equ zp_address
zp_address set zp_address+1
	ENDM
	
ZP_END MACRO
zp_end equ zp_address
zp_size equ zp_address-zp_begin
	ENDM
	
;Local variables - each emu level gets a copy
LOCALS_START MACRO ptr
locals_begin equ ptr
local_address set ptr
	ENDM

LOCAL MACRO var
var equ local_address
local_address set local_address+1
	ENDM

LOCALS_END MACRO
locals_end equ local_address
locals_size equ locals_end-locals_begin
	ENDM

;???
PC_NEXT MACRO
	INC emu_PC,X
	BNE .skip
		INC emu_PC+1,X
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
		STA emu_temp_ZP,X
	ELSECASE
		;error "Addressing mode not found: amode"
	ENDCASE
	ENDM

OP_STEP MACRO op, stepname	
	SWITCH "stepname"
		
	;Immediates
	;==========
	CASE "BIT_TEMP_F"
		PLP
		BIT emu_temp,X
		PHP
	CASE "BRK"
		;TODO: set flag?
		BRK
		BRK
		PC_NEXT
	CASE "CMP_IMMED_F"
		PLP
		CMP (emu_PC,X)
		PHP
	CASE "CMP_TEMP_F"
		PLP
		CMP emu_PC,X
		PHP
	CASE "CMP_ZP_F"
		PLP
		CMP (emu_temp_ZP,X)
		PHP		
	CASE "LDA_0"
		LDA #0
	CASE "LDA_A"
		LDA emu_A,X
	CASE "LDA_X"
		LDA emu_X,X
	CASE "LDA_Y"
		LDA emu_Y,X
	CASE "LDA_IMMED"
		LDA (emu_PC,X)
	CASE "LDA_IMMED_F"
		PLP
		LDA (emu_PC,X)
		PHP
	CASE "LDA_ZP"
		LDA (emu_temp_ZP,X)
	CASE "LDA_ZP_F"
		PLP
		LDA (emu_temp_ZP,X)
		PHP
	CASE "OP_F"
		PLP
		op
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
		op (emu_temp_ZP,X)
		PHP
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
	CASE "STA_TEMP"
		STA emu_temp,X
	CASE "STA_ZP"
		STA (emu_temp_ZP,X)
	CASE "TRB_ZP"
		LDA (emu_temp_ZP,X)
		STA emu_temp,X
		LDA emu_A,X
		PLP
		BIT emu_temp,X
		PHP
		EOR #$FF
		AND emu_temp,X
		STA (emu_temp_ZP,X)
	CASE "TSB_ZP"
		LDA (emu_temp_ZP,X)
		STA emu_temp,X
		LDA emu_A,X
		PLP
		BIT emu_temp,X
		PHP
		ORA emu_A,X
		STA (emu_temp_ZP,X)
	CASE ""
		;Do nothing
	ELSECASE
		error "Op step not found: stepname"
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
	POST_OP
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
	STA emu_temp+1,X			;4
	JMP (emu_temp,X)			;6
				
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
		