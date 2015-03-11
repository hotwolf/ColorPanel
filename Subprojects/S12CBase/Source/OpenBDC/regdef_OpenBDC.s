#ifndef	REDDEF_COMPILED
#define REGDEF_COMPILED
;###############################################################################
;# S12CBase - REGDEF - Register Definitions (OpenBDC)                          #
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
;#    This module defines the register map of the S12C128.                     #
;###############################################################################
;# Required Modules:                                                           #
;#    - none                                                                   #
;#                                                                             #
;# Requirements to Software Using this Module:                                 #
;#    - none                                                                   #
;###############################################################################
;# Version History:                                                            #
;#    Apr 1, 2010                                                              #
;#      - Initial release                                                      #
;###############################################################################
;################################
;# S12C128 Register Definitions #
;################################
PORTA		EQU	$0000
PTA7		EQU	$80
PTA6		EQU	$40
PTA5		EQU	$20
PTA4		EQU	$10
PTA3		EQU	$08
PTA2		EQU	$04
PTA1		EQU	$02
PTA0		EQU	$01
PA7		EQU	$80
PA6		EQU	$40
PA5		EQU	$20
PA4		EQU	$10
PA3		EQU	$08
PA2		EQU	$04
PA1		EQU	$02
PA0		EQU	$01

PORTB		EQU	$0001
PTB7		EQU	$80
PTB6		EQU	$40
PTB5		EQU	$20
PTB4		EQU	$10
PTB3		EQU	$08
PTB2		EQU	$04
PTB1		EQU	$02
PTB0		EQU	$01
PB7		EQU	$80
PB6		EQU	$40
PB5		EQU	$20
PB4		EQU	$10
PB3		EQU	$08
PB2		EQU	$04
PB1		EQU	$02
PB0		EQU	$01

DDRA		EQU	$0002
DDRA7		EQU	$80
DDRA6		EQU	$40
DDRA5		EQU	$20
DDRA4		EQU	$10
DDRA3		EQU	$08
DDRA2		EQU	$04
DDRA1		EQU	$02
DDRA0		EQU	$01

DDRB		EQU	$0003
DDRB7		EQU	$80
DDRB6		EQU	$40
DDRB5		EQU	$20
DDRB4		EQU	$10
DDRB3		EQU	$08
DDRB2		EQU	$04
DDRB1		EQU	$02
DDRB0		EQU	$01

;$0004 to $0007 reserved

PORTE		EQU	$0008
PTE7		EQU	$80
PTE6		EQU	$40
PTE5		EQU	$20
PTE4		EQU	$10
PTE3		EQU	$08
PTE2		EQU	$04
PTE1		EQU	$02
PTE0		EQU	$01
PE7		EQU	$80
PE6		EQU	$40
PE5		EQU	$20
PE4		EQU	$10
PE3		EQU	$08
PE2		EQU	$04
PE1		EQU	$02
PE0		EQU	$01

DDRE		EQU	$0009
DDRE7		EQU	$80
DDRE6		EQU	$40
DDRE5		EQU	$20
DDRE4		EQU	$10
DDRE3		EQU	$08
DDRE2		EQU	$04

PEAR		EQU	$000A
NOACCE		EQU	$80
PIPOE		EQU	$20
NECLK		EQU	$10
LSTRE		EQU	$08
RDWE		EQU	$04

MODE		EQU	$000B
MODC		EQU	$80
MODB		EQU	$40
MODA		EQU	$20
IVIS		EQU	$08
EMK		EQU	$02
EME		EQU	$01

PUCR		EQU	$000C
PUPKE		EQU	$80
PUPEE		EQU	$10
PUPBE		EQU	$02
PUPAE		EQU	$01

RDRIV		EQU	$000D
RDPK		EQU	$80
RDPE		EQU	$10
RDPB		EQU	$02
RDPA		EQU	$01

EBICTL		EQU	$000E
ESTR		EQU	$01

;$000F reserved

INITRM		EQU	$0010
RAM15		EQU	$80
RAM14		EQU	$40
RAM13		EQU	$20
RAM12		EQU	$10
RAM11		EQU	$08
RAMHAL		EQU	$01

INITRG		EQU	$0011
REG14		EQU	$40
REG13		EQU	$20
REG12		EQU	$10
REG11		EQU	$08

INITEE		EQU	$0012
EE15		EQU	$80
EE14		EQU	$40
EE13		EQU	$20
EE12		EQU	$10
EEON		EQU	$01

MISC		EQU	$0013
EXSTR1		EQU	$08
EXSTR0		EQU	$04
ROMHM		EQU	$02
ROMON		EQU	$01

MTST0		EQU	$0014

ITCR		EQU	$0015
WRINT		EQU	$10
ADR3		EQU	$08
ADR2		EQU	$04
ADR1		EQU	$02
ADR0		EQU	$01

ITEST		EQU	$0016
INTE		EQU	$80
INTC		EQU	$40
INTA		EQU	$20
INT8		EQU	$10
INT6		EQU	$08
INT4		EQU	$04
INT2		EQU	$02
INT0		EQU	$01

MTST1		EQU	$0017

;$0018 reserved

VREGCTRL	EQU	$0019
LDVS		EQU	$04
LVIE		EQU	$02
LVIF		EQU	$01

PARTIDH		EQU	$001A
ID15		EQU	$80
ID14		EQU	$40
ID13		EQU	$20
ID12		EQU	$10
ID11		EQU	$08
ID10		EQU	$04
ID9		EQU	$02
ID8		EQU	$01

PARTIDL		EQU	$001B
ID7		EQU	$80
ID6		EQU	$40
ID5		EQU	$20
ID4		EQU	$10
ID3		EQU	$08
ID2		EQU	$04
ID1		EQU	$02
ID0		EQU	$01

