#ifndef FUDICT_COMPILED
#define FUDICT_COMPILED
;###############################################################################
;# S12CForth - FUDICT - User Dictionary and User Variables                     #
;###############################################################################
;#    Copyright 2010-2015 Dirk Heisswolf                                       #
;#    This file is part of the S12CForth framework for Freescale's S12C MCU    #
;#    family.                                                                  #
;#                                                                             #
;#    S12CForth is free software: you can redistribute it and/or modify        #
;#    it under the terms of the GNU General Public License as published by     #
;#    the Free Software Foundation, either version 3 of the License, or        #
;#    (at your option) any later version.                                      #
;#                                                                             #
;#    S12CForth is distributed in the hope that it will be useful,             #
;#    but WITHOUT ANY WARRANTY; without even the implied warranty of           #
;#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            #
;#    GNU General Public License for more details.                             #
;#                                                                             #
;#    You should have received a copy of the GNU General Public License        #
;#    along with S12CForth.  If not, see <http://www.gnu.org/licenses/>.       #
;###############################################################################
;# Description:                                                                #
;#    This module implements the volatile user dictionary, user variables, and #
;#    the PAD.                                                                 #
;#                                                                             #
;#    The following registers are implemented:                                 #
;#             CP = Compile pointer                                            #
;#                  Points to the next free space after the dictionary         #
;#       CP_SAVED = Previous compile pointer                                   #
;#                                                                             #
;#    Compile strategy:                                                        #
;#    The user dictionary is 16-bit aligned and is allocated below the NVDICT  #
;#    variables. Both data and compile pointer are represented by the variable #
;#    CP.                                                                      #
;#                                                                             #
;###############################################################################
;# Version History:                                                            #
;#    April 23, 2009                                                           #
;#      - Initial release                                                      #
;###############################################################################
;# Required Modules:                                                           #
;#    FEXCPT - Forth Exception Handler                                         #
;#                                                                             #
;# Requirements to Software Using this Module:                                 #
;#    - none                                                                   #
;###############################################################################

;###############################################################################
;# Memory Layout                                                               #
;###############################################################################
;        
;      	                    +--------------+--------------+	     
;         UDICT_PS_START -> |                             | 	     
;                           |     NVDICT Variables        |	     
;                           |                             | <- [DP]	     
;                           | --- --- --- --- --- --- --- |          
;                           |              |              |	     
;                           |       User Dictionary       |	     
;                           |       User Variables        |	     
;                           |              |              | <- [UDICT_LAST_NFA]	     
;                           |              v              |	     
;                       -+- | --- --- --- --- --- --- --- |
;             UDICT_PADDING |                             | <- [CP]	     
;                       -+- | --- --- --- --- --- --- --- |          
;                           |              ^              | <- [HLD]	     
;                           |             PAD             |	     
;                       -+- | --- --- --- --- --- --- --- |          
;             PS_PADDING |  |                             | <- [PAD]          
;                       -+- .                             .          
;                           .                             .          
;                           | --- --- --- --- --- --- --- |          
;                           |              ^              | <- [PSP]	  
;                           |              |              |		  
;                           |       Parameter stack       |		  
;    	                    |              |              |		  
;                           +--------------+--------------+        
;              PS_EMPTY, ->   
;          UDICT_PS_END
;	
;                           Word format:
;                           +---+-------------------------+
;                     NFA-> |IMM|    Previous NFA >> 1    |	
;                           +---+----------+--------------+
;                           |                             | 
;                           |            Name             | 
;                           |                             | 
;                           |              +--------------+ 
;                           |              |    Padding   | 
;                           +--------------+--------------+
;                     CFA-> |     Code Field Pointer      |	
;                           +--------------+--------------+
;                           |                             | 
;                           |            Data             | 
;                           |                             | 
;                           +--------------+--------------+   
	
;###############################################################################
;# Configuration                                                               #
;###############################################################################
;Boundaries
;UDICT_PS_START		EQU	0
;UDICT_PS_END		EQU	0

;Debug option for dictionary overflows
;FUDICT_DEBUG		EQU	1 
	
;Disable dictionary range checks
;FUDICT_NO_CHECK	EQU	1 

