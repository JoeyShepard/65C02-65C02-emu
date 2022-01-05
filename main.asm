	;TODO
	;-All operations same size to eliminate second jump in dispatch?
	;-Split SP btw data SP and SP
	; - more SP than data SP - 16 or so
	;-Recalc dispatch - cycles times don't matter!
	;-Load code into RAM and recode! fair as long as done by 6502
	; - actually, no way to tell from binary without listing :/
	; - so JIT but that's probably slower. also huge amount of memory :/

	;Included files
	include macros.asm

	;JavaScript emulator constants
RAM_BANK2 = 	$FFE1		;0x4000-0x7FFF
RAM_BANK3 = 	$FFE2		;0x8000-0xBFFF
BANK_GFX_RAM1 = 4
BANK_GFX_RAM2 = 5

DEBUG =			$FFE7
DEBUG_HEX = 	$FFE8
DEBUG_DEC = 	$FFE9
DEBUG_DEC16 = 	$FFEA

	;65C02 emulator constants
MAX_EMU_LEVEL = 5

	;Zero page variables - shared between emu levels
	ZP_START 240
		ZP global_emu_level
	ZP_END
	
	;Locals - each emu level gets a copy
	LOCALS_START 0
		LOCAL emu_level
		LOCAL emu_data_SP
		LOCAL emu_PC
		LOCAL emu_PC_hi
		LOCAL emu_SP
		LOCAL emu_A
		LOCAL emu_X
		LOCAL emu_Y
		LOCAL emu_D_flag
		LOCAL emu_mem
		LOCAL emu_ptr
		LOCAL emu_ptr_hi
		LOCAL emu_ptr2
		LOCAL emu_ptr2_hi
	LOCALS_END
		
	ORG $C000
	;Setup before any emulator level loads
	STZ global_emu_level
	
	;Setup for each emulator level
	emu_begin:
			
		;Calculate local emu level
		LDA global_emu_level
		CMP #MAX_EMU_LEVEL
		BNE .level_good
			JMP ExitEmu
		.level_good:
		INC global_emu_level
		
		;Calculate SP and ZP data stack pointer
		TAY
		TAX
		LDA #0
		CLC
		.loop:
			ADC #locals_size
			DEX
			BNE .loop
		TAX
		STA emu_data_SP,X
		STA emu_SP,X
		TYA
		STA emu_level,X
		
		;Clear emulated D flag
		STZ emu_D_flag,X
		
		;Load emulated PC
		LDA #lo(test_prog)
		STA emu_PC,X
		LDA #hi(test_prog)
		STA emu_PC+1,X
	
		;Start emulating - should never return from this
		NEXT_MACRO
		
		halt
		JMP *

	;Deepest emulation layer reached - stop nesting
	ExitEmu:
		halt
		JMP *
	
	include "instructions.asm"
	include "jump-table.asm"
	include "test.asm"
	