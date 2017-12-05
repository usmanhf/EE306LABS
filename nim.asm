.ORIG x3000
AND R0,R0,x0000
ADD R0,R0,#-1
ST R0,TURNcheck
ADD R0,R0,#4
ST R0,numA
ADD R0,R0,#2
ST R0,numB
ADD R0,R0,#3
ST R0,numC

LEA R0,stackA
AND R1,R0,x0000
LD R1,o
STR R1,R0,#0
ADD R0,R0,#1
STR R1,R0,#0
ADD R0,R0,#1  
STR R1,R0,#0

LEA R0,stackB
AND R1,R0,x0000
LD R1,o
STR R1,R0,#0
ADD R0,R0,#1
STR R1,R0,#0
ADD R0,R0,#1  
STR R1,R0,#0
ADD R0,R0,#1  
STR R1,R0,#0
ADD R0,R0,#1  
STR R1,R0,#0

LEA R0,stackC
AND R1,R0,x0000
LD R1,o
STR R1,R0,#0
ADD R0,R0,#1
STR R1,R0,#0
ADD R0,R0,#1  
STR R1,R0,#0
ADD R0,R0,#1  
STR R1,R0,#0
ADD R0,R0,#1  
STR R1,R0,#0
ADD R0,R0,#1
STR R1,R0,#0
ADD R0,R0,#1  
STR R1,R0,#0
ADD R0,R0,#1  
STR R1,R0,#0

AND R0,R0,x0000
AND R1,R0,x0000
AND R2,R0,x0000
AND R3,R0,x0000
AND R4,R0,x0000
AND R5,R0,x0000
AND R6,R0,x0000

printROWS ST R0,SAVER0

LEA R6,ROWA; Loads the beginning of the string ROWA into R6
ROWAstring LDR R0,R6,#0
BRz printRowA
TRAP x21
ADD R6,R6,#1
BR ROWAstring

DoneA LD R0,newLine
TRAP x21

LEA R6,ROWB; Loads the beginning of the string ROWB into R6
ROWBstring LDR R0,R6,#0
BRz printRowB
TRAP x21
ADD R6,R6,#1
BR ROWBstring

DoneB LD R0,newLine
TRAP x21

LEA R6,ROWC; Loads the beginning of the string ROWC into R6
ROWCstring LDR R0,R6,#0
BRz printRowC
TRAP x21
ADD R6,R6,#1
BR ROWCstring

printRowA LEA R6,stackA; starts to print the remaining o's
loopPrintRowA LDR R0,R6,#0
BRz DoneA
TRAP x21
ADD R6,R6,#1
BR loopPrintRowA

printRowB LEA R6,stackB; starts to print the remaining o's
loopPrintRowB LDR R0,R6,#0
BRz DoneB
TRAP x21
ADD R6,R6,#1
BR loopPrintRowB

printRowC LEA R6,stackC; starts to print the remaining o's
loopPrintRowC LDR R0,R6,#0
BRz DoneC
TRAP x21
ADD R6,R6,#1
BR loopPrintRowC

DoneC LD R0,newLine
TRAP x21
LD R0,SAVER0
LD R1,SAVER1
LD R2,SAVER2
LD R3,SAVER3
LD R4,SAVER4
LD R5,SAVER5
LD R6,SAVER6
LD R7,SAVER7

JSR nextTurn
BR printROWS

nextTurn ST R0,SAVER0
ST R1,SAVER1
ST R2,SAVER2
ST R3,SAVER3
ST R4,SAVER4
ST R5,SAVER5
ST R6,SAVER6
ST R7,SAVER7

whoTURN LD R1,TURNcheck
BRp p2print

LEA R6,p1String; p1 turn string
loopPrintp1String LDR R0,R6,#0
BRz time4Input
TRAP x21
ADD R6,R6,#1
BR loopPrintp1String

p2print LEA R6,p2String; p1 turn string
loopPrintp2String LDR R0,R6,#0
BRz time4Input
TRAP x21
ADD R6,R6,#1
BR loopPrintp2String

