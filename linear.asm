;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ECE 109~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Programming Assignment 2~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Calder Brown~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~This program accepts three inputs: one for slope, one for y-intercept, and one for color.~~~~~~~~~~~~~
;Enter a number inbetween 0 and 3 for slope (attempted to implement -3 to 0 as well, ran out of time)~~~~~~~
;~~~~~~~~~~Lines that have been commented out illustrate thinking towards solving this problem.~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~A digit -6 to +6 for y-intercept~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~Enter a character corresponding to a color or to clear the display~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~The program will print the line in the color selected by the user~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.ORIG x3000

CLDR1
	LD R2, COUNT
	LD R0, BLACK
	LD R1, START
CLDR2
	AND R0, R0, #0
	STR R1, R0, #0		;stores color black at pointer
	ADD R1, R1, #1		;increments pointer
	ADD R2, R2, #-1		;decrements counter 
	BRp CLDR2			;loops until counter = 0
RESTART
	AND R0, R0, #0		;clear registers
	AND R1, R1, #0		;clear registers
	AND R2, R2, #0		;clear registers
	AND R3, R3, #0		;clear registers
	AND R4, R4, #0		;clear registers
	AND R5, R5, #0		;clear registers
	AND R6, R6, #0		;clear registers
	
	
	LD R2, YADD			;loads values into registers to begin drawing axes
	LD R3, YADD
	LD R0, WHITE
	LD R1, YST
YAXES					;loop to draw y-axes
	STR R0, R1, #0
	ADD R1, R1, R3
	ADD R2, R2, #-1
	BRp YAXES
	
	LD R0, WHITE		;loads values into registers to draw x axes
	LD R2, YADD
	LD R1, XST
XAXES					;loop to draw x-axes
	STR R0, R1, #0		
	ADD R1, R1, #1
	ADD R2, R2, #-1
	BRp XAXES
RETSLOPE	
	LEA R0, P1			;loads prompt for slope
	PUTS				;outputs prompt
	
	LD R1, ASCIIOFF
	;LD R2, NEGOFF
	LD R2, TRIOFF
	LD R3, NEGADD
	LD R6, TRIADD
SLOPE
	GETC
	OUT
	ADD R0, R0, R2					;method that determines if number is in between 0 and 3
	BRp RETSLOPE
	ADD R0, R0, R6
	;ADD R0, R0, R2		;check if first character is (-)
	;BRz NEGSLOPE		;branch if frist character is (-)
	;ADD R0, R0, R3		;add back to get value back if not (-)
	ADD R3, R0, R1		;decimal value of char in R3
	;BRnzp INTE			;unconditional branch to intercept if not negative slope

;NEGSLOPE
	;GETC				;if first character is (-), take next character
	;OUT				;echo character
	;ADD R3, R0, R1		;decimal value of char in R3
	;NOT R3, R3
	;ADD R3, R3, #1		;get 2sC of slope in R3
RETINTE	
	LD R2, NEGOFF
	LD R6, NEGADD
	LEA R0, P3
	PUTS
	AND R0, R0, #0		;R0 is 0
INTE
	;LEA R0, P3
	;PUTS
	;AND R0, R0, #0		;R0 is 0
	GETC				;R0 is ASCII value of char
	OUT
						;NEED method that determines if number is in between 6 - (-6)
	ADD R0, R0, R2		;check if first character is (-)
	BRz NEGINTE			;branch if first character is (-)
	ADD R0, R0, R6		;add back to get value back if not (-)
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R0, R0, #-6
	BRp RETINTE			;loops back if value >6
	
MULTI
	ADD R4, R0, R1		;decimal value of intercept in R4
	BRnzp MULTIPLY

NEGINTE					;method to calculate the 2sC if a negative sign is pressed by user
	GETC
	OUT
	ADD R0, R0, #-12	;check if absolute value of # is >6
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R0, R0, #-12
	ADD R0, R0, #-6
	BRp RETINTE			;loops back if value >6
	ADD R4, R0, R1		;get 2sC of number
	NOT R4, R4
	ADD R4, R4, #1

MULTIPLY	
	ADD R5, R4, R5
	ADD R4, R4, R5		;x2
	ADD R4, R4, R5		;x3
	ADD R4, R4, R5		;x4
	ADD R4, R4, R5		;x5
	ADD R4, R4, R5		;x6
	ADD R4, R4, R5		;x7
	ADD R4, R4, R5		;x8
	ADD R4, R4, R5		;x9
	ADD R4, R4, R5		;x10
	NOT R4, R4
	ADD R4, R4, #1		;gets 2sC of intercept to subtract from 127
	
	LEA R0, P2 			;loads prompt 3 into R0
	PUTS 				;output prompt 3
