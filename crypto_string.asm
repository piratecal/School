.ORIG x3000
	LEA R0, P1 		
	PUTS 			;output prompt #1
	AND R2, R2, #0
	AND R3, R3, #0
	
	LEA R1, INP 	;reserves 15 blocks of memory for the string
	LD R2, LIMIT	;sets R2 to 15

STRING	
	GETC 			;get character typed on kybd into R0 |2.
	OUT				;echoes char |3.
	STR R0, R1, #0
	ADD R1, R1, #1
	ADD R0, R0, #-10
	ADD R2, R2, #-1 ;decrement loop
	BRnp STRING
	
	
	
	HALT 			;halts the program |14.
	
	LF	.FILL x0A
	
	INP .BLKW 15
	
	P1	.STRINGZ "ENTER STRING TO BE DECODED:"
	LIMIT .FILL #15
	
	.END