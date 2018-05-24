#!/usr/bin/perl

use strict;
use warnings;
use stringutil;

my $source = shift @ARGV;
my $target = shift @ARGV;

my $template = read_file_as_string ($source);
print "hello world\n";