time4Input TRAP x20
TRAP x21
ST R0,Input1
TRAP x20
TRAP x21
LD R1,neg0
ADD R0,R0,R1
BRnz invalidInput
ST R0,Input2

LD R2,Input1
LD R3,negA
ADD R3,R3,R2
BRz goodSoFarA
LD R3,negB
ADD R3,R3,R2
BRz goodSoFarB
LD R3,negC
ADD R3,R3,R2
BRz goodSoFarC
BR invalidInput

goodSoFarA
LD R2,numA
LD R3,Input2
NOT R3,R3
ADD R3,R3,#1
ADD R3,R2,R3
BRn invalidInput
ST R3,numA
LEA R4,stackA
ADD R4,R3,R4
AND R5,R5,#0
STR R5,R4,#0
BR goodInput

goodSoFarB
LD R2,numB
LD R3,Input2
NOT R3,R3
ADD R3,R3,#1
ADD R3,R2,R3
BRn invalidInput
ST R3,numB
LEA R4,stackB
ADD R4,R3,R4
AND R5,R5,#0
STR R5,R4,#0
BR goodInput

goodSoFarC
LD R2,numC
LD R3,Input2
NOT R3,R3
ADD R3,R3,#1
ADD R3,R2,R3
BRn invalidInput
ST R3,numC
LEA R4,stackC
ADD R4,R3,R4
AND R5,R5,#0
STR R5,R4,#0
BR goodInput


invalidInput LD R0,newLine; invalid input
TRAP x21

LEA R6,invalidString; invalid input string
loopPrintInvalid LDR R0,R6,#0
BRz invalidDone
TRAP x21
ADD R6,R6,#1
BR loopPrintInvalid

invalidDone LD R0,newLine
TRAP x21
BR whoTURN

goodInput LD R0,newLine
TRAP x21
LD R0,newLine
TRAP x21
LD R1,TURNcheck
BRn changeP2
ADD R1,R1,#-2
BR changePDone
changeP2 ADD R1,R1,#2
changePDone ST R1,TURNcheck

checkWIN LD R6,numA
BRp noWin
LD R6,numB
BRp noWin
LD R6,numC
BRz Win
BR noWin

noWin LD R0,SAVER0
LD R1,SAVER1
LD R2,SAVER2
LD R3,SAVER3
LD R4,SAVER4
LD R5,SAVER5
LD R6,SAVER6
LD R7,SAVER7

RET

Win LD R1,TURNcheck
BRn p1WIN

LEA R6,p2WINstring; p2 WIN string
loopPrintp2WINString LDR R0,R6,#0
BRz DONEDONE
TRAP x21
ADD R6,R6,#1
BR loopPrintp2WINString

p1WIN LEA R6,p1WINstring; p1 WIN string
loopPrintp1WINString LDR R0,R6,#0
BRz DONEDONE
TRAP x21
ADD R6,R6,#1
BR loopPrintp1WINString


DONEDONE ADD R0,R0,#0

HALT
TURNcheck .FILL #-1
stackA .BLKW #4
stackB .BLKW #6
stackC .BLKW #9
numA .BLKW #1
numB .BLKW #1
numC .BLKW #1
o .FILL x006F
invalidString .STRINGZ "Invalid move. Try again."
SAVER0 .BLKW #1
SAVER1 .BLKW #1
SAVER2 .BLKW #1
SAVER3 .BLKW #1
SAVER4 .BLKW #1
SAVER5 .BLKW #1
SAVER6 .BLKW #1
SAVER7 .BLKW #1
Input1 .BLKW #1
Input2 .BLKW #1
neg0 .FILL #-48
negA .FILL #-65
negB .FILL #-66
negC .FILL #-67
newLine .FILL x000A
ROWA .STRINGZ "ROW A: "
ROWB .STRINGZ "ROW B: "
ROWC .STRINGZ "ROW C: "
p1String .STRINGZ "Player 1, choose a row and number of rocks: "
p2String .STRINGZ "Player 2, choose a row and number of rocks: "
p1WINstring .STRINGZ "Player 1 Wins."
p2WINstring .STRINGZ "Player 2 Wins."
.END