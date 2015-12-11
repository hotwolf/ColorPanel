#ifndef PANEL_COMPILED
#define	PANEL_COMPILED	
;###############################################################################
;# ColorPanel - PANEL - LED Panel Driver (WS2812B)                             #
;###############################################################################
;#    Copyright 2015 Dirk Heisswolf                                            #
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
;#    This is the low level driver for LCD using a ST7565R controller. This    #
;#    driver assumes, that the ST7565R is connected via the 4-wire SPI         #
;#    interface. The default pin mapping matches ColorPanel hardware RevC   #
;#                                                                             #
;#    This modules  provides three functions to the main program:              #
;#    PANEL_CHECK_BUF - This function checks if the command buffer is able      #
;#                        to accept more data.                                 #
;#    PANEL_TX_NB -     This function send one command to the display           #
;#                        without blocking the program flow.                   #
;#    PANEL_TX_BL -     This function send one command to the display and       #
;#                        blocks the program flow until it has been            #
;#                        successful.                                          #
;#                                                                             #
;#    For convinience, all of these functions may also be called as macro.     #
;###############################################################################
;# Required Modules:                                                           #
;#    REGDEF - Register Definitions                                            #
;#    VECMAP - Vector Map                                                      #
;#    CLOCK  - Clock driver                                                    #
;#    GPIO   - GPIO driver                                                     #
;#    ISTACK - Interrupt Stack Handler                                         #
;#    SSTACK - Subroutine Stack Handler                                        #
;#    GPIO   - GPIO driver                                                     #
;#                                                                             #
;###############################################################################
;# Version History:                                                            #
;#    December 8, 2015                                                         #
;#      - Initial release                                                      #
;#                                                                             #
;###############################################################################

;#Pixel buffer (RGB):
;
;     +--------------+ +0
;     |              |
;     |    CPAGE     |
;     |    green     |
;     |              |
;     |              |
;     +--------------+ +PANEL_CPAGE_SIZE
;     |              |
;     |    CPAGE     |
;     |     red      |
;     |              |
;     |              |
;     +--------------+ +2*PANEL_CPAGE_SIZE
;     |              |
;     |    CPAGE     |
;     |    blue      |
;     |              |
;     |              |
;     +--------------+
;
;#Color page:
;        C0  C1  C2  C3  C4  C5  C6  C7  C8  C9  C10 C11 C12 C13  C14
;      +----+---+---+---+---+---+---+---+---+---+---+---+---+----+----+
;  R0  |A104|A75<A74|A45<A44|A15<A14|B14>B15|B44>B45|B74>B75|B104>B105| +$00
;      +-^--+-v-+-^-+-v-+-^-+-v-+-^-+-^-+-v-+-^-+-v-+-^-+-v-+--^-+-v--+ 
;  R1  |A103|A76|A73|A46|A43|A16|A13|B13|B16|B43|B46|B73|B76|B103|B106| +$0F
;      +-^--+-v-+-^-+-v-+-^-+-v-+-^-+-^-+-v-+-^-+-v-+-^-+-v-+-^--+-v--+ 
;  R2  |A102|A77|A72|A47|A42|A17|A12|B12|B17|B42|B47|B72|B77|B102|B107| +$1E  
;      +-^--+-v-+-^-+-v-+-^-+-v-+-^-+-^-+-v-+-^-+-v-+-^-+-v-+-^--+-v--+ 
;  R3  |A101|A78|A71|A48|A41|A18|A11|B11|B18|B41|B48|B71|B78|B101|B108| +$2D  
;      +-^--+-v-+-^-+-v-+-^-+-v-+-^-+-^-+-v-+-^-+-v-+-^-+-v-+-^--+-v--+ 
;  R4  |A100|A79|A70|A49|A40|A19|A10|B10|B19|B40|B49|B70|B79|B100|B109| +$3C  
;      +-^--+-v-+-^-+-v-+-^-+-v-+-^-+-^-+-v-+-^-+-v-+-^-+-v-+-^--+-v--+ 
;  R5  |A99 |A80|A69|A50|A39|A20|A9 |B9 |B20|B39|B50|B69|B80|B99 |B110| +$4B  
;      +-^--+-v-+-^-+-v-+-^-+-v-+-^-+-^-+-v-+-^-+-v-+-^-+-v-+-^--+-v--+ 
;  R6  |A98 |A81|A68|A51|A38|A21|A8 |B8 |B21|B38|B51|B68|B81|B98 |B111| +$5A  
;      +-^--+-v-+-^-+-v-+-^-+-v-+-^-+-^-+-v-+-^-+-v-+-^-+-v-+-^--+-v--+ 
;  R7  |A97 |A82|A67|A52|A37|A22|A7 |B7 |B22|B37|B52|B67|B82|B97 |B112| +$69   
;      +-^--+-v-+-^-+-v-+-^-+-v-+-^-+-^-+-v-+-^-+-v-+-^-+-v-+-^--+-v--+ 
;  R8  |A96 |A83|A66|A53|A36|A23|A6 |B6 |B23|B36|B53|B66|B83|B96 |B113| +$78  
;      +-^--+-v-+-^-+-v-+-^-+-v-+-^-+-^-+-v-+-^-+-v-+-^-+-v-+-^--+-v--+ 
;  R9  |A95 |A84|A65|A54|A35|A24|A5 |B5 |B24|B35|B54|B65|B84|B95 |B114| +$87   
;      +-^--+-v-+-^-+-v-+-^-+-v-+-^-+-^-+-v-+-^-+-v-+-^-+-v-+-^--+-v--+ 
;  R10 |A94 |A85|A64|A55|A34|A25|A4 |B4 |B25|B34|B55|B64|B85|B94 |B115| +$96 
;      +-^--+-v-+-^-+-v-+-^-+-v-+-^-+-^-+-v-+-^-+-v-+-^-+-v-+-^--+-v--+ 
;  R11 |A93 |A86|A63|A56|A33|A26|A3 |B3 |B26|B33|B56|B63|B86|B93 |B116| +$A5 
;      +-^--+-v-+-^-+-v-+-^-+-v-+-^-+-^-+-v-+-^-+-v-+-^-+-v-+-^--+-v--+ 
;  R12 |A92 |A87|A62|A57|A32|A27|A2 |B2 |B27|B32|B57|B62|B87|B92 |B117| +$C3  
;      +-^--+-v-+-^-+-v-+-^-+-v-+-^-+-^-+-v-+-^-+-v-+-^-+-v-+-^--+-v--+ 
;  R13 |A91 |A88|A61|A58|A31|A28|A1 |B1 |B28|B31|B58|B61|B88|B91 |B118| +$D2  
;      +-^--+-v-+-^-+-v-+-^-+-v-+-^-+-^-+-v-+-^-+-v-+-^-+-v-+-^--+-v--+ 
;  R14 |A90 <A89<A60<A59|A30<A29|A0 |B0 |B29>B30|B59>B60|B89>B90 |B119| +$E1  
;      +----+---+---+---+---+---+---+---+---+---+---+---+---+----+----+ 
;                                 ^   ^
;                           STRIP_A   STRIP_B
;                            (SPI0)   (SPI1)
;
	
