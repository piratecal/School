;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~ECE 109~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~Programming Assignment 3~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~Calder Brown~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~This program is a game.~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~The user plays as the mouse and moves it with WASD keys.~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~When the mouse hits the cheese the program ends~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~When the program ends the amount of red dots, or crumbs, eaten by the mouse is calculated and output~~~~~
;~~~~~~~~~~~~~~~~~~~~~Users can also end the program with the Q key.~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
.ORIG x3000
	
	JSR CLEAR		;
	JSR COURSE		;
	JSR MOUSE		;calls each subroutine needed. Other subroutines are called inside these routines.
	JSR CHEESE		;
	JSR CRUMBS		;
CRUMBRET	
	JSR KYBD		;	
	JSR STOP		;end the program

CLEAR		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			;Method that clears the screen when restarting the program, used just to be sure to re-update the display.
	LD R1, BLACK
	LD R0, DISPLAY
	LD R2, DISPLAYCT
	
	DISPLAYCT .FILL #15871	;
CLEARL	
	STR R1, R0, #0	;store black at location
	ADD R0, R0, #1
	ADD R2, R2, #-1
	BRp CLEARL
	RET
	
	BLACK .FILL x0000		;here b/c they were out of range at bottom of code
	DISPLAY .FILL xC000		;
	
COURSE		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			;Prints the blue lines of the course on the display.
	LD R1, BLUE
	LD R0, COURSEST
	LD R2, COURSECT
	
COURSE1
	STR R1, R0, #0	;store blue at location
	ADD R0, R0, #1
	ADD R2, R2, #-1
	BRp COURSE1
	LD R2, COURSECT
	LD R3, COURSEOFF1
	
	ADD R0, R0, R3
COURSE2
	STR R1, R0, #0
	ADD R0, R0, #1
	ADD R2, R2, #-1
	BRp COURSE2
	
	LD R2, COURSECT
	LD R3, COURSEOFF2
	ADD R0, R0, R3
COURSE3
	STR R1, R0, #0
	ADD R0, R0, #1
	ADD R2, R2, #-1
	BRp COURSE3

	LD R2, COURSECT
	LD R3, COURSEOFF1
	ADD R0, R0, R3
COURSE4
	STR R1, R0, #0
	ADD R0, R0, #1
	ADD R2, R2, #-1
	BRp COURSE4
	RET

	BLUE .FILL x001F		;here b/c it was out of range at bottom
	COURSEST .FILL xCB99	;
	COURSECT .FILL #103		;
	COURSEOFF1 .FILL #3200	;
	COURSEOFF2 .FILL #3250	;
	
ERASE		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			;Erases the previous locations of the mouse, is called by kybd press before reprinting the new location of the mouse.
	LD R0, MOUSEST
	LD R1, BLACK
	ADD R0, R0, R5
	LD R2, MOUSEX
	STR R1, R0, #0
ERASE1	
	LD R3, MOUSEY
ERASE2
	LD R4, DISPY
	ADD R0, R0, R4
	STR R1, R0, #0
	ADD R3, R3, #-1
	BRp ERASE2
	
	LD R3, MOUSEY
	ADD R0, R0, #1
	STR R1, R0, #0
ERASE3
	LD R4, NDISPY
	ADD R0, R0, R4
	STR R1, R0, #0
	ADD R3, R3, #-1
	BRp ERASE3
	
	ADD R0, R0, #1
	STR R1, R0, #0
	ADD R2, R2, #-1
	BRp ERASE1

	RET

	DISPY .FILL #128
	NDISPY .FILL #-128
MOUSE		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			;Prints the beginning mouse and then mouses after the movement based on an offset.
	LD R0, MOUSEST
	ADD R0, R0, R5
	LD R1, GRAY
	LD R2, MOUSEX
	STR R1, R0, #0
	
MOUSE1	
	LD R3, MOUSEY
MOUSE2
	LD R4, DISPY
	ADD R0, R0, R4
	STR R1, R0, #0
	ADD R3, R3, #-1
	BRp MOUSE2
	
	LD R3, MOUSEY
	ADD R0, R0, #1
	STR R1, R0, #0
	
