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
		DEFINE X_COUNT, 4
		DEFINE GFX_STACK_SIZE, 8
		
		;Just declarations - no code generated
		LOCALS_START 0
			LOCAL local_level
			LOCAL color_temp
			LOCAL origin
			LOCAL origin_hi
			LOCAL gfx_ptr
			LOCAL gfx_ptr_hi
			LOCAL counter1
			LOCAL ball_X
			LOCAL ball_Y
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
		LDA #16
		STA ball_X,X
		STA ball_Y,X
		
		;Draw background
		STA color_temp,X		
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
		
		halt
		
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
			
			halt
			
			;Erase ball
			LDA origin,X
			CLC
			ADC ball_X,X
			STA gfx_ptr
			LDA origin_hi,X
			;CLC - above should never overflow
			ADC ball_Y,X
			STA gfx_ptr_hi,X
			LDY local_level,X
			LDA gfx_test2_bg_colors,Y
			STA (gfx_ptr,X)
			
			;Calculate new ball position
			LDA ball_X,X
			CMP #FRAME_WIDTH/2
			BCC .ball_up
			.ball_down:
				INC ball_Y,X
				INC gfx_ptr_hi,X
				BRA .ball_vert_done
			.ball_up:
				DEC ball_Y,X
				DEC gfx_ptr_hi,X
			.ball_vert_done:
			
			LDA ball_Y,X
			CMP #FRAME_HEIGHT/2
			BCC .ball_right
			.ball_left:
				DEC ball_X,X
				DEC gfx_ptr,X
				BRA .ball_horiz_done
			.ball_right:
				INC ball_X,X
				INC gfx_ptr,X
			.ball_horiz_done:
			
			;Draw ball
			LDY local_level,X
			LDA gfx_test2_ball_colors,Y
			STA (gfx_ptr,X)
			
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
			
			
			
			
			
			
	
		
		