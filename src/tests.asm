;Tests for all emulated instructions
;===================================
	
	;Set up emulator then execute tests for all emulated instructions
	test_prog:
		
		;Make sure binary NOT compiled with parallel emulation
		IF PARALLEL_EMU = TRUE
			halt
			JMP *
		ENDIF
		
		;Setup before any emulator level loads
		STZ global_emu_level
		LDX #EMULATOR_STACK_START+EMULATOR_STACK_SIZE-1
		TXS
			
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
		;STA emu_data_SP,X
		STY emu_level,X
		
		;Set up emulated SP
		LDA #EMULATED_STACK_START+EMULATED_STACK_SIZE-1	;Level 0 uses first stack chunk
		INY						;emu_level+1
		CLC
		.loop_sp:
			ADC #EMULATED_STACK_SIZE
			DEY
			BNE .loop_sp
		.loop_sp_done:
		STA emu_SP,X
		LDA #1
		STA emu_SP_hi,X
		
		;Load emulated PC
		LDA #lo(instruction_tests)
		STA emu_PC,X
		LDA #hi(instruction_tests)
		STA emu_PC+1,X
		
		;Jump into emulation and don't return
		NEXT_MACRO
		
		halt
		JMP *

	;Deepest emulation layer reached - stop nesting
	ExitEmu:
		halt
		JMP *
		
		
	instruction_tests:
		
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
		CLD
		CLI
		SEI
		CLV
		
		;LDA emu?,X
		;STA (emu_SP,X)
		;DEC emu_SP,X
		LDA #5
		PHA
		PHA
		PHA
		PHA
		PLA
		
		;INC emu_SP,X
		;PLP
		;LDA (emu_SP,X)
		;PHP
		;STA emu_?,X 
		PLA
		PLX
		PLY
		
		LDX #6
		PHX
		LDY #7
		PHY
		PLX
		PLY
		
		;Test
		SEC
		SED
		SEI
		
		;PLA
		;PHA
		;STA (emu_SP,X)
		;DEC emu_SP,X
		PHP
		
		;INC emu_SP,X
		;PLA - drop flags from stack
		;LDA (emu_SP,X)
		;PHA
		PLP
		
		;Test
		LDA #0
		PHA
		LDA #$FF
		PHA
		PLP
		LDA #0
		PLP
		LDA #0
		
		;Test
		LDX #5
		LDY #9
		
		DEX
		INX
		DEY
		INY
		
		;Test
		LDA #5
		LDX #7
		LDY #9
			
		;PLP
		;LDA emu_?,X
		;PHP
		;STA emu_?,X
		TAX
		LDA #9
		TXA
		TAY
		LDA #9
		TYA
		TSX
		TXA
		
		;LDA emu_X,X
		;STA emu_SP,X
		LDX #$23
		TXS
		TAX
		TXS
		
		;Marked as unimplemented - loops forever 
		;RTI
		
		;Tested below with JSR
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
		LDA #$FE
		BIT #1
		BIT #2
		
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
		;	STA emu_ZP,X
		
		;Test
		LDA #$23
		STA $F0
		INC
		STA $F1
		INC 
		STA $F2
		
		;PLP
		;LDA (emu_ZP,X)
		;PHP
		;STA emu_?,X
		LDA $F0
		LDX $F1
		LDY $F2
			
		;LDA emu_?,X
		;STA (emu_ZP,X)
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
		;op (emu_ZP,X)
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
		
		;LDA (emu_ZP,X)
		;STA emu_temp,X
		;LDA emu_A,X
		;PLP
		;BIT emu_temp,X
		;PHP
		LDA #$AA
		BIT $F0
		
		;LDA (emu_ZP,X)
		;PLP
		;op
		;PHP
		;STA (emu_ZP,X)
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
		
		;LDA (emu_ZP,X)
		;STA emu_temp,X
		;LDA emu_A,X
		;PLP
		;BIT emu_temp,X
		;PHP
		;ORA emu_temp,X
		;STA (emu_ZP,X)
		LDA #$55
		STA $F0
		LDA #$A5
		TSB $F0
				
		;LDA (emu_ZP,X)
		;STA emu_temp,X
		;LDA emu_A,X
		;PLP
		;BIT emu_temp,X
		;PHP
		;EOR #$FF
		;AND emu_temp,X
		;STA (emu_ZP,X)
		LDA #$F5
		STA $F0
		LDA #$51
		TRB $F0
		
		;Test
		LDA #$23
		STA $F0
		LDX #$34
		STX $F1
		LDY #$45
		STY $F2
		
		;LDA emu_?,X
		;PLP
		;CMP (emu_ZP,X)
		;PHP
		CMP $F0
		CPX $F1
		CPY $F2
		
		INC $F0
		INC $F1
		INC $F2
		
		CMP $F0
		CPX $F1
		CPY $F2
		
		LDA #$FF
		STA $F0
		RMB0 $F0
		RMB1 $F0
		RMB2 $F0
		RMB3 $F0
		RMB4 $F0
		RMB5 $F0
		RMB6 $F0
		RMB7 $F0
		
		STZ $F0
		SMB0 $F0
		SMB1 $F0
		SMB2 $F0
		SMB3 $F0
		SMB4 $F0
		SMB5 $F0
		SMB6 $F0
		SMB7 $F0
		
		
		
		;Absolute
		;========
		;PRE:
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	STA emu_address,X
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	STA emu_address_hi,X
		
		;Test
		LDA #$23
		LDX #$34
		LDY #$45
		
		;LDA emu_?,X
		;STA (emu_address,X)
		STA $2000
		STX $2001
		STY $2002
		STA $2003
		STZ $2003
		
		;PLP
		;LDA (emu_address,X)
		;PHP
		;STA emu_?,X
		LDA $2002 
		LDX $2001
		LDY $2000
		
		;Test
		LDA #$55
		STA $2000
		LDA #$A5
		STA $2001
		
		;LDA emu_A,X
		;PLP
		;op (emu_address,X)
		;PHP
		;STA emu_A,X
		LDA #$5A
		AND $2000
		LDA #$5A
		ORA $2000
		LDA #$5A
		EOR $2000
		LDA #$23
		CLC
		ADC $2001
		LDA #$87
		SEC 
		SBC $2000
		
		;LDA (emu_address,X)
		;STA emu_temp,X
		;LDA emu_A,X
		;PLP
		;BIT emu_temp,X
		;PHP
		LDA #$AA
		BIT $2000
		
		;LDA (emu_address,X)
		;PLP
		;op
		;PHP
		;STA (emu_address,X)
		LDA #$BF
		STA $2000
		ASL $2000
		ROL $2000
		LSR $2000
		ROR $2000
		LDA #5
		STA $2000
		DEC $2000
		INC $2000
		
		;LDA (emu_address,X)
		;STA emu_temp,X
		;LDA emu_A,X
		;PLP
		;BIT emu_temp,X
		;PHP
		;ORA emu_temp,X
		;STA (emu_address,X)
		LDA #$55
		STA $2000
		LDA #$A5
		TSB $2000
		
		;LDA (emu_address,X)
		;STA emu_temp,X
		;LDA emu_A,X
		;PLP
		;BIT emu_temp,X
		;PHP
		;EOR #$FF
		;AND emu_temp,X
		;STA (emu_address,X)
		LDA #$F5
		STA $2000
		LDA #$51
		TRB $2000
		
		;Test
		LDA #$23
		STA $2000
		LDX #$34
		STX $2001
		LDY #$45
		STY $2002
		
		;LDA emu_?,X
		;PLP
		;CMP (emu_address,X)
		;PHP
		CMP $2000
		CPX $2001
		CPY $2002
		
		INC $2000
		INC $2001
		INC $2002
		
		CMP $2000
		CPX $2001
		CPY $2002
		
		LDA #5
		JMP jmp_test
		DEC
		jmp_test:
		LDA #6
		
		JSR jsr_test
		LDA #9
		JMP jsr_test_done
		
		jsr_test:
		LDA #7
		RTS
		jsr_test_done:
		LDA #8
		
		
		
		;Zero page, X
		;============
		;PRE:
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	CLC
		;	ADC emu_X,X
		;	STA emu_ZP,X
		
		;Test
		LDA #$23
		STA $F7
		LDA #$34
		STA $F8
		LDA #$45
		STA $F9
		
		LDX #3
		LDA $F4,X
		INX
		LDA $F4,X
		INX
		LDA $F4,X
		
		LDX #1
		LDA $F6,X
		LDA $F7,X
		LDA $F8,X
		
		LDX #3
		LDY $F4,X
		INX
		LDY $F4,X
		
		;Test
		LDA #$56
		LDY #$67
		
		STA $F4,X
		STY $F4,X
		STZ $F4,X
		
		;Test
		LDA #$55
		STA $F8
		LDA #$A5
		STA $F9
		LDX #4
		
		LDA #$5A
		AND $F4,X
		LDA #$5A
		ORA $F4,X
		LDA #$5A
		EOR $F4,X
		LDA #$23
		CLC
		ADC $F5,X
		LDA #$87
		SEC
		SBC $F4,X
		
		LDA #$C0
		STA $F4,X
		LDA #$3F
		BIT $F4,X
		
		LDA #$BF
		STA $F4,X
		ASL $F4,X
		ROL $F4,X
		LSR $F4,X
		ROR $F4,X
		LDA #5
		STA $F4,X
		DEC $F4,X
		INC $F4,X
		
		LDA #$75
		STA $F4,X
		CMP $F4,X
		LDA #$76
		CMP $F4,X
		
		
		
		;Zero Page, Y
		;===
		;PRE:
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	CLC
		;	ADC emu_Y,X
		;	STA emu_ZP,X
		
		LDY #8
		LDX #$57
		STX $E0,Y
		STZ $E8
		LDX $E0,Y
		
		
		
		;Absolute, X
		;============
		;PRE:
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	CLC
		;	ADC emu_X,X
		;	STA emu_address,X
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	ADC #0
		;	STA emu_address_hi,X
		
		;Test
		LDA #$23
		STA $20FF
		LDA #$34
		STA $2100
		LDA #$45
		STA $2101
		
		LDX #1
		LDA $20FE,X
		INX
		LDA $20FE,X
		INX
		LDA $20FE,X
		
		LDX #1
		LDA $20FE,X
		LDA $20FF,X
		LDA $2100,X
		
		LDX #1
		LDY $20FE,X
		INX
		LDY $20FF,X
		
		;Test
		LDA #$56
		LDY #$67
		LDX #3
		
		STA $20FC,X
		STZ $20FE,X
		
		;Test
		LDA #$55
		STA $2100
		LDA #$A5
		STA $2101
		LDX #1
		
		LDA #$5A
		AND $20FF,X
		LDA #$5A
		ORA $20FF,X
		LDA #$5A
		EOR $20FF,X
		LDA #$23
		CLC
		ADC $20FF,X
		LDA #$87
		SEC
		SBC $20FF,X
		
		LDA #$C0
		STA $20FF,X
		LDA #$3F
		
		BIT $20FF,X
		
		LDA #$BF
		STA $20FF,X
		ASL $20FF,X
		ROL $20FF,X
		LSR $20FF,X
		ROR $20FF,X
		LDA #5
		STA $20FF,X
		DEC $20FF,X
		INC $20FF,X
		
		LDA #$75
		STA $20FF,X
		CMP $20FF,X
		LDA #$76
		CMP $20FF,X
		


		;Absolute, Y
		;============
		;PRE:
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	CLC
		;	ADC emu_Y,X
		;	STA emu_address,X
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	ADC #0
		;	STA emu_address_hi,X
		
		;Test
		LDA #$23
		STA $20FF
		LDA #$34
		STA $2100
		LDA #$45
		STA $2101
		LDY #1
		
		LDA $20FE,Y
		INY
		LDA $20FE,Y
		INY
		LDA $20FE,Y
		
		LDY #1
		LDA $20FE,Y
		LDA $20FF,Y
		LDA $2100,Y
		
		LDY #1
		LDX $20FE,Y
		INY
		LDX $20FF,Y
		
		;Test
		LDA #$56
		LDX #$67
		LDY #3
		
		STA $20FC,Y
		
		;Test
		LDA #$55
		STA $2100
		LDA #$A5
		STA $2101
		LDY #1
		
		LDA #$5A
		AND $20FF,Y
		LDA #$5A
		ORA $20FF,Y
		LDA #$5A
		EOR $20FF,Y
		LDA #$23
		CLC
		ADC $20FF,Y
		LDA #$87
		SEC
		SBC $20FF,Y
		
		LDY #1
		LDA #$75
		STA $20FF,Y
		CMP $20FF,Y
		LDA #$76
		CMP $20FF,Y
		
		
		
		;(Zero page)
		;===========
		;PRE:
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	STA emu_ZP,X
		;	LDA (emu_ZP,X)
		;   STA emu_address,X
		;	INC emu_ZP,X
		;	LDA (emu_ZP,X)
		;	STA emu_address_hi,X
		
		;Test
		LDA #$23
		STA $BCDE
		LDA #$DE
		STA $F0
		LDA #$BC
		STA $F1

		LDA ($F0)
		LDA #$55
		STA ($F0)
		
		LDA #$5A
		AND ($F0)
		LDA #$5A
		ORA ($F0)
		LDA #$5A
		EOR ($F0)
		LDA #$23
		CLC
		ADC ($F0)
		LDA #$87
		SEC
		SBC ($F0)

		LDA #$75
		STA ($F0)
		CMP	($F0)
		LDA #$76
		CMP	($F0)
		
		;(Zero page,X)
		;=============
		;PRE:
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	CLC
		;	ADC emu_X,X
		;	STA emu_ZP,X
		;	LDA (emu_ZP,X)
		;   STA emu_address,X
		;	INC emu_ZP,X
		;	LDA (emu_ZP,X)
		;	STA emu_address_hi,X
		
		;Test
		LDA #$67
		STA $ABCD
		LDA #$CD
		STA $F4
		LDA #$AB
		STA $F5
		LDX #4

		LDA ($F0,X)
		LDA #$55
		STA ($F0,X)
		
		LDA #$5A
		AND ($F0,X)
		LDA #$5A
		ORA ($F0,X)
		LDA #$5A
		EOR ($F0,X)
		LDA #$23
		CLC
		ADC ($F0,X)
		LDA #$87
		SEC
		SBC ($F0,X)
		
		LDA #$75
		STA ($F0,X)
		CMP	($F0,X)
		LDA #$76
		CMP	($F0,X)
		
		;(Zero page),Y
		;=============
		;PRE:
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	STA emu_ZP,X
		;	LDA (emu_ZP,X)
		;	CLC
		;	ADC emu_Y,X
		;   STA emu_address,X
		;	INC emu_ZP,X
		;	LDA (emu_ZP,X)
		;	ADC #0
		;	STA emu_address_hi,X
		
		;Test
		LDA #$78
		STA $AC07
		LDA #lo($ABF0)
		STA $F0
		LDA #hi($ABF0)
		STA $F1
		LDY #$17

		LDA ($F0),Y
		LDA #$55
		STA ($F0),Y
		
		LDA #$5A
		AND ($F0),Y
		LDA #$5A
		ORA ($F0),Y
		LDA #$5A
		EOR ($F0),Y
		LDA #$23
		CLC
		ADC ($F0),Y
		LDA #$87
		SEC
		SBC ($F0),Y
		
		LDA #$75
		STA ($F0),Y
		CMP	($F0),Y
		LDA #$76
		CMP	($F0),Y
		
		
		
		;JMP (Absolute)
		;==============
		;PRE:
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	STA emu_temp,X
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	STA emu_temp_hi,X
		;	LDA (emu_temp,X)
		;	STA emu_PC,X
		;	INC emu_temp,X
		;	BNE .skip
		;		inc emu_temp_hi
		;	.skip:
		;	LDA (emu_temp,X)
		;	STA emu_PC_hi
		
		;Test
		LDA #lo(jmp_skip1)
		STA $8005
		LDA #hi(jmp_skip1)
		STA $8006
		
		JMP ($8005)
		LDA #$FF
		jmp_skip1:
		LDA #$89
		
		
		
		;JMP (Absolute,X)
		;================
		;PRE:
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	CLC
		;	ADC emu_X,X
		;	STA emu_temp,X
		;	PC_NEXT
		;	LDA (emu_PC,X)
		;	ADC #0
		;	STA emu_temp_hi,X
		;	LDA (emu_temp,X)
		;	STA emu_PC,X
		;	INC emu_temp,X
		;	BNE .skip
		;		inc emu_temp_hi
		;	.skip:
		;	LDA (emu_temp,X)
		;	STA emu_PC_hi
		
		;Test
		LDA #lo(jmp_skip2)
		STA $8000
		LDA #hi(jmp_skip2)
		STA $8001
		LDX #2
		
		JMP ($7FFE,X)
		LDA #$FF
		jmp_skip2:
		LDA #$9A
		
		
		
		;Branches
		;========
		JMP begin_branch_tests
		branch_test_failed:
			LDA #'!'
			STA DEBUG
			halt
			JMP *
		begin_branch_tests:
		
