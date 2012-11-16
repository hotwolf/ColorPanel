;###############################################################################
;# S12CBase - VECTAB - Vector Table (OpenBDC)                                  #
;###############################################################################
;#    Copyright 2010-2012 Dirk Heisswolf                                       #
;#    This file is part of the S12CBase framework for Freescale's S12C MCU     #
;#    family.                                                                  #
;#                                                                             #
;#    S12CBase is free software: you can redistribute it and/or modify         #
;#    it under the terms of the GNU General Public License as published by     #
;#    the Free Software Foundation, either version 3 of the License, or        #
;#    (at your option) any later version.                                      #
;#                                                                             #
;#    S12CBase is distributed in the hope that it will be useful,              #
;#    but WITHOUT ANY WARRANTY; without even the implied warranty of           #
;#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            #
;#    GNU General Public License for more details.                             #
;#                                                                             #
;#    You should have received a copy of the GNU General Public License        #
;#    along with S12CBase.  If not, see <http://www.gnu.org/licenses/>.        #
;###############################################################################
;# Description:                                                                #
;#    This module defines the static vector table of the OpenBDC firmware.     #
;#    Unexpected inerrupts are cought and trigger a fatal error in the reset   #
;#    handler.                                                                 #
;###############################################################################
;# Required Modules:                                                           #
;#    ERROR  - Error handler                                                   #
;#    CLOCK  - Clock handler                                                   #
;#    SCI    - UART driver                                                     #
;#    LED    - LED driver                                                      #
;#                                                                             #
;# Requirements to Software Using this Module:                                 #
;#    - none                                                                   #
;###############################################################################
;# Version History:                                                            #
;#    April 4, 2010                                                            #
;#      - Initial release                                                      #
;#    July 9, 2012                                                             #
;#      - Added support for linear PC                                          #
;#      - Added dummy vectors                                                  #
;#    July 31, 2012                                                            #
;#      - Moved vector table to table section                                  #
;#    November 16, 2012                                                        #
;#      - Restructured table                                                   #
;###############################################################################

;###############################################################################
;# Configuration                                                               #
;###############################################################################
;Make each unused interrupt point to a separate BGND instruction
;VECTAB_DEBUG		EQU	1 

;###############################################################################
;# Constants                                                                   #
;###############################################################################
VECTAB_START		EQU	$FF80
VECTAB_START_LIN	EQU	$FFF80
	
;###############################################################################
;# Variables                                                                   #
;###############################################################################
#ifdef VECTAB_VARS_START_LIN
			ORG 	VECTAB_VARS_START, VECTAB_VARS_START_LIN
#else
			ORG 	VECTAB_VARS_START
VECTAB_VARS_START_LIN	EQU	@			
#endif	

VECTAB_VARS_END		EQU	*
VECTAB_VARS_END_LIN	EQU	@

;###############################################################################
;# Macros                                                                      #
;###############################################################################
;#Initialization
#macro	VECTAB_INIT, 0
#ifdef	SCI_ISR_BD_PE
			;Give SCI_ISR_BD_PE high priority 
			MOVB	#(VEC_TC0&$FF), HPRIO	
#endif
#emac	

;###############################################################################
;# Code                                                                        #
;###############################################################################
#ifdef VECTAB_CODE_START_LIN
			ORG 	VECTAB_CODE_START, VECTAB_CODE_START_LIN
#else
			ORG 	VECTAB_CODE_START
VECTAB_VARS_START_LIN	EQU	@			
#endif	
	
VECTAB_CODE_END		EQU	*	
VECTAB_CODE_END_LIN	EQU	@	

;###############################################################################
;# Tables                                                                      #
;###############################################################################
#ifdef VECTAB_TABS_START_LIN
			ORG 	VECTAB_TABS_START, VECTAB_TABS_START_LIN
#else
			ORG 	VECTAB_TABS_START
VECTAB_VARS_START_LIN	EQU	@			
#endif	

