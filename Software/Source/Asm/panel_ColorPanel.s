#ifndef PANEL_COMPILED
#define	PANEL_COMPILED	
;###############################################################################
;# ColorPanel - PANEL - LED Panel Driver (WS2812B)                             #
;###############################################################################
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
;     +--------------+ +PANEL_PIXEL_COUNT
;     |              |
;     |    CPAGE     |
;     |     red      |
;     |              |
;     |              |
;     +--------------+ +2*PANEL_PIXEL_COUNT
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
;                            STRIPA   STRIPB
;                            (SPI0)   (SPI1)
;
	
;###############################################################################
;# Configuration                                                               #
;###############################################################################
;#Bus frequency
#ifndef CLOCK_BUS_FREQ	
CLOCK_BUS_FREQ		EQU	25000000	;default is 25 MHz
#endif

;#Dimensions 
#ifndef PANEL_WIDTH	
PANEL_WIDTH		EQU	15		
#endif
#ifndef PANEL_HEIGHT	
PANEL_HEIGHT		EQU	15
#endif

;#Partitioning 
#ifndef PANEL_STARTCOL_STRIP_A
PANEL_STARTCOL_STRIP_A	EQU	6
#endif
#ifndef PANEL_STARTCOL_STRIP_B
PANEL_STARTCOL_STRIP_B	EQU	7
#endif

;###############################################################################
;# Constants                                                                   #
;###############################################################################
;#Number of 8-bit transmissions for the reset pulse
PANEL_RST_LENGTH	EQU	17 		;must be an odd number

//#Pixel buffer	
PANEL_PIXEL_COUNT	EQU	PANEL_WIDTH*PANEL_HEIGHT



	

	

;SPI buffer
PANEL_SCI_TXBUF_MASK	EQU	PANEL_SPI_TXBUF_SIZE

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

;#Reset length (number of 8-bit SPI transmissions) WS2812B requires >50us
PANEL_RST_LENGTH	EQU	17 		;must be an odd number

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
PANEL_PIXBUF_START	EQU	*
PANEL_PIXBUF_GREEN	DS	PANEL_PIXEL_COUNT
PANEL_PIXBUF_RED	DS	PANEL_PIXEL_COUNT
PANEL_PIXBUF_BLUE	DS	PANEL_PIXEL_COUNT
PANEL_PIXBUF_END	EQU	*

;#Strip A buffer
PANEL_AUTO_LOC1		EQU	* 			;1st auto-place location
			ALIGN	1 			
PANEL_STRIPA_BUF	DS	4 			;intermediate buffer
PANEL_STRIPA_BUF_CNT	DS	1 			;byte count in intermediate buffer
PANEL_STRIPA_VERT_MOVE	DS	1 			;vertical movement (+/- PANEL_WIDTH)
PANEL_STRIPA_PIXBUF_PTR	DS	2 			;pixel buffer pointer
PANEL_STRIPA_RST_CNT	EQU	((PANEL_AUTO_LOC1&1)*PANEL_AUTO_LOC1)+((~(PANEL_AUTO_LOC1)&1)*PANEL_AUTO_LOC2)	  	
				  	
;#Strip B buffer		  	
PANEL_STRIPB_BUF	DS	4 			;intermediate buffer
PANEL_STRIPB_BUF_CNT	DS	1 			;byte count in intermediate buffer
PANEL_STRIPB_VERT_MOVE	DS	1 			;vertical movement (+/- PANEL_WIDTH)
PANEL_STRIPB_PIXBUF_PTR	DS	2 			;pixel buffer pointer
PANEL_STRIPB_RST_CNT	DS	1 			;byte count in intermediate buffer	
				  			
PANEL_AUTO_LOC2		EQU	* 			;2nd auto-place location
	
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
			;Initialize pixel buffer
			LDAA	#PANEL_PIXBUF_SIZE
			LDX	PANEL_PIXBUF_START
#ifdef	PANEL_SPLASH			
			LDY	PANEL_SPLASH
LOOP			MOVB	1,Y+, 1,X+
#else
LOOP			CLR	1,X+	
#endif
			DBNE	A, LOOP
			;Update display
			PANEL_UPDATE
#emac
	
;# Essential functions
;---------------------
	
