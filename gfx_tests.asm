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
			LOCAL ball_color
			LOCAL bg_color
			LOCAL origin
			LOCAL origin_hi
			LOCAL gfx_ptr
			LOCAL gfx_ptr_hi
			LOCAL counter1
			LOCAL counter2
			LOCAL SP,X
		LOCALS_END
		
		;Run once before any instance loads
		STZ test_level
		
		.draw_bg:
		;Allocate data stack
		LDA #0
		LDX test_level
		BEQ .ds_loop_done
		CLC
		.ds_loop:
			ADC #locals_size
			DEX
			BNE .ds_loop
		.ds_loop_done:
		CLC
		ADC #program_stacks
		TAX
		LDY test_level
		STY local_level,X
		
		;Set return stack pointer
		INY
		LDA #0
		.rs_loop:
			CLC
			ADC #GFX_STACK_SIZE
			DEY
			BNE .rs_loop
		STX test_temp
		TAX
		TXS
		LDX test_temp
		
		;Background and ball colors
		LDY local_level,X
		LDA gfx_test2_bg_colors,Y
		STA bg_color,X
		LDA gfx_test2_ball_colors,Y
		STA ball_color,X
		
		;Calculate screen coordinates
		LDA local_level,X
		AND #3	;ie mod 4
		TAY
		LDA #0
		CPY #0
		.color_loop:
			BEQ .color_done
			CLC
			ADC #FRAME_WIDTH
			DEY
			BRA .color_loop
		.color_done:
		STA origin,X
		LDY #$40
		LDA local_level,X
		LSR
		LSR
		BEQ .y_coord_done
		LDY #$80
		.y_coord_done:
		STY origin_hi,X
		
		;Draw background
		LDA #FRAME_HEIGHT
		STA counter1,X
		LDA origin_hi,X
		STA gfx_ptr_hi,X
		.draw_loop_outer:
			LDA origin,X
			STA gfx_ptr,X
			LDY #FRAME_WIDTH
			.draw_loop:
				LDA bg_color,X
				STA (gfx_ptr,X)
				INC gfx_ptr,X
				DEY
				BNE .draw_loop
			INC gfx_ptr_hi,X
			DEC counter1,X
			BNE .draw_loop_outer
		
		;Advance to next background drawing
		LDA test_level
		INC
		CMP #8
		STA test_level
		BEQ .begin_ball_drawing
		JMP .draw_bg
		
		;Background drawing done - start drawing ball animations
		.begin_ball_drawing:
		;STZ test_level
		.draw_ball:
		
			halt
		
			;Save SP
			STX test_temp
			TSX
			TXA
			LDX test_temp
			STA SP,X
			
			;Calculate next frame's data stack pointer
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
			STA test_temp
			
			halt
			
			;Load new SP
			LDA SP,X
			TAX
			TXS
			LDX test_temp
			
			;Draw ball
			LDA ball_color,X
			STA (origin,X)
			
			;Next frame
			JMP .draw_ball
			
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
			
			
			
			
			
			
	
		
		