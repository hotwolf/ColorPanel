#ifndef	GPIO_COMPILED
#define	GPIO_COMPILED
;###############################################################################
;# S12CBase - GPIO - GPIO Handler (ColorPanel)                                 #
;###############################################################################
;#    Copyright 2010-2016 Dirk Heisswolf                                       #
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
;#    This module initializes all unused GPIO ports. The OpenBDM firmware      #
;#    assumes the following I/O pin configuration of the S12G128 MCU:          #
;#    Port AD:                                                                 #
;#     PAD0  - NC                         (input        pull-up  )             #
;#     PAD1  - NC                         (input        pull-up  )             #
;#     PAD2  - NC                         (input        pull-up  )             #
;#     PAD3  - NC                         (input        pull-up  )             #
;#     PAD4  - NC                         (input        pull-up  )             #
;#     PAD5  - NC                         (input        pull-up  )             #
;#     PAD6  - NC                         (input        pull-up  )             #
;#     PAD7  - Vusb                       (analog       no pull  )             #
;#     PAD8  - NC                         (input        pull-up  )             #
;#     PAD9  - NC                         (input        pull-up  )             #
;#     PAD10 - NC                         (input        pull-up  )             #
;#     PAD11 - NC                         (input        pull-up  )             #
;#     PAD12 - NC                         (input        pull-up  )             #
;#     PAD13 - NC                         (input        pull-up  )             #
;#     PAD14 - NC                         (input        pull-up  )             #
;#     PAD15 - NC                         (input        pull-up  )             #
;#    Port A:                                                                  #
;#     PA0 - NC                           (input        pull-up  )             #
;#     PA1 - NC                           (input        pull-up  )             #
;#     PA2 - NC                           (input        pull-up  )             #
;#     PA3 - NC                           (input        pull-up  )             #
;#     PA4 - NC                           (input        pull-up  )             #
;#     PA5 - NC                           (input        pull-up  )             #
;#     PA6 - NC                           (input        pull-up  )             #
;#     PA7 - NC                           (input        pull-up  )             #
;#    Port B:                                                                  #
;#     PB0 - NC                           (input        pull-up  )             #
;#     PB1 - NC                           (input        pull-up  )             #
;#     PB2 - NC                           (input        pull-up  )             #
;#     PB3 - NC                           (input        pull-up  )             #
;#     PB4 - NC                           (input        pull-up  )             #
;#     PB5 - NC                           (input        pull-up  )             #
;#     PB6 - NC                           (input        pull-up  )             #
;#     PB7 - NC                           (input        pull-up  )             #
;#    Port C:                                                                  #
;#     PC0 - NC                           (input        pull-up  )             #
;#     PC1 - NC                           (input        pull-up  )             #
;#     PC2 - NC                           (input        pull-up  )             #
;#     PC3 - NC                           (input        pull-up  )             #
;#     PC4 - NC                           (input        pull-up  )             #
;#     PC5 - NC                           (input        pull-up  )             #
;#     PC6 - NC                           (input        pull-up  )             #
;#     PC7 - NC                           (input        pull-up  )             #
;#    Port D:                                                                  #
;#     PD0 - NC                           (input        pull-up  )             #
;#     PD1 - NC                           (input        pull-up  )             #
;#     PD2 - NC                           (input        pull-up  )             #
;#     PD3 - NC                           (input        pull-up  )             #
;#     PD4 - NC                           (input        pull-up  )             #
;#     PD5 - NC                           (input        pull-up  )             #
;#     PD6 - NC                           (input        pull-up  )             #
;#     PD7 - NC                           (input        pull-up  )             #
;#    Port E:                                                                  #
;#     PE0 - LED (green)                  (output       high     )             #
;#     PE1 - LED (red)                    (output       high     )             #
;#    Port J:                                                                  #
;#     PJ0 - NC (SPI1 MISO)               (input        pull-up  )             #
;#     PJ1 - SPI1 MOSI                    (output       high     )             #
;#     PJ2 - NC (SPI1 SCK)                (input        pull-up  )             #
;#     PJ3 - NC (SPI1 /SS)                (input        pull-up  )             #
;#     PJ4 - NC                           (input        pull-up  )             #
;#     PJ5 - NC                           (input        pull-up  )             #
;#     PJ6 - NC                           (input        pull-up  )             #
;#     PJ7 - NC                           (input        pull-up  )             #
;#    Port M:                                                                  #
;#     PM0 - RTS                          (input        no pull  )             #
;#     PM1 - CTS (output)                 (output       low      )             #
;#     PM2 - NC                           (input        pull_up  )             #
;#     PM3 - NC                           (input        pull_up  )             #
;#    Port P:                                                                  #
;#     PP0 - NC                           (input        pull-up  )             #
;#     PP1 - NC                           (input        pull-up  )             #
;#     PP2 - NC                           (input        pull-up  )             #
;#     PP3 - NC                           (input        pull-up  )             #
;#     PP4 - NC                           (input        pull-up  )             #
;#     PP5 - NC                           (input        pull-up  )             #
;#     PP6 - NC                           (input        pull-up  )             #
;#     PP7 - NC                           (input        pull-up  )             #
;#    Port S:                                                                  #
;#     PS0 - SCI0 RX                      (input        no pull  )             #
;#     PS1 - SCI0 TX (output)             (output       high     )             #
;#     PS2 - NC                           (input        pull-up  )             #
;#     PS3 - NC                           (input        pull-up  )             #
;#     PS4 - NC (SPI0 MISO)               (input        pull-up  )             #
;#     PS5 - SPI MOSI                     (output       high     )             #
;#     PS6 - NC (SPI0 SCK)                (input        pull-up  )             #
;#     PS7 - NC (SPI0 /SS)                (input        pull-up  )             #
;#    Port T:                                                                  #
;#     PT0 - IC0 (/XIRQ)                  (input        no pull  )             #
;#     PT1 - IC1 (/IRQ)                   (input        no pull  )             #
;#     PT2 - NC                           (input        pull-up  )             #
;#     PT3 - NC                           (input        pull-up  )             #
;#     PT4 - NC                           (input        pull-up  )             #
;#     PT5 - NC                           (input        pull-up  )             #
;#     PT6 - NC                           (input        pull-up  )             #
;#     PT7 - NC                           (input        pull-up  )             #
;###############################################################################
;# Required Modules:                                                           #
;#    REGDEF - Register Definitions                                            #
;#                                                                             #
;# Requirements to Software Using this Module:                                 #
;#    - none                                                                   #
;###############################################################################
;# Version History:                                                            #
;#    December 17, 2015                                                        #
;#      - Initial release                                                      #
;###############################################################################