;# Convenience macros
;--------------------
	
;# Macros for internal use
;-------------------------

;#Expand byte
; args:   B: byte value
;         1: address of 1st expanded byte
;         2: address of 2nd expanded byte
;         3: address of 3rd expanded byte
; result: A: 3rd expanded byte
; 	  B: zero
; SSTACK: none
;         X andY are preserved 
#macro PANEL_EXPAND_BYTE, 3
			;1st expanded byte
			LSLA				;bit 7
			LSLD				;bit 6
			LSLA				;bit 5
			LSLA				;bit 4
			LSLD				;bit 3
			LSLA				;bit 2
			LSLA				;bit 1
			LSLD				;bit 0
			ORAA	#$92			;set TxHs
			STAA	/1			;store 1st expanded byte
			;2nd expanded byte		
			LSLA				;bit 7
			LSLA				;bit 6
			LSLD				;bit 5
			LSLA				;bit 4
			LSLA				;bit 3
			LSLD				;bit 2
			LSLA				;bit 1
			LSLA				;bit 0
			ORAA	#$49			;set TxHs
			STAA	/2			;store 1st expanded byte
			;3rd expanded byte		
			LSLD				;bit 7
			LSLA				;bit 6
			LSLA				;bit 5
			LSLD				;bit 4
			LSLA				;bit 3
			LSLA				;bit 2
			LSLD				;bit 1
			LSLA				;bit 0
			ORAA	#$24			;set TxHs
			STAA	/3			;store 1st expanded byte
#emac

;#Switch to next pixel buffer entry (strip A)
; args:   1: branch address in case there is no next entry
; result: A: new vertical movement (PANEL_STRIPA_VERT_MOVE)
; 	  X: new buffer pointer (PANEL_STRIPA_PIXBUF_PTR)
; SSTACK: none
;         B and Y are preserved 
#macro PANEL_STRIPA_NEXT, 3
			;Check if there is a next pixel buffer entrz 
			LDX	PANEL_STRIPA_PIXBUF_PTR ;buffer pointer -> X
			CPX	#PANEL_PIXBUF_START	;check for last pixel
			BEQ	\1			;no next entry
			;Switch color (buffer pointer in X)
			CPX	#PANEL_PIXBUF_BLUE	;check for blue
			BHS	PANEL_STRIPA_NEXT_1	;back to green
			LEAX	PANEL_PIXEL_COUNT,X	;switch color
			JOB	PANEL_STRIPA_NEXT_3	;update pointer
PANEL_STRIPA_NEXT_1	LEAX	(-2*PANEL_PIXEL_COUNT),X;switch back to green
			;Switch row (new buffer pointer in X)
			LDAA	PANEL_STRIPA_VERT_MOVE 	;vertical movement -> A
			LEAX	A,X			;vertical move			
			CPX	#PANEL_PIXBUF_GREEN	;check green boundaries
			BL0	PANEL_STRIPA_NEXT_2	;change vertical direction
			CPX	#PANEL_PIXBUF_RED	;check green boundaries
			BLO	PANEL_STRIPA_NEXT_3	;update pointer
PANEL_STRIPA_NEXT_2	NEGA				;change direction
			STAA	PANEL_STRIPA_VERT_MOVE 	;update vertical movement
			LEAX	A,Y			;revert vertical move			
			;Switch column (new buffer pointer in X)
			LEAX	-1,X 			;horizontal movement
PANEL_STRIPA_NEXT_3	STX	PANEL_STRIPA_PIXBUF_PTR ;update buffer pointer
#emac
			
;#Switch to next pixel buffer entry (strip B)
; args:   1: branch address in case there is no next entry
; result: A: new vertical movement (PANEL_STRIPB_VERT_MOVE)
; 	  X: new buffer pointer (PANEL_STRIPB_PIXBUF_PTR)
; SSTACK: none
;         B and Y are preserved 
#macro PANEL_STRIPB_NEXT, 3
			;Check if there is a next pixel buffer entrz 
			LDX	PANEL_STRIPB_PIXBUF_PTR ;buffer pointer -> X
			CPX	#(PANEL_PIXBUF_START+PANEL_WIDTH-1);check for last pixel
			BEQ	\1			;no next entry
			;Switch color (buffer pointer in X)
			CPX	#PANEL_PIXBUF_BLUE	;check for blue
			BHS	PANEL_STRIPB_NEXT_1	;back to green
			LEAX	PANEL_PIXEL_COUNT,X	;switch color
			JOB	PANEL_STRIPB_NEXT_3	;update pointer
