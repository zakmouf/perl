#!/usr/bin/perl

use strict;
use warnings;
use stringutil;

my $source_l001 = shift @ARGV;
my $target_l001 = shift @ARGV;
my $target_l007 = shift @ARGV;

open my $in_001, '<', $source_l001 or die ("cannot open file $source_l001");
open my $out_001, '>', $target_l001 or die ("cannot open file $target_l001");
open my $out_007, '>', $target_l007 or die ("cannot open file $target_l007");
my $header_1 = undef;
my $header_2 = undef;
my $out = 1;
while (my $line = <$in_001>) {
  $line =~ s/(\r?\n)*$//g;;
  if (not defined ($header_1)) {
    $header_1 = $line;
  } elsif (not defined ($header_2)) {
    $header_2 = $line;
  } elsif ($out == 1) {
    print $out_001 "$line$header_1$header_2\n";
    $out = 7;
  } elsif ($out == 7) {
    print $out_007 "$line$header_1$header_2\n";
    $out = 1;
  }
}
close $in_001;
close $out_001;
close $out_007;
