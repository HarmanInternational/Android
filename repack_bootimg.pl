#!/usr/bin/perl -w

use strict;
use warnings;
use strict;
use File::Path;
use File::Basename;
use Config::Tiny;

# Turn on print flushing
$|++;

######################################################################
## Global Variables and Constants

my $SCRIPT = __FILE__;
my $KERNEL_FN = undef;
my $PARAMS_FN = undef;
my $PARAMS = "--base 0x00000000";
my $RAMDISK_DIR = undef;
my $RAMDISK_FN = undef;
my $OUTPUT = undef;
my $TOOLS_DIR = dirname $SCRIPT;

######################################################################
## Main Code

&parse_cmdline();
&parse_configfile() if (defined $PARAMS_FN);

# Creating ramdisk 
printf "Creating Ramdisk ... ";
( -d $RAMDISK_DIR ) or die "Error, cannot find ramdisk directory, $RAMDISK_DIR\n";
$RAMDISK_FN = basename $RAMDISK_DIR . "-repack.gz";
system("$TOOLS_DIR/mkbootfs $RAMDISK_DIR | gzip > $RAMDISK_FN");
printf "complete.\n";    

# Creating image
printf "Creating image ... ";
( -e $KERNEL_FN ) or die "Error, cannot find kernel file, $KERNEL_FN\n";
system("$TOOLS_DIR/mkbootimg --kernel $KERNEL_FN --ramdisk $RAMDISK_FN $PARAMS -o $OUTPUT");
printf "complete.\n";    

######################################################################
## Subroutines

sub parse_cmdline {
    if ($#ARGV < 2) {
	die "Usage: $SCRIPT <kernel> <ramdisk directory> <out image> [parameters conf file]\n";
    }
    $KERNEL_FN = $ARGV[0];
    $RAMDISK_DIR = $ARGV[1];
    $OUTPUT = $ARGV[2];
    $PARAMS_FN = $ARGV[3] if defined ($ARGV[3]);
}

sub parse_configfile {
    printf "Parsing config file $PARAMS_FN ... ";
    my $config = Config::Tiny->read( $PARAMS_FN );

    foreach my $parameter (keys %{$config->{_}}) {
	$PARAMS .= " --$parameter $config->{_}->{$parameter}" if (length($config->{_}->{$parameter}) > 0);
    }
    printf "complete.\n";    
}
