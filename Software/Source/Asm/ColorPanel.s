;###############################################################################
;# ColorPanel - Main File                                                      #
;###############################################################################
;#    Copyright 2015-2016 Dirk Heisswolf                                       #
;#    This file is part of the ColorPanel project.                             #
;#                                                                             #
;#    The ColorPanel firmware is free software: you can redistribute it and/or #
;#    modify it under the terms of the GNU General Public License as published #
;#    by the Free Software Foundation, either version 3 of the License, or     #
;#    (at your option) any later version.                                      #
;#                                                                             #
;#    The ColorPanel firmware is distributed in the hope that it will be       #
;#    useful, but WITHOUT ANY WARRANTY; without even the implied warranty of   #
;#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            #
;#    GNU General Public License for more details.                             #
;#                                                                             #
;#    You should have received a copy of the GNU General Public License        #
;#    along with the ColorPanel firmware. If not, see                          #
;#    <http://www.gnu.org/licenses/>.                                          #
;###############################################################################
;# Description:                                                                #
;#    This demo application transmits each byte it receives via the SCI.       #
;#                                                                             #
;# Usage:                                                                      #
;#    1. Upload S-Record                                                       #
;#    2. Execute code at address "START_OF_CODE"                               #
;###############################################################################
;# Version History:                                                            #
;#    December 17, 2015                                                        #
;#      - Initial release                                                      #
;###############################################################################

;###############################################################################
;# Configuration                                                               #
;###############################################################################
;# Clocks
CLOCK_CPMU		EQU	1		;CPMU
CLOCK_IRC		EQU	1		;use IRC
CLOCK_OSC_FREQ		EQU	 1000000	; 1 MHz IRC frequency
CLOCK_BUS_FREQ		EQU	25000000	; 25 MHz bus frequency
CLOCK_REF_FREQ		EQU	 1000000	; 1 MHz reference clock frequency
CLOCK_VCOFRQ		EQU	$1		; 10 MHz VCO frequency
CLOCK_REFFRQ		EQU	$0		;  1 MHz reference clock frequency

;# Memory map:
MMAP_S12G240		EQU	1 		;S12G128
#ifndef MMAP_RAM
#ifndef MMAP_FLASH
MMAP_RAM		EQU	1 		;use RAM memory map
#endif
#endif

;# Interrupt stack
ISTACK_LEVELS		EQU	2	 	;interrupt nesting not guaranteed
ISTACK_DEBUG		EQU	1 		;don't enter wait mode

;# Subroutine stack
SSTACK_DEPTH		EQU	36	 	;no interrupt nesting
SSTACK_DEBUG		EQU	1 		;debug behavior

;# COP
COP_DEBUG		EQU	1 		;disable COP

;# RESET
RESET_WELCOME		EQU	MAIN_WELCOME 	;welcome message
	
;# Vector table
VECTAB_DEBUG		EQU	1 		;multiple dummy ISRs
	
;# SCI
SCI_FC_RTSCTS		EQU	1 		;RTS/CTS flow control
SCI_RTS_PORT		EQU	PTM 		;PTM
SCI_RTS_PIN		EQU	PM0		;PM0
SCI_CTS_PORT		EQU	PTM 		;PTM
SCI_CTS_PIN		EQU	PM1		;PM1
SCI_HANDLE_BREAK	EQU	1		;react to BREAK symbol
SCI_HANDLE_SUSPEND	EQU	1		;react to SUSPEND symbol
SCI_BD_ON		EQU	1 		;use baud rate detection
SCI_BD_TIM		EQU	1 		;TIM
SCI_BD_ICPE		EQU	0		;IC0
SCI_BD_ICNE		EQU	1		;IC1			
SCI_BD_OC		EQU	2		;OC2			
SCI_BD_LOG_ON		EQU	0		;log captured BD pulses			
SCI_DLY_OC		EQU	3		;OC3
SCI_ERRSIG_ON		EQU	1 		;signal errors
SCI_BLOCKING_ON		EQU	1		;enable blocking subroutines

;# String
STRING_ENABLE_FILL_NB	EQU	1		;enable STRING_FILL_NB 
STRING_ENABLE_FILL_BL	EQU	1		;enable STRING_FILL_BL 
STRING_ENABLE_PRINTABLE	EQU	1		;enable STRING_PRINTABLE
	
	
;###############################################################################
;# Resource mapping                                                            #
;###############################################################################
;# RAM allocation:
;-----------------			
			ORG	MMAP_RAM_START, MMAP_RAM_START_LIN
#ifdef	MMAP_RAM
;Code
START_OF_CODE		EQU	*
MAIN_CODE_START		EQU	*
MAIN_CODE_START_LIN	EQU	@
			ORG	MAIN_CODE_END, MAIN_CODE_END_LIN

PANEL_CODE_START	EQU	*
PANEL_CODE_START_LIN	EQU	@
			ORG	PANEL_CODE_END, PANEL_CODE_END_LIN

BASE_CODE_START		EQU	*
BASE_CODE_START_LIN	EQU	@
			ORG	BASE_CODE_END, BASE_CODE_END_LIN
;Tables
MAIN_TABS_START		EQU	*
MAIN_TABS_START_LIN	EQU	@
			ORG	MAIN_TABS_END, MAIN_TABS_END_LIN

PANEL_TABS_START	EQU	*
PANEL_TABS_START_LIN	EQU	@
			ORG	PANEL_TABS_END, PANEL_TABS_END_LIN

BASE_TABS_START		EQU	*
BASE_TABS_START_LIN	EQU	@
			ORG	BASE_TABS_END, BASE_TABS_END_LIN
;Variables
MAIN_VARS_START		EQU	*
MAIN_VARS_START_LIN	EQU	@
			ORG	MAIN_VARS_END, MAIN_VARS_END_LIN