;Provide equivalents for missing flag setting instructions: SEV, SEN, CLN, SEZ, CLZ
NEWJUMP MACRO jump
	IF "jump"="SEV"
		LDA #$7F
		ADC #1
	ELSEIF ("jump"="SEN") || ("jump"="CLZ")
		LDA #$80
	ELSEIF ("jump"="CLN") || ("jump"="SEZ")
		LDA #$0
	ELSE
		jump
	ENDIF
	ENDM
		
BRANCH_TEST MACRO br, jump, nojump
	;Case where no branch should happen - ie CLC then BCS
	NEWJUMP nojump
	br branch_test1
	LDA #'1'
	STA DEBUG
	JMP branch_test_good
	branch_test1:
	JMP branch_test_failed
	branch_test_good:
	
	;Positive branch offset
	NEWJUMP jump
	br branch_test2
	JMP branch_test_failed
	branch_test2:
	LDA #'2'
	STA DEBUG
	
	;Negative branch offset
	JMP branch_test3
	branch_test4:
		LDA #'3'
		STA DEBUG
		JMP branch_test5
	branch_test3:
	NEWJUMP jump
	br branch_test4
	JMP branch_test_failed
	branch_test5:
	LDA #' '
	STA DEBUG
	
	ENDM
	
	BRANCH_TEST BCS, SEC, CLC 
	BRANCH_TEST BCC, CLC, SEC 
	BRANCH_TEST BVS, SEV, CLV		
	BRANCH_TEST BVC, CLV, SEV
	BRANCH_TEST BMI, SEN, CLN
	BRANCH_TEST BPL, CLN, SEN
	BRANCH_TEST BEQ, SEZ, CLZ
	BRANCH_TEST BNE, CLZ, SEZ
	
	BRA bra_test1
	JMP branch_test_failed
	bra_test2:
	LDA #'2'
	STA DEBUG
	BRA bra_test3
	JMP branch_test_failed
	bra_test1:
	LDA #'1'
	STA DEBUG
	BRA bra_test2
	JMP branch_test_failed
	bra_test3:
	LDA #10
	STA DEBUG
	
	
	
	;BBS and BBR
	;===========
	
	;Test
	LDX #0
	LDA #1
	bbs_loop:
		STA $E0,X
		EOR #$FF
		STA $E8,X
		EOR #$FF
		ASL
		INX
		CPX #8
		BNE bbs_loop
	STZ $F0
	LDA #$FF
	STA $F1
		
