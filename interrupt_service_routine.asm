.ORIG     x1500

	ST R0,SAVER0
	ST R1,SAVER1
	ST R2,SAVER2
	ST R3,SAVER3
	ST R4,SAVER4
	ST R5,SAVER5
	ST R6,SAVER6
	ST R7,SAVER7

;==Interrupt service routine==

	LD R3,lf
	JSR print
	LDI R0,KBDR
	LD R2,min
	ADD R2,R0,R2
	BRn Invalid
	LD R2,max
	ADD R2,R0,R2
	BRp Invalid

	LEA R1,goodP1
out1	LDR R3,R1,#0
	BRz Done1
	JSR print
	ADD R1,R1,#1
	BR out1
Done1	LDR R3,R0,#0
	JSR print
	LEA R1,goodP2
out2	LDR R3,R1,#0
	BRz Done2
	JSR print
	ADD R1,R1,#1
	BR out2
Done2 	LD R5,convert
	ADD R0,R0,R5
	LDR R3,R0,#0
	JSR print
	LD R3,period
	JSR print
	BR Done

Invalid	LDR R3,R0,#0
	JSR print
	LEA R1,bad
outLoop	LDR R3,R1,#0
	BRz Done
	JSR print
	ADD R1,R1,#1
	BR outLoop

Done	LD R3,lf
	JSR print

	LD R0,SAVER0
	LD R1,SAVER1
	LD R2,SAVER2
	LD R3,SAVER3
	LD R4,SAVER4
	LD R5,SAVER5
	LD R6,SAVER6
	LD R7,SAVER7

        RTI

;==OUT PRINTS==

print	LDI R4,DSR	;Check DSR
	BRzp print
	STI R3,DDR	;Prints by storing R0 to the DDR
	RET
	
;==STORED MEMORY==

DSR	.FILL xFE04
DDR	.FILL xFE06
KBDR	.FILL xFE02
lf	.FILL x000A
min	.FILL #-65
max	.FILL #-90
convert .FILL #32
bad	.STRINGZ " is not a capital letter in the English alphabet."
goodP1	.STRINGZ "The lower case character of "
goodP2	.STRINGZ " is "
period	.FILL x002E
SAVER0	.BLKW #1
SAVER1	.BLKW #1
SAVER2	.BLKW #1
SAVER3	.BLKW #1
SAVER4	.BLKW #1
SAVER5	.BLKW #1
SAVER6	.BLKW #1
SAVER7	.BLKW #1

.END	  