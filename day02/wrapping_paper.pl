#!/usr/bin/env perl
use strict;
use warnings;
use 5.10.0;

my $total = 0;
while (<>) {
    chomp;
    my @d = split /x/;

    my $volume = wrapping(\@d);
    printf "%10d %s\n", $volume, $_;
    $total += $volume;
}

say "total = $total";

sub wrapping {
    my $d = shift;

    my $volume = 0;
    my $smallest;

    for my $i (0..1) {
        for my $j ($i+1..2) {
            my $area = $d->[$i] * $d->[$j];
            $volume += 2 * $area;
            if (!defined $smallest || $area < $smallest) {
                $smallest = $area;
            }
        }
    }

    return $volume + $smallest;
}
