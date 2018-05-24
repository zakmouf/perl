#!/usr/bin/perl

use strict;
use warnings;
use stringutil;

my $source_l001 = shift @ARGV;
my $target_l001 = shift @ARGV;
my $target_l007 = shift @ARGV;

open my $in_l001, '<', $source_l001 or die ("cannot open file $source_l001");
open my $out_l001, '>', $target_l001 or die ("cannot open file $target_l001");
open my $out_l007, '>', $target_l007 or die ("cannot open file $target_l007");
my $header_1 = undef;
my $header_2 = undef;
my $out_file = 1;
my $count_l001 = 0;
my $count_l007 = 0;
while (my $line = <$in_l001>) {
  $line =~ s/(\r?\n)*$//g;;
  if (not defined ($header_1)) {
    $header_1 = $line;
  } elsif (not defined ($header_2)) {
    $header_2 = $line;
  } elsif ($out_file == 1) {
    print $out_l001 "$line\n";
    $count_l001 = $count_l001 + 1;
    $out_file = 7;
  } elsif ($out_file == 7) {
    print $out_l007 "$line\n";
    $count_l007 = $count_l007 + 1;
    $out_file = 1;
  }
}
close $in_l001;
close $out_l001;
close $out_l007;

debug ("header 1 : $header_1");
debug ("header 2 : $header_2");
debug ("count l001 : $count_l001");
debug ("count l007 : $count_l007");

sub debug {
  print STDERR @_,"\n";
}