MEMSIZ0		EQU	$001C
REG_SW0		EQU	$80
EEP_SW1		EQU	$20
EEP_SW0		EQU	$10
RAM_SW2		EQU	$04
RAM_SW1		EQU	$02
RAM_SW0		EQU	$01

MEMSIZ1		EQU	$001D
ROM_SW1		EQU	$80
ROM_SW0		EQU	$40
PAG_SW1		EQU	$02
PAG_SW0		EQU	$01

INTCR		EQU	$001E
IRQE		EQU	$80
IRQEN		EQU	$40

HPRIO		EQU	$001F
PSEL7		EQU	$80
PSEL6		EQU	$40
PSEL5		EQU	$20
PSEL4		EQU	$10
PSEL3		EQU	$08
PSEL2		EQU	$04
PSEL1		EQU	$02

DBGC1		EQU	$0020
DBGEN		EQU	$80
ARM		EQU	$40
TRGSEL		EQU	$20
BEGIN		EQU	$10
DBGBRK		EQU	$08
CAPMOD1		EQU	$02
CAPMOD0		EQU	$01

DBGSC		EQU	$0021
AF		EQU	$80
BF		EQU	$40
CF		EQU	$20
TRG3		EQU	$08
TRG2		EQU	$04
TRG1		EQU	$02
TRG0		EQU	$01

DBGTBH		EQU	$0022
DBGTBL		EQU	$0023

DBGCNT		EQU	$0024
TBF		EQU	$80
CNT5		EQU	$20
CNT4		EQU	$10
CNT3		EQU	$08
CNT2		EQU	$04
CNT1		EQU	$02
CNT0		EQU	$01

DBGCCX		EQU	$0025
PAGSEL1		EQU	$80
PAGSEL0		EQU	$40
EXTCMP5		EQU	$20
EXTCMP4		EQU	$10
EXTCMP3		EQU	$08
EXTCMP2		EQU	$04
EXTCMP1		EQU	$02
EXTCMP0		EQU	$01

DBGCCH		EQU	$0026
DBGCCL		EQU	$0027

DBGC2		EQU	$0028
BKPCT0		EQU	$0028
BKABEN		EQU	$80
FULL		EQU	$40
BDM		EQU	$20
TAGAB		EQU	$10
BKCEN		EQU	$08
TAGC		EQU	$04
RWCEN		EQU	$02
RWC		EQU	$01

DBGC3		EQU	$0029
BKPCT1		EQU	$0029
BKAMBH		EQU	$80
BKAMBL		EQU	$40
BKBMBH		EQU	$20
BKBMBL		EQU	$10
RWAEN		EQU	$08
RWA		EQU	$04
RWBEN		EQU	$02
RWB		EQU	$01

DBGCAX		EQU	$002A
BKP0X		EQU	$002A

DBGCAH		EQU	$002B
DBGCAL		EQU	$002C
BKP0H		EQU	$002B
BKP0L		EQU	$002C

DBGCBX		EQU	$002D

DBGCBH		EQU	$002E
DBGCBL		EQU	$002F
BKP1H		EQU	$002E
BKP1L		EQU	$002F

PPAGE		EQU	$0030
PIX5		EQU	$20
PIX4		EQU	$10
PIX3		EQU	$08
PIX2		EQU	$04
PIX1		EQU	$02
PIX0		EQU	$01

;$0031 reserved

PORTK		EQU	$0032
PTK7		EQU	$80
PTK6		EQU	$40
PTK5		EQU	$20
PTK4		EQU	$10
PTK3		EQU	$08
PTK2		EQU	$04
PTK1		EQU	$02
PTK0		EQU	$01
PK7		EQU	$80
PK6		EQU	$40
PK5		EQU	$20
PK4		EQU	$10
PK3		EQU	$08
PK2		EQU	$04
PK1		EQU	$02
PK0		EQU	$01

DDRK		EQU	$0033
DDRK7		EQU	$80
DDRK6		EQU	$40
DDRK5		EQU	$20
DDRK4		EQU	$10
DDRK3		EQU	$08
DDRK2		EQU	$04
DDRK1		EQU	$02
DDRK0		EQU	$01

SYNR		EQU	$0034
SYN5		EQU	$20
SYN4		EQU	$10
SYN3		EQU	$08
SYN2		EQU	$04
SYN1		EQU	$02
SYN0		EQU	$01

REFDV		EQU	$0035
REFDV3		EQU	$08
REFDV2		EQU	$04
REFDV1		EQU	$02
REFDV0		EQU	$01

CTFLG		EQU	$0036
TOUT7		EQU	$80
TOUT6		EQU	$40
TOUT5		EQU	$20
TOUT4		EQU	$10
TOUT3		EQU	$08
TOUT2		EQU	$04
TOUT1		EQU	$02
TOUT0		EQU	$01

CRGFLG		EQU	$0037
RTIF		EQU	$80
PORF		EQU	$40
LVRF		EQU	$20
LOCKIF		EQU	$10
LOCK		EQU	$08
TRACK		EQU	$04
SCMIF		EQU	$02
SCM		EQU	$01

CRGINT		EQU	$0038
RTIE		EQU	$80
LOCKIE		EQU	$10
SCMIE		EQU	$02

CLKSEL		EQU	$0039
PLLSEL		EQU	$80
PSTP		EQU	$40
SYSWAI		EQU	$20
ROAWAI		EQU	$10
PLLWAI		EQU	$08
CWAI		EQU	$04
RTIWAI		EQU	$02
COPWAI		EQU	$01

PLLCTL		EQU	$003A
CME		EQU	$80
PLLON		EQU	$40
AUTO		EQU	$20
ACQ		EQU	$10
PRE		EQU	$04
PCE		EQU	$02
SCME		EQU	$01

