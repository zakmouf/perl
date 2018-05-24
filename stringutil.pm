#!/usr/bin/perl

use strict;
use warnings;

package strigutil;
use vars qw(@ISA @EXPORT);
use Exporter;
@ISA    = qw(Exporter);
@EXPORT = qw( read_file_as_string );

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

1;