;Safety distance between the user dictionary and the PAD
#ifndef UDICT_PADDING
UDICT_PADDING		EQU	4 	;default is 4 bytes
#endif

;PAD SIZE
#ifndef PAD_SIZE
PAD_SIZE		EQU	84 	;default is 84 bytes
#endif
#ifndef PAD_MINSIZE
PAD_MINSIZE		EQU	4 	;default is 4 bytes
#endif
	
;Safety distance between the PAD and the parameter stack
#ifndef PS_PADDING
PS_PADDING		EQU	16 	;default is 16 bytes
#endif

;Max. line length
FUDICT_LINE_WIDTH	EQU	DEFAULT_LINE_WIDTH

;NULL pointer
#ifndef NULL
NULL			EQU	$0000
#endif

;###############################################################################
;# Constants                                                                   #
;###############################################################################
;NVC variable 
NVC_VOLATILE		EQU	FALSE
NVC_NON_VOLATILE	EQU	TRUE
	
;Max. line length
FUDICT_LINE_WIDTH	EQU	DEFAULT_LINE_WIDTH
	
;###############################################################################
;# Variables                                                                   #
;###############################################################################
#ifdef FUDICT_VARS_START_LIN
			ORG 	FUDICT_VARS_START, FUDICT_VARS_START_LIN
#else
			ORG 	FUDICT_VARS_START
FUDICT_VARS_START_LIN	EQU	@
#endif

			ALIGN	1	
CP			DS	2 	;compile pointer (next free space in the dictionary space) 
CP_SAVED		DS	2 	;previous compile pointer

HLD			DS	2 	;start of PAD space 
PAD			DS	2 	;end of PAD space 
	
UDICT_LAST_NFA		DS	2 	;pointer to the most recent NFA of the UDICT

FUDICT_VARS_END		EQU	*
FUDICT_VARS_END_LIN	EQU	@

;###############################################################################
;# Macros                                                                      #
;###############################################################################
;#Initialization
#macro	FUDICT_INIT, 0
			;Initialize the compile data pointer
			MOVW	#UDICT_PS_START, CP
	
	
			MOVW	#0000, UDICT_LAST_NFA
			LDD	#UDICT_PS_START
			STD	CP
			STD	CP_SAVED
	
			;Initialize PAD (DICT_START in D)
			STD	PAD 		;Pad is allocated on demand
			STD	HLD
#emac

;#Abort action (to be executed in addition of quit action)
#macro	FUDICT_ABORT, 0
#emac
	
;#Quit action
#macro	FUDICT_QUIT, 0
#emac
	
;#Suspend action
#macro	FUDICT_SUSPEND, 0
#emac

;#User dictionary (UDICT)
;========================
;Complile operations:
;====================	
;#Check if there is room in the DICT space and deallocate the PAD (CP+bytes -> X)
; args:   1: required space in bytes (constant, A, B, or D are valid args)
; result: X: CP_PRELIM+new bytes
; SSTACK: none
; throws: FEXCPT_EC_DICTOF
;        Y and D are preserved 
#macro	UDICT_CHECK_OF, 1
			LDX	CP	 		;=> 3 cycles
			LEAX	\1,X			;=> 2 cycles
			STX	PAD			;=> 3 cycles
			STX	HLD			;=> 3 cycles
#ifndef	FUDICT_NO_CHECK
			CPX	PSP			;=> 3 cycles
			BHI	FUDICT_THROW_DICTOF	;=> 3 cycles/ 4 cycles
#endif
							;  -------------------
							;   17 cycles/12 cycles
#emac			

;Compile cell into user dictionary
; args:   X: cell value
; result: X: CP_PRELIM+new bytes
; SSTACK: none
;         X and D are preserved 
#macro	FUDICT_COMPILE_CELL, 0
			STX	[CP] 			;store cell in next free space
			UDICT_CHECK_OF 2		;allocate storage space
#emac			

;Dictionary operations:
;======================	
;#Look-up word in user dictionary 
; args:   X: string pointer (terminated string)
; result: X: execution token (unchanged if word not found)
;	  D: 1=immediate, -1=non-immediate, 0=not found
;	  Y: start of dictionary (last NFA)
; SSTACK: 8 bytes
;         No registers are preserved
#macro	FUDICT_FIND, 0
			LDY	UDICT_LAST_NFA	
			SSTACK_JOBSR	FUDICT_FIND, 8
