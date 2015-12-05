#!/usr/bin/env perl
use strict;
use warnings;
use 5.10.0;

my $num_nice = 0;
while (<>) {
    chomp;
    my $vowels;
    my $double;
    my $special;

    if (/[aeiou].*[aeiou].*[aeiou]/) {
        $vowels = 1;
    } else {
        $vowels = 0;
    }

    if (/(.)\1/) {
        $double = 1;
    } else {
        $double = 0;
    }

    if (/ab|cd|pq|xy/) {
        $special = 1;
    } else {
        $special = 0;
    }

    if ($vowels && $double && !$special) {
        say "nice    $_";
        $num_nice++;
    } else {
        say "naughty $_";
    }
}

say "$num_nice were nice";
