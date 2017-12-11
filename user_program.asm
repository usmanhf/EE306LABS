.ORIG    x3000
	; initialize the stack pointer
	LD R6,USRSP
	LD R1,INTloc
        ; set up the keyboard interrupt vector table entry
        STI R1,INTSP
        ; enable keyboard interrupts
	LDI R2,KBSR
	LD R3,MASKBIT
	NOT R2,R2
	NOT R3,R3
	AND R2,R3,R2
	NOT R2,R2
	STI R2,KBSR

; ==PROMPT==
Loop	LEA R0,prompt
	TRAP x22
	LD R0,lf
	TRAP x21
	JSR DELAY
	BR Loop

USRSP	.FILL x3000
INTSP	.FILL x0180
INTloc	.FILL x1500
KBSR	.FILL xFE00
MASKBIT	.FILL x4000
COUNT   .FILL #65535
lf	.FILL x000A
SaveR1  .BLKW 1
prompt .STRINGZ "Input a capital letter from the English alphabet:"

;==DELAY==
DELAY   ST  R1, SaveR1
        LD  R1, COUNT
REP     ADD R1,R1,#-1
        BRnp REP
        LD  R1, SaveR1
        RET

.END