RTICTL		EQU	$003B
RTR6		EQU	$40
RTR5		EQU	$20
RTR4		EQU	$10
RTR3		EQU	$08
RTR2		EQU	$04
RTR1		EQU	$02
RTR0		EQU	$01

COPCTL		EQU	$003C
WCOP		EQU	$80
RSBCK		EQU	$40
CR2		EQU	$04
CR1		EQU	$02
CR0		EQU	$01

FORBYP		EQU	$003D
RTIBYP		EQU	$80
COPBYP		EQU	$40
PLLBYP		EQU	$10
FCM		EQU	$02

CTCTL		EQU	$003E

ARMCOP		EQU	$003F

TIOS		EQU	$0040
IOS7		EQU	$80
IOS6		EQU	$40
IOS5		EQU	$20
IOS4		EQU	$10
IOS3		EQU	$08
IOS2		EQU	$04
IOS1		EQU	$02
IOS0		EQU	$01

TCFORC		EQU	$0041
FOC7		EQU	$80
FOC6		EQU	$40
FOC5		EQU	$20
FOC4		EQU	$10
FOC3		EQU	$08
FOC2		EQU	$04
FOC1		EQU	$02
FOC0		EQU	$01

TOC7M		EQU	$0042
OC7M7		EQU	$80
OC7M6		EQU	$40
OC7M5		EQU	$20
OC7M4		EQU	$10
OC7M3		EQU	$08
OC7M2		EQU	$04
OC7M1		EQU	$02
OC7M0		EQU	$01

TOC7D		EQU	$0043
OC7D7		EQU	$80
OC7D6		EQU	$40
OC7D5		EQU	$20
OC7D4		EQU	$10
OC7D3		EQU	$08
OC7D2		EQU	$04
OC7D1		EQU	$02
OC7D0		EQU	$01

TCNT		EQU	$0044

TSCR1		EQU	$0046
TEN		EQU	$80
TSWAI		EQU	$40
TSFRZ		EQU	$20
TFFCA		EQU	$10

TTOV		EQU	$0047
TOV7		EQU	$80
TOV6		EQU	$40
TOV5		EQU	$20
TOV4		EQU	$10
TOV3		EQU	$08
TOV2		EQU	$04
TOV1		EQU	$02
TOV0		EQU	$01

TCTL1		EQU	$0048
OM7		EQU	$80
OL7		EQU	$40
OM6		EQU	$20
OL6		EQU	$10
OM5		EQU	$08
OL5		EQU	$04
OM4		EQU	$02
OL4		EQU	$01

TCTL2		EQU	$0049
OM3		EQU	$80
OL3		EQU	$40
OM2		EQU	$20
OL2		EQU	$10
OM1		EQU	$08
OL1		EQU	$04
OM0		EQU	$02
OL0		EQU	$01

TCTL3		EQU	$004A
EDG7B		EQU	$80
EDG7A		EQU	$40
EDG6B		EQU	$20
EDG6A		EQU	$10
EDG5B		EQU	$08
EDG5A		EQU	$04
EDG4B		EQU	$02
EDG4A		EQU	$01

TCTL4		EQU	$004B
EDG3B		EQU	$80
EDG3A		EQU	$40
EDG2B		EQU	$20
EDG2A		EQU	$10
EDG1B		EQU	$08
EDG1A		EQU	$04
EDG0B		EQU	$02
EDG0A		EQU	$01

TIE		EQU	$004C
C7I		EQU	$80
C6I		EQU	$40
C5I		EQU	$20
C4I		EQU	$10
C3I		EQU	$08
C2I		EQU	$04
C1I		EQU	$02
C0I		EQU	$01

TSCR2		EQU	$004D
TOI		EQU	$80
TCRE		EQU	$08
PR2		EQU	$04
PR1		EQU	$02
PR0		EQU	$01

TFLG1		EQU	$004E
C7F		EQU	$80
C6F		EQU	$40
C5F		EQU	$20
C4F		EQU	$10
C3F		EQU	$08
C2F		EQU	$04
C1F		EQU	$02
C0F		EQU	$01

TFLG2		EQU	$004F
TOF		EQU	$80

TC0		EQU	$0050
TC1		EQU	$0052
TC2		EQU	$0054
TC3		EQU	$0056
TC4		EQU	$0058
TC5		EQU	$005A
TC6		EQU	$005C
TC7		EQU	$005E

PACTL		EQU	$0060
PAEN		EQU	$40
PAMOD		EQU	$20
PEDGE		EQU	$10
CLK1		EQU	$08
CLK0		EQU	$04
PAOVI		EQU	$02
PAI		EQU	$01

PAFLG		EQU	$0061
PAOVF		EQU	$02
PAIF		EQU	$01

PACNT		EQU	$0062

;$0064 to $007F reserved

ATDCTL0		EQU	$0080
ATDCTL1		EQU	$0081

ATDCTL2		EQU	$0082
ADPU		EQU	$80
AFFC		EQU	$40
AWAI		EQU	$20
ETRIGLE		EQU	$10
ETRIGP		EQU	$08
ETRIG		EQU	$04
ASCIE		EQU	$02
ASCIF		EQU	$01

ATDCTL3		EQU	$0083
S8C		EQU	$40
S4C		EQU	$20
S2C		EQU	$10
S1C		EQU	$08
FIFO		EQU	$04
FRZ1		EQU	$02
FRZ0		EQU	$01

ATDCTL4		EQU	$0084
SRES8		EQU	$80
SMP1		EQU	$40
SMP0		EQU	$20
PRS4		EQU	$10
PRS3		EQU	$08
PRS2		EQU	$04
PRS1		EQU	$02
PRS0		EQU	$01

ATDCTL5		EQU	$0085
DJM		EQU	$80
DSGN		EQU	$40
SCAN		EQU	$20
MULT		EQU	$10
CC		EQU	$04
CB		EQU	$02
CA		EQU	$01

