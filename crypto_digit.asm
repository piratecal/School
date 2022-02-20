.ORIG x3000
LEA R0, P2 		;prompt for seed number output
	PUTS
	GETC			;get seed number
	OUT				;echoes character, keeps it displayed
	ADD R1, R0, #0
	
	LD R0, m48
	ADD R1, R1, R0
	LEA R0, P2
	PUTS
LOOP
	GETC
	OUT
	ADD R2, R0, #0
	LD R0, m48
	ADD R2, R2, R0
	ADD R3, R1, R2
	OUT
	
OUTSIDE
	
	LEA R0, P3
	PUTS
	
	LD R0, p48
	ADD R0, R3, R0
	OUT
	
		HALT 			;halts the program |14.
	

	
	P1	.STRINGZ "ENTER STRING TO BE DECODED:"
	P2	.STRINGZ "\nENTER A SEED NUMBER:"
	P3	.STRINGZ "SUM: "
	p48 .FILL #48
	m48	.FILL #-48
	
	.END