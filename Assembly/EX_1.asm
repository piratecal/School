; ECE 109 - Spring 2013
; Program 1: Print the ASCII code for a character
; entered by the user.
; G. Byrd, March 2013

	.ORIG x3000

	LEA R0, PROMPT	; print prompt string
	PUTS

	GETC		; get character from user
	ST R0, CHAR	; store for safekeeping
	OUT		; echo character
	LD R0, LF	; and print linefeed
	OUT
;
; Print output string containing character
;
	LEA R0, OSTR1	
	PUTS
	LD R0, CHAR
	OUT
	LEA R0, OSTR2
	PUTS
;
; Get bits of value, store as a string
; Easier to build the string in reverse, so start
; with null character
;
	LEA R3, ENDSTR	; R3 points to end of string

	ADD R4, R2, #9  ; R4 is loop counter
	ADD R5, R2, #1  ; R5 is bit mask (initialize to 1)
	LD R0, CHAR	; R0 is character to be masked

	; loop will mask the bottom eight bits of character
	; and save them as characters in the string,
	; starting with the least-significant bit
	; (bit mask is shifted left each time)

LOOP	ADD R4, R4, #-1
	BRnz DONE
	ADD R3, R3, #-1	; move to next string character

	AND R1, R0, R5	; AND char with mask
	BRz BZERO	; if result is zero, bit is zero
	LD R1, ASC1	; if bit is 1, store '1' to string
	BRnzp SKIP
BZERO	LD R1, ASC0	; if bit is 0, store '0' to string
SKIP	STR R1, R3, #0
	ADD R5, R5, R5  ; adjust mask
	BRnzp LOOP	; back to top of loop
;
; After loop, string is ready to print
;
DONE	ADD R0, R3, #0	; R3 points to first char in string
	PUTS
	LD R0, LF
	OUT
	HALT

LF	.FILL x0A
ASC0	.FILL x30
ASC1	.FILL x31
PROMPT	.STRINGZ "> "
CHAR	.BLKW 1		; storage for character
OSTR1	.STRINGZ "The ASCII code for '"
OSTR2	.STRINGZ "' is: "
	.BLKW 8		; storage for string
ENDSTR	.FILL #0	; terminator for string


	.END
