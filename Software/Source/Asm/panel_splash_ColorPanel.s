#ifndef PANEL_SPLASH_COMPILE
#define PANEL_SPLASH_COMPILE
;###############################################################################
;# ColorPanel - Rainbow Pattern for the Panel Driver                           #
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
;# Brightness:  0.50                                                           #
;###############################################################################

;#Gamma correction look-up table:
;--------------------------------
#macro PANEL_SPLASH, 0
                ;Green:
                DB $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.00
                DB $77 $77 $77 $80 $80 $80 $80 $80 $80 $80 $77 $77 $77 $77 $77 $77 ;saturation = 0.07
                DB $6F $6F $6F $80 $80 $80 $80 $80 $80 $80 $6F $6F $6F $6F $6F $6F ;saturation = 0.13
                DB $66 $66 $66 $80 $80 $80 $80 $80 $80 $80 $66 $66 $66 $66 $66 $66 ;saturation = 0.20
                DB $5E $5E $5E $80 $80 $80 $80 $80 $80 $80 $5E $5E $5E $5E $5E $5E ;saturation = 0.27
                DB $55 $55 $55 $80 $80 $80 $80 $80 $80 $80 $55 $55 $55 $55 $55 $55 ;saturation = 0.33
                DB $4D $4D $4D $80 $80 $80 $80 $80 $80 $80 $4D $4D $4D $4D $4D $4D ;saturation = 0.40
                DB $44 $44 $44 $80 $80 $80 $80 $80 $80 $80 $44 $44 $44 $44 $44 $44 ;saturation = 0.47
                DB $3C $3C $3C $80 $80 $80 $80 $80 $80 $80 $3C $3C $3C $3C $3C $3C ;saturation = 0.53
                DB $33 $33 $33 $80 $80 $80 $80 $80 $80 $80 $33 $33 $33 $33 $33 $33 ;saturation = 0.60
                DB $2B $2B $2B $80 $80 $80 $80 $80 $80 $80 $2B $2B $2B $2B $2B $2B ;saturation = 0.67
                DB $22 $22 $22 $80 $80 $80 $80 $80 $80 $80 $22 $22 $22 $22 $22 $22 ;saturation = 0.73
                DB $19 $19 $19 $80 $80 $80 $80 $80 $80 $80 $19 $19 $19 $19 $19 $19 ;saturation = 0.80
                DB $11 $11 $11 $80 $80 $80 $80 $80 $80 $80 $11 $11 $11 $11 $11 $11 ;saturation = 0.87
                DB $08 $08 $08 $80 $80 $80 $80 $80 $80 $80 $08 $08 $08 $08 $08 $08 ;saturation = 0.93
                DB $00 $00 $00 $80 $80 $80 $80 $80 $80 $80 $00 $00 $00 $00 $00 $00 ;saturation = 1.00
                ;Red:
                DB $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.00
                DB $80 $80 $80 $80 $80 $77 $77 $77 $77 $77 $77 $77 $77 $80 $80 $80 ;saturation = 0.07
                DB $80 $80 $80 $80 $80 $6F $6F $6F $6F $6F $6F $6F $6F $80 $80 $80 ;saturation = 0.13
                DB $80 $80 $80 $80 $80 $66 $66 $66 $66 $66 $66 $66 $66 $80 $80 $80 ;saturation = 0.20
                DB $80 $80 $80 $80 $80 $5E $5E $5E $5E $5E $5E $5E $5E $80 $80 $80 ;saturation = 0.27
                DB $80 $80 $80 $80 $80 $55 $55 $55 $55 $55 $55 $55 $55 $80 $80 $80 ;saturation = 0.33
                DB $80 $80 $80 $80 $80 $4D $4D $4D $4D $4D $4D $4D $4D $80 $80 $80 ;saturation = 0.40
                DB $80 $80 $80 $80 $80 $44 $44 $44 $44 $44 $44 $44 $44 $80 $80 $80 ;saturation = 0.47
                DB $80 $80 $80 $80 $80 $3C $3C $3C $3C $3C $3C $3C $3C $80 $80 $80 ;saturation = 0.53
                DB $80 $80 $80 $80 $80 $33 $33 $33 $33 $33 $33 $33 $33 $80 $80 $80 ;saturation = 0.60
                DB $80 $80 $80 $80 $80 $2B $2B $2B $2B $2B $2B $2B $2B $80 $80 $80 ;saturation = 0.67
                DB $80 $80 $80 $80 $80 $22 $22 $22 $22 $22 $22 $22 $22 $80 $80 $80 ;saturation = 0.73
                DB $80 $80 $80 $80 $80 $19 $19 $19 $19 $19 $19 $19 $19 $80 $80 $80 ;saturation = 0.80
                DB $80 $80 $80 $80 $80 $11 $11 $11 $11 $11 $11 $11 $11 $80 $80 $80 ;saturation = 0.87
                DB $80 $80 $80 $80 $80 $08 $08 $08 $08 $08 $08 $08 $08 $80 $80 $80 ;saturation = 0.93
                DB $80 $80 $80 $80 $80 $00 $00 $00 $00 $00 $00 $00 $00 $80 $80 $80 ;saturation = 1.00
                ;Blue:
                DB $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.00
                DB $77 $77 $77 $77 $77 $77 $77 $77 $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.07
                DB $6F $6F $6F $6F $6F $6F $6F $6F $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.13
                DB $66 $66 $66 $66 $66 $66 $66 $66 $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.20
                DB $5E $5E $5E $5E $5E $5E $5E $5E $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.27
                DB $55 $55 $55 $55 $55 $55 $55 $55 $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.33
                DB $4D $4D $4D $4D $4D $4D $4D $4D $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.40
                DB $44 $44 $44 $44 $44 $44 $44 $44 $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.47
                DB $3C $3C $3C $3C $3C $3C $3C $3C $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.53
                DB $33 $33 $33 $33 $33 $33 $33 $33 $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.60
                DB $2B $2B $2B $2B $2B $2B $2B $2B $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.67
                DB $22 $22 $22 $22 $22 $22 $22 $22 $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.73
                DB $19 $19 $19 $19 $19 $19 $19 $19 $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.80
                DB $11 $11 $11 $11 $11 $11 $11 $11 $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.87
                DB $08 $08 $08 $08 $08 $08 $08 $08 $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 0.93
                DB $00 $00 $00 $00 $00 $00 $00 $00 $80 $80 $80 $80 $80 $80 $80 $80 ;saturation = 1.00
#emac
#endif
