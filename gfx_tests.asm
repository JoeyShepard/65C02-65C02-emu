;Graphical tests to demonstrate emulator functionality
;=====================================================

	;Simple pattern
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
		
	;Eight patterns on screen at once
	gfx_test2:
		DEFINE FRAME_WIDTH, 64
		DEFINE FRAME_HEIGHT, 64
		DEFINE BALL_SIZE, 8
		
		;Just declarations - no code generated
		LOCALS_START 0
			LOCAL local_level
			LOCAL origin
			LOCAL origin_hi
			LOCAL gfx_ptr
			LOCAL gfx_ptr_hi
			LOCAL counter1
			LOCAL counter2
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
		LDY #local_level
		LDA gfx_test2_ball_start_X,Y
		STA ball_X,X
		CLC
		ADC origin,X
		STA ball_ptr,X
		
		LDA gfx_test2_ball_start_Y,Y
		STA ball_Y,X
		CLC
		ADC origin_hi,X
		STA ball_ptr_hi,X
		
		;Draw background		
		LDA #FRAME_HEIGHT
		STA counter1,X
		LDA origin_hi,X
		STA gfx_ptr_hi,X
		.draw_loop_outer:
			LDA origin,X
			STA gfx_ptr,X
			LDY local_level,X
			LDA gfx_test2_bg_colors,Y
			LDY #FRAME_WIDTH
			.draw_loop:
				STA (gfx_ptr,X)
				INC gfx_ptr,X
				DEY
				BNE .draw_loop
			INC gfx_ptr_hi,X
			DEC counter1,X
			BNE .draw_loop_outer
		
		;DEBUG - non-emulation version only
		LDA test_level
		INC
		CMP #8
		STA test_level
		BEQ .bg_done
		TXA
		CLC
		ADC #locals_size
		TAX
		JMP .emu_start
		.bg_done:
		LDX #program_stacks
		
		;Background drawing done - start drawing ball animations
		.draw_ball:

			;Erase ball
			LDA #BALL_SIZE
			STA counter1,X
			.erase_loop_outer:
				LDY local_level,X
				LDA gfx_test2_bg_colors,Y
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
				DEC counter1,X
				BNE .erase_loop_outer
			LDA ball_ptr_hi,X
			SEC
			SBC #BALL_SIZE
			STA ball_ptr_hi,X
						
			;Calculate new ball position
			LDA ball_X,X
			STA DEBUG_DEC
			LDA #','
			STA DEBUG 
			LDA ball_Y,X
			STA DEBUG_DEC
			LDA #' '
			STA DEBUG
			LDA #'-'
			STA DEBUG
			LDA #' '
			STA DEBUG
			
			LDA ball_Y,X
			STA counter1,X
			LDA ball_X,X
			CMP #(FRAME_WIDTH-BALL_SIZE)/2-1
			BCC .ball_up
			.ball_down:
				INC ball_Y,X
				INC ball_ptr_hi,X
				BRA .ball_vert_done
			.ball_up:
				DEC ball_Y,X
				DEC ball_ptr_hi,X
			.ball_vert_done:
			
			LDA counter1,X
			CMP #(FRAME_HEIGHT-BALL_SIZE)/2-1
			BCC .ball_right
			.ball_left:
				DEC ball_X,X
				DEC ball_ptr,X
				BRA .ball_horiz_done
			.ball_right:
				INC ball_X,X
				INC ball_ptr,X
			.ball_horiz_done:
			
			LDA ball_X,X
			STA DEBUG_DEC
			LDA #','
			STA DEBUG 
			LDA ball_Y,X
			STA DEBUG_DEC
			LDA #10
			STA DEBUG
			
			;Draw ball
			LDA #lo(gfx_test2_ball_image)
			STA gfx_ptr,X
			LDA #hi(gfx_test2_ball_image)
			STA gfx_ptr_hi,X
			LDA #BALL_SIZE
			STA counter1,X
			LDY local_level,X
			.ball_loop_outer:
				LDA #BALL_SIZE
				STA counter2,X	
				.ball_loop:
					LDA (gfx_ptr,X)
					BEQ .transparent
					BMI .white
					.fg_color:
						LDA gfx_test2_ball_colors,Y
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
					DEC counter2,X
					BNE .ball_loop
				LDA ball_ptr,X
				SEC
				SBC #BALL_SIZE
				STA ball_ptr,X
				INC ball_ptr_hi,X
				DEC counter1,X
				BNE .ball_loop_outer
			
			;Reset ball_ptr after drawing
			LDA ball_ptr_hi,X
			SEC
			SBC #BALL_SIZE
			STA ball_ptr_hi,X
						
			halt
						
			;Next frame
			JMP .draw_ball
			
			;DEBUG - non-emulation version only
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
			
			
			
	gfx_test2_bg_colors:
		FCB $01		;Red
		FCB $04		;Green
		FCB $10		;Blue
		FCB $11		;Purple
		FCB $14		;Cyan
		FCB $05		;Yellow
		FCB $15		;Dark gray
		FCB $00		;Black
			
	gfx_test2_ball_colors:
		FCB $03		;Red
		FCB $0C		;Green
		FCB $30		;Blue
		FCB $33		;Purple
		FCB $3C		;Cyan
		FCB $0F		;Yellow
		FCB $3F		;White
		FCB $2A		;Light gray
			
	gfx_test2_ball_image:
		FCB	$00, $00, $FF, $FF, $FF, $FF, $00, $00
		FCB $00, $FF, $01, $01, $01, $01, $FF, $00
		FCB $FF, $01, $01, $01, $FF, $01, $01, $FF
		FCB $FF, $01, $01, $01, $01, $FF, $01, $FF
		FCB $FF, $01, $01, $01, $01, $01, $01, $FF
		FCB $FF, $01, $01, $01, $01, $01, $01, $FF
		FCB $00, $FF, $01, $01, $01, $01, $FF, $00	
		FCB	$00, $00, $FF, $FF, $FF, $FF, $00, $00	
		
	gfx_test2_ball_start_X:
		FCB 13
	
	gfx_test2_ball_start_Y:
		FCB 13
			
			
	
		
		