C1
	GETC				;gets character entered into R0
	OUT					;echoes input char
	LD R1, D1			;load nagative ASCII offset
	ADD R0, R0, R1		;test if character entered
	BRz R				;branch if character matches
	LD R1, N1			;add back offset
	ADD R0, R0, R1		;continue doing this for each possible entered character
	LD R1, D2
	ADD R0, R0, R1
	BRz G
	LD R1, N2
	ADD R0, R0, R1
	LD R1, D3
	ADD R0, R0, R1
	BRz B
	LD R1, N3
	ADD R0, R0, R1
	LD R1, D4
	ADD R0, R0, R1
	BRz Y
	LD R1, N4
	ADD R0, R0, R1
	LD R1, D5
	ADD R0, R0, R1
	BRz CLDR1
	LD R1, N5
	ADD R0, R0, R1
	LD R1, D6
	ADD R0, R0, R1
	BRz CLOSE
	BRnzp C1

R
	LD R2, RED			;load R2 with hex code of color if branched here
	BRnzp COMPUTE		;unconditionally branch out to begin computation
G
	LD R2, GREEN		;do this for each character
	BRnzp COMPUTE
B
	LD R2, BLUE
	BRnzp COMPUTE
Y
	LD R2, YELLOW
	BRnzp COMPUTE		;change CLOSE in these lines to the subroutine that puts everything together

COMPUTE		
	LD R1, PRADD
	ADD R1, R1, R4		;R1: 63 - y-int -- Still need to divide by slope
	LD R4, PRADD

;TESTNEG
	;ADD R3, R3, #-3
	;BRz

	NOT R3, R3
	ADD R3, R3, #1		;get 2sC of divisor (slope)
	AND R5, R5, #0		;clear R5
DIVI
	ADD R5, R5, #1		;counter, will be output of division
	ADD R1, R1, R3		;add negative slope and numerator
	;ADD R4, R1, R3		
	BRzp DIVI
	
	ADD R0, R5, R4		;add computed addition and #63
	LD R5, START
	ADD R0, R0, R5
	LD R4, YADD			;load #128 into R4
	STR	R2, R0, #0		;store color at memory address pointed by R0
	ADD R3, R3, #-1		;get decimal value of slope again

	NOT R3, R3
	ADD R3, R3, #-1	
	AND R1, R1, #0		;set R1 to zero
	ADD R1, R1, R3		;load value of R3 into R1
	LD R6, YADD
PRINT1
	AND R3, R3, #0
	ADD R3, R3, R1
	
PRINT2
	ADD R3, R3, #-1		;decrement counter
	BRn PRINT3			;continue loop until counter hits #-1
	ADD R0, R0, R4		;add #128 to pointer address
	STR R2, R0, #0		;store color at new memory locations
	ADD R3, R3, #0
	BRzp PRINT2
PRINT3	
	;LD R6, YSUB		;load #127 into R6
	LD R5, YSUB
	ADD R0, R0, R5 		;add #127 to pointer address
	STR R2, R0, #0		;store color at address of pointer
	;ADD R4, R4, #-1
	ADD R6, R6, #-1
	BRp PRINT1			
	
	BRnzp RESTART		;restarts the program to from the beginning if it has not been branched into the close method
	
CLOSE
	LEA R0, P4
	PUTS

HALT
	
	BLACK .FILL x0000	;Hex codes for colors used in 
	WHITE .FILL x7FFF	;
	
	RED .FILL x7C00		;Hex codes for each color option
	GREEN .FILL x03E0	;
	BLUE .FILL x001F	;
	YELLOW .FILL x7FED	;
	
	
	START .FILL xC000	;Beginning of memory allocated to display
	COUNT .FILL #15871	;Total # of memory locations allocated to display
	YST	.FILL xC040		;Middle of first line
	YADD .FILL x0080 	;#128
	YSUB .FILL x007F	;#127
	
	XST .FILL xDF00		;
	
	PROFF .FILL #64
	PRADD .FILL #63
	ASCIIOFF .FILL #-48
	NEGOFF .FILL #-45
	NEGADD .FILL #45
	TRIOFF .FILL #-51
	TRIADD .FILL #51
	
	D1 .FILL #-114		;ascii codes for each color code letter, will be substracted to test if a key was entered, and then re-added if number not equal to zero
	N1 .FILL #114		;
	D2 .FILL #-103		;
	N2 .FILL #103		;
	D3 .FILL #-98		;
	N3 .FILL #98		;
	D4 .FILL #-121		;
	N4 .FILL #121		;
	D5 .FILL #-99		;
	N5 .FILL #99		;
	D6 .FILL #-120		;
	
	
	P1 .STRINGZ "\nENTER THE SLOPE OF THE LINE (-3 to +3): "
	P3 .STRINGZ "\nENTER THE Y-INTERCEPT OF THE LINE(-6 to +6 - WILL BE MULTIPLIED BY 10): "
	P2 .STRINGZ "\nENTER A COLOR FOR THE LINE: "
	P4 .STRINGZ "\nGOODBYE."
.END