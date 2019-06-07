;----------------------------------------------------------------------------------
;--	License terms :
;--	You are free to use this code as long as you
;--		(i) DO NOT post it on any public repository;
;--		(ii) use it only for educational purposes;
;--		(iii) accept the responsibility to ensure that your implementation does not violate any intellectual property of ARM Holdings or other entities.
;--		(iv) accept that the program is provided "as is" without warranty of any kind or assurance regarding its suitability for any particular purpose;
;--		(v) send an email to rajesh.panicker@ieee.org briefly mentioning its use (except when used for the course CG3207 at the National University of Singapore);
;--		(vi) retain this notice in this file or any files derived from this.
;----------------------------------------------------------------------------------

	AREA    MYCODE, CODE, READONLY, ALIGN=9 
   	  ENTRY
	  
; ------- <code memory (ROM mapped to Instruction Memory) begins>
; Total number of instructions should not exceed 127 (126 excluding the last line 'halt B halt').

GOTO
	LDR R2,LEDS;
	LDR R1,DIPS;
	LDR R3,[R2];
	LDR R4,[R1];
	AND R0,R4,R3;
	ORR R5,R4,R3;
	ADD R6,R4,R3;
	SUB R7,R4,R3;
	STR R3,[R1],#16;
	LDR R9,[R2],#16;
	CMN R6,R7;
	CMP R6,R7;
	LDR R10,DELAY_VAL;
	ADD R0,R4,R3,LSL R10;
	ADD R0,R4,R3,LSR R10;
	ADD R0,R4,R3,ASR R10;
	ADD R0,R4,R3,ROR R10;
	STR R3,[R1],-R10;
	LDR R9,[R2],-R10; 
	B GOTO
halt	
		B    halt           ; infinite loop to halt computation. // A program should not "terminate" without an operating system to return control to
							; keep halt	B halt as the last line of your code.
; ------- <\code memory (ROM mapped to Instruction Memory) ends>


	AREA    CONSTANTS, DATA, READONLY, ALIGN=9 
; ------- <constant memory (ROM mapped to Data Memory) begins>
; All constants should be declared in this section. This section is read only (Only LDR, no STR).
; Total number of constants should not exceed 128 (124 excluding the 4 used for peripheral pointers).
; If a variable is accessed multiple times, it is better to store the address in a register and use it rather than load it repeatedly.

;Peripheral pointers
LEDS
		DCD 0x00000C00		; Address of LEDs. //volatile unsigned int * const LEDS = (unsigned int*)0x00000C00;  
DIPS
		DCD 0x00000C04		; Address of DIP switches. //volatile unsigned int * const DIPS = (unsigned int*)0x00000C04;
PBS
		DCD 0x00000C08		; Address of Push Buttons. Used only in Lab 2
UART
		DCD 0x00000C0C		; Address of UART. Used only in Lab 2

; Rest of the constants should be declared below.
DELAY_VAL   
		DCD  0x3			; The number of steps of delay // const unsigned int DELAY_VAL = 3;
constant1
		DCD 0xABCD1234		; // const unsigned int constant1 = 0xABCD1234;
string1   
		DCB  "Hello World!!!!",0	; // unsigned char string1[] = "Hello World!"; // assembler will issue a warning if the string size is not a multiple of 4, but the warning is safe to ignore
		
; ------- <constant memory (ROM mapped to Data Memory) ends>	


	AREA   VARIABLES, DATA, READWRITE, ALIGN=9
; ------- <variable memory (RAM mapped to Data Memory) begins>
; All variables should be declared in this section. This section is read-write.
; Total number of variables should not exceed 128. 
; No initialization possible in this region. In other words, you should write to a location before you can read from it (i.e., write to a location using STR before reading using LDR).
; ------- <variable memory (RAM mapped to Data Memory) ends>	

		END	
		
;const int* x;         // x is a non-constant pointer to constant data
;int const* x;         // x is a non-constant pointer to constant data 
;int*const x;          // x is a constant pointer to non-constant data
		