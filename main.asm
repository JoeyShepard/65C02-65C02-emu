	;TODO
	;-6502 emu could understand recoded instructions leaving out flags
	; - actually, wouldnt make sense unless 6502 side generates too
	; - best idea is MIPS generating assembly and optimizing out flags
	;-Example - 4 or 8 in one screen to demonstrate
	;-Change NEXT_MACRO to jump? saves 4k 0_0
	;-Add STP and WAI
	
	;Include macros first so available to all files
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
EMU_STACK_SIZE = 16

	;Zero page variables - shared between emu levels
	ZP_START $80
		ZP global_emu_level
		;Used for testing to keep track of level or ID
		ZP test_level
		;Room for emulated programs to use
		ZP program_stacks
	ZP_END
	
	;Locals - each emu level gets a copy
	LOCALS_START 0
		LOCAL emu_level
		LOCAL emu_data_SP
		LOCAL emu_PC
		LOCAL emu_PC_hi
		LOCAL emu_SP
		LOCAL emu_SP_hi
		LOCAL emu_A
		LOCAL emu_X
		LOCAL emu_Y
		LOCAL emu_ZP
		LOCAL emu_ZP_hi
		LOCAL emu_address
		LOCAL emu_address_hi
		LOCAL emu_temp
		LOCAL emu_temp_hi
		;Last variable - stack space starts here
		LOCAL emu_stack_begin
	LOCALS_END
		
	ORG $C000
	
	;Debug - file sizes
	JSR DebugFileSizes
	
	;JavaScript emulator setup
	LDA #BANK_GFX_RAM1
	STA RAM_BANK2
	LDA #BANK_GFX_RAM2
	STA RAM_BANK3
	
	;Graphical test pattern
	JMP gfx_test2
	
	;Setup before any emulator level loads
	STZ global_emu_level
	LDX #EMU_STACK_SIZE-1
	TXS
	
	;Setup for each emulator level
	emu_begin:
	
		;Keep emulated flags on stack
		SEI
		CLD
		PHP
	
		;Calculate local emu level
		LDA global_emu_level
		CMP #MAX_EMU_LEVEL
		BNE .level_good
			JMP ExitEmu
		.level_good:
		INC global_emu_level
		
		;Calculate ZP data stack pointer
		TAY
		TAX
		BEQ .loop_done
		LDA #0
		CLC
		.loop:
			ADC #locals_size
			DEX
			BNE .loop
		.loop_done:
		TAX
		STA emu_data_SP,X
		STY emu_level,X
		
		;Set up emulated SP
		LDA #EMU_STACK_SIZE-1	;Level 0 uses first stack chunk
		INY						;emu_level+1
		CLC
		.loop_sp:
			ADC #EMU_STACK_SIZE
			DEY
			BNE .loop_sp
		.loop_sp_done:
		STA emu_SP,X
		LDA #1
		STA emu_SP_hi,X
		
		;Load emulated PC
		LDA #lo(test_prog)
		STA emu_PC,X
		LDA #hi(test_prog)
		STA emu_PC+1,X
		
		;Jump into emulation and don't return
		NEXT_MACRO
		
		halt
		JMP *

	;Deepest emulation layer reached - stop nesting
	ExitEmu:
		halt
		JMP *
	
	;Included files
	include "instructions.asm"
	include "jump-table.asm"
	include "debug.asm"
	include "tests.asm"
	include "gfx_tests.asm"
	