PANEL_STRIPB_NEXT_1	LEAX	(-2*PANEL_PIXEL_COUNT),X;switch back to green
			;Switch row (new buffer pointer in X)
			LDAA	PANEL_STRIPB_VERT_MOVE 	;vertical movement -> A
			LEAX	A,X			;vertical move			
			CPX	#PANEL_PIXBUF_GREEN	;check green boundaries
			BL0	PANEL_STRIPB_NEXT_2	;change vertical direction
			CPX	#PANEL_PIXBUF_RED	;check green boundaries
			BLO	PANEL_STRIPB_NEXT_3	;update pointer
PANEL_STRIPB_NEXT_2	NEGA				;change direction
			STAA	PANEL_STRIPB_VERT_MOVE 	;update vertical movement
			LEAX	A,Y			;revert vertical move			
			;Switch column (new buffer pointer in X)
			LEAX	1,X 			;horizontal movement
PANEL_STRIPB_NEXT_3	STX	PANEL_STRIPB_PIXBUF_PTR ;update buffer pointer
#emac

;#SPI ISRs for transmitting data to the WS2812B LEDs
;---------------------------------------------------
; args:   1: "STRIPA" or "STRIPB"
;         2: "SPI0" or "SPI1"
#macro PANEL_ISR, 1
			;Check if reset pulse is to be driven
			LDAA	PANEL_\1_RST_CNT 	;reset pilse counter -> A
			BEQ	PANEL_ISR_ 		;drive pixels			
			;Drive reset pulse (reset pulse counter in A)
			BRCLR	\1SR, #SPTEF, PANEL_SPI_ISR_1 			;done
			MOVW	#0000, \1DR 					;transmit part of reset pulse
			DBEQ	A, PANEL_SPI_ISR_ 				;prepare first pixel
			STAA	PANEL_\1_RST_CNT 	;reset pilse counter -> A
			;Dr
			ISTACK_RTI


	
			;Check if TX data is available
			LDD	\1_TXBUF_IN 					;IN:OUT -> D
			ANDA	$#FE 						;ignore odd buffer entries
			CBA							;check if buffer is empty
			BEQ	PANEL_SPI_ISR_2 					;buffer is empty
			;Transmit next word (IN:OUT in D)
			BRCLR	\1SR, #SPTEF, PANEL_SPI_ISR_1 			;SPI still busy
			LDX	#\1_TXBUF 					;buffer pointer -> X
			MOVW	B,X, \1DR 					;transmit next word
			;Update buffer pointer (IN:OUT in D)
			ADDB	#2 						;increment out pointer 
			ANDB	#SPI_TXBUF_MASK
			STAB	\1_TXBUF_IN 					;IN:OUT -> D
			;Done
PANEL_ISR_1		ISTACK_RTI
			;Disable interrupts 
PANEL_ISR_2		MOVB	#PANEL_SPICR1_CFG, \1CR1 			;clear SPTIE 
			OB	PANEL_ISR_1
#emac
	
;###############################################################################
;# Code                                                                        #
;###############################################################################
#ifdef PANEL_CODE_START_LIN
			ORG 	PANEL_CODE_START, PANEL_CODE_START_LIN
#else
			ORG 	PANEL_CODE_START
#endif



;#Reset WS2812B communication
; args:   1: SPI instance
;         X:  
; result: A: Space left on the buffer in bytes
; SSTACK: 3 bytes
;         X, Y and B are preserved 
PANEL_RST_BL		EQU	* 	
			;Save registers
			PSHX							;save X
			PSHY							;save Y
			PSHD							;save D
			;Allocate reset counters
			MOVW	#((PANEL_RST_LENGTH<<8)|PANEL_RST_LENGTH), 2,-SP;SPI1:SPI0
			;Check SPI0 buffer
