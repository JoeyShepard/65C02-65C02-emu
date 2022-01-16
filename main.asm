	;TODO
	;-6502 emu could understand recoded instructions leaving out flags
	; - actually, wouldnt make sense unless 6502 side generates too
	; - best idea is MIPS generating assembly and optimizing out flags
	; - 
	;-Example - 4 or 8 in one screen to demonstrate
	;-Change NEXT_MACRO to jump? saves 4k 0_0
	;-Add STP and WAI
	
	;Include macros first so available to all files
	include macros.asm

	;JavaScript emulator constants
	DEFINE RAM_BANK2, 		$FFE1	;0x4000-0x7FFF
	DEFINE RAM_BANK3, 		$FFE2	;0x8000-0xBFFF
	DEFINE BANK_GFX_RAM1, 	4
	DEFINE BANK_GFX_RAM2, 	5

	DEFINE TIMER_MS4, 		$FFE5
	DEFINE TIMER_S, 		$FFE6
	DEFINE DEBUG,			$FFE7
	DEFINE DEBUG_HEX, 		$FFE8
	DEFINE DEBUG_DEC, 		$FFE9
	DEFINE DEBUG_DEC16, 	$FFEA

	;65C02 emulator constants
	DEFINE MAX_EMU_LEVEL,	5
	DEFINE EMU_STACK_SIZE,	16
	DEFINE PARALLEL_EMU,	TRUE

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
	
	;JavaScript emulator setup - graphics memory
	LDA #BANK_GFX_RAM1
	STA RAM_BANK2
	LDA #BANK_GFX_RAM2
	STA RAM_BANK3
	
	;Tests for all emulated instructions
	JMP test_prog
	
	;Graphical test patterns to verify emulator
	;JMP gfx_test1
	;JMP gfx_test2
	JMP gfx_test3
	
	
	
	;Included files
	include "instructions.asm"
	include "jump-table.asm"
	include "debug.asm"
	include "tests.asm"
	include "gfx_tests.asm"
	