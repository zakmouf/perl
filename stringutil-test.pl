#!/usr/bin/perl

require '/Users/userlia/Documents/perl/stringutil.pl';

my $source = shift @ARGV;
my $target = shift @ARGV;

my $template = read_file_as_string ($source);

my $loop = trim_newline (substr_between ($template, 'begin_loop', 'end_loop'));
my $case_1 = trim_newline (substr_between ($template, 'begin_case_1', 'end_case_1'));
my $case_x = trim_newline (substr_between ($template, 'begin_case_x', 'end_case_x'));
my $begin = trim_newline (substr_before ($template, 'begin_loop'));
my $end = trim_newline (substr_after ($template, 'end_loop'));

my $case_before = trim_newline (substr_between ($template, 'begin_loop', 'begin_case_1'));
my $case_after = trim_newline (substr_between ($template, 'end_case_x', 'end_loop'));

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
