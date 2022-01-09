	test_prog:
		
		;Implied
		;=======
		
		;BRK	;Tested - works
		
		CLC
		SEC
		
		;LDA emu_A,X
		;PLP
		;op
		;PHP
		;STA emu_A,X
		INC
		DEC
		LDA #$A5
		ASL
		ROL
		LSR
		ROR
		
		;PLP
		;op
		;PHP
		CLD
		SED
		CLI
		SEI
		CLV
		
		;PHA
		;PLA
		;PHX
		;PLX
		;PHY
		;PLY
		;PHP
		;PLP
		
		;DEX
		;INX
		;DEY
		;INY
		
		;TAX
		;TXA
		;TAY
		;TYA
		;TXS
		;TSX
		
		;RTI
		;RTS
				
		
		
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
		CLC
		ADC #$25	;$15 ADC $25 = $3A
		SEC
		SBC #$1B	;$3A SBC $1B = $1F
		
		;LDA (emu_PC,X)
		;STA emu_temp,X
		;LDA emu_A,X
		;PLP
		;BIT emu_temp,X
		;PHP
		BIT #$E1	;$1E BIT $E1 = $1E (Z,N,V set)
		
		;LDA emu_?,X
		;PLP
		;CMP (emu_PC,X)
		;PHP
		CMP #$1F
		CPX #$24
		CPY #$28
		
		
		
		;Zero page
		;=========
		;PRE:
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	STA emu_temp_ZP,X
		
		;Test
		LDA #$23
		STA $F0
		INC
		STA $F1
		INC 
		STA $F2
		
		;PLP
		;LDA (emu_temp_ZP,X)
		;PHP
		;STA emu_?,X
		LDA $F0
		LDX $F1
		LDY $F2
			
		;LDA emu_?,X
		;STA (emu_temp_ZP,X)
		STA $F3
		STX $F4
		STY $F5
		STZ $F0
		
		;Test
		LDA #$55
		STA $F0
		LDA #$A5
		STA $F1
		
		;LDA emu_A,X
		;PLP
		;op (emu_temp_ZP,X)
		;PHP
		;STA emu_A,X
		LDA #$5A
		AND $F0
		LDA #$5A
		ORA $F0
		LDA #$5A
		EOR $F0
		LDA #$23
		CLC
		ADC $F1
		LDA #$87
		SEC 
		SBC $F0
		
		;LDA (emu_temp_ZP,X)
		;STA emu_temp,X
		;LDA emu_A,X
		;PLP
		;BIT emu_temp,X
		;PHP
		LDA #$AA
		BIT $F0
		
		;LDA (emu_temp_ZP,X)
		;PLP
		;op
		;PHP
		;STA (emu_temp_ZP,X)
		LDA #$BF
		STA $F0
		ASL $F0
		ROL $F0
		LSR $F0
		ROR $F0
		LDA #5
		STA $F0
		DEC $F0
		INC $F0
		
		halt
		
		;LDA (emu_temp_ZP,X)
		;STA emu_temp,X
		;LDA emu_A,X
		;PLP
		;BIT emu_temp,X
		;PHP
		;ORA emu_temp,X
		;STA (emu_temp_ZP,X)
		LDA 
		TSB
				
		;LDA (emu_temp_ZP,X)
		;STA emu_temp,X
		;LDA emu_A,X
		;PLP
		;BIT emu_temp,X
		;PHP
		;EOR #$FF
		;AND emu_temp,X
		;STA (emu_temp_ZP,X)
		TRB
		
		;		
		;		;LDA emu_?,X
		;		;PLP
		;		;CMP (emu_temp_ZP,X)
		;		;PHP
		;		CMP
		;		CPX
		;		CPY
		
		
		
		
		
		