;#Interrupt service routines
;#--------------------------
#ifdef VECTAB_DEBUG
ISR_RES80   		BGND				;vector base + $80
ISR_RES82   		BGND				;vector base + $82
ISR_RES84   		BGND				;vector base + $84
ISR_RES86   		BGND				;vector base + $86
ISR_RES88   		BGND				;vector base + $88
ISR_LVI     		BGND      			;vector base + $8A
ISR_PWM     		BGND      			;vector base + $8C
ISR_PORTP   		BGND				;vector base + $8E
ISR_RES90   		BGND				;vector base + $90
ISR_RES92   		BGND				;vector base + $92
ISR_RES94   		BGND				;vector base + $94
ISR_RES96   		BGND				;vector base + $96
ISR_RES98   		BGND				;vector base + $98
ISR_RES9A   		BGND				;vector base + $9A
ISR_RES9C   		BGND				;vector base + $9C
ISR_RES9E   		BGND				;vector base + $9E
ISR_RESA0   		BGND				;vector base + $A0
ISR_RESA2   		BGND				;vector base + $A2
ISR_RESA4   		BGND				;vector base + $A4
ISR_RESA6   		BGND				;vector base + $A6
ISR_RESA8   		BGND				;vector base + $A8
ISR_RESAA   		BGND				;vector base + $AA
ISR_RESAC   		BGND				;vector base + $AC
ISR_RESAE   		BGND				;vector base + $AE
ISR_CANTX   		BGND				;vector base + $A0
ISR_CANRX   		BGND				;vector base + $B2
ISR_CANERR  		BGND				;vector base + $B4
ISR_CANWUP  		BGND				;vector base + $B6
ISR_FLASH   		BGND				;vector base + $B8
ISR_RESBA   		BGND				;vector base + $BA
ISR_RESBC   		BGND				;vector base + $BC
ISR_RESBE   		BGND				;vector base + $BE
ISR_RESC0   		BGND				;vector base + $C0
ISR_RESC2   		BGND				;vector base + $C2
ISR_SCM     		BGND      			;vector base + $C4
#ifdef	CLOCK_ISR					;vector base + $C6
ISR_PLLLOCK		EQU	CLOCK_ISR
#else
ISR_PLLLOCK		BGND
#endif
ISR_RESC8  		BGND				;vector base + $C8
ISR_RESCA  		BGND				;vector base + $CA
ISR_RESCC  		BGND				;vector base + $CC
ISR_PORTJ  		BGND				;vector base + $CC
ISR_RESD0  		BGND				;vector base + $D0
ISR_ATD    		BGND				;vector base + $D2
ISR_RESD4  		BGND				;vector base + $D4
#ifdef	SCI_ISR_RXTX					;vector base + $D6
ISR_SCI			EQU	SCI_ISR_RXTX
#else
ISR_SCI			BGND
#endif
ISR_SCI    		BGND				;vector base + $D6
ISR_SPI    		BGND				;vector base + $D8
ISR_TIM_PAIE   		BGND				;vector base + $DA
ISR_TIM_PAOV   		BGND				;vector base + $DC
ISR_TIM_TOV    		BGND				;vector base + $DE
ISR_TIM_TC7    		BGND				;vector base + $E0
ISR_TIM_TC6    		BGND				;vector base + $E2
ISR_TIM_TC5    		BGND				;vector base + $E4
ISR_TIM_TC4    		BGND				;vector base + $E6
#ifdef	SCI_ISR_DELAY					;vector base + $E8
ISR_TIM_TC3		EQU	SCI_ISR_DELAY
#else
ISR_TIM_TC3		BGND
#endif
ISR_TIM_TC2    		BGND				;vector base + $EA
#ifdef	SCI_ISR_BD_NE					;vector base + $EC
ISR_TIM_TC1		EQU	SCI_ISR_BD_NE
#else
ISR_TIM_TC1		BGND
#endif
#ifdef	SCI_ISR_BD_PE					;vector base + $EE
ISR_TIM_TC0		EQU	SCI_ISR_BD_PE
#else
ISR_TIM_TC0		BGND
#endif
#ifdef	LED_ISR						;vector base + $F0
ISR_RTI			EQU	LED_ISR
#else
ISR_RTI			BGND
#endif
ISR_IRQ    		BGND				;vector base + $F2
ISR_XIRQ   		BGND				;vector base + $F4
ISR_SWI    		BGND				;vector base + $F6
ISR_TIM_TRAP   		BGND				;vector base + $F8
#else
ISR_RES80   		EQU	ERROR_ISR		;vector base + $80
ISR_RES82   		EQU	ERROR_ISR		;vector base + $82
ISR_RES84   		EQU	ERROR_ISR		;vector base + $84
ISR_RES86   		EQU	ERROR_ISR		;vector base + $86
ISR_RES88   		EQU	ERROR_ISR		;vector base + $88
ISR_LVI     		EQU	ERROR_ISR      		;vector base + $8A
ISR_PWM     		EQU	ERROR_ISR      		;vector base + $8C
ISR_PORTP   		EQU	ERROR_ISR		;vector base + $8E
ISR_RES90   		EQU	ERROR_ISR		;vector base + $90
ISR_RES92   		EQU	ERROR_ISR		;vector base + $92
ISR_RES94   		EQU	ERROR_ISR		;vector base + $94
ISR_RES96   		EQU	ERROR_ISR		;vector base + $96
ISR_RES98   		EQU	ERROR_ISR		;vector base + $98
ISR_RES9A   		EQU	ERROR_ISR		;vector base + $9A
ISR_RES9C   		EQU	ERROR_ISR		;vector base + $9C
ISR_RES9E   		EQU	ERROR_ISR		;vector base + $9E
ISR_RESA0   		EQU	ERROR_ISR		;vector base + $A0
ISR_RESA2   		EQU	ERROR_ISR		;vector base + $A2
ISR_RESA4   		EQU	ERROR_ISR		;vector base + $A4
ISR_RESA6   		EQU	ERROR_ISR		;vector base + $A6
ISR_RESA8   		EQU	ERROR_ISR		;vector base + $A8
ISR_RESAA   		EQU	ERROR_ISR		;vector base + $AA
ISR_RESAC   		EQU	ERROR_ISR		;vector base + $AC
ISR_RESAE   		EQU	ERROR_ISR		;vector base + $AE
ISR_CANTX   		EQU	ERROR_ISR		;vector base + $A0
ISR_CANRX   		EQU	ERROR_ISR		;vector base + $B2
ISR_CANERR  		EQU	ERROR_ISR		;vector base + $B4
ISR_CANWUP  		EQU	ERROR_ISR		;vector base + $B6
ISR_FLASH   		EQU	ERROR_ISR		;vector base + $B8
ISR_RESBA   		EQU	ERROR_ISR		;vector base + $BA
ISR_RESBC   		EQU	ERROR_ISR		;vector base + $BC
ISR_RESBE   		EQU	ERROR_ISR		;vector base + $BE
ISR_RESC0   		EQU	ERROR_ISR		;vector base + $C0
ISR_RESC2   		EQU	ERROR_ISR		;vector base + $C2
ISR_SCM     		EQU	ERROR_ISR      		;vector base + $C4
#ifdef	CLOCK_ISR					;vector base + $C6
ISR_PLLLOCK		EQU	CLOCK_ISR
#else
ISR_PLLLOCK		BGND
#endif
ISR_RESC8  		EQU	ERROR_ISR		;vector base + $C8
ISR_RESCA  		EQU	ERROR_ISR		;vector base + $CA
ISR_RESCC  		EQU	ERROR_ISR		;vector base + $CC
ISR_PORTJ  		EQU	ERROR_ISR		;vector base + $CC
ISR_RESD0  		EQU	ERROR_ISR		;vector base + $D0
ISR_ATD    		EQU	ERROR_ISR		;vector base + $D2
ISR_RESD4  		EQU	ERROR_ISR		;vector base + $D4
#ifdef	SCI_ISR_RXTX					;vector base + $D6
ISR_SCI			EQU	SCI_ISR_RXTX
#else
ISR_SCI			EQU	ERROR_ISR
#endif
ISR_SPI    		EQU	ERROR_ISR		;vector base + $D8
ISR_TIM_PAIE   		EQU	ERROR_ISR		;vector base + $DA
ISR_TIM_PAOV   		EQU	ERROR_ISR		;vector base + $DC
ISR_TIM_TOV    		EQU	ERROR_ISR		;vector base + $DE
ISR_TIM_TC7    		EQU	ERROR_ISR		;vector base + $E0
ISR_TIM_TC6    		EQU	ERROR_ISR		;vector base + $E2
ISR_TIM_TC5    		EQU	ERROR_ISR		;vector base + $E4
ISR_TIM_TC4    		EQU	ERROR_ISR		;vector base + $E6
#ifdef	SCI_ISR_DELAY					;vector base + $E8
ISR_TIM_TC3		EQU	SCI_ISR_DELAY
#else
ISR_TIM_TC3		EQU	ERROR_ISR
#endif
ISR_TIM_TC2    		EQU	ERROR_ISR		;vector base + $EA
#ifdef	SCI_ISR_BD_NE					;vector base + $EC
ISR_TIM_TC1		EQU	SCI_ISR_BD_NE
#else
ISR_TIM_TC1		EQU	ERROR_ISR
#endif
#ifdef	SCI_ISR_BD_PE					;vector base + $EE
ISR_TIM_TC0		EQU	SCI_ISR_BD_PE
#else
ISR_TIM_TC0		EQU	ERROR_ISR
#endif
#ifdef	LED_ISR						;vector base + $F0
ISR_RTI			EQU	LED_ISR
#else
ISR_RTI			EQU	ERROR_ISR
#endif
ISR_IRQ    		EQU	ERROR_ISR		;vector base + $F2
ISR_XIRQ   		EQU	ERROR_ISR		;vector base + $F4
ISR_SWI    		EQU	ERROR_ISR		;vector base + $F6
ISR_TRAP   		EQU	ERROR_ISR		;vector base + $F8
#endif					
					
