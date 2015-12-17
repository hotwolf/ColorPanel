#!/usr/bin/env perl
###############################################################################
# ColorPanel - Gamma Correction Look-Up Table Generator for the Panel Driver  #
###############################################################################
#    Copyright 2015-2016 Dirk Heisswolf                                       #
#    This file is part of the ColorPanel project.                             #
#                                                                             #
#    The ColorPanel firmware is free software: you can redistribute it and/or #
#    modify it under the terms of the GNU General Public License as published #
#    by the Free Software Foundation, either version 3 of the License, or     #
#    (at your option) any later version.                                      #
#                                                                             #
#    The ColorPanel firmware is distributed in the hope that it will be       #
#    useful, but WITHOUT ANY WARRANTY; without even the implied warranty of   #
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            #
#    GNU General Public License for more details.                             #
#                                                                             #
#    You should have received a copy of the GNU General Public License        #
#    along with the ColorPanel firmware. If not, see                          #
#    <http://www.gnu.org/licenses/>.                                          #
###############################################################################
# Description:                                                                #
#    This perl script generates the assembler source for an 8-bit gamma       #
#    correction look-up table.                                                #
#                                                                             #
###############################################################################
# Version History:                                                            #
#    16 December, 2015                                                        #
#      - Initial release                                                      #
###############################################################################

#################
# Perl settings #
#################
use 5.005;
#use warnings;
use File::Basename;
use FindBin qw($RealBin);
use lib $RealBin;

###############
# global vars #
###############
$need_help         = 0;
$arg_type          = "G";
$factor            = 2.4;
$file_name         = "panel_gamma.s";

($sec,$min,$hour,$mday,$mon,$year,$wday,$yday,$isdst) = localtime(time);
$year += 1900;
@months = ("Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec");
@days   = ("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat");

##########################
# read command line args #
##########################
#printf "parsing args: count: %s\n", $#ARGV + 1;
foreach $arg (@ARGV) {
    #printf "  arg: %s\n", $arg;

    #Help
    if ($arg =~ /^\s*-*(?|help|h)\s*$/i) {
	$need_help = 1;
    } 

    #Arg type	
    elsif ($arg =~ /^\s*-(G|O)\s*$/i) {
	$arg_type = $1;
    }

    #Args	
    elsif (($arg_type =~ /^G$/i) && ($arg =~ /^\s*(\d+\.?\d*)\s*$/i)) {
	$factor = 1*$1;
    }

    elsif (($arg_type =~ /^O$/i) && ($arg =~ /^\s*(\S+)\s*$/i)) {
	$file_name = $1;
    }

    #Wrong args	
    else {
	$need_help = 1;
    } 
}

###################
# print help text #
###################
if ($need_help) {
    printf "usage: %s -G gamma -O file name\n", $0;
    print  "\n";
    exit;
}

###################
# print ASM files #
###################
#Open file
#--------- 
if (open (FILEHANDLE, sprintf(">%s", $file_name))) {
    
    #Print header
    #------------ 
    printf FILEHANDLE "#ifndef PANEL_GAMMA_COMPILE\n"; 
    printf FILEHANDLE "#define PANEL_GAMMA_COMPILE\n"; 
    printf FILEHANDLE ";###############################################################################\n";
    printf FILEHANDLE ";# ColorPanel - Gamma Correction Look-Up Table for the Panel Driver            #\n";
    printf FILEHANDLE ";###############################################################################\n";
    printf FILEHANDLE ";#    Copyright 2015-2016 Dirk Heisswolf                                       #\n";
    printf FILEHANDLE ";#    This file is part of the ColorPanel project.                             #\n";
    printf FILEHANDLE ";#                                                                             #\n";
    printf FILEHANDLE ";#    The ColorPanel firmware is free software: you can redistribute it and/or #\n";
    printf FILEHANDLE ";#    modify it under the terms of the GNU General Public License as published #\n";
    printf FILEHANDLE ";#    by the Free Software Foundation, either version 3 of the License, or     #\n";
    printf FILEHANDLE ";#    (at your option) any later version.                                      #\n";
    printf FILEHANDLE ";#                                                                             #\n";
    printf FILEHANDLE ";#    The ColorPanel firmware is distributed in the hope that it will be       #\n";
    printf FILEHANDLE ";#    useful, but WITHOUT ANY WARRANTY; without even the implied warranty of   #\n";
    printf FILEHANDLE ";#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            #\n";
    printf FILEHANDLE ";#    GNU General Public License for more details.                             #\n";
    printf FILEHANDLE ";#                                                                             #\n";
    printf FILEHANDLE ";#    You should have received a copy of the GNU General Public License        #\n";
    printf FILEHANDLE ";#    along with the ColorPanel firmware. If not, see                          #\n";
    printf FILEHANDLE ";#    <http://www.gnu.org/licenses/>.                                          #\n";
    printf FILEHANDLE ";###############################################################################\n";
    printf FILEHANDLE ";# Description:                                                                #\n";
    printf FILEHANDLE ";#    This perl script generates the assembler source for an 8-bit gamma       #\n";
    printf FILEHANDLE ";#    correction look-up table.                                                #\n";
    printf FILEHANDLE ";#                                                                             #\n";
    printf FILEHANDLE ";###############################################################################\n";
    printf FILEHANDLE ";# Generated on %3s, %3s %.2d %4d                                               #\n", $days[$wday], $months[$mon], $mday, $year;
    printf FILEHANDLE ";###############################################################################\n";
    printf FILEHANDLE ";# Gamma correction factor: %4.1f %-30s                #\n", $factor;
    printf FILEHANDLE ";###############################################################################\n";
    printf FILEHANDLE "\n";
    foreach my $row (0..15) {
        #Print row header
	if ($column == 0) {	
	    if ($row == 0) {
		print  FILEHANDLE "PANEL_GAMMA_LUT DB";
	    } else {
		print  FILEHANDLE "\n                DB";
	    }
	}
	foreach my $column    (0..15) {
	    #Print table entry
	    my $inval  = $column+(16*$row);
	    my $outval = (($inval/255)**$factor)*255;
	    printf FILEHANDLE " \$%.2X", $outval;
	}                                
    }
    printf FILEHANDLE "\n#endif\n"; 

    close FILEHANDLE
}