;###############################################################################
;# Configuration                                                               #
;###############################################################################
;#Bus frequency
#ifndef CLOCK_BUS_FREQ	
CLOCK_BUS_FREQ		EQU	25000000	;default is 25 MHz
#endif

;#SPI transmit buffer sizes		
#ifndef	SCI_TXBUF_SIZE	
SCI_TXBUF_SIZE		EQU	2*8		;size of each transmit buffer
#endif
	
;###############################################################################
;# Constants                                                                   #
;###############################################################################
;#Dimensions 
PANEL_WIDTH		EQU	15		
PANEL_HEIGHT		EQU	15
PANEL_CPAGE_SIZE	EQU	PANEL_WIDTH*PANEL_HEIGHT
PANEL_PIXBUF_SIZE	EQU	3*PANEL_COLPAG_SIZE
	
;#Baud rate
PANEL_BAUD		EQU	2500000		;WS2812B requires 2.5 Mbit/s

;#Baud rate divider
PANEL_SPPR		EQU	((CLOCK_BUS_FREQ/(2*PANEL_BAUD))-1)&7
PANEL_SPR		EQU	0	

;#Reset length (number of 16-bit SPI transmissions)
PANEL_RST_LENGTH	EQU	8

;#SPI configuration
				;+-------------- Rx interrupt enable (disabled)
				;|+------------- SPI enable (always on)
				;||+------------ Tx buffer empty interrupy enable
				;|||+----------- master mode
				;||||+---------- clock polarity does not matter
				;|||||+--------- clock phase does not matter
				;||||||+-------- no slave select output
				;|||||||+------- transmit MSB first
				;||||||||	
PANEL_SPICR1_CFG	EQU	%01010100 	;only SPTIE will be modified
				;SSSMCCSL 
				;PPPSPPSS 
				;IETTOHOB 
				;E IRLAEF 
				;  E    E 

				; +------------- 16-bit transfer width
				; | +----------- no slave select output
				; | |+---------- MOSI in bidirectional mode 
				; | || +-------- no STOP in WAIT mode
				; | || |+------- bidirectional mode (disables MISO)
				; | || ||	
PANEL_SPICR2_CFG	EQU	%01001001
				; X MB SS
				; F OI PP
				; R DD IC
				; W FI S0
				;   ER W
				;   NO A
				;    E I
PANEL_SPIBR_CFG		EQU	((PANEL_SPPR<<4)|PANEL_SPR)