ATDSTAT0	EQU	$0086
SCF		EQU	$80
ETORF		EQU	$20
FIFOR		EQU	$10
CC2		EQU	$04
CC1		EQU	$02
CC0		EQU	$01

;$0087 reserved

ATDTEST0	EQU	$0088
SAR9		EQU	$80
SAR8		EQU	$40
SAR7		EQU	$20
SAR6		EQU	$10
SAR5		EQU	$08
SAR4		EQU	$04
SAR3		EQU	$02
SAR2		EQU	$01

ATDTEST1	EQU	$0089
SAR1		EQU	$80
SAR0		EQU	$40
RST		EQU	$04
SC		EQU	$01

;$008a reserved

ATDSTAT1	EQU	$008B
CCF7		EQU	$80
CCF6		EQU	$40
CCF5		EQU	$20
CCF4		EQU	$10
CCF3		EQU	$08
CCF2		EQU	$04
CCF1		EQU	$02
CCF0		EQU	$01

;$008C reserved

ATDDIEN		EQU	$008D

;$008E reserved

PORTAD		EQU	$008F
PTAD07		EQU	$80
PTAD06		EQU	$40
PTAD05		EQU	$20
PTAD04		EQU	$10
PTAD03		EQU	$08
PTAD02		EQU	$04
PTAD01		EQU	$02
PTAD00		EQU	$01

ATDDR0H		EQU	$0090
ATDDR0L		EQU	$0091
ATDDR1H		EQU	$0092
ATDDR1L		EQU	$0093
ATDDR2H		EQU	$0094
ATDDR2L		EQU	$0095
ATDDR3H		EQU	$0096
ATDDR3L		EQU	$0097
ATDDR4H		EQU	$0098
ATDDR4L		EQU	$0099
ATDDR5H		EQU	$009A
ATDDR5L		EQU	$009B
ATDDR6H		EQU	$009C
ATDDR6L		EQU	$009D
ATDDR7H		EQU	$009E
ATDDR7L		EQU	$009F

;$00A0 to $00C7 reserved

SCIBDH		EQU	$00C8
SBR12		EQU	$10
SBR11		EQU	$08
SBR10		EQU	$04
SBR9		EQU	$02
SBR8		EQU	$01

SCIBDL		EQU	$00C9
SBR7		EQU	$80
SBR6		EQU	$40
SBR5		EQU	$20
SBR4		EQU	$10
SBR3		EQU	$08
SBR2		EQU	$04
SBR1		EQU	$02
SBR0		EQU	$01
  
SCICR1		EQU	$00CA
LOOPS		EQU	$80
SCISWAI		EQU	$40
RSRC		EQU	$20
M		EQU	$10
WAKE		EQU	$08
ILT		EQU	$04
PE		EQU	$02
PT		EQU	$01

SCICR2		EQU	$00CB
TXIE		EQU	$80  ;renamed to txie, not to clash with tie register
TCIE		EQU	$40
RIE		EQU	$20
ILIE		EQU	$10
TE		EQU	$08
RE		EQU	$04
RWU		EQU	$02
SBK		EQU	$01

SCISR1		EQU	$00CC
TDRE		EQU	$80
TC		EQU	$40
RDRF		EQU	$20
IDLE		EQU	$10
OR		EQU	$08
NF		EQU	$04
FE		EQU	$02
PF		EQU	$01

SCISR2		EQU	$00CD
BRK13		EQU	$04
TXDIR		EQU	$02
RAF		EQU	$01

SCIDRH		EQU	$00CE
R8		EQU	$80
T8		EQU	$40

SCIDRL		EQU	$00CF

;$00D0 to $00D7 reserved

SPICR1		EQU	$00D8
SPIE		EQU	$80
SPE		EQU	$40
SPTIE		EQU	$20
MSTR		EQU	$10
CPOL		EQU	$08
CPHA		EQU	$04
SSOE		EQU	$02
LSBFE		EQU	$01

SPICR2		EQU	$00D9
MODFEN		EQU	$10
BIDIROE		EQU	$08
SPISWAI		EQU	$02
SPC0		EQU	$01

SPIBR		EQU	$00DA
SPPR2		EQU	$40
SPPR1		EQU	$20
SPPR0		EQU	$10
SPR2		EQU	$04
SPR1		EQU	$02
SPR0		EQU	$01

SPISR		EQU	$00DB
SPIF		EQU	$80
SPTEF		EQU	$20
MODF		EQU	$10

;$00DC reserved

SPIDR		EQU	$00DD

;$00DE and $00DF reserved

PWME		EQU	$00E0
PWME7		EQU	$80
PWME6		EQU	$40
PWME5		EQU	$20
PWME4		EQU	$10
PWME3		EQU	$08
PWME2		EQU	$04
PWME1		EQU	$02
PWME0		EQU	$01

PWMPOL		EQU	$00E1
PPOL7		EQU	$80
PPOL6		EQU	$40
PPOL5		EQU	$20
PPOL4		EQU	$10
PPOL3		EQU	$08
PPOL2		EQU	$04
PPOL1		EQU	$02
PPOL0		EQU	$01

PWMCLK		EQU	$00E2
PCLK7		EQU	$80
PCLK6		EQU	$40
PCLK5		EQU	$20
PCLK4		EQU	$10
PCLK3		EQU	$08
PCLK2		EQU	$04
PCLK1		EQU	$02
PCLK0		EQU	$01

PWMPRCLK	EQU	$00E3
PCKB2		EQU	$40
PCKB1		EQU	$20
PCKB0		EQU	$10
PCKA2		EQU	$04
PCKA1		EQU	$02
PCKA0		EQU	$01