#emac
	
;#Reverse lookup a CFA and print the corresponding word
; args:   D: CFA
; result: C-flag: set if successful
;	  Y: start of dictionary (last NFA)
; SSTACK: 18 bytes
;         X and D are preserved
;#macro	FUDICT_REVPRINT_BL, 0
;			LDY	UDICT_LAST_NFA
;			SSTACK_JOBSR	FUDICT_REVPRINT_BL,	18
;#emac

;Iterator operations:
;====================
;Set interator to first word in CDICT
; args:   1: iterator (indexed address)
; result: none
; SSTACK: none
;         All registers are preserved
#macro FUDICT_ITERATOR_FIRST, 1
			MOVW	UDICT_LAST_NFA, \1 	;last NFA -> ITERATOR
#emac

;Advance iterator
; args:   1:      iterator (indexed address)
; result: D:      previous NFA (NULL if no previous NFA exists)
;         Z-flag: set if no previous NFA exists
; SSTACK: none
;         X and Y are preserved
#macro FUDICT_ITERATOR_NEXT, 1
 			LDD	[\1] 			;(previous NFA>>1) -> D
			LSLD 				; previous NFA -> D
			STD	\1			; previous NFA -> ITERATOR
#emac

;Get length of word referenced by current iterator
; args:   1: iterator (indexed address)
;         D: old char count 
; result: D: new char count
;	  X: points to the byte after the string
; SSTACK: none
;         Y is preserved
#macro FUDICT_ITERATOR_WC, 1
			LDX	\1 			;current NFA -> X
			LEAX	2,X			;start of string -> X
			FIO_SKIP_AND_COUNT		;count chars
#emac

;Print word referenced by current iterator (BLOCKING)
; args:   1: iterator (indexed address)
; result: X: points to the byte after the string
; SSTACK: 10 bytes
;         Y and D are preserved
#macro FUDICT_ITERATOR_PRINT, 1
			LDX	\1 			;current NFA -> X
			LEAX	2,X			;start of string -> X
			FIO_PRINT_BL                 ;print string
#emac

;Get CFA of word referenced by current iterator
; args:   1: iterator (indexed address)
; result: D: {IMMEDIATE, CFA>>1}
;         X: CFA pointer
; SSTACK: none
;         Y is preserved
#macro FUDICT_ITERATOR_CFA, 1
			LDX	\1 			;current NFA -> X
			LEAX	2,X			;start of string -> X
			BRCLR	1,X+, #FIO_TERM, *	;skip over string
			FUDICT_WORD_ALIGN X 		;word align X
			LDD	2,+X			;{IMMEDIATE, CFA>>1} -> D
#emac

;Pointer operations:
;===================
;Word align index register
; args:   1:   index register
; result: [1]: word aligned address
; SSTACK: none
;         All registers except for 1 are preserved
#macro FUDICT_WORD_ALIGN, 1
			EXG	D, \1 			; index <-> D
			ANDB	#$FE			; word align D 
			EXG	D, \1 			; index <-> D
#emac
	
;#Pictured numeric output buffer (PAD)
;=====================================
;PAD_CHECK_OF: check if there is room for one more character on the PAD (HLD -> X)
; args:   none
; result: X: HLD
; SSTACK: none
; throws: FEXCPT_EC_PADOF
;        Y and D are preserved 
#macro	PAD_CHECK_OF, 0
			LDX	HLD 			;=> 3 cycles
			CPX	CP			;=> 3 cycles
			BLS	FUDICT_THROW_PADOF	;=> 3 cycles/ 4 cycles
							;  -------------------
							;   9 cycles/10 cycles
#emac			
	
;PAD_ALLOC: allocate the PAD buffer (PAD_SIZE bytes if possible) (PAD -> D)
; args:   none
; result: D: PAD (= HLD)
; SSTACK: 2 bytes
; throws: FEXCPT_EC_PADOF
;        X and Y are preserved 
#macro	PAD_ALLOC, 0 
			SSTACK_JOBSR	FUDICT_PAD_ALLOC, 2
			TBEQ	D, FUDICT_THROW_PADOF 	;no space available at all
