;Graphical tests to demonstrate emulator functionality
;=====================================================

	;Simple pattern - make sure screen drawing works outside emulation
	gfx_test1:
		
		LDY #0
		.loop:
			LDA #0
			STA $4000,Y
			INC
			STA $5000,Y
			INC
			STA $6000,Y
			INC
			STA $7000,Y
			INC
			STA $8000,Y
			INY
			BNE .loop
		
	
	
	;Graphics resources common to all tests below
	;============================================
	;Works but looks strange - balls meet on horizontal line
	;gfx_tests_ball_start_X:
	;	FCB 0
	;	FCB 14
	;	FCB 28
	;	FCB 42
	;	FCB 54
	;	FCB 42
	;	FCB 28
	;	FCB 14
	;	
	;gfx_tests_ball_start_Y:
	;	FCB 28
	;	FCB 14
	;	FCB 0
	;	FCB 14
	;	FCB 28
	;	FCB 40	;confirmed correct
	;	FCB 54
	;	FCB 42
	
	gfx_tests_ball_start_X:
		FCB 0
		FCB 4
		FCB 8
		FCB 12
		FCB 16
		FCB 20
		FCB 24
		FCB 28
		
	gfx_tests_ball_start_Y:
		FCB 28
		FCB 24
		FCB 20
		FCB 16
		FCB 12
		FCB 8
		FCB 4
		FCB 0
	
	gfx_tests_bg_colors:
		FCB $01		;Dark red
		FCB $04		;Dark green
		FCB $10		;Dark blue
		FCB $11		;Dark purple
		FCB $14		;Dark cyan
		FCB $05		;Dark yellow
		FCB $15		;Dark gray
		FCB $00		;Black
		
	gfx_tests_ball_colors:
		FCB $03		;Red
		FCB $0C		;Green
		FCB $30		;Blue
		FCB $33		;Purple
		FCB $3C		;Cyan
		FCB $0F		;Yellow
		FCB $3F		;White
		FCB $2A		;Light gray
			
	gfx_tests_ball_image:
		FCB	$00, $00, $FF, $FF,$FF, $FF, $FF, $00, $00
		FCB $00, $FF, $01, $01,$01, $01, $01, $FF, $00
		FCB $FF, $01, $01, $01,$01, $FF, $01, $01, $FF
		FCB $FF, $01, $01, $01,$01, $01, $FF, $01, $FF
		FCB $FF, $01, $01, $01,$01, $01, $01, $01, $FF
		FCB $FF, $01, $01, $01,$01, $01, $01, $01, $FF
		FCB $FF, $01, $01, $01,$01, $01, $01, $01, $FF
		FCB $00, $FF, $01, $01,$01, $01, $01, $FF, $00	
		FCB	$00, $00, $FF, $FF,$FF, $FF, $FF, $00, $00	

	
		
	;Eight patterns on screen at once - no emulation
	gfx_test2:
		DEFINE FRAME_WIDTH, 64
		DEFINE FRAME_HEIGHT, 64
		DEFINE BALL_SIZE, 9
		
		;Just declarations - no code generated
		LOCALS_START 0
			LOCAL local_level
			LOCAL origin
			LOCAL origin_hi
			LOCAL gfx_ptr
			LOCAL gfx_ptr_hi
			LOCAL temp1
			LOCAL temp2
			LOCAL ball_X
			LOCAL ball_Y
			LOCAL ball_ptr
			LOCAL ball_ptr_hi
		LOCALS_END
		
		;Initialize all threads - runs once before any emulation loads
		STZ test_level
		LDY #0
		LDA #program_stacks
		.init_loop:
			TAX
			STY local_level,X
			CLC
			ADC #locals_size
			INY
			CPY #8
			BNE .init_loop
		LDX #program_stacks
		
		.bg_loop:
		
		;Calculate screen coordinates
		LDA local_level,X
		AND #3	;ie mod 4
		TAY
		LDA #0
		CPY #0
		.coord_loop:
			BEQ .coord_done
			CLC
			ADC #FRAME_WIDTH
			DEY
			BRA .coord_loop
		.coord_done:
		STA origin,X
		LDY #$40
		LDA local_level,X
		LSR
		LSR
		BEQ .y_coord_done
		LDY #$80
		.y_coord_done:
		STY origin_hi,X
		
		;Initialize ball
		LDY local_level,X
		LDA gfx_tests_ball_start_X,Y
		STA ball_X,X
		CLC
		ADC origin,X
		STA ball_ptr,X
		
		LDA gfx_tests_ball_start_Y,Y
		STA ball_Y,X
		CLC
		ADC origin_hi,X
		STA ball_ptr_hi,X
		
		;Draw background		
		LDA #FRAME_HEIGHT
		STA temp1,X
		LDA origin_hi,X
		STA gfx_ptr_hi,X
		.draw_loop_outer:
			LDA origin,X
			STA gfx_ptr,X
			LDY local_level,X
			LDA gfx_tests_bg_colors,Y
			LDY #FRAME_WIDTH
			.draw_loop:
				STA (gfx_ptr,X)
				INC gfx_ptr,X
				DEY
				BNE .draw_loop
			INC gfx_ptr_hi,X
			DEC temp1,X
			BNE .draw_loop_outer
		
		;Since not emulating, loop through all 8 backgrounds manually
		LDA test_level
		INC
		CMP #8
		STA test_level
		BEQ .bg_done
		TXA
		CLC
		ADC #locals_size
		TAX
		JMP .bg_loop
		.bg_done:
		LDX #program_stacks
		
		;Background drawing done - start drawing ball animations
		.draw_ball:

			;Erase ball
			LDA #BALL_SIZE
			STA temp1,X
			.erase_loop_outer:
				LDY local_level,X
				LDA gfx_tests_bg_colors,Y
				LDY #BALL_SIZE
				.erase_loop:
					STA (ball_ptr,X)
					INC ball_ptr,X
					DEY
					BNE .erase_loop
				LDA ball_ptr,X
				SEC
				SBC #BALL_SIZE
				STA ball_ptr,X
				INC ball_ptr_hi,X
				DEC temp1,X
				BNE .erase_loop_outer
			LDA ball_ptr_hi,X
			SEC
			SBC #BALL_SIZE
			STA ball_ptr_hi,X
						
			;Calculate new ball position
			LDA ball_X,X
			CMP #(FRAME_WIDTH-BALL_SIZE)/2+1
			BCC .ball_up
			.ball_down:
				INC ball_Y,X
				INC ball_ptr_hi,X
				BRA .ball_vert_done
			.ball_up:
				DEC ball_Y,X
				DEC ball_ptr_hi,X
			.ball_vert_done:
			
			LDA ball_Y,X
			CMP #(FRAME_HEIGHT-BALL_SIZE)/2+1
			BCC .ball_right
			.ball_left:
				DEC ball_X,X
				DEC ball_ptr,X
				BRA .ball_horiz_done
			.ball_right:
				INC ball_X,X
				INC ball_ptr,X
			.ball_horiz_done:
			
			;Draw ball
			LDA #lo(gfx_tests_ball_image)
			STA gfx_ptr,X
			LDA #hi(gfx_tests_ball_image)
			STA gfx_ptr_hi,X
			LDA #BALL_SIZE
			STA temp1,X
			LDY local_level,X
			.ball_loop_outer:
				LDA #BALL_SIZE
				STA temp2,X	
				.ball_loop:
					LDA (gfx_ptr,X)
					BEQ .transparent
					BMI .white
					.fg_color:
						LDA gfx_tests_ball_colors,Y
						BRA .color_done
					.white:
						LDA #$3F
					.color_done:
					STA (ball_ptr,X)
					.transparent:
					INC gfx_ptr,X
					BNE .skip
						INC gfx_ptr_hi,X
					.skip:
					INC ball_ptr,X
					DEC temp2,X
					BNE .ball_loop
				LDA ball_ptr,X
				SEC
				SBC #BALL_SIZE
				STA ball_ptr,X
				INC ball_ptr_hi,X
				DEC temp1,X
				BNE .ball_loop_outer
			
			;Reset ball_ptr after drawing
			LDA ball_ptr_hi,X
			SEC
			SBC #BALL_SIZE
			STA ball_ptr_hi,X
			
			;Delay ~4 ms - otherwise frames way too fast
			LDA TIMER_MS4
			STA temp1,X
			.timer_loop:
				LDA TIMER_MS4
				CMP temp1,X
				BEQ .timer_loop
			
			;Since not emulating - switch to drawing next ball manually
			LDA local_level,X
			CMP #7
			BNE .increase_stack
				LDA #program_stacks
				BRA .stack_done
			.increase_stack:
				TXA
				CLC
				ADC #locals_size
			.stack_done:
			TAX
			
			;Next frame
			JMP .draw_ball

	
		
	;Same as gfx_test2 but only one of eight patterns - no emulation
	gfx_test3:
		DEFINE FRAME_WIDTH, 64
		DEFINE FRAME_HEIGHT, 64
		DEFINE BALL_SIZE, 9
		
		;Just declarations - no code generated
		LOCALS_START 0
			LOCAL local_level
			LOCAL origin
			LOCAL origin_hi
			LOCAL gfx_ptr
			LOCAL gfx_ptr_hi
			LOCAL temp1
			LOCAL temp2
			LOCAL ball_X
			LOCAL ball_Y
			LOCAL ball_ptr
			LOCAL ball_ptr_hi
		LOCALS_END
		
		;Initialize all threads - runs once before any emulation loads
		STZ test_level
		LDY #0
		LDA #program_stacks
		.init_loop:
			TAX
			STY local_level,X
			CLC
			ADC #locals_size
			INY
			CPY #8
			BNE .init_loop
		LDX #program_stacks
		
		;Emulation starts here
		.emu_start:
		
		;Calculate screen coordinates
		LDA local_level,X
		AND #3	;ie mod 4
		TAY
		LDA #0
		CPY #0
		.coord_loop:
			BEQ .coord_done
			CLC
			ADC #FRAME_WIDTH
			DEY
			BRA .coord_loop
		.coord_done:
		STA origin,X
		LDY #$40
		LDA local_level,X
		LSR
		LSR
		BEQ .y_coord_done
		LDY #$80
		.y_coord_done:
		STY origin_hi,X
		
		;Initialize ball
		LDY local_level,X
		LDA gfx_tests_ball_start_X,Y
		STA ball_X,X
		CLC
		ADC origin,X
		STA ball_ptr,X
		
		LDA gfx_tests_ball_start_Y,Y
		STA ball_Y,X
		CLC
		ADC origin_hi,X
		STA ball_ptr_hi,X
		
		;Draw background		
		LDA #FRAME_HEIGHT
		STA temp1,X
		LDA origin_hi,X
		STA gfx_ptr_hi,X
		.draw_loop_outer:
			LDA origin,X
			STA gfx_ptr,X
			LDY local_level,X
			LDA gfx_tests_bg_colors,Y
			LDY #FRAME_WIDTH
			.draw_loop:
				STA (gfx_ptr,X)
				INC gfx_ptr,X
				DEY
				BNE .draw_loop
			INC gfx_ptr_hi,X
			DEC temp1,X
			BNE .draw_loop_outer
		
		;Background drawing done - start drawing ball animations
		.draw_ball:

			;Erase ball
			LDA #BALL_SIZE
			STA temp1,X
			.erase_loop_outer:
				LDY local_level,X
				LDA gfx_tests_bg_colors,Y
				LDY #BALL_SIZE
				.erase_loop:
					STA (ball_ptr,X)
					INC ball_ptr,X
					DEY
					BNE .erase_loop
				LDA ball_ptr,X
				SEC
				SBC #BALL_SIZE
				STA ball_ptr,X
				INC ball_ptr_hi,X
				DEC temp1,X
				BNE .erase_loop_outer
			LDA ball_ptr_hi,X
			SEC
			SBC #BALL_SIZE
			STA ball_ptr_hi,X
						
			;Calculate new ball position
			LDA ball_X,X
			CMP #(FRAME_WIDTH-BALL_SIZE)/2+1
			BCC .ball_up
			.ball_down:
				INC ball_Y,X
				INC ball_ptr_hi,X
				BRA .ball_vert_done
			.ball_up:
				DEC ball_Y,X
				DEC ball_ptr_hi,X
			.ball_vert_done:
			
			LDA ball_Y,X
			CMP #(FRAME_HEIGHT-BALL_SIZE)/2+1
			BCC .ball_right
			.ball_left:
				DEC ball_X,X
				DEC ball_ptr,X
				BRA .ball_horiz_done
			.ball_right:
				INC ball_X,X
				INC ball_ptr,X
			.ball_horiz_done:
			
			;Draw ball
			LDA #lo(gfx_tests_ball_image)
			STA gfx_ptr,X
			LDA #hi(gfx_tests_ball_image)
			STA gfx_ptr_hi,X
			LDA #BALL_SIZE
			STA temp1,X
			LDY local_level,X
			.ball_loop_outer:
				LDA #BALL_SIZE
				STA temp2,X	
				.ball_loop:
					LDA (gfx_ptr,X)
					BEQ .transparent
					BMI .white
					.fg_color:
						LDA gfx_tests_ball_colors,Y
						BRA .color_done
					.white:
						LDA #$3F
					.color_done:
					STA (ball_ptr,X)
					.transparent:
					INC gfx_ptr,X
					BNE .skip
						INC gfx_ptr_hi,X
					.skip:
					INC ball_ptr,X
					DEC temp2,X
					BNE .ball_loop
				LDA ball_ptr,X
				SEC
				SBC #BALL_SIZE
				STA ball_ptr,X
				INC ball_ptr_hi,X
				DEC temp1,X
				BNE .ball_loop_outer
			
			;Reset ball_ptr after drawing
			LDA ball_ptr_hi,X
			SEC
			SBC #BALL_SIZE
			STA ball_ptr_hi,X
			
			;Delay ~4 ms - otherwise frames way too fast
			LDA TIMER_MS4
			STA temp1,X
			.timer_loop:
				LDA TIMER_MS4
				CMP temp1,X
				BEQ .timer_loop
						
			;Next frame
			JMP .draw_ball	
		
		
		
	;Same as gfx_test2 with only one of eight patterns - emulation
	gfx_test4:
		DEFINE FRAME_WIDTH, 64
		DEFINE FRAME_HEIGHT, 64
		DEFINE BALL_SIZE, 9
		
		;Just declarations - no code generated
		LOCALS_START 0
			LOCAL local_level
			LOCAL origin
			LOCAL origin_hi
			LOCAL gfx_ptr
			LOCAL gfx_ptr_hi
			LOCAL temp1
			LOCAL temp2
			LOCAL ball_X
			LOCAL ball_Y
			LOCAL ball_ptr
			LOCAL ball_ptr_hi
		LOCALS_END
				
		;Make sure binary NOT compiled with parallel emulation
		IF PARALLEL_EMU = TRUE
			halt
			JMP *
		ENDIF
		
		;Initialize emulator
		STZ global_emu_level
		STZ global_temp_X
		LDA #EMULATOR_STACK_START+EMULATOR_STACK_SIZE-1
		STA global_temp_SP
		.emu_setup_loop:
			
			;Variables for each emulator thread
			LDX global_temp_X
			LDA global_emu_level
			STA emu_level,X
			STZ emu_ZP_hi,X
			LDA #1
			STA emu_SP_hi,X
			LDA #lo(.emu_start)
			STA emu_PC,X
			LDA #hi(.emu_start)
			STA emu_PC_hi,X
			
			;Keep emulated flags on stack
			LDX global_temp_SP
			TXS
			SEI
			CLD
			PHP
			TSX
			TXA
			LDX global_temp_X
			STA host_SP,X
			
			;Advance to next emulator thread
			LDA global_temp_X
			CLC
			ADC #emu_locals_size
			STA global_temp_X
			
			LDA global_temp_SP
			CLC
			ADC #EMULATOR_STACK_SIZE
			STA global_temp_SP
			
			INC global_emu_level
			LDA global_emu_level
			CMP #8
			BNE .emu_setup_loop
		
		;Switch to first emulator thread
		LDX host_SP
		TXS
		LDX #0
		STZ global_emu_level
		
		;Jump into emulation and don't return
		NEXT_MACRO
		
	
		
		;Emulation starts here
		.emu_start:
		
		;Drawing program SP
		LDA #EMULATED_STACK_START+EMULATED_STACK_SIZE-1
		LDY global_emu_level	;always reads correct level - managed by emulator
		.SP_loop:
			BEQ .SP_loop_done
			CLC
			ADC #EMULATED_STACK_SIZE
			DEY
			BRA .SP_loop
		.SP_loop_done:
		TAX
		TXS
		
		;Drawing program local data stack
		LDA #program_stacks
		LDY global_emu_level	;always reads correct level - managed by emulator
		.program_stacks_loop:
			BEQ .program_stacks_done
			CLC
			ADC #locals_size
			DEY
			BRA .program_stacks_loop
		.program_stacks_done:
		TAX
		LDA global_emu_level
		STA local_level,X
		
		;Calculate screen coordinates
		LDA local_level,X
		AND #3	;ie mod 4
		TAY
		LDA #0
		CPY #0
		.coord_loop:
			BEQ .coord_done
			CLC
			ADC #FRAME_WIDTH
			DEY
			BRA .coord_loop
		.coord_done:
		STA origin,X
		LDY #$40
		LDA local_level,X
		LSR
		LSR
		BEQ .y_coord_done
		LDY #$80
		.y_coord_done:
		STY origin_hi,X
		
		;Initialize ball
		LDY local_level,X
		LDA gfx_tests_ball_start_X,Y
		STA ball_X,X
		CLC
		ADC origin,X
		STA ball_ptr,X
		
		LDA gfx_tests_ball_start_Y,Y
		STA ball_Y,X
		CLC
		ADC origin_hi,X
		STA ball_ptr_hi,X
		
		;Draw background		
		LDA #FRAME_HEIGHT
		STA temp1,X
		LDA origin_hi,X
		STA gfx_ptr_hi,X
		.draw_loop_outer:
			LDA origin,X
			STA gfx_ptr,X
			LDY local_level,X
			LDA gfx_tests_bg_colors,Y
			LDY #FRAME_WIDTH
			.draw_loop:
				STA (gfx_ptr,X)
				INC gfx_ptr,X
				DEY
				BNE .draw_loop
			INC gfx_ptr_hi,X
			DEC temp1,X
			BNE .draw_loop_outer
		
		;Background drawing done - start drawing ball animations
		.draw_ball:

			;Erase ball
			LDA #BALL_SIZE
			STA temp1,X
			.erase_loop_outer:
				LDY local_level,X
				LDA gfx_tests_bg_colors,Y
				LDY #BALL_SIZE
				.erase_loop:
					STA (ball_ptr,X)
					INC ball_ptr,X
					DEY
					BNE .erase_loop
				LDA ball_ptr,X
				SEC
				SBC #BALL_SIZE
				STA ball_ptr,X
				INC ball_ptr_hi,X
				DEC temp1,X
				BNE .erase_loop_outer
			LDA ball_ptr_hi,X
			SEC
			SBC #BALL_SIZE
			STA ball_ptr_hi,X
						
			;Calculate new ball position
			LDA ball_X,X
			CMP #(FRAME_WIDTH-BALL_SIZE)/2+1
			BCC .ball_up
			.ball_down:
				INC ball_Y,X
				INC ball_ptr_hi,X
				BRA .ball_vert_done
			.ball_up:
				DEC ball_Y,X
				DEC ball_ptr_hi,X
			.ball_vert_done:
			
			LDA ball_Y,X
			CMP #(FRAME_HEIGHT-BALL_SIZE)/2+1
			BCC .ball_right
			.ball_left:
				DEC ball_X,X
				DEC ball_ptr,X
				BRA .ball_horiz_done
			.ball_right:
				INC ball_X,X
				INC ball_ptr,X
			.ball_horiz_done:
			
			;Draw ball
			LDA #lo(gfx_tests_ball_image)
			STA gfx_ptr,X
			LDA #hi(gfx_tests_ball_image)
			STA gfx_ptr_hi,X
			LDA #BALL_SIZE
			STA temp1,X
			LDY local_level,X
			.ball_loop_outer:
				LDA #BALL_SIZE
				STA temp2,X	
				.ball_loop:
					LDA (gfx_ptr,X)
					BEQ .transparent
					BMI .white
					.fg_color:
						LDA gfx_tests_ball_colors,Y
						BRA .color_done
					.white:
						LDA #$3F
					.color_done:
					STA (ball_ptr,X)
					.transparent:
					INC gfx_ptr,X
					BNE .skip
						INC gfx_ptr_hi,X
					.skip:
					INC ball_ptr,X
					DEC temp2,X
					BNE .ball_loop
				LDA ball_ptr,X
				SEC
				SBC #BALL_SIZE
				STA ball_ptr,X
				INC ball_ptr_hi,X
				DEC temp1,X
				BNE .ball_loop_outer
			
			;Reset ball_ptr after drawing
			LDA ball_ptr_hi,X
			SEC
			SBC #BALL_SIZE
			STA ball_ptr_hi,X
			
			;Delay ~4 ms - otherwise frames way too fast
			LDA TIMER_MS4
			STA temp1,X
			.timer_loop:
				LDA TIMER_MS4
				CMP temp1,X
				BEQ .timer_loop
						
			;Next frame
			JMP .draw_ball
	
	
	
	;Same as gfx_test2 with all eight patterns - parallel emulation
	gfx_test5:
		DEFINE FRAME_WIDTH, 64
		DEFINE FRAME_HEIGHT, 64
		DEFINE BALL_SIZE, 9
		
		;Just declarations - no code generated
		LOCALS_START 0
			LOCAL local_level
			LOCAL origin
			LOCAL origin_hi
			LOCAL gfx_ptr
			LOCAL gfx_ptr_hi
			LOCAL temp1
			LOCAL temp2
			LOCAL ball_X
			LOCAL ball_Y
			LOCAL ball_ptr
			LOCAL ball_ptr_hi
		LOCALS_END
				
		;Make sure binary compiled with parallel emulation
		IF PARALLEL_EMU = FALSE
			halt
			JMP *
		ENDIF
		
		;Initialize emulator
		STZ global_emu_level
		STZ global_temp_X
		LDA #EMULATOR_STACK_START+EMULATOR_STACK_SIZE-1
		STA global_temp_SP
		.emu_setup_loop:
			
			;Variables for each emulator thread
			LDX global_temp_X
			LDA global_emu_level
			STA emu_level,X
			STZ emu_ZP_hi,X
			LDA #1
			STA emu_SP_hi,X
			LDA #lo(.emu_start)
			STA emu_PC,X
			LDA #hi(.emu_start)
			STA emu_PC_hi,X
			
			;Keep emulated flags on stack
			LDX global_temp_SP
			TXS
			SEI
			CLD
			PHP
			TSX
			TXA
			LDX global_temp_X
			STA host_SP,X
			
			;Advance to next emulator thread
			LDA global_temp_X
			CLC
			ADC #emu_locals_size
			STA global_temp_X
			
			LDA global_temp_SP
			CLC
			ADC #EMULATOR_STACK_SIZE
			STA global_temp_SP
			
			INC global_emu_level
			LDA global_emu_level
			CMP #8
			BNE .emu_setup_loop
		
		;;Switch to last emulator thread - DOES NOT WORK!
		;DEC global_emu_level
		
		;Switch to first emulator thread
		STZ global_emu_level
		LDX host_SP
		TXS
		LDX #0
		
		;Jump into emulation and don't return
		NEXT_MACRO
		
	
		
		;Emulation starts here
		.emu_start:
		
		;Drawing program SP
		LDA #EMULATED_STACK_START+EMULATED_STACK_SIZE-1
		LDY global_emu_level	;always reads correct level - managed by emulator
		.SP_loop:
			BEQ .SP_loop_done
			CLC
			ADC #EMULATED_STACK_SIZE
			DEY
			BRA .SP_loop
		.SP_loop_done:
		TAX
		TXS
		
		;Drawing program local data stack
		LDA #program_stacks
		LDY global_emu_level	;always reads correct level - managed by emulator
		.program_stacks_loop:
			BEQ .program_stacks_done
			CLC
			ADC #locals_size
			DEY
			BRA .program_stacks_loop
		.program_stacks_done:
		TAX
		LDA global_emu_level
		STA local_level,X
		
		;Calculate screen coordinates
		LDA local_level,X
		AND #3	;ie mod 4
		TAY
		LDA #0
		CPY #0
		.coord_loop:
			BEQ .coord_done
			CLC
			ADC #FRAME_WIDTH
			DEY
			BRA .coord_loop
		.coord_done:
		STA origin,X
		LDY #$40
		LDA local_level,X
		LSR
		LSR
		BEQ .y_coord_done
		LDY #$80
		.y_coord_done:
		STY origin_hi,X
		
		;Initialize ball
		LDY local_level,X
		LDA gfx_tests_ball_start_X,Y
		STA ball_X,X
		CLC
		ADC origin,X
		STA ball_ptr,X
		
		LDA gfx_tests_ball_start_Y,Y
		STA ball_Y,X
		CLC
		ADC origin_hi,X
		STA ball_ptr_hi,X
		
		;Draw background		
		LDA #FRAME_HEIGHT
		STA temp1,X
		LDA origin_hi,X
		STA gfx_ptr_hi,X
		.draw_loop_outer:
			LDA origin,X
			STA gfx_ptr,X
			LDY local_level,X
			LDA gfx_tests_bg_colors,Y
			LDY #FRAME_WIDTH
			.draw_loop:
				STA (gfx_ptr,X)
				INC gfx_ptr,X
				DEY
				BNE .draw_loop
			INC gfx_ptr_hi,X
			DEC temp1,X
			BNE .draw_loop_outer
		
		;Background drawing done - start drawing ball animations
		.draw_ball:
		
			;Erase ball
			LDA #BALL_SIZE
			STA temp1,X
			.erase_loop_outer:
				LDY local_level,X
				LDA gfx_tests_bg_colors,Y
				LDY #BALL_SIZE
				.erase_loop:
					STA (ball_ptr,X)
					INC ball_ptr,X
					DEY
					BNE .erase_loop
				LDA ball_ptr,X
				SEC
				SBC #BALL_SIZE
				STA ball_ptr,X
				INC ball_ptr_hi,X
				DEC temp1,X
				BNE .erase_loop_outer
			LDA ball_ptr_hi,X
			SEC
			SBC #BALL_SIZE
			STA ball_ptr_hi,X
						
			;Calculate new ball position
			LDA ball_X,X
			CMP #(FRAME_WIDTH-BALL_SIZE)/2+1
			BCC .ball_up
			.ball_down:
				INC ball_Y,X
				INC ball_ptr_hi,X
				BRA .ball_vert_done
			.ball_up:
				DEC ball_Y,X
				DEC ball_ptr_hi,X
			.ball_vert_done:
			
			LDA ball_Y,X
			CMP #(FRAME_HEIGHT-BALL_SIZE)/2+1
			BCC .ball_right
			.ball_left:
				DEC ball_X,X
				DEC ball_ptr,X
				BRA .ball_horiz_done
			.ball_right:
				INC ball_X,X
				INC ball_ptr,X
			.ball_horiz_done:
			
			;Draw ball
			LDA #lo(gfx_tests_ball_image)
			STA gfx_ptr,X
			LDA #hi(gfx_tests_ball_image)
			STA gfx_ptr_hi,X
			LDA #BALL_SIZE
			STA temp1,X
			LDY local_level,X
			.ball_loop_outer:
				LDA #BALL_SIZE
				STA temp2,X	
				.ball_loop:
					LDA (gfx_ptr,X)
					BEQ .transparent
					BMI .white
					.fg_color:
						LDA gfx_tests_ball_colors,Y
						BRA .color_done
					.white:
						LDA #$3F
					.color_done:
					STA (ball_ptr,X)
					.transparent:
					INC gfx_ptr,X
					BNE .skip
						INC gfx_ptr_hi,X
					.skip:
					INC ball_ptr,X
					DEC temp2,X
					BNE .ball_loop
				LDA ball_ptr,X
				SEC
				SBC #BALL_SIZE
				STA ball_ptr,X
				INC ball_ptr_hi,X
				DEC temp1,X
				BNE .ball_loop_outer
			
			;Reset ball_ptr after drawing
			LDA ball_ptr_hi,X
			SEC
			SBC #BALL_SIZE
			STA ball_ptr_hi,X
			
			;Delay ~4 ms - otherwise frames way too fast
			LDA TIMER_MS4
			STA temp1,X
			.timer_loop:
				LDA TIMER_MS4
				CMP temp1,X
				BEQ .timer_loop
						
			;Next frame
			JMP .draw_ball