PWMCAE		EQU	$00E4
CAE7		EQU	$80
CAE6		EQU	$40
CAE5		EQU	$20
CAE4		EQU	$10
CAE3		EQU	$08
CAE2		EQU	$04
CAE1		EQU	$02
CAE0		EQU	$01
  
PWMCTL		EQU	$00E5
CON67		EQU	$80
CON45		EQU	$40
CON23		EQU	$20
CON01		EQU	$10
PSWAI		EQU	$08
PFRZ		EQU	$04

PWMTST		EQU	$00E6
PWMPRSC		EQU	$00E7

PWMSCLA		EQU	$00E8
PWMSCLB		EQU	$00E9

PWMSCNTA	EQU	$00EA
PWMSCNTB	EQU	$00EB

PWMCNT0		EQU	$00EC
PWMCNT1		EQU	$00ED
PWMCNT2		EQU	$00EE
PWMCNT3		EQU	$00EF
PWMCNT4		EQU	$00F0
PWMCNT5		EQU	$00F1

PWMPER0		EQU	$00F2
PWMPER1		EQU	$00F3
PWMPER2		EQU	$00F4
PWMPER3		EQU	$00F5
PWMPER4		EQU	$00F6
PWMPER5		EQU	$00F7

PWMDTY0		EQU	$00F8
PWMDTY1		EQU	$00F9
PWMDTY2		EQU	$00FA
PWMDTY3		EQU	$00FB
PWMDTY4		EQU	$00FC
PWMDTY5		EQU	$00FD

;$00FE to $00FF reserved

FCLKDIV		EQU	$0100
FDIVLD		EQU	$80
FDIV8		EQU	$40
FDIV5		EQU	$20
FDIV4		EQU	$10
FDIV3		EQU	$08
FDIV2		EQU	$04
FDIV1		EQU	$02
FDIV0		EQU	$01

FSEC		EQU	$0101
KEYEN		EQU	$80
NV6		EQU	$40
NV5		EQU	$20
NV4		EQU	$10
NV3		EQU	$08
NV2		EQU	$04
SEC01		EQU	$02
SEC00		EQU	$01

FTSTMOD		EQU	$0102
BIST		EQU	$80
HOLD		EQU	$40
INVOKE		EQU	$20
WRALL		EQU	$10
DIRECT		EQU	$01

FCNFG		EQU	$0103
CBEIE		EQU	$80
CCIE		EQU	$40
KEYACC		EQU	$20
BKSEL1		EQU	$02
BKSEL0		EQU	$01

FPROT		EQU	$0104
FPOPEN		EQU	$80
FPHDIS		EQU	$20
FPHS1		EQU	$10
FPHS0		EQU	$08
FPLDIS		EQU	$04
FPLS1		EQU	$02
FPLS0		EQU	$01

FSTAT		EQU	$0105
CBEIF		EQU	$80
CCIF		EQU	$40
PVIOL		EQU	$20
ACCERR		EQU	$10
BLANK		EQU	$04

FCMD		EQU	$0106
ERASE		EQU	$40
PROG		EQU	$20
ERVR		EQU	$04
MASS		EQU	$01

FCTL		EQU	$0107
TTMR		EQU	$80
IFREN		EQU	$20
NVSTR		EQU	$10
XE		EQU	$08
YE		EQU	$04
SE		EQU	$02
OE		EQU	$01

FADDRHI		EQU	$0108
FADDRLO		EQU	$0109
FDATAHI		EQU	$010A
FDATALO		EQU	$010B

;$010C to $013F reserved

CANCTL0		EQU	$0140
RXFRM		EQU	$80
RXACT		EQU	$40
CSWAI		EQU	$20
SYNCH		EQU	$10
TIMEN		EQU	$08 ;RENAMED 
WUPE		EQU	$04
SLPRQ		EQU	$02
INITRQ		EQU	$01

CANCTL1		EQU	$0141
CANE		EQU	$80
CLKSRC		EQU	$40
LOOPB		EQU	$20
LISTEN		EQU	$10
WUPM		EQU	$04
SLPAK		EQU	$02
INITAK		EQU	$01

CANBTR0		EQU	$0142
SJW1		EQU	$80
SJW0		EQU	$40
BRP5		EQU	$20
BRP4		EQU	$10
BRP3		EQU	$08
BRP2		EQU	$04
BRP1		EQU	$02
BRP0		EQU	$01

CANBTR1		EQU	$0143
SAMP		EQU	$80
TSEG22		EQU	$40
TSEG21		EQU	$20
TSEG20		EQU	$10
TSEG13		EQU	$08
TSEG12		EQU	$04
TSEG11		EQU	$02
TESG10		EQU	$01

CANRFLG		EQU	$0144
WUPIF		EQU	$80
CSCIF		EQU	$40
RSTAT1		EQU	$20
RSTAT0		EQU	$10
TSTAT1		EQU	$08
TSTAT0		EQU	$04
OVRIF		EQU	$02
RXF		EQU	$01

CANRIER		EQU	$0145
WUPIE		EQU	$80
CSCIE		EQU	$40
RSTATE1		EQU	$20
RSTATE0		EQU	$10
TSTATE1		EQU	$08
TSTATE0		EQU	$04
OVRIE		EQU	$02
RXFIE		EQU	$01

CANTFLG		EQU	$0146
TXE2		EQU	$04
TXE1		EQU	$02
TXE0		EQU	$01

CANTIER		EQU	$0147
TXEIE2		EQU	$04
TXEIE1		EQU	$02
TXEIE0		EQU	$01

CANTARQ		EQU	$0148
ABTRQ2		EQU	$04
ABTRQ1		EQU	$02
ABTRQ0		EQU	$01

CANTAAK		EQU	$0149
ABTAK2		EQU	$04
ABTAK1		EQU	$02
ABTAK0		EQU	$01

CANTBSEL	EQU	$014A
TX2		EQU	$04
TX1		EQU	$02
TX0		EQU	$01

