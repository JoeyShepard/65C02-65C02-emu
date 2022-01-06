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
PRE_OP MACRO name, mode
	SWITCH "mode"
	CASE "IMMED_A"
		PC_NEXT
	CASE "IMMED_XY"
		PC_NEXT
		LDA (emu_PC,X)
		STA emu_temp,X
	ELSECASE
		;Do nothing - prevents assembler warning
	ENDCASE
	ENDM

OP MACRO name, mode
	SWITCH "mode"
	CASE "IMMED_A"
		IF "name"<>"LDA"
			LDA emu_A,X
		ENDIF
		PLP
		name (emu_PC,X)
		PHP
		STA emu_A,X
	ELSECASE
		;Do nothing - prevents assembler warning
	ENDCASE
	ENDM

POST_OP MACRO name, mode
	PC_NEXT
	ENDM

;Called when each instruction is executed
OP_MACRO MACRO code, name, mode, full
	;Preparation before emulated instruction
	PRE_OP name, mode
	OP name, mode
	POST_OP name, mode
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
		