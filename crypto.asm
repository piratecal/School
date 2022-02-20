;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~ECE 109~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~Programming Assignment 1~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~Calder Brown~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~This program takes input string and offsets each character based on an input decimal value~~~~~~~~~~~~~~
;~~~~~~~~Enter a string of up to 15 characters in length~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~Enter a digit 0-9~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
;~~~~~~~~~~~The program will return the decoded string~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
.ORIG x3000
	LEA R0, P1 		;loads prompt 1 into R0
	PUTS 			;output prompt #1
	
	LEA R1, INP 	;Loads the address of the 15 reserved memory blocks into R1
	LD R2, LIMIT	;Loads the value of 15 into the counter to decrement every loop

; 
;	Get string and store in memory
;

STRING	
	GETC 			;get character typed on kybd into R0
	OUT				;echoes char
	ADD R4, R0, #-10;checks if the char entered was a enter (ASCII #10)
	BRz NUMBER		;starts NUMBER if enter was pressed
	STR R0, R1, #0	;stores char
	ADD R1, R1, #1	;increments index
	ADD R2, R2, #-1 ;decrement loop
	
	BRp STRING		;continues the loop until the counter hits zero

;
;	Get value of decimal, store in Register 1
;	
	
NUMBER	
	LEA R0, P2 		;prompt for seed number output
	PUTS			;outputs string loaded into R0
	GETC			;get seed number
	OUT				;echoes character, keeps it displayed
	ADD R1, R0, #0	;transfer ASCII value of char into R1
	LD R0, n48		;Load value of -48 into R0
	ADD R1, R1, R0	;Add value of -48 to ASCII value, changing it to its decimal value, store in R1

;	
;	Add decimal value of offset to ASCII value of each char in string, reinsert into same memory position
;	
	
	LEA R3, INP		;Loads starting address of the input string into R3
	LD R2, LIMIT	;Sets counter for loop
	

DECRYPT
	LDR R0, R3, #0 	;Loads contents of stored string into R0
	ADD R0, R1, R0	;Adds offset to ASCII for char
	ADD R1, R1, #2	;increments the value of the offset by 2
	STR R0, R3, #0	;Store the decrypted character
	ADD R3, R3, #1	;Increment pointer
	ADD R2, R2, #-1	;Decrements max count of characters
	
	BRp DECRYPT
	BR	OUTPUT
	
;
;	Print final prompt and decoded string
;	

OUTPUT
	LEA R0, P3 		;Loads the third prompt into R0
	PUTS			;Prints the third prompt
	
	LEA R3, INP		;Loads the initial location of the input in memory
	LD R2, LIMIT	;Loads the limit into R2, will decrement and stop loop when max has been hit.
	
PRINTOUT
	LDR R0, R3, #0	;Loads the first character into R0 to be output based on where in the memory R3 is pointing
	OUT				;outputs character loaded into R0
	ADD R3, R3, #1	;increments R3 to point to the next memory location (where the next character is located in the memory)
	ADD R2, R2, #-1	;decrements the counter with the max loaded into it
	BRp PRINTOUT	;continues the loop until the counter hits zero
	
	
	HALT 			;halts the program
	
	INP .BLKW 15
	LIMIT .FILL #15
	
	P1	.STRINGZ "ENTER STRING TO BE DECODED: "
	P2	.STRINGZ "\nENTER A SEED NUMBER: "
	P3	.STRINGZ "\nTHE DECODED STRING IS: "
	
	p48 .FILL #48
	n48	.FILL #-48

	
	.END