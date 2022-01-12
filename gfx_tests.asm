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
		
		;Just declarations - no code generated
		LOCALS_START 0
			LOCAL local_level
			LOCAL color
			LOCAL origin
			LOCAL origin_hi
			LOCAL gfx_ptr
			LOCAL gfx_ptr_hi
			LOCAL counter1
			LOCAL counter2
		LOCALS_END
		
		;Run once before any instance loads
		STZ test_level
		
		.new_frame:
		;Allocate part of data stack for this instance
		LDA test_level
		TAY
		JSR alloc_prog_stack
		STY local_level,X
		
		halt
		
		;Background color
		LDA gfx_test2_colors,Y
		STA color,X
		
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
				LDA color,X
				STA (gfx_ptr,X)
				INC gfx_ptr,X
				DEY
				BNE .draw_loop
			INC gfx_ptr_hi,X
			DEC counter1,X
			BNE .draw_loop_outer
		
		
		;Debug
		;=====
		
		;Advance to next frame
		LDA test_level
		INC
		CMP #8
		BNE .level_reset_done
		LDA #0
		.level_reset_done:
		STA test_level
		JMP .new_frame
			
	gfx_test2_colors:
		FCB $03		;Red
		FCB $0C		;Green
		FCB $30		;Blue
		FCB $33		;Purple
		FCB $3C		;Cyan
		FCB $0F		;Yellow
		FCB $2A		;Light gray
		FCB $15		;Dark gray
			
			
			
			
			
			
			
			
	;Helper function to calculate program stacks
	alloc_prog_stack:
		TAX
		BEQ .loop_done
		LDA #0
		CLC
		.loop:
			ADC #locals_size
			DEX
			BNE .loop
		.loop_done:
		CLC
		ADC #program_stacks
		TAX
		RTS
		
		
		
		