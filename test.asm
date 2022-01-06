	test_prog:
	
		NOTES:
		-No PRE, OP, POST
		 - instead just steps spelled out in speadsheet
	
		;Immediate mode
		;==============
		;PLP
		;LDA (emu_PC,X)
		;PHA
		;STA emu_?,X
		LDA #$53
		LDX #$25
		LDY #$27
		
		;LDA emu_A,X
		;PLP
		;op  (emu_PC,X)
		;PHP
		;STA emu_A,X
		AND #$36	;$53 AND $36 = $12
		ORA #$25    ;$12 ORA $25 = $37
		EOR #$22	;$37 EOR $22 = $15
		
		;LDA emu_A,X
		;PLP
		;op (emu_PC,X)
		;PHP
		;STA emu_A,X
		ADC #$25	;$15 ADC $25 = $3A
		SBC #$1B	;$3A SBC $1B = $1E (no carry set)
		
		;LDA emu_?,X
		;PLP
		;CMP (emu_PC,X)
		;PHP
		CMP #$1E
		CPX #$24
		CPY #$28
		 
		