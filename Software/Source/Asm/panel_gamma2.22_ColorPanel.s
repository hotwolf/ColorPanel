#ifndef PANEL_GAMMA_COMPILE
#define PANEL_GAMMA_COMPILE
;###############################################################################
;# ColorPanel - Gamma Correction Look-Up Table for the Panel Driver            #
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
;#    This perl script generates the assembler source for an 8-bit gamma       #
;#    correction look-up table.                                                #
;#                                                                             #
;###############################################################################
;# Generated on Thu, Dec 17 2015                                               #
;###############################################################################
;# Gamma correction factor:  2.22                                              #
;###############################################################################

;#Gamma correction look-up table:
;--------------------------------
#macro PANEL_GAMMA_LUT, 0
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
#emac
#endif