CANIDAC		EQU	$014B
IDAM1		EQU	$20
IDAM0		EQU	$10
IDHIT2		EQU	$04
IDHIT1		EQU	$02
IDHIT0		EQU	$01

; $14c and $14d reserved

CANRXERR	EQU	$014E
CANTXERR	EQU	$014F

CANIDAR0	EQU	$0150
CANIDAR1	EQU	$0151
CANIDAR2	EQU	$0152
CANIDAR3	EQU	$0153
CANIDMR0	EQU	$0154
CANIDMR1	EQU	$0155
CANIDMR2	EQU	$0156
CANIDMR3	EQU	$0157

CANIDAR4	EQU	$0158
CANIDAR5	EQU	$0159
CANIDAR6	EQU	$015A
CANIDAR7	EQU	$015B
CANIDMR4	EQU	$015C
CANIDMR5	EQU	$015D
CANIDMR6	EQU	$015E
CANIDMR7	EQU	$015F

CANRXIDR0	EQU	$0160
CANRXIDR1	EQU	$0161
CANRXIDR2	EQU	$0162
CANRXIDR3	EQU	$0163
CANRXDSR0	EQU	$0164
CANRXDSR1	EQU	$0165
CANRXDSR2	EQU	$0166
CANRXDSR3	EQU	$0167
CANRXDSR4	EQU	$0168
CANRXDSR5	EQU	$0169
CANRXDSR6	EQU	$016A
CANRXDSR7	EQU	$016B
CANRXDLR	EQU	$016C

;$016D reserved

CANRTSRH	EQU	$016E
CANRTSRL	EQU	$016F
CANTXIDR0	EQU	$0170
CANTXIDR1	EQU	$0171
CANTXIDR2	EQU	$0172
CANTXIDR3	EQU	$0173
CANTXDSR0	EQU	$0174
CANTXDSR1	EQU	$0175
CANTXDSR2	EQU	$0176
CANTXDSR3	EQU	$0177
CANTXDSR4	EQU	$0178
CANTXDSR5	EQU	$0179
CANTXDSR6	EQU	$017A
CANTXDSR7	EQU	$017B
CANTXDLR	EQU	$017C
CANTXTBPR	EQU	$017D
CANTXTSRH	EQU	$017E
CANTXTSRL	EQU	$017F

;$0180 to $013F reserved

PTT		EQU	$0240
PTT7		EQU	$80
PTT6		EQU	$40
PTT5		EQU	$20
PTT4		EQU	$10
PTT3		EQU	$08
PTT2		EQU	$04
PTT1		EQU	$02
PTT0		EQU	$01
PT7		EQU	$80
PT6		EQU	$40
PT5		EQU	$20
PT4		EQU	$10
PT3		EQU	$08
PT2		EQU	$04
PT1		EQU	$02
PT0		EQU	$01

PTIT		EQU	$0241
PTIT7		EQU	$80
PTIT6		EQU	$40
PTIT5		EQU	$20
PTIT4		EQU	$10
PTIT3		EQU	$08
PTIT2		EQU	$04
PTIT1		EQU	$02
PTIT0		EQU	$01

DDRT		EQU	$0242
DDRT7		EQU	$80
DDRT6		EQU	$40
DDRT5		EQU	$20
DDRT4		EQU	$10
DDRT3		EQU	$08
DDRT2		EQU	$04
DDRT1		EQU	$02
DDRT0		EQU	$01

RDRT		EQU	$0243
RDRT7		EQU	$80
RDRT6		EQU	$40
RDRT5		EQU	$20
RDRT4		EQU	$10
RDRT3		EQU	$08
RDRT2		EQU	$04
RDRT1		EQU	$02
RDRT0		EQU	$01

PERT		EQU	$0244
PERT7		EQU	$80
PERT6		EQU	$40
PERT5		EQU	$20
PERT4		EQU	$10
PERT3		EQU	$08
PERT2		EQU	$04
PERT1		EQU	$02
PERT0		EQU	$01

PPST		EQU	$0245
PPST7		EQU	$80
PPST6		EQU	$40
PPST5		EQU	$20
PPST4		EQU	$10
PPST3		EQU	$08
PPST2		EQU	$04
PPST1		EQU	$02
PPST0		EQU	$01

;$0246 reserved

MODRR		EQU	$0247
MODRR4		EQU	$10
MODRR3		EQU	$08
MODRR2		EQU	$04
MODRR1		EQU	$02
MODRR0		EQU	$01

PTS		EQU	$0248
PTS7		EQU	$80
PTS6		EQU	$40
PTS5		EQU	$20
PTS4		EQU	$10
PTS3		EQU	$08
PTS2		EQU	$04
PTS1		EQU	$02
PTS0		EQU	$01
PS7		EQU	$80
PS6		EQU	$40
PS5		EQU	$20
PS4		EQU	$10
PS3		EQU	$08
PS2		EQU	$04
PS1		EQU	$02
PS0		EQU	$01

PTIS		EQU	$0249
PTIS7		EQU	$80
PTIS6		EQU	$40
PTIS5		EQU	$20
PTIS4		EQU	$10
PTIS3		EQU	$08
PTIS2		EQU	$04
PTIS1		EQU	$02
PTIS0		EQU	$01

DDRS		EQU	$024A
DDRS7		EQU	$80
DDRS6		EQU	$40
DDRS5		EQU	$20
DDRS4		EQU	$10
DDRS3		EQU	$08
DDRS2		EQU	$04
DDRS1		EQU	$02
DDRS0		EQU	$01

RDRS		EQU	$024B
RDRS7		EQU	$80
RDRS6		EQU	$40
RDRS5		EQU	$20
RDRS4		EQU	$10
RDRS3		EQU	$08
RDRS2		EQU	$04
RDRS1		EQU	$02
RDRS0		EQU	$01