MOUSE3
	LD R4, NDISPY
	ADD R0, R0, R4

	STR R1, R0, #0
	ADD R3, R3, #-1
	BRp MOUSE3
	
	ADD R0, R0, #1
	STR R1, R0, #0
	ADD R2, R2, #-1
	BRp MOUSE1

	STR R5, R0, #0
	RET

	MOUSEST .FILL xF504
	MOUSEST2 .FILL xF5A4
	MOUSEST3 .FILL XFC84
	MOUSEX .FILL #5
	MOUSEY .FILL #13
	
CHEESE		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			;Prints the cheese in the upper right corner of the display.
	LD R1, YELLOW
	LD R2, CHEESEX
	LD R0, CHEESEST
	STR R1, R0, #0
CHEESE1	
	LD R3, MOUSEY
CHEESE2
	LD R4, DISPY
	ADD R0, R0, R4
	STR R1, R0, #0
	ADD R3, R3, #-1
	BRp CHEESE2
	
	LD R3, MOUSEY
	ADD R0, R0, #1
	STR R1, R0, #0
CHEESE3
	LD R4, NDISPY
	ADD R0, R0, R4
	STR R1, R0, #0
	ADD R3, R3, #-1
	BRp CHEESE3
	
	ADD R0, R0, #1
	STR R1, R0, #0
	ADD R2, R2, #-1
	BRp CHEESE1
	STR R5, R0, #0
	RET
	
	CHEESEST .FILL xC26C
	CHEESELOFF .FILL #-51564
	CHEESEL .FILL #51564
	CHEESEX .FILL #7
CRUMBS		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			;Loads the locations of the crumbs and then calls the crumbprint subroutine to print the crumb around the location.
	LD R0, CRUMB1
	JSR CRUMBPRINT
	LD R0, CRUMB2
	JSR CRUMBPRINT
	LD R0, CRUMB3
	JSR CRUMBPRINT
	LD R0, CRUMB4
	JSR CRUMBPRINT
	LD R0, CRUMB5
	JSR CRUMBPRINT
	LD R0, CRUMB6
	JSR CRUMBPRINT
	LD R0, CRUMB7
	JSR CRUMBPRINT
	LD R0, CRUMB8
	JSR CRUMBPRINT
	LD R0, CRUMB9
	JSR CRUMBPRINT
	LD R0, CRUMB10
	JSR CRUMBPRINT
	LD R0, CRUMB11
	JSR CRUMBPRINT
	LD R0, CRUMB12
	JSR CRUMBPRINT
	LD R0, CRUMB13
	JSR CRUMBPRINT
	LD R0, CRUMB14
	JSR CRUMBPRINT
	LD R0, CRUMB15
	JSR CRUMBPRINT
	LD R0, CRUMB16
	JSR CRUMBPRINT
	LD R0, CRUMB17
	JSR CRUMBPRINT
	LD R0, CRUMB18
	JSR CRUMBPRINT
	LD R0, CRUMB19
	JSR CRUMBPRINT
	LD R0, CRUMB20
	JSR CRUMBPRINT
	LD R0, CRUMB21
	JSR CRUMBPRINT
	LD R0, CRUMB22
	JSR CRUMBPRINT
	LD R0, CRUMB23
	JSR CRUMBPRINT
	BRnzp CRUMBRET

	RED .FILL x7C00
	YELLOW .FILL x7FED
	WHITE .FILL x7FFF
	GRAY .FILL x56B5
	CRUMB1 .FILL #50700
	CRUMB2 .FILL #50724
	CRUMB3 .FILL #50752
	CRUMB4 .FILL #50776
	CRUMB5 .FILL #53772
	CRUMB6 .FILL #53796
	CRUMB7 .FILL #53824
	CRUMB8 .FILL #53848
	CRUMB9 .FILL #53872
	CRUMB10 .FILL #57356
	CRUMB11 .FILL #57380
	CRUMB12 .FILL #57408
	CRUMB13 .FILL #57432
	CRUMB14 .FILL #57456
	CRUMB15 .FILL #60428
	CRUMB16 .FILL #60452
	CRUMB17 .FILL #60480
	CRUMB18 .FILL #60504
	CRUMB19 .FILL #60528
	CRUMB20 .FILL #63524
	CRUMB21 .FILL #63552
	CRUMB22 .FILL #63576
	CRUMB23 .FILL #63600
	
