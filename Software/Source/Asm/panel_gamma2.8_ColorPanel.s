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
;# Gamma correction factor:  2.80                                              #
;###############################################################################

;#Gamma correction look-up table:
;--------------------------------
#macro PANEL_GAMMA_LUT, 0
                DB $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00
                DB $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00
                DB $00 $00 $00 $00 $01 $01 $01 $01 $01 $01 $01 $01 $01 $01 $02 $02
                DB $02 $02 $02 $02 $02 $03 $03 $03 $03 $03 $04 $04 $04 $04 $04 $05
                DB $05 $05 $05 $06 $06 $06 $06 $07 $07 $07 $07 $08 $08 $08 $09 $09
                DB $09 $0A $0A $0B $0B $0B $0C $0C $0C $0D $0D $0E $0E $0F $0F $10
                DB $10 $11 $11 $12 $12 $13 $13 $14 $14 $15 $15 $16 $17 $17 $18 $18
                DB $19 $1A $1A $1B $1C $1C $1D $1E $1E $1F $20 $21 $21 $22 $23 $24
                DB $25 $25 $26 $27 $28 $29 $2A $2A $2B $2C $2D $2E $2F $30 $31 $32
                DB $33 $34 $35 $36 $37 $38 $39 $3A $3B $3D $3E $3F $40 $41 $42 $43
                DB $45 $46 $47 $48 $4A $4B $4C $4D $4F $50 $51 $53 $54 $56 $57 $58
                DB $5A $5B $5D $5E $60 $61 $63 $64 $66 $67 $69 $6B $6C $6E $6F $71
                DB $73 $74 $76 $78 $7A $7B $7D $7F $81 $82 $84 $86 $88 $8A $8C $8E
                DB $90 $92 $94 $96 $98 $9A $9C $9E $A0 $A2 $A4 $A6 $A8 $AA $AC $AF
                DB $B1 $B3 $B5 $B8 $BA $BC $BF $C1 $C3 $C6 $C8 $CA $CD $CF $D2 $D4
                DB $D7 $D9 $DC $DE $E1 $E3 $E6 $E9 $EB $EE $F1 $F3 $F6 $F9 $FC $FF
#emac
#endif