PANEL_RST_BL_1		SEI							;make sequence atomic
			LDD	PANEL_SPI0_IN 					;check SPI1 buffer
			SBA							;IN-OUT -> A
			ANDA	#~PANEL_SPI_MASK 				;wrap result
			COMA							;available space in A
			BNE	PANEL_RST_BL_					;queue not full
			;Check SPI1 buffer
			LDD	PANEL_SPI1_IN 					;check SPI1 buffer
			SBA							;IN-OUT -> A
			ANDA	#~PANEL_SPI_MASK 				;wrap result
			COMA							;available space in A
			BNE	PANEL_RST_BL_					;queue not full
			;Wait for any system event
			ISTACK_WAIT 						;wait for next event
			JOB	PANEL_RST_BL_1 					;check buffers again

			;Fill SPI0 buffer (available buffer entrirs in A, OUT in B)
			CLI							;allow interrupts

			LDY	#PANEL_SPI0_TXBUF
			LEAY	B,Y












	
	
	BITA	#PANEL_SPI_MASK					;check available space		
			BNE	PANEL_RST_BL_ 					;
	

			;Fill SPI0 buffer 
			LDY	
	

	PSHD							;save D
			PSHD							;save D
			
	
			;Transmit next byte (start pointer in X, byte count in Y)
DISP_STREAM_NB_1	LDAB	1,X+ 						;get data
			DISP_TX_NB 						;transmit data (SSTACK: 5 bytes)
			BCC	DISP_STREAM_NB_3				;TX buffer is full
			DBNE	Y, DISP_STREAM_NB_1 				;transmit next byte



	
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

;#Gamma correction look-up table
;-------------------------------
PANEL_GAMMA_LUT		EQU	*
#ifmac PANEL_GAMMA_LUT
			PANEL_GAMMA_LUT
#else
			;Default gamma correction factor = 2.22: 
                	DB $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00
                	DB $00 $00 $00 $00 $00 $00 $01 $01 $01 $01 $01 $01 $01 $02 $02 $02
                	DB $02 $02 $02 $03 $03 $03 $03 $03 $04 $04 $04 $04 $05 $05 $05 $05
                	DB $06 $06 $06 $07 $07 $07 $08 $08 $08 $09 $09 $09 $0A $0A $0B $0B
                	DB $0B $0C $0C $0D $0D $0E $0E $0E $0F $0F $10 $10 $11 $11 $12 $12
                	DB $13 $13 $14 $15 $15 $16 $16 $17 $18 $18 $19 $19 $1A $1B $1B $1C
                	DB $1D $1D $1E $1F $1F $20 $21 $22 $22 $23 $24 $25 $25 $26 $27 $28
                	DB $29 $29 $2A $2B $2C $2D $2E $2E $2F $30 $31 $32 $33 $34 $35 $36
                	DB $37 $38 $39 $3A $3B $3C $3D $3E $3F $40 $41 $42 $43 $44 $45 $46
                	DB $47 $48 $49 $4B $4C $4D $4E $4F $50 $52 $53 $54 $55 $56 $58 $59
                	DB $5A $5B $5D $5E $5F $61 $62 $63 $64 $66 $67 $69 $6A $6B $6D $6E
                	DB $6F $71 $72 $74 $75 $77 $78 $7A $7B $7D $7E $80 $81 $83 $84 $86
                	DB $87 $89 $8A $8C $8E $8F $91 $93 $94 $96 $98 $99 $9B $9D $9E $A0
                	DB $A2 $A3 $A5 $A7 $A9 $AB $AC $AE $B0 $B2 $B4 $B5 $B7 $B9 $BB $BD
                	DB $BF $C1 $C3 $C4 $C6 $C8 $CA $CC $CE $D0 $D2 $D4 $D6 $D8 $DA $DC
                	DB $DE $E0 $E3 $E5 $E7 $E9 $EB $ED $EF $F1 $F4 $F6 $F8 $FA $FC $FF
#endif

#ifmac PANEL_SPLASH
;#Gamma correction look-up table
;-------------------------------
PANEL_SPLASH		EQU	*
			PANEL_SPLASH
PANEL_SPLASH_END	EQU	*
#endif
	
PANEL_TABS_END		EQU	*
PANEL_TABS_END_LIN	EQU	@
#endif
