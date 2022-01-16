	DEBUG_STR1: FCB "instructions.asm size: ",0
	DEBUG_STR2: FCB "jump-table.asm size: ",0
	DEBUG_STR3: FCB "remaining program space: ",0
		
	DebugStr:
		LDY 0
		PHY
		LDY 1
		PHY
		STA 0
		STX 1
		LDY #0
		.loop:
			LDA (0),Y
			BEQ .done
			STA DEBUG
			INY
			BRA .loop
		.done:
		PLA
		STA 1
		PLA
		STA 0
		RTS
		
	DebugFileSizes:
		;instructions.asm size
		LOAD16 DEBUG_STR1
		JSR DebugStr
		LOAD16 instructions_size
		STA DEBUG_DEC16
		LDA #10
		STA DEBUG
		
		;jump-table.asm size
		LOAD16 DEBUG_STR2
		JSR DebugStr
		LOAD16 jump_table_size
		STA DEBUG_DEC16
		LDA #10
		STA DEBUG
		
		;last program address
		LOAD16 DEBUG_STR3
		JSR DebugStr
		LOAD16 $FFE0-program_end
		STA DEBUG_DEC16
		LDA #10
		STA DEBUG
		
		RTS
		