CRUMBPRINT	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			;Prints the crumb around the location from the CRUMBS subroutine.
	LD R1, RED
	LD R3, NDISPY
	LD R4, DISPY
	STR R1, R0, #0
	ADD R0, R0, #-1
	STR R1, R0, #0
	ADD R0, R0, #2
	STR R1, R0, #0
	ADD R0, R0, #-1
	ADD R0, R0, R3
	STR R1, R0, #0
	ADD R0, R0, R4
	ADD R0, R0, R4
	STR R1, R0, #0
	RET

CRUMBEND1	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			;Looks at the location of the crumbs when the program is ended, branches to the crumbct subroutine to count the number of crumbs eaten by the mouse.
	LD R3, CRUMBSUB
CRUMBEND2		
	LD R0, CRUMB1
	LDR R2, R0, #0
	BRnp CRU2
	JSR CRUMBCT
CRU2	
	LD R0, CRUMB2
	LDR R2, R0, #0
	BRnp CRU3
	JSR CRUMBCT
CRU3
	LD R0, CRUMB3
	LDR R2, R0, #0
	BRnp CRU4
	JSR CRUMBCT
CRU4	
	LD R0, CRUMB4
	LDR R2, R0, #0
	BRnp CRU5
	JSR CRUMBCT
CRU5	
	LD R0, CRUMB5
	LDR R2, R0, #0
	BRnp CRU6
	JSR CRUMBCT
CRU6	
	LD R0, CRUMB6
	LDR R2, R0, #0
	BRnp CRU7
	JSR CRUMBCT
CRU7	
	LD R0, CRUMB7
	LDR R2, R0, #0
	BRnp CRU8
	JSR CRUMBCT
CRU8	
	LD R0, CRUMB8
	LDR R2, R0, #0
	BRnp CRU9
	JSR CRUMBCT
CRU9	
	LD R0, CRUMB9
	LDR R2, R0, #0
	BRnp CRU10
	JSR CRUMBCT
CRU10	
	LD R0, CRUMB10
	LDR R2, R0, #0
	BRnp CRU11
	JSR CRUMBCT
CRU11	
	LD R0, CRUMB11
	LDR R2, R0, #0
	BRnp CRU12
	JSR CRUMBCT
CRU12	
	LD R0, CRUMB12
	LDR R2, R0, #0
	BRnp CRU13
	JSR CRUMBCT
CRU13	
	LD R0, CRUMB13
	LDR R2, R0, #0
	BRnp CRU14
	JSR CRUMBCT
CRU14	
	LD R0, CRUMB14
	LDR R2, R0, #0
	BRnp CRU15
	JSR CRUMBCT
CRU15	
	LD R0, CRUMB15
	LDR R2, R0, #0
	BRnp CRU16
	JSR CRUMBCT
CRU16	
	LD R0, CRUMB16
	LDR R2, R0, #0
	BRnp CRU17
	JSR CRUMBCT
CRU17	
	LD R0, CRUMB17
	LDR R2, R0, #0
	BRnp CRU18
	JSR CRUMBCT
CRU18	
	LD R0, CRUMB18
	LDR R2, R0, #0
	BRnp CRU19
	JSR CRUMBCT
CRU19	
	LD R0, CRUMB19
	LDR R2, R0, #0
	BRnp CRU20
	JSR CRUMBCT
CRU20	
	LD R0, CRUMB20
	LDR R2, R0, #0
	BRnp CRU21
	JSR CRUMBCT
CRU21	
	LD R0, CRUMB21
	LDR R2, R0, #0
	BRnp CRU22
	JSR CRUMBCT
CRU22	
	LD R0, CRUMB22
	LDR R2, R0, #0
	BRnp CRU23
	JSR CRUMBCT
CRU23	
	LD R0, CRUMB23
	LDR R2, R0, #0
	BRnp CRU24
	JSR CRUMBCT
CRU24	
	JSR OUTPUT

	CRUMBSUB .FILL #23
	
CRUMBCT		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			;Subtracts 1 from 23 for each crumb address not containing the value of red, will calculate exact # in output subroutine.
	ADD R3, R3, #-1
	RET
	