;#Code entry points
;#-----------------
#ifdef	ERROR_RESET_COP					;vector base + $FA
RES_COP			EQU	ERROR_RESET_COP
#else
RES_COP			EQU	RES_EXT
#endif
#ifdef	ERROR_RESET_CM					;vector base + $FC
RES_CM			EQU	ERROR_RESET_CM
#else
RES_CM			EQU	RES_EXT
#endif
#ifdef	ERROR_RESET_EXT					;vector base + $FE
RES_EXT			EQU	ERROR_RESET_COP
#else
RES_EXT			EQU	START_OF_CODE
#endif
	
VECTAB_TABS_END		EQU	*	
VECTAB_TABS_END_LIN	EQU	@	

;###############################################################################
;# S12G128 Vector Table                                                        #
;###############################################################################
			ORG	VECTAB_START, VECTAB_START_LIN		 	
VEC_RES80    		DW	VEC_RES80    		;vector base + $80
VEC_RES82    		DW	VEC_RES82    		;vector base + $82
VEC_RES84    		DW	VEC_RES84    		;vector base + $84
VEC_RES86    		DW	VEC_RES86    		;vector base + $86
VEC_RES88    		DW	VEC_RES88    		;vector base + $88
VEC_LVI	      		DW	VEC_LVI	           	;vector base + $8A
VEC_PWM	      		DW	VEC_PWM	           	;vector base + $8C
VEC_PORTP    		DW	VEC_PORTP    		;vector base + $8E
VEC_RES90    		DW	VEC_RES90    		;vector base + $90
VEC_RES92    		DW	VEC_RES92    		;vector base + $92
VEC_RES94    		DW	VEC_RES94    		;vector base + $94
VEC_RES96    		DW	VEC_RES96    		;vector base + $96
VEC_RES98    		DW	VEC_RES98    		;vector base + $98
VEC_RES9A    		DW	VEC_RES9A    		;vector base + $9A
VEC_RES9C    		DW	VEC_RES9C    		;vector base + $9C
VEC_RES9E    		DW	VEC_RES9E    		;vector base + $9E
VEC_RESA0    		DW	VEC_RESA0    		;vector base + $A0
VEC_RESA2    		DW	VEC_RESA2    		;vector base + $A2
VEC_RESA4    		DW	VEC_RESA4    		;vector base + $A4
VEC_RESA6    		DW	VEC_RESA6    		;vector base + $A6
VEC_RESA8    		DW	VEC_RESA8    		;vector base + $A8
VEC_RESAA    		DW	VEC_RESAA    		;vector base + $AA
VEC_RESAC    		DW	VEC_RESAC    		;vector base + $AC
VEC_RESAE    		DW	VEC_RESAE    		;vector base + $AE
VEC_CANTX     		DW	VEC_CANTX        	;vector base + $A0
VEC_CANRX     		DW	VEC_CANRX        	;vector base + $B2
VEC_CANERR    		DW	VEC_CANERR       	;vector base + $B4
VEC_CANWUP    		DW	VEC_CANWUP       	;vector base + $B6
VEC_FLASH     		DW	VEC_FLASH        	;vector base + $B8
VEC_RESBA    		DW	VEC_RESBA    		;vector base + $BA
VEC_RESBC    		DW	VEC_RESBC    		;vector base + $BC
VEC_RESBE    		DW	VEC_RESBE    		;vector base + $BE
VEC_RESC0    		DW	VEC_RESC0    		;vector base + $C0
VEC_RESC2    		DW	VEC_RESC2    		;vector base + $C2
VEC_SCM	      		DW	VEC_SCM	           	;vector base + $C4
VEC_PLLLOCK  		DW	VEC_PLLLOCK  		;vector base + $C6
VEC_RESC8    		DW	VEC_RESC8    		;vector base + $C8
VEC_RESCA    		DW	VEC_RESCA    		;vector base + $CA
VEC_RESCC    		DW	VEC_RESCC    		;vector base + $CC
VEC_PORTJ     		DW	VEC_PORTJ        	;vector base + $CC
VEC_RESD0    		DW	VEC_RESD0    		;vector base + $D0
VEC_ATD	      		DW	VEC_ATD	           	;vector base + $D2
VEC_RED4     		DW	VEC_RED4     		;vector base + $D4
VEC_SCI	     		DW	VEC_SCI	     		;vector base + $D6
VEC_SPI	     		DW	VEC_SPI	     		;vector base + $D8
VEC_TIM_PAIE     	DW	VEC_TIM_PAIE     	;vector base + $DA
VEC_TIM_PAOV     	DW	VEC_TIM_PAOV     	;vector base + $DC
VEC_TIM_TOV	     	DW	VEC_TIM_TOV	     	;vector base + $DE
VEC_TIM_TC7	     	DW	VEC_TIM_TC7	     	;vector base + $E0
VEC_TIM_TC6	     	DW	VEC_TIM_TC6	     	;vector base + $E2
VEC_TIM_TC5	     	DW	VEC_TIM_TC5	     	;vector base + $E4
VEC_TIM_TC4	     	DW	VEC_TIM_TC4	     	;vector base + $E6
VEC_TIM_TC3	     	DW	VEC_TIM_TC3	     	;vector base + $E8
VEC_TIM_TC2	     	DW	VEC_TIM_TC2	     	;vector base + $EA
VEC_TIM_TC1	     	DW	VEC_TIM_TC1	     	;vector base + $EC
VEC_TIM_TC0	     	DW	VEC_TIM_TC0	     	;vector base + $EE
VEC_RTI	     		DW	VEC_RTI	     		;vector base + $F0
VEC_IRQ	     		DW	VEC_IRQ	     		;vector base + $F2
VEC_XIRQ     		DW	VEC_XIRQ     		;vector base + $F4
VEC_SWI	     		DW	VEC_SWI	     		;vector base + $F6
VEC_TRAP     		DW	VEC_TRAP     		;vector base + $F8
VEC_RESET_COP		DW	RES_COP			;vector base + $FA
VEC_RESET_CM 		DW	RES_CM 			;vector base + $FC
VEC_RESET_EXT		DW	RES_EXT			;vector base + $FE
