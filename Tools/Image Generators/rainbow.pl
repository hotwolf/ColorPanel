#!/usr/bin/env perl
###############################################################################
# ColorPanel - Rainbow Pattern Generator                                      #
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
$arg_type          = "B";
$brightness        = 0.5;
$file_name         = "panel_rainbow.s";

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
    elsif (($arg_type =~ /^B$/i) && ($arg =~ /^\s*(\d+\.?\d*)\s*$/i)) {
	$brightness = 1*$1;
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
    printf "usage: %s -B brightness -O file name\n", $0;
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
    printf FILEHANDLE "#ifndef PANEL_SPLASH_COMPILE\n"; 
    printf FILEHANDLE "#define PANEL_SPLASH_COMPILE\n"; 
    printf FILEHANDLE ";###############################################################################\n";
    printf FILEHANDLE ";# ColorPanel - Rainbow Pattern for the Panel Driver                           #\n";
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
    printf FILEHANDLE ";# Brightness: %5.2f                                                           #\n", $brightness;
    printf FILEHANDLE ";###############################################################################\n";
    printf FILEHANDLE "\n";
    printf FILEHANDLE ";#Gamma correction look-up table:\n";
    printf FILEHANDLE ";--------------------------------\n";
    print  FILEHANDLE "#macro PANEL_SPLASH, 0";
    foreach my $color ("Green", "Red", "Blue") {
        #Print color header
	printf  FILEHANDLE "\n                ;%s:", ($color);	    
	foreach my $row (0..14) {
	    my $saturation = $row / 14;
	    #Print row header
	    print  FILEHANDLE "\n                DB";	    
	    foreach my $column    (0..14) {
		my $hue        = ($column * 360) / 15; ;

		my $hue_i      = int($hue / 60);
		my $f          = ($hue / 60) - $hue_i;
		my $p          = $brightness * (1 -  $saturation);
		my $q          = $brightness * (1 - ($saturation * f));
		my $t          = $brightness * (1 - ($saturation * (1 - f)));
		my $pwm_val;
		#printf FILEHANDLE "\nhue=%4.2f hue_i=%d f=%4.2f p=%4.2f q=%4.2f t=%4.2f ==>", $hue, $hue_i, $f, $p, $q, $t;
		
		for ($color) {
		    /Red/ && do {
			my $red   = ($hue_i == 0) ? $brightness :
			            ($hue_i == 1) ? $q          :
			            ($hue_i == 2) ? $p          :
			            ($hue_i == 3) ? $p          :
			            ($hue_i == 4) ? $t          :
			                            $brightness;
			$pwm_val  = int((0xff * $red) + 0.5);
			last;};
		    /Green/ && do {
			my $green = ($hue_i == 0) ? $t          :
			            ($hue_i == 1) ? $brightness :
	      	                    ($hue_i == 2) ? $brightness :
	      	                    ($hue_i == 3) ? $q          :
	      	                    ($hue_i == 4) ? $p          :
				                    $p;
			$pwm_val  = int((0xff * $green) + 0.5);
			last;};
		    /Blue/ && do {
			my $blue  = ($hue_i == 0) ? $p          :
	      	                    ($hue_i == 1) ? $p          :
	      	                    ($hue_i == 2) ? $t          :
	      	                    ($hue_i == 3) ? $brightness :
	      	                    ($hue_i == 4) ? $brightness :
				                    $q;
			$pwm_val  = int((0xff * $blue) + 0.5);
			last;};
		}
		printf FILEHANDLE " \$%.2X", $pwm_val;
	    }
	    printf FILEHANDLE " ;saturation = %4.2f", $saturation;
	}
    }
    printf FILEHANDLE "\n#emac\n"; 
    printf FILEHANDLE "#endif\n"; 

    close FILEHANDLE
}
