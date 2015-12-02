#!/usr/bin/env perl
use strict;
use warnings;
use 5.10.0;

my $total_wrapping = 0;
my $total_ribbon = 0;
while (<>) {
    chomp;
    my @d = split /x/;

    my $wrapping = wrapping(\@d);
    my $ribbon = ribbon(\@d);
    printf "%10d %10d %s\n", $wrapping, $ribbon, $_;
    $total_wrapping += $wrapping;
    $total_ribbon += $ribbon;
}

say "total wrapping = $total_wrapping";
say "total ribbon = $total_ribbon";

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

sub ribbon {
    my $d = shift;
    my $smallest;

    for my $i (0..1) {
        for my $j ($i+1..2) {
            my $perim = 2 * ($d->[$i] + $d->[$j]);
            if (!defined $smallest || $perim < $smallest) {
                $smallest = $perim;
            }
        }
    }

    return $smallest + $d->[0] * $d->[1] * $d->[2];
}