KYBD		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			;Checks if the user is using the keyboard and calls the appropriate subroutine to move the mouse.
			;Also serves the function of checking whether to end the program based on whether the mouse has overriden the cheese locations.
	LD R3, CHEESEC			;
	LDR R2, R3, #0			;checks if mouse has overridden corner of cheese to know when to end program
	LD R3, CHEESECHECK		;
	ADD R2, R2, R3			;
	BRnp CRUMBEND1			;
	
	LD R3, CHEESEE			;
	LDR R2, R3, #0			;checks if mouse has overridden left edge of cheese to know when to end program
	LD R3, CHEESECHECK		;
	ADD R2, R2, R3			;
	BRnp CRUMBEND1			;
	
	LD R3, CHEESEE2			;
	LDR R2, R3, #0			;checks if mouse has overridden bottom edge of cheese to know when to end program
	LD R3, CHEESECHECK		;
	ADD R2, R2, R3			;
	BRnp CRUMBEND1			;
	
	GETC 
	LD R1, WOFF				;Goes to UP subroutine if W is pressed.
	ADD R0, R0, R1
	BRz UP
	LD R1, WADD			
	ADD R0, R0, R1
	LD R1, AOFF				;Goes to LEFT subroutine if A is pressed.
	ADD R0, R0, R1
	BRz LEFT
	LD R1, AADD
	ADD R0, R0, R1
	LD R1, SOFF				;Goes to DOWN subroutine if S is pressed.
	ADD R0, R0, R1
	BRz DOWN
	LD R1, SADD
	ADD R0, R0, R1
	LD R1, DOFF				;Goes to RIGHT subroutine if D is pressed.
	ADD R0, R0, R1
	BRz RIGHT
	LD R1, DADD
	ADD R0, R0, R1
	LD R1, QOFF				;Goes to QUIT subroutine if Q is pressed.
	ADD R0, R0, R1
	BRz QUIT
	LD R1, QADD
	ADD R0, R0, R1
	BRnzp KYBD
	RET

	CHEESECHECK .FILL #-32749
	CHEESEC .FILL xC8EC
	CHEESEE .FILL xC6EC
	CHEESEE2 .FILL xC8F3
MOVEMENT	;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			;Serves as an area to call labels to use throughout the program. Prevents out of range errors.
	WOFF .FILL #-119
	WADD .FILL #119
	AOFF .FILL #-97
	AADD .FILL #97
	SOFF .FILL #-115
	SADD .FILL #115
	DOFF .FILL #-100
	DADD .FILL #100
	QOFF .FILL #-113
	QADD .FILL #113
	
	RIGHTOFF .FILL #2
	LEFTOFF .FILL #-2
	UPOFF .FILL #-256
	DOWNOFF .FILL #256

	TOPOFF .FILL #-49152
	TOPADD .FILL #49152
	BOTOFF .FILL #-65023
	BOTADD .FILL #65023
	

;UP1			;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;LD R1, BOTADD
	;ADD R5, R5, R1
UP				;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
				;Moves the starting position of the mouse up and calls the subroutines to repaint.
	LD R6, UPOFF
	JSR ERASE 
	;LD R1, TOPOFF
	;ADD R5, R5, R1
	;BRnz DOWN1				;working to create bounds for mouse
	;LD R1, TOPADD
	;ADD R5, R5, R1
	ADD R5, R5, R6
	JSR MOUSE
	BRnzp KYBD
	RET
;DOWN1		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	;LD R1, TOPADD
	;ADD R5, R5, R1
DOWN		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~	
		;Moves the starting position of the mouse down and calls the subroutines to repaint.
	LD R6, DOWNOFF
	JSR ERASE
	;LD R1, BOTOFF
	;ADD R5, R5, R1			;working to create bounds for mouse
	;BRnz UP1
	;LD R1, BOTADD
	;ADD R5, R5, R1
	ADD R5, R5, R6
	JSR MOUSE
	BRnzp KYBD
	RET
RIGHT		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
		;Moves the starting position of the mouse right and calls the subroutines to repaint.
	LD R6, RIGHTOFF
	JSR ERASE
	ADD R5, R5, R6
	JSR MOUSE
	BRnzp KYBD
