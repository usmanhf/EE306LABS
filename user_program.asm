.ORIG    x3000
             ; initialize the stack pointer
                          ; set up the keyboard interrupt vector table entry
                  
                       ; enable keyboard interrupts
; ==PROMPT==
Loop	LEA R0,prompt
	TRAP x22
	LD R0,lf
	TRAP x21
	JSR DELAY
	BR Loop
HALT
DELAY   ST  R1, SaveR1
        LD  R1, COUNT
REP     ADD R1,R1,#-1
        BRnp REP
        LD  R1, SaveR1
        RET
COUNT   .FILL #65535
lf	.FILL x000A
SaveR1  .BLKW 1
prompt .STRINGZ "Input a capital letter from the English alphabet:"

.END