	.ORIG x3000
	LD	R6,STACKBASE; Stack pointer
LOOP    LEA 	R0,prompt
	TRAP 	x22
	LEA	R1,UserInput
	AND	R0,R0,#0
	ADD	R2,R0,#-21
CLEAR	STR	R0,R1,#0
	ADD	R1,R1,#1
	ADD	R2,R2,#1
	BRn	CLEAR
	LEA	R1,UserInput
INPUT	TRAP	x20
	TRAP	x21
	NOT 	R2,R0
	ADD 	R2,R2,#1
	LD	R4,ENTER
	ADD	R3,R2,R4
	BRz	CHECK
	STR 	R2,R1,#0
	ADD 	R1,R1,#1
	BR	INPUT
CHECK	LEA	R1,UserInput
	LDR	R2,R1,#0
	LD	R3,d
	ADD	R2,R2,R3
	BRnp	Test
	LDR	R2,R1,#1
	BRnp	Test
	Halt
Test	LDI	R4,root
	ADD	R4,R4,#2
	

; Subroutine that prints a positive 2's complement number on the display
; Input Register: R0 (positive 2's complement number)
; Output Registers: None
; Algorithm: The subroutine keeps dividing the input number by 10. It stores 
;            the remainder of each division in some sequential storage growing
;            backwards. When the quotient of the division hits zero, it prints
;            the stored digits in the reverse order and returns.
PRINT_NUM        ST   R0, PRINT_NUM_SAVER0
                 ST   R1, PRINT_NUM_SAVER1
                 ST   R6, PRINT_NUM_SAVER6
                 ST   R7, PRINT_NUM_SAVER7

                 LEA  R6, PRINT_NUM_LF ; initialize the local stack pointer
PRINT_NUM_AGAIN  JSR  DIV10            ; Extract next digit by dividing by 10
                 ADD  R6, R6, #-1
                 LD   R7, PRINT_NUM_HEX30
                 ADD  R0, R0, R7       ; Convert the single digit to ASCII
                 STR  R0, R6, #0       ; push the ASCII digit onto the stack
                 ADD  R1, R1, #0
                 BRz  PRINT_NUM_DONE   ; If the quotient is zero, we are ready to print
                 ADD  R0, R1, #0
                 BR   PRINT_NUM_AGAIN
PRINT_NUM_DONE   ADD  R0, R6, #0
                 TRAP x22              ; Print all the digits in the reverse order
                 LD   R0, PRINT_NUM_SAVER0
                 LD   R1, PRINT_NUM_SAVER1
                 LD   R6, PRINT_NUM_SAVER6
                 LD   R7, PRINT_NUM_SAVER7
                 RET

PRINT_NUM_STACK  .BLKW 5
PRINT_NUM_LF     .FILL x000A  
PRINT_NUM_NULL   .FILL x0000
PRINT_NUM_HEX30  .FILL x0030
PRINT_NUM_SAVER0 .BLKW 1
PRINT_NUM_SAVER1 .BLKW 1
PRINT_NUM_SAVER6 .BLKW 1
PRINT_NUM_SAVER7 .BLKW 1

; Subroutine for dividing a number by 10
; Input: R0 (the dividend)
; Outputs: R0 (the remainder), R1(the quotient)
DIV10            AND  R1, R1, #0
DIV10_AGAIN      ADD  R0, R0, #-10
                 BRn  DIV10_DONE
                 ADD  R1, R1, #1
                 BR   DIV10_AGAIN
DIV10_DONE       ADD  R0, R0, #10
                 RET
root		.FILL x4000
d		.FILL x0064
ENTER		.FILL x000A
notFound	.STRINGZ "No Entry"
prompt 		.STRINGZ "Type a professor's name and then press Enter:"
UserInput	.BLKW #21
	.END