#emac			

;PAD_DEALLOC: deallocate the PAD buffer  (PAD -> D)
; args:   none
; result: D: CP (= HLD = PAD)
; SSTACK: none
;        X and Y are preserved 
#macro	PAD_DEALLOC, 0 
			LDD	CP
			STD	PAD
			STD	HLD
#emac			

;###############################################################################
;# Code                                                                        #
;###############################################################################
#ifdef FUDICT_CODE_START_LIN
			ORG 	FUDICT_CODE_START, FUDICT_CODE_START_LIN
#else
			ORG 	FUDICT_CODE_START
FUDICT_CODE_START_LIN	EQU	@
#endif

;#User dictionary (UDICT)
;========================
;Complile operations:
;====================	



;Dictionary operations:
;======================	
;#Look-up word in user dictionary 
; args:   X: string pointer (terminated string)
;	  Y: start of dictionary (last NFA)
; result: X: execution token (unchanged if word not found)
;	  D: 1=immediate, -1=non-immediate, 0=not found
; SSTACK: 8 bytes
;         Y is preserved
FUDICT_FIND		EQU	*
			;Save registers (string pointer in X, start of dictionary in Y)
			PSHY						;start of dictionary
			PSHX						;string pointer
			;Allocate iterator (string pointer in X, start of dictionary in Y)
			;FUDICT_ITERATOR_FIRST	(2,-SP)			;ITERATOR -> 0,SP
			PSHY						;ITERATOR -> 0,SP
			;Compare strings (string pointer in X)
			LDY	0,SP					;current NFA -> Y
FUDICT_FIND_1		LEAY	2,Y					;start of dict string -> Y
FUDICT_FIND_2		LDAB	1,X+					;string char -> A
			CMPB	1,Y+ 					;compare chars
			BNE	FUDICT_FIND_4 				;mismatch
			BRCLR	-1,X, #FIO_TERM, FUDICT_FIND_2 	;check next char
			;Match (pointer to code field or padding in Y)
			FUDICT_WORD_ALIGN Y 				;word align Y
			LDD	2,Y 					;{IMMEDIATE, CFA>>1} -> D
			TFR	X, D					;{IMMEDIATE, CFA>>1} -> X
			LEAX	D,X					;CFA -> X
			CLRB
			LSLA						;immediate flag -> C
			ROLB						;immediate flag -> B
			LSLB						;B*2 -> B
			DECB						;B-1 -> B
			SEX	B, D					;B -> D
			;Done (result in D, execution token/string pointer X)
FUDICT_FIND_3		SSTACK_PREPULL	8 				;check stack
			LDY	4,+SP					;restore Y	
			RTS
			;Mismatch
FUDICT_FIND_4		FUDICT_ITERATOR_NEXT	(0,SP) 			;advance iterator
			TFR	D, Y 					;new NFA -> Y
			BNE	FUDICT_FIND_1 				;compare strings
			;Search unsuccessful (string pointer in X)
			CLRA						;set result
			CLRB						; -> not found
			LDX	2,SP	      				;restore X
			JOB	FUDICT_FIND_3 				;done

;#Reverse lookup a CFA and print the corresponding word
; args:   D: CFA
;	  Y: start of dictionary (last NFA)
; result: C-flag: set if successful
; SSTACK: 18 bytes
;         All registers are preserved
;FUDICT_REVPRINT_BL	EQU	*
;			;Save registers (CFA in D, start of dictionary in X)
;			PSHX						;string pointer
;			PSHD						;CFA
;			;Allocate iterator (CFA in D, start of dictionary in X)
;			;FUDICT_ITERATOR_FIRST	(2,-SP)			;ITERATOR -> 0,SP
;			PSHY						;ITERATOR -> 0,SP
;			;Check CFA
;FUDICT_REVPRINT_BL_1	FUDICT_ITERATOR_CFA	(0,SP)			;{IMMEDIATE, CFA>>1} -> D
;			LSLD						;remove IMMEDIATE flag
;			CPD	2,SP 					;compare CFAs
;			BEQ	FUDICT_REVPRINT_BL_2 			;match
;			;Mismatch		
;			FUDICT_ITERATOR_NEXT 	(0,SP)			;advance iterator
;			BNE	FUDICT_REVPRINT_BL_1 			;check next CFA
;			;Search unsucessful					
;			SSTACK_PREPULL	8 				;check stack
;			CLC						;flag failure
;			JOB	FUDICT_REVPRINT_BL_3 			;done
;			;Search unsucessful		
;FUDICT_REVPRINT_BL_2	FUDICT_ITERATOR_PRINT 	(0,SP)			;print word (SSTACK: 10 bytes)
;			SSTACK_PREPULL	8 				;check stack
;			SEC						;flag success
;			;Done		
;FUDICT_REVPRINT_BL_3	LEAS	2,SP 					;remove iterator
;			PULD						;restore D
;			PULX						;restore X
;			RTS

