	test_prog:
		
		;Immediate mode
		;==============
		;PRE:
		;	PC_NEXT
		
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
		ADC #$25	;$15 ADC $25 = $3A
		SBC #$1B	;$3A SBC $1B = $1E (no carry set)
		
		;LDA (emu_PC,X)
		;STA emu_temp,X
		;PLP
		;BIT emu_temp,X
		;PHP
		BIT #$E1	;$E1 BIT $E1 = $E1 (Z,N,V set)
		
		;LDA emu_?,X
		;PLP
		;CMP (emu_PC,X)
		;PHP
		CMP #$1E
		CPX #$24
		CPY #$28
		
		;Zero page
		;=========
		;PRE:
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	STA emu_temp_ZP,X
		
		;PLP
		;LDA (emu_temp_ZP,X)
		;PHP
		;STA emu_?,X
		LDA
		LDY
		LDX
		
		;LDA emu_?,X
		;STA (emu_temp_ZP,X)
		STY
		STA
		STX
		STZ
		
		;LDA emu_A,X
		;PLP
		;op (emu_temp_ZP,X)
		;PHP
		;STA emu_A,X
		AND
		ORA 
		EOR
		ADC
		SBC
		
		;LDA (emu_temp_ZP,X)
		;STA emu_temp,X
		;PLP
		;BIT emu_temp,X
		;PHP
		BIT
		
		;LDA (emu_temp_ZP,X)
		;PLP
		;op
		;PHP
		;STA (emu_temp_ZP,X)
		ASL
		ROL
		LSR
		ROR
		
		;CAN'T USE TRB/TSB SINCE ONLY ZP OR ABS!
		
		;LDA (emu_temp_ZP,X)
		;STA emu_temp,X
		;PLP
		;BIT emu_temp,X
		;PHP
		;ORA emu_A,X
		;STA (emu_temp_ZP,X)
		TSB
		
		;LDA (emu_temp_ZP,X)
		;STA emu_temp,X
		;PLP
		;BIT emu_temp,X
		;PHP
		;LDA emu_A,X
		;EOR #$FF
		;AND emu_temp,X
		;STA (emu_temp_ZP,X)
		TRB
		
		
		DEC
		INC
		
		CMP
		CPX
		CPY
		
		
		
		
		
		