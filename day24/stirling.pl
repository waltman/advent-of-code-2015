#!/usr/bin/env perl
use strict;
use warnings;
use 5.10.0;

say stirling(10, 3);
say stirling(28, 3);
say stirling(28, 2);

# from https://en.wikipedia.org/wiki/Stirling_numbers_of_the_second_kind
sub stirling {
    my ($n, $k) = @_;

    my $sum = 0;
    for my $j (0..$k) {
        $sum += (-1)**($k-$j) * choose($k, $j) * $j**$n;
    }

    return $sum / fact($k);
}

sub choose {
    my ($n, $k) = @_;

    my $prod = 1;
    $prod *= ($n + 1 - $_) / $_ for 1..$k;

    return $prod;
}

sub fact {
    my $k = shift;

    my $prod = 1;
    $prod *= $_ for 1..$k;

    return $prod;
}