BBSTEST MACRO op, mem
	;Branch not taken
	op $F0, skip
	LDA #'1'
	STA DEBUG
	JMP good
	skip:
	JMP branch_test_failed
	good:
	
	;Positive branch taken
	op mem, skip2
	JMP branch_test_failed
	skip2:
	LDA #'2'
	STA DEBUG
	
	;Negative branch taken
	JMP neg1
	neg2:
	LDA #'3'
	STA DEBUG
	JMP done
	neg1:
	op mem, neg2
	JMP branch_test_failed
	done:
	LDA #' '
	STA DEBUG
	ENDM	

BBRTEST MACRO op, mem
	;Branch not taken
	op $F1, skip
	LDA #'1'
	STA DEBUG
	JMP good
	skip:
	JMP branch_test_failed
	good:
	
	;Positive branch taken
	op mem, skip2
	JMP branch_test_failed
	skip2:
	LDA #'2'
	STA DEBUG
	
	;Negative branch taken
	JMP neg1
	neg2:
	LDA #'3'
	STA DEBUG
	JMP done
	neg1:
	op mem, neg2
	JMP branch_test_failed
	done:
	LDA #' '
	STA DEBUG
	ENDM	
	
		BBSTEST BBS0, $E0
		BBSTEST BBS1, $E1
		BBSTEST BBS2, $E2
		BBSTEST BBS3, $E3
		BBSTEST BBS4, $E4
		BBSTEST BBS5, $E5
		BBSTEST BBS6, $E6
		BBSTEST BBS7, $E7
		
		LDA #10
		STA DEBUG
		
		BBRTEST BBR0, $E8
		BBRTEST BBR1, $E9
		BBRTEST BBR2, $EA
		BBRTEST BBR3, $EB
		BBRTEST BBR4, $EC
		BBRTEST BBR5, $ED
		BBRTEST BBR6, $EE
		BBRTEST BBR7, $EF
		
		halt
			
		
		
		
		
		
		