;###############################################################################
;# Constants                                                                   #
;###############################################################################

;###############################################################################
;# Variables                                                                   #
;###############################################################################
			ORG 	GPIO_VARS_START, GPIO_VARS_START_LIN

GPIO_VARS_END		EQU	*
GPIO_VARS_END_LIN	EQU	@

;###############################################################################
;# Macros                                                                      #
;###############################################################################
;#Initialization
#macro	GPIO_INIT, 0
		;#General
		LDAA	#MODC					;lock MODE register into NSC mode
		STAA	MODE		
		STAA	MODE
		;#Port AD
		MOVW	#%1111_1111_0111_1111, ATDDIEN   	;switch unused pins to digital
		;MOVW	#$0000, PT0AD
		;MOVW	#$0000, DDR0AD
		MOVW	#$FF7F, PER0AD
		;MOVW	#$0000, PPS0AD
		;MOVW	#$0000, PIE0AD
		;#Port A, B, C, D, and E
		;MOVW	#$0000, PORTA				;port A/B
		;MOVW	#$0000, DDRA				;port A/B
		;MOVW	#$0000, PORTC				;port C/D
		;MOVW	#$0000, DDRC				;port C/D
		MOVW	#$0303, PORTE 				;port E (PORTE/DDRE)
		MOVB	#$4F,   PUCR				;BKPUE|~PDPEE|PUPDE|PUPCE|PUPBE|PUPAE
		;MOVB	#$C0,   ECLKCTL
		;MOVB	#$00,	IRQCR
		;#Port J
		MOVB	#$02,   PTJ 			
		MOVB	#$02,   DDRJ 			
		MOVB	#$FD	PERJ
		;MOVB	#$00,   PPSJ 			
		;MOVB	#$00FF,	PIEJ				;PIEJ/PIFJ 			
		;#Port M
		;MOVB	#$00,   PTM 			
		MOVB	#$02,   DDRM 			
		;MOVW	#$0D01	PERM 				;PERM/PPSM
		MOVB	#$0C	PERM
		;MOVW	#$0C00	PERM 				;PERM/PPSM
		;MOVB	#$02,	WOMM
	        MOVB	PKGCR, PKGCR 				;lock PKGCR
		;#Port P
		;MOVB	#$00,   PTP 			
		;MOVB	#$00,   DDRP 			
		MOVB	#$FF	PERP
		;MOVB	#$00,   PPSP 			
		;MOVB	#$00FF,	PIEP				;PIEP/PIFP 			
		;#Port S
		MOVB	#$22, PTS	
		MOVB	#$22, DDRS
		MOVW	#$DC, PERS 				;PERS/PPSS
		;MOVB	#$02,	WOMS
		;#Port T
		;MOVB	#$00,   PTT 			
		;MOVB	#$00,   DDRT 			
		MOVB	#$FC	PERT
		;MOVB	#$00,   PPST 			
#emac
	
;###############################################################################
;# Code                                                                        #
;;###############################################################################
			ORG 	GPIO_CODE_START, GPIO_CODE_START_LIN

GPIO_CODE_END		EQU	*	
GPIO_CODE_END_LIN	EQU	@	

;###############################################################################
;# Tables                                                                      #
;###############################################################################
			ORG 	GPIO_TABS_START, GPIO_TABS_START_LIN

GPIO_TABS_END		EQU	*	
GPIO_TABS_END_LIN	EQU	@	
#endif	
