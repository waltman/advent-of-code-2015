#!/usr/bin/env perl
use strict;
use warnings;
use 5.10.0;

my $num_nice = 0;
while (<>) {
    chomp;
    my $pair;
    my $between;

    if (/(..).*\1/) {
        $pair = 1;
    } else {
        $pair = 0;
    }

    if (/(.).\1/) {
        $between = 1;
    } else {
        $between = 0;
    }

    if ($pair && $between) {
        say "nice    $_";
        $num_nice++;
    } else {
        say "naughty $_";
    }
}

say "$num_nice were nice";
