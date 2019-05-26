#! /usr/bin/perl
use strict;

die "\nUsage: create_dump_from_hex.pl input_file output_file\n" if ($#ARGV + 1 != 2);
die "\n File not found $ARGV[0]\n" if (! -e $ARGV[0]);
my $dump_temp = "temp.dump";
#Dont read the last line because that is just the last address
`hexdump -v $ARGV[0] | head --lines=-1 > $dump_temp`;

open my $hexfile, $dump_temp or die "Could not open $dump_temp: $!";
open my $dumpfile, '>', $ARGV[1] or die "Could not open $ARGV[1]: $!";

while( my $line = <$hexfile>)  {
  $line =~ s/^....... //g ;
  $line =~ s/(..)(..) (..)(..)/$2 $1 $4 $3/g;
  print $dumpfile $line;
}

close $hexfile;