PERS		EQU	$024C
PERS7		EQU	$80
PERS6		EQU	$40
PERS5		EQU	$20
PERS4		EQU	$10
PERS3		EQU	$08
PERS2		EQU	$04
PERS1		EQU	$02
PERS0		EQU	$01

PPSS		EQU	$024D
PPSS7		EQU	$80
PPSS6		EQU	$40
PPSS5		EQU	$20
PPSS4		EQU	$10
PPSS3		EQU	$08
PPSS2		EQU	$04
PPSS1		EQU	$02
PPSS0		EQU	$01

WOMS		EQU	$024E
WOMS7		EQU	$80
WOMS6		EQU	$40
WOMS5		EQU	$20
WOMS4		EQU	$10
WOMS3		EQU	$08
WOMS2		EQU	$04
WOMS1		EQU	$02
WOMS0		EQU	$01

;$024F reserved

PTM		EQU	$0250
PTM7		EQU	$80
PTM6		EQU	$40
PTM5		EQU	$20
PTM4		EQU	$10
PTM3		EQU	$08
PTM2		EQU	$04
PTM1		EQU	$02
PTM0		EQU	$01
PM7		EQU	$80
PM6		EQU	$40
PM5		EQU	$20
PM4		EQU	$10
PM3		EQU	$08
PM2		EQU	$04
PM1		EQU	$02
PM0		EQU	$01

PTIM		EQU	$0251
PTIM7		EQU	$80
PTIM6		EQU	$40
PTIM5		EQU	$20
PTIM4		EQU	$10
PTIM3		EQU	$08
PTIM2		EQU	$04
PTIM1		EQU	$02
PTIM0		EQU	$01

DDRM		EQU	$0252
DDRM7		EQU	$80
DDRM6		EQU	$40
DDRM5		EQU	$20
DDRM4		EQU	$10
DDRM3		EQU	$08
DDRM2		EQU	$04
DDRM1		EQU	$02
DDRM0		EQU	$01

RDRM		EQU	$0253
RDRM7		EQU	$80
RDRM6		EQU	$40
RDRM5		EQU	$20
RDRM4		EQU	$10
RDRM3		EQU	$08
RDRM2		EQU	$04
RDRM1		EQU	$02
RDRM0		EQU	$01

PERM		EQU	$0254
PERM7		EQU	$80
PERM6		EQU	$40
PERM5		EQU	$20
PERM4		EQU	$10
PERM3		EQU	$08
PERM2		EQU	$04
PERM1		EQU	$02
PERM0		EQU	$01

PPSM		EQU	$0255
PPSM7		EQU	$80
PPSM6		EQU	$40
PPSM5		EQU	$20
PPSM4		EQU	$10
PPSM3		EQU	$08
PPSM2		EQU	$04
PPSM1		EQU	$02
PPSM0		EQU	$01

WOMM		EQU	$0256
WOMM7		EQU	$80
WOMM6		EQU	$40
WOMM5		EQU	$20
WOMM4		EQU	$10
WOMM3		EQU	$08
WOMM2		EQU	$04
WOMM1		EQU	$02
WOMM0		EQU	$01

;$0257 reserved

PTP		EQU	$0258
PTP7		EQU	$80
PTP6		EQU	$40
PTP5		EQU	$20
PTP4		EQU	$10
PTP3		EQU	$08
PTP2		EQU	$04
PTP1		EQU	$02
PTP0		EQU	$01
PP7		EQU	$80
PP6		EQU	$40
PP5		EQU	$20
PP4		EQU	$10
PP3		EQU	$08
PP2		EQU	$04
PP1		EQU	$02
PP0		EQU	$01

PTIP		EQU	$0259
PTIP7		EQU	$80
PTIP6		EQU	$40
PTIP5		EQU	$20
PTIP4		EQU	$10
PTIP3		EQU	$08
PTIP2		EQU	$04
PTIP1		EQU	$02
PTIP0		EQU	$01

DDRP		EQU	$025A
DDRP7		EQU	$80
DDRP6		EQU	$40
DDRP5		EQU	$20
DDRP4		EQU	$10
DDRP3		EQU	$08
DDRP2		EQU	$04
DDRP1		EQU	$02
DDRP0		EQU	$01

RDRP		EQU	$025B
RDRP7		EQU	$80
RDRP6		EQU	$40
RDRP5		EQU	$20
RDRP4		EQU	$10
RDRP3		EQU	$08
RDRP2		EQU	$04
RDRP1		EQU	$02
RDRP0		EQU	$01

PERP		EQU	$025C
PERP7		EQU	$80
PERP6		EQU	$40
PERP5		EQU	$20
PERP4		EQU	$10
PERP3		EQU	$08
PERP2		EQU	$04
PERP1		EQU	$02
PERP0		EQU	$01

PPSP		EQU	$025D
PPSP7		EQU	$80
PPSP6		EQU	$40
PPSP5		EQU	$20
PPSP4		EQU	$10
PPSP3		EQU	$08
PPSP2		EQU	$04
PPSP1		EQU	$02
PPSP0		EQU	$01

PIEP		EQU	$025E
PIEP7		EQU	$80
PIEP6		EQU	$40
PIEP5		EQU	$20
PIEP4		EQU	$10
PIEP3		EQU	$08
PIEP2		EQU	$04
PIEP1		EQU	$02
PIEP0		EQU	$01

PIFP		EQU	$025F
PIFP7		EQU	$80
PIFP6		EQU	$40
PIFP5		EQU	$20
PIFP4		EQU	$10
PIFP3		EQU	$08
PIFP2		EQU	$04
PIFP1		EQU	$02
PIFP0		EQU	$01

;$0260 to $0267 reserved