;ERASED
;	LD R0, MOUSEST
;	LD R1, BLACK
;	LD R2, DISPY
;	LD R3, MOUSEY
;ERASED1	
;	STR R1, R0, #0
;	ADD R0, R0, R2
;	ADD R3, R3, #-1
;	BRp ERASED1
;	LD R2, NDISPY
;	LD R3, MOUSEY
;ERASED2
;	ADD R0, R0, #1
;	STR R1, R0, #0				OLD ATTEMPT AT METHOD OF MOVEMENT
;	ADD R0, R0, R2
;	ADD R3, R3, #-1
;	BRp ERASED

;ENCROACHD
;	LD R0, MOUSEST2
;	LD R1, GRAY
;	LD R2, DISPY
;	LD R3, MOUSEY
;ENCROACHD1	
;	STR R1, R0, #0
;	ADD R0, R0, R2
;	ADD R3, R3, #-1
;	BRp ENCROACHD1
;	LD R2, NDISPY
;	LD R3, MOUSEY
;ENCROACHD2
;	ADD R0, R0, #1
;	STR R1, R0, #0
;	ADD R0, R0, R2
;	ADD R3, R3, #-1
;	BRp ENCROACHD
	
	RET
LEFT		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			;Moves the starting position of the mouse left and calls the subroutines to repaint.
	LD R6, LEFTOFF
	JSR ERASE
	ADD R5, R5, R6
	JSR MOUSE
	BRnzp KYBD
	RET

OUTPUT		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			;Calculates and outputs the final result of the program
	LEA R0, CRUMBSTR
	PUTS
	
	AND R0, R0, #0
	AND R1, R1, #0
	LD R5, SUBOFF
	AND R2, R2, #0
	NOT R3, R3
	ADD R3, R3, #1		;2sC to subtract from 23 - get the original #
	ADD R3, R3, R5		;23 - #
	ADD R0, R0, R3		;store in R0
	LD R4, REALOFF
	LD R5, REALADD
	LD R3, OUTOFF
NUMDIV
	ADD R0, R0, R4		;# - 10
	BRn NUMOUT
	ADD R0, R0, #0
	BRzp DIVNUM
	
	

NUMOUT 
	ADD R0, R0, R5
	ADD R0, R0, R3
	OUT
	JSR STOP
	
DIVNUM
	ADD R2, R2, #1
	ADD R0, R0, R4
	BRp DIVNUM
	ADD R0, R0, #0
	ADD R1, R1, R0
	BRnz DIVOUT
	
DIVOUT
	AND R0, R0, #0
	ADD R0, R0, R2
	ADD R0, R0, R3
	OUT
	AND R0, R0, #0
	ADD R0, R1, R0
	ADD R0, R0, R5
	ADD R0, R0, R3
	OUT
	JSR STOP
	
;NUMOUT
;	ADD R0, R0, R4		;# - 10
;	BRnz NUMCOM			;branch to numcom if <= 0
	
	
;	AND R2, R2, #0		;clear R2
;	AND R1, R1, #0		;clear R1
;	ADD R1, R1, R0		;set R1 to value in R0
;NUMDIV	
;	ADD R2, R2, #1		;add 1 to R2, -R2 is a counter and will be first output
;	ADD R1, R1, #0		
;	BRnz DIVOUT
;	ADD R1, R1, R4		;subtract -10 from number
;	BRp NUMDIV
	
;NUMCOM	
;	LD R4, OUTOFF
;	ADD R0, R0, R4
;	ADD R0, R0, R5
;	OUT
;	JSR STOP
;DIVOUT
;	LD R3, OUTOFF
;	ADD R1, R1, R5
;	AND R0, R0, #0
;	ADD R0, R2, R0
;	ADD R0, R0, R3
;	OUT
;	AND R0, R0, #0
;	ADD R0, R0, R1
;	ADD R0, R0, R3
;	OUT
	JSR STOP
	
	RET

	SUBOFF .FILL #23
	OUTOFF .FILL #48
	REALOFF .FILL #-10
	REALADD .FILL #10

QUIT		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
			;Prints the goodbye message, is called by the user pressing Q during the program.
	LEA R0, GDBYE
	PUTS
STOP		;~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
	HALT
	
	CRUMBSTR .STRINGZ "The number of crumbs picked up was: "
	GDBYE .STRINGZ "Program halted becuase the user pressed (Q)"
	.END
