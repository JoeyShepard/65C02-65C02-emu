;General macros - included before anything else
;==============================================

;Defining constants - looks better than not allowing indentation
DEFINE MACRO symbol, value
symbol set value
	ENDM

DEFINE_EQU MACRO symbol, value
symbol equ value
	ENDM

;Zero page variables
ZP_START MACRO ptr
	DEFINE zp_begin, ptr
	DEFINE zp_address, ptr
	ENDM
			
ZP MACRO var
	DEFINE var, zp_address
	DEFINE zp_address, zp_address+1
	ENDM
	
ZP_END MACRO
	DEFINE zp_end, zp_address
	DEFINE zp_size, zp_address-zp_begin
	ENDM
	
;Local variables - each emu level gets a copy
	DEFINE locals_block_counter, 0

LOCALS_START MACRO ptr
	DEFINE locals_begin, ptr
	DEFINE local_address, ptr
	ENDM

LOCAL MACRO var
	DEFINE var, local_address
	DEFINE local_address, local_address+1
	ENDM

LOCALS_END MACRO
	DEFINE locals_end, local_address
	DEFINE locals_size, locals_end-locals_begin
	DEFINE locals_block_counter, locals_block_counter+1
	DEFINE temp, "\{locals_block_counter}"
	DEFINE_EQU locals_end_{temp}, *
	ENDM
		
;Misc
halt MACRO
	BRK
	BRK
	ENDM
	
LOAD16 MACRO val
	LDA #lo(val)
	LDX #hi(val)
	ENDM
	
hi FUNCTION x,(x/256)
lo FUNCTION x,(x#256)
		