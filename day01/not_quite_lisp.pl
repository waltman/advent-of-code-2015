#!/usr/bin/env perl
use strict;
use warnings;
use 5.10.0;

while (<>) {
    my $floor = 0;
    my $basement = 0;
    chomp;
    my @c = split //;
    for my $i (0..$#c) {
        my $c = $c[$i];
        $floor++ if $c eq '(';
        $floor-- if $c eq ')';
        $basement = $i+1 if $floor < 0 && $basement == 0;
    }
    say "$floor $basement => $_";
    $floor = 0;
    $basement = 0;
}
