#!/usr/bin/env perl
use strict;
use warnings;
use 5.22.0;

while (<>) {
    chomp;
    my $sum = 0;
    while (/(\-?\d+)/g) {
        $sum += $1;
    }

    say "total is $sum";
}