;#Pictured numeric output buffer (PAD)
;=====================================
	
;PAD_ALLOC: allocate the PAD buffer (PAD_SIZE bytes if possible) (PAD -> D)
; args:   none
; result: D: PAD (= HLD), $0000 if no space is available
; SSTACK: 2
;        X and Y are preserved 
FUDICT_PAD_ALLOC	EQU	*
			;Calculate available space
			LDD	PSP
			SUBD	CP
			;BLS	FUDICT_PAD_ALLOC_4 	;no space available at all
			;Check if requested space is available
			CPD	#(PAD_SIZE+PS_PADDING)
			BLO	FUDICT_PAD_ALLOC_3	;reduce size
			LDD	CP
			ADDD	#PAD_SIZE
			;Allocate PAD
FUDICT_PAD_ALLOC_1	STD	PAD
			STD	HLD
			;Done 
FUDICT_PAD_ALLOC_2	SSTACK_PREPULL	2
			RTS
			;Reduce PAD size 
FUDICT_PAD_ALLOC_3	CPD	#(PAD_MINSIZE+PS_PADDING)
			BLO	FUDICT_PAD_ALLOC_4		;not enough space available
			LDD	PSP
			SUBD	#PS_PADDING
			JOB	FUDICT_PAD_ALLOC_1 		;allocate PAD
			;Not enough space available
FUDICT_PAD_ALLOC_4	LDD 	$0000 				;signal failure
			JOB	FUDICT_PAD_ALLOC_2		;done

;Code fields:
;============
;FIND-UDICT ( c-addr -- c-addr 0 |  xt 1 | xt -1 )  
;Find the definition named in the terminated string at c-addr. If the definition is
;not found, return c-addr and zero.  If the definition is found, return its
;execution token xt.  If the definition is immediate, also return one (1),
;otherwise also return minus-one (-1).  For a given string, the values returned
;by FIND-UDICT while compiling may differ from those returned while not compiling. 
; args:   PSP+0: terminated string to match dictionary entry
; result: PSP+0: 1 if match is immediate, -1 if match is not immediate, 0 in
;         	 case of a mismatch
;  	  PSP+2: execution token on match, input string on mismatch
; SSTACK: 8 bytes
; PS:     1 cell
; RS:     1 cell
; throws: FEXCPT_EC_PSOF
;         FEXCPT_EC_PSUF
CF_FIND_UDICT		EQU	*
			;Check PS
			PS_CHECK_UFOF	1, 1 		;new PSP -> Y
			;Search core directory (PSP in Y)
			LDX	2,Y
			FUDICT_FIND 			;(SSTACK: 8 bytes)
			STD	0,Y
			STX	2,Y
			;Done
			NEXT

;WORDS-UDICT ( -- )
;List the definition names in the core dictionary in alphabetical order.
; args:   none
; result: none
; SSTACK: 8 bytes
; PS:     ? cells
; RS:     2 cells
; throws:  FEXCPT_EC_PSOF
CF_WORDS_UDICT		EQU	*
			;PS layout:
			; +--------+--------+
			; |    Iterator     | PSP+0
			; +--------+--------+
			; | Column counter  | PSP+2
			; +--------+--------+
			;Print header
			PS_PUSH	#FUDICT_WORDS_HEADER
			;Allocate stack space
			PS_CHECK_OF	2			;new PSP -> Y
			STY	PSP
			;Initialize iterator and column counter (PSP in Y)
			FUDICT_ITERATOR_FIRST	(0,Y)	;initialize iterator
			MOVW #FCDICT_LINE_WIDTH, 2,Y	;initialize column count
			;Check column width (PSP in Y)