PANEL_SPICR1_SPICR2_CFG	EQU	((PANEL_SPICR1_CFG<8)|PANEL_SPICR2_CFG)
PANEL_SPIBR_SPISR_CFG	EQU(	((PANEL_SPIBR_CFG<8)|SPIF|SPTEF|MODF)
	
;###############################################################################
;# Variables                                                                   #
;###############################################################################
#ifdef PANEL_VARS_START_LIN
			ORG 	PANEL_VARS_START, PANEL_VARS_START_LIN
#else
			ORG 	PANEL_VARS_START
PANEL_VARS_START_LIN	EQU	@			
#endif	
	
//#Pixel buffer	
PANEL_PIXBUF		EQU	*
PANEL_CPAGE_RED		DS	PANEL_CPAGE_SIZE
PANEL_CPAGE_GREEN	DS	PANEL_CPAGE_SIZE
PANEL_CPAGE_BLUE	DS	PANEL_CPAGE_SIZE

;#SPI0 Transmit buffer
SPI0_TXBUF		DS	SPI_TXBUF_SIZE
SPI0_TXBUF_IN		DS	1		;points to the next free space
SPI0_TXBUF_OUT		DS	1		;points to the oldest entry

;#SPI1 Transmit buffer
SPI1_TXBUF		DS	SPI_TXBUF_SIZE
SPI1_TXBUF_IN		DS	1		;points to the next free space
SPI1_TXBUF_OUT		DS	1		;points to the oldest entry










	
PANEL_STRIPA_RSTCNT	DS	1
PANEL_STRIPA_CPAGE_IDX	DS	1
PABEL_STRIPA_COLOR	DS	1
PANEL_STRIPA_TXDATA	DS	2		
PANEL_RST
	
//#Strip B

PANEL_VARS_END		EQU	*
PANEL_VARS_END_LIN	EQU	@
	
;###############################################################################
;# Macros                                                                      #
;###############################################################################
;#Initialization
#macro	PANEL_INIT, 0
			;SPI0 setup 
			MOVW	#PANEL_SPICR1_SPICR2_CFG, SPI0CR1
			MOVW	#PANEL_SPIBR_SPISR_CFG,   SPI0BR
			;SPI1 setup 
			MOVW	#PANEL_SPICR1_SPICR2_CFG, SPI1CR1
			MOVW	#PANEL_SPIBR_SPISR_CFG,   SPI1BR
#emac

;# Essential functions
;---------------------
	
;# Convenience macros
;--------------------
	
;# Macros for internal use
;-------------------------

;#Check if all pixels have been transmittet
; args:   none
; result: A: Space left on the buffer in bytes
; SSTACK: 3 bytes
;         X, Y and B are preserved 



	

;#Determine how much space is left on the buffer
; args:   1: SPI instance
;         X:  
; result: A: Space left on the buffer in bytes
; SSTACK: 3 bytes
;         X, Y and B are preserved 



;#SPI ISRs for transmitting data to the WS2812B LEDs
;---------------------------------------------------
; args:   1: SPI instance
#macro PANEL_SPI_ISR, 1
			;Check if TX data is available
			LDD	\1_TXBUF_IN 					;IN:OUT -> D
			CBA							;check if buffer is empty
			BEQ	PANEL_SPI_ISR_ 					;buffer is empty
			;Transmit next word (IN:OUT in D)
			BRCLR	\1SR, #SPTEF, PANEL_SPI_ISR_1 		;SPI still busy
			LDX	#\1_TXBUF 					;buffer pointer -> X
			MOVW	B,X, \1DR 					;transmit next word
			;Update buffer pointer (IN:OUT in D)
			ADDB	#2 						;increment out pointer 
			ANDB	#(SPI_TXBUF_SIZE-1)
			STAB	\1_TXBUF_IN 					;IN:OUT -> D
			;Done
PANEL_ISR_1		ISTACK_RTI
			;Disable interrupts 
			MOVB	#PANEL_SPICR1_CFG, \1CR1 			;clear SPTIE 
PANEL_ISR_2		JOB	PANEL_ISR_1
#emac
	
;###############################################################################
;# Code                                                                        #
;###############################################################################
#ifdef PANEL_CODE_START_LIN
			ORG 	PANEL_CODE_START, PANEL_CODE_START_LIN
#else
			ORG 	PANEL_CODE_START
#endif






	
;#SPI ISRs for transmitting data to the WS2812B LEDs
;---------------------------------------------------
PANEL_SPI0_ISR		PANEL_SPI_ISR	SPI0
PANEL_SPI1_ISR		PANEL_SPI_ISR	SPI1
	
PANEL_CODE_END		EQU	*	
PANEL_CODE_END_LIN	EQU	@	
	
;###############################################################################
;# Tables                                                                      #
;###############################################################################
#ifdef PANEL_TABS_START_LIN
			ORG 	PANEL_TABS_START, PANEL_TABS_START_LIN
#else
			ORG 	PANEL_TABS_START
#endif	

	
PANEL_TABS_END		EQU	*
PANEL_TABS_END_LIN	EQU	@
#endif
