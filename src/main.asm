	;TODO
	;-6502 emu could understand recoded instructions leaving out flags
	; - actually, wouldnt make sense unless 6502 side generates too
	; - best idea is MIPS generating assembly and optimizing out flags
	; - not sure how to nest, but generating STC is type of JIT
	; - also self mod in ram
	
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
	DEFINE MAX_EMU_LEVEL,			5
	DEFINE EMULATOR_STACK_SIZE,		8
	DEFINE EMULATED_STACK_SIZE,		8
	DEFINE EMULATOR_STACK_START,	0
	DEFINE EMULATED_STACK_START,	$80
	DEFINE PARALLEL_EMU,			FALSE	;test_prog, gfx_test4, gfx_test6
	;DEFINE PARALLEL_EMU,			TRUE	;gfx_test5

	;Zero page variables - shared between emu levels
	ZP_START $80
		ZP global_emu_level
		;Used for testing to keep track of level or ID
		ZP test_level
		ZP global_temp_X
		ZP global_temp_SP
		;Room for emulated programs to use
		ZP program_stacks
	ZP_END
	
	;Locals - each emu level gets a copy
	LOCALS_START 0
		LOCAL emu_level
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
		LOCAL host_SP
	LOCALS_END
		
	DEFINE emu_locals_size, locals_size
	
	ORG $C000
		
	;Debug - print out file sizes
	JSR DebugFileSizes
	
	;JavaScript emulator setup - graphics memory
	LDA #BANK_GFX_RAM1
	STA RAM_BANK2
	LDA #BANK_GFX_RAM2
	STA RAM_BANK3
	
	;Tests for all emulated instructions
	;JMP test_prog
	
	;Graphical test patterns to verify emulator
	;JMP gfx_test1
	;JMP gfx_test2
	;JMP gfx_test3
	;JMP gfx_test4
	;JMP gfx_test5
	JMP gfx_test6
	
	
	;Included files
	;==============
	;Contains routine used by macro so put at end
	include "emu-macros.asm"
	include "instructions.asm"
	include "jump-table.asm"
	include "debug.asm"
	include "tests.asm"
	include "gfx-tests.asm"
	
	program_end: