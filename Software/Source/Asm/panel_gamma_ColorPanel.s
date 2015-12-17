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
;# Generated on Wed, Dec 16 2015                                               #
;###############################################################################
;# Gamma correction factor: 2.40                                               #
;###############################################################################

PANEL_GAMMA_LUT DB $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $00
                DB $00 $00 $00 $00 $00 $00 $00 $00 $00 $00 $01 $01 $01 $01 $01 $01
                DB $01 $01 $02 $02 $02 $02 $02 $02 $02 $03 $03 $03 $03 $03 $04 $04
                DB $04 $04 $05 $05 $05 $05 $06 $06 $06 $06 $07 $07 $07 $08 $08 $08
                DB $09 $09 $09 $0A $0A $0B $0B $0B $0C $0C $0D $0D $0D $0E $0E $0F
                DB $0F $10 $10 $11 $11 $12 $12 $13 $13 $14 $14 $15 $16 $16 $17 $17
                DB $18 $19 $19 $1A $1A $1B $1C $1C $1D $1E $1F $1F $20 $21 $21 $22
                DB $23 $24 $24 $25 $26 $27 $28 $28 $29 $2A $2B $2C $2D $2E $2E $2F
                DB $30 $31 $32 $33 $34 $35 $36 $37 $38 $39 $3A $3B $3C $3D $3E $3F
                DB $40 $41 $42 $43 $45 $46 $47 $48 $49 $4A $4C $4D $4E $4F $50 $52
                DB $53 $54 $55 $57 $58 $59 $5B $5C $5D $5F $60 $61 $63 $64 $65 $67
                DB $68 $6A $6B $6D $6E $70 $71 $73 $74 $76 $77 $79 $7A $7C $7D $7F
                DB $81 $82 $84 $85 $87 $89 $8A $8C $8E $90 $91 $93 $95 $97 $98 $9A
                DB $9C $9E $A0 $A1 $A3 $A5 $A7 $A9 $AB $AD $AF $B0 $B2 $B4 $B6 $B8
                DB $BA $BC $BE $C0 $C2 $C4 $C7 $C9 $CB $CD $CF $D1 $D3 $D5 $D8 $DA
                DB $DC $DE $E0 $E3 $E5 $E7 $E9 $EC $EE $F0 $F3 $F5 $F7 $FA $FC $FF
#endif
