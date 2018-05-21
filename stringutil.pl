#!/usr/bin/perl

use strict;
use warnings;

my $source = shift @ARGV;
my $target = shift @ARGV;

my $template = read_file_as_string ($source);

my $begin = trim_newline (substr_before ($template, 'begin_loop'));

my $case_before = trim_newline (substr_between ($template, 'begin_loop', 'begin_case_1'));
my $case_after = trim_newline (substr_between ($template, 'end_case_x', 'end_loop'));

my $loop = trim_newline (substr_between ($template, 'begin_loop', 'end_loop'));
my $case_1 = trim_newline (substr_between ($template, 'begin_case_1', 'end_case_1'));
my $case_x = trim_newline (substr_between ($template, 'begin_case_x', 'end_case_x'));

my $end = trim_newline (substr_after ($template, 'end_loop'));

open my $out, '>', $target or die ("cannot open file $target");
print $out "$begin\n";
my $i = 1;
while ($i <= 5) {
  print $out "$case_before\n" if length ($case_before) > 0;
  if ($i <= 2) { print $out "$case_1\n" if length ($case_1) > 0; }
          else { print $out "$case_x\n" if length ($case_x) > 0; }
  print $out "$case_after\n" if length ($case_after) > 0;
  $i = $i + 1;
}
print $out "$end\n";
close $out;

# ------------------------------------------------------------------------------

sub read_file_as_string {
  my ($source) = @_;
  open my $in, '<', $source or die ("cannot open file $source");
  my $target = '';
  while (my $line = <$in>) {
    $target = $target . $line;
  }
  close $in;
  return $target;
}

sub trim_newline {
  my ($source) = @_;
  my $target = $source;
  $target =~ s/^(\r?\n)*//g;
  $target =~ s/(\r?\n)*$//g;
  return $target;
}

sub substr_before {
  my ($source, $before) = @_;
  my $index_before = index ($source, $before);
  my $target = '';
  if ($index_before > -1) {
    $target = substr ($source, 0, $index_before);
  }
  return $target;
}

sub substr_after {
  my ($source, $after) = @_;
  my $index_after = index ($source, $after);
  my $target = '';
  if ($index_after > -1) {
    $target = substr ($source, $index_after + length ($after));
  }
  return $target;
}

sub substr_between {
  my ($source, $before, $after) = @_;
  my $target = substr_after ($source, $before);
  $target = substr_before ($target, $after);
  return $target;
}