PANEL_VARS_START	EQU	*
PANEL_VARS_START_LIN	EQU	@
			ORG	PANEL_VARS_END, PANEL_VARS_END_LIN

BASE_VARS_START		EQU	*
BASE_VARS_START_LIN	EQU	@
			ORG	BASE_VARS_END, BASE_VARS_END_LIN
#endif

;# Flash allocation:
;-----------------			
#ifdef	MMAP_FLASH
			ORG	MMAP_FLASH_F_START, MMAP_FLASH_F_START_LIN
;Code
START_OF_CODE		EQU	*
MAIN_CODE_START		EQU	*
MAIN_CODE_START_LIN	EQU	@
			ORG	MAIN_CODE_END, MAIN_CODE_END_LIN

PANEL_CODE_START	EQU	*
PANEL_CODE_START_LIN	EQU	@
			ORG	PANEL_CODE_END, PANEL_CODE_END_LIN

BASE_CODE_START		EQU	*
BASE_CODE_START_LIN	EQU	@
			ORG	BASE_CODE_END, BASE_CODE_END_LIN
;Tables
MAIN_TABS_START		EQU	*
MAIN_TABS_START_LIN	EQU	@
			ORG	MAIN_TABS_END, MAIN_TABS_END_LIN

PANEL_TABS_START	EQU	*
PANEL_TABS_START_LIN	EQU	@
			ORG	PANEL_TABS_END, PANEL_TABS_END_LIN

BASE_TABS_START		EQU	*
BASE_TABS_START_LIN	EQU	@
			ORG	BASE_TABS_END, BASE_TABS_END_LIN
#endif

;###############################################################################
;# Variables                                                                   #
;###############################################################################
			ORG 	MAIN_VARS_START, MAIN_VARS_START_LIN

MAIN_VARS_END		EQU	*
	
MAIN_VARS_END_LIN	EQU	@

;###############################################################################
;# Macros                                                                      #
;###############################################################################
;Break handler
#macro	SCI_BREAK_ACTION, 0
			LED_BUSY_ON
#emac
	
;Suspend handler
#macro	SCI_SUSPEND_ACTION, 0
			LED_BUSY_OFF
#emac

;###############################################################################
;# Code                                                                        #
;###############################################################################
			ORG 	MAIN_CODE_START, MAIN_CODE_START_LIN

;Initialization
			BASE_INIT
			PANEL_INIT
			PANEL_WAIT_BL	
;Application code
MAIN_LOOP		SCI_RX_BL
			;Ignore RX errors 
			ANDA	#(SCI_FLG_SWOR|OR|NF|FE|PF)
			BNE	MAIN_LOOP
			;TBNE	A, MAIN_LOOP

			;Print ASCII character (char in B)
			TFR	D, X
			LDAA	#4
			LDAB	#" "
			STRING_FILL_BL
			TFR	X, D
			CLRA
			STRING_PRINTABLE
			SCI_TX_BL

			;Print hexadecimal value (char in X)
			LDY	#$0000
			LDAB	#16
			NUM_REVERSE
			TFR	SP, Y
			NEGA
			ADDA	#5
			LDAB	#" "
			STRING_FILL_BL
			LDAB	#16
			NUM_REVPRINT_BL
			NUM_CLEAN_REVERSE
	
			;Print decimal value (char in X)
			LDY	#$0000
			LDAB	#10
			NUM_REVERSE
			TFR	SP, Y
			NEGA
			ADDA	#5
			LDAB	#" "
			STRING_FILL_BL
			LDAB	#10
			NUM_REVPRINT_BL
			NUM_CLEAN_REVERSE
	
			;Print octal value (char in X)
			LDY	#$0000
			LDAB	#8
			NUM_REVERSE
			TFR	SP, Y
			NEGA
			ADDA	#5
			LDAB	#" "
			STRING_FILL_BL
			LDAB	#8
			NUM_REVPRINT_BL
			NUM_CLEAN_REVERSE
	
			;Print binary value (char in X)
			LDAA	#2
			LDAB	#" "
			STRING_FILL_BL
			LDY	#$0000
			LDAB	#2
			NUM_REVERSE
			TFR	SP, Y
			NEGA
			ADDA	#8
			LDAB	#"0"
			STRING_fill_BL
			LDAB	#2
			NUM_REVPRINT_BL
			NUM_CLEAN_REVERSE
	
			;Print new line
			LDX	#STRING_STR_NL
			STRING_PRINT_BL
			JOB	MAIN_LOOP
	
MAIN_CODE_END		EQU	*	
MAIN_CODE_END_LIN	EQU	@	

;###############################################################################
;# Tables                                                                      #
;###############################################################################
			ORG 	MAIN_TABS_START, MAIN_TABS_START_LIN

MAIN_WELCOME		FCC	"ColorPanel V00.00"
			STRING_NL_NONTERM

MAIN_TABS_END		EQU	*	
MAIN_TABS_END_LIN	EQU	@	

;###############################################################################
;# Includes                                                                    #
;###############################################################################
#include ./panel_gamma2.4_ColorPanel.s 									;Gamma correction look-up table
#include ./panel_splash_ColorPanel.s 									;Splash screen
#include ./panel_ColorPanel.s										;Panel driver
#include ./gpio_ColorPanel.s										;I/O setup
#include ./vectab_ColorPanel.s										;Vector table
;#include ../../../Subprojects/S12CForth/Subprojects/S12CBase/Source/S12G-Micro-EVB/base_S12G-Micro-EVB.s;S12CBase bundle
#include ../../../../S12CBase/Source/S12G-Micro-EVB/base_S12G-Micro-EVB.s				;S12CBase bundle
	