PTJ		EQU	$0268
PTJ7		EQU	$80
PTJ6		EQU	$40
PJ7		EQU	$80
PJ6		EQU	$40

PTIJ		EQU	$0269
PTIJ7		EQU	$80
PTIJ6		EQU	$40

DDRJ		EQU	$026A
DDRJ7		EQU	$80
DDRJ6		EQU	$40

RDRJ		EQU	$026B
RDRJ7		EQU	$80
RDRJ6		EQU	$40

PERJ		EQU	$026C
PERJ7		EQU	$80
PERJ6		EQU	$40

PPSJ		EQU	$026D
PPSJ7		EQU	$80
PPSJ6		EQU	$40

PIEJ		EQU	$026E
PIEJ7		EQU	$80
PIEJ6		EQU	$40

PIFJ		EQU	$026F
PIFJ7		EQU	$80
PIFJ6		EQU	$40

PTAD		EQU	$0270
PTAD7		EQU	$80
PTAD6		EQU	$40
PTAD5		EQU	$20
PTAD4		EQU	$10
PTAD3		EQU	$08
PTAD2		EQU	$04
PTAD1		EQU	$02
PTAD0		EQU	$01
PAD7		EQU	$80
PAD6		EQU	$40
PAD5		EQU	$20
PAD4		EQU	$10
PAD3		EQU	$08
PAD2		EQU	$04
PAD1		EQU	$02
PAD0		EQU	$01

PTIAD		EQU	$0271
PTIAD7		EQU	$80
PTIAD6		EQU	$40
PTIAD5		EQU	$20
PTIAD4		EQU	$10
PTIAD3		EQU	$08
PTIAD2		EQU	$04
PTIAD1		EQU	$02
PTIAD0		EQU	$01

DDRAD		EQU	$0272
DDRAD7		EQU	$80
DDRAD6		EQU	$40
DDRAD5		EQU	$20
DDRAD4		EQU	$10
DDRAD3		EQU	$08
DDRAD2		EQU	$04
DDRAD1		EQU	$02
DDRAD0		EQU	$01

RDRAD		EQU	$0273
RDRAD7		EQU	$80
RDRAD6		EQU	$40
RDRAD5		EQU	$20
RDRAD4		EQU	$10
RDRAD3		EQU	$08
RDRAD2		EQU	$04
RDRAD1		EQU	$02
RDRAD0		EQU	$01

PERAD		EQU	$0274
PERAD7		EQU	$80
PERAD6		EQU	$40
PERAD5		EQU	$20
PERAD4		EQU	$10
PERAD3		EQU	$08
PERAD2		EQU	$04
PERAD1		EQU	$02
PERAD0		EQU	$01

PPSAD		EQU	$0275
PPSAD7		EQU	$80
PPSAD6		EQU	$40
PPSAD5		EQU	$20
PPSAD4		EQU	$10
PPSAD3		EQU	$08
PPSAD2		EQU	$04
PPSAD1		EQU	$02
PPSAD0		EQU	$01

;$0276 to $027F reserved

CAN4CTL0	EQU	$280
CAN4CTL1	EQU	$281
CAN4BTR0	EQU	$282
CAN4BTR1	EQU	$283
CAN4RFLG	EQU	$284
CAN4RIER	EQU	$285
CAN4TFLG	EQU	$286
CAN4TIER	EQU	$287
CAN4TARQ	EQU	$288
CAN4TAAK	EQU	$289
CAN4TBSEL	EQU	$28A
CAN4IDAC	EQU	$28B

; can4 registers have the same bit definitions as can0, see above

; $28c and $28d reserved

CAN4RXERR	EQU	$28E
CAN4TXERR	EQU	$28F

CAN4IDAR0	EQU	$290
CAN4IDAR1	EQU	$291
CAN4IDAR2	EQU	$292
CAN4IDAR3	EQU	$293
CAN4IDMR0	EQU	$294
CAN4IDMR1	EQU	$295
CAN4IDMR2	EQU	$296
CAN4IDMR3	EQU	$297

CAN4IDAR4	EQU	$298
CAN4IDAR5	EQU	$299
CAN4IDAR6	EQU	$29A
CAN4IDAR7	EQU	$29B
CAN4IDMR4	EQU	$29C
CAN4IDMR5	EQU	$29D
CAN4IDMR6	EQU	$29E
CAN4IDMR7	EQU	$29F

CAN4RXIDR0	EQU	$2A0
CAN4RXIDR1	EQU	$2A1
CAN4RXIDR2	EQU	$2A2
CAN4RXIDR3	EQU	$2A3
CAN4RXDSR0	EQU	$2A4
CAN4RXDSR1	EQU	$2A5
CAN4RXDSR2	EQU	$2A6
CAN4RXDSR3	EQU	$2A7
CAN4RXDSR4	EQU	$2A8
CAN4RXDSR5	EQU	$2A9
CAN4RXDSR6	EQU	$2AA
CAN4RXDSR7	EQU	$2AB
CAN4RXDLR	EQU	$2AC

; $2ad to $2af reserved

CAN4TXIDR1	EQU	$2B1
CAN4TXIDR2	EQU	$2B2
CAN4TXIDR3	EQU	$2B3
CAN4TXDSR0	EQU	$2B4
CAN4TXDSR1	EQU	$2B5
CAN4TXDSR2	EQU	$2B6
CAN4TXDSR3	EQU	$2B7
CAN4TXDSR4	EQU	$2B8
CAN4TXDSR5	EQU	$2B9
CAN4TXDSR6	EQU	$2BA
CAN4TXDSR7	EQU	$2BB
CAN4TXDLR	EQU	$2BC
CAN4TXTBPR	EQU	$2BD
CAN4TXTSRH	EQU	$2BE
CAN4TXTSRL	EQU	$2BF

; $2c0 to $2ff reserved

; $300 to $3ff unimplememted
#endif