CF_WORDS_UDICT_1	LDD	2,Y 			;column clint -> D
			FUDICT_ITERATOR_WC (0,Y)
			CPD	#(FUDICT_LINE_WIDTH+1)	;check line width
			BLS	CF_WORDS_UDICT_2 	;insert white space
			;Insert line break (PSP in Y)			
			MOVW	#$0000, 2,Y		;reset column counter
			EXEC_CF	CF_CR 			;print line break
			JOB	CF_WORDS_UDICT_3	;print word
			;Insert white space (PSP in Y, new column count in D)
CF_WORDS_UDICT_2	ADDD	#1			;count space char
			STD	CF_WORDS_CDICT_COLCNT,Y	;update column counter
			EXEC_CF	CF_SPACE		;print whitespace
			;Print word						
CF_WORDS_UDICT_3	LDY	PSP				;PSP -> Y
			LDX	0,Y			;word entry -> X
			LEAX	2,X			;start of string -> X
			PS_PUSH_X			;print string
			EXEC_CF	CF_STRING_DOT		;
			;Skip to next word						
			LDY	PSP			;PSP -> Y
			FUDICT_ITERATOR_NEXT	(0,Y)	;advance iterator
			BNE	CF_WORDS_UDICT_1	;print next word					
			;Clean up (PSP in Y)						
			PS_CHECK_UF	2 		;PSP -> Y
			LEAY	2,Y
			STY	PSP
			NEXT

;Exceptions:
;===========
;Standard exceptions
#ifndef FUDICT_NO_CHECK
#ifdef FUDICT_DEBUG
FIDICT_THROW_DICTOF	BGND					;parameter stack overflow
FIDICT_THROW_PADOF	BGND					;PAD overflow
#else
FUDICT_THROW_DICTOF	FEXCPT_THROW	FEXCPT_EC_DICTOF	;parameter stack overflow
FUDICT_THROW_PADOF	FEXCPT_THROW	FEXCPT_EC_PADOF		;PAD overflow
#endif
#endif

FUDICT_CODE_END		EQU	*
FUDICT_CODE_END_LIN	EQU	@

;###############################################################################
;# Tables                                                                      #
;###############################################################################
#ifdef FUDICT_TABS_START_LIN
			ORG 	FUDICT_TABS_START, FUDICT_TABS_START_LIN
#else
			ORG 	FUDICT_TABS_START
FUDICT_TABS_START_LIN	EQU	@
#endif	

;#New line string
FUDICT_STR_NL		EQU	FIO_STR_NL

;#Header line for WORDS output 
FUDICT_WORDS_HEADER	FIO_NL_NONTERM
			FCC	"User Dictionary:"
			;FCC	"UDICT:"
			FIO_NL_TERM

FUDICT_TABS_END		EQU	*
FUDICT_TABS_END_LIN	EQU	@

;###############################################################################
;# Words                                                                       #
;###############################################################################
#ifdef FUDICT_WORDS_START_LIN
			ORG 	FUDICT_WORDS_START, FUDICT_WORDS_START_LIN
#else
			ORG 	FUDICT_WORDS_START
FUDICT_WORDS_START_LIN	EQU	@
#endif	

;#ANSForth Words:
;================

;#S12CForth Words:
;=================
;Word: FIND-UDICT ( c-addr -- c-addr 0 |  xt 1 | xt -1 )  
;Find the definition named in the terminated string at c-addr. If the definition is
;not found, return c-addr and zero.  If the definition is found, return its
;execution token xt.  If the definition is immediate, also return one (1),
;otherwise also return minus-one (-1).  For a given string, the values returned
;by FIND-UDICT while compiling may differ from those returned while not compiling. 
CFA_FIND_UDICT		DW	CF_FIND_UDICT

;Word: WORDS-UDICT ( -- )
;List the definition names in the core dictionary in alphabetical order.
CFA_WORDS_UDICT		DW	CF_WORDS_UDICT
		
FUDICT_WORDS_END	EQU	*
FUDICT_WORDS_END_LIN	EQU	@
#endif