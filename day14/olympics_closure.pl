#!/usr/bin/env perl
use strict;
use warnings;
use 5.22.0;

my $n = shift;
my %calc_dist;

while (<>) {
    my @F = split;
    my ($name, $speed, $durr, $rest) = @F[0, 3, 6, -2];
    $calc_dist{$name} = sub {
        my $n = shift;
        my $cycles = int($n / ($durr + $rest));
        my $rem = $n - $cycles * ($durr + $rest);
        my $n_fly = $cycles * $durr;
        $n_fly += $rem < $durr ? $rem : $durr;
        return $speed * $n_fly;
    }
}

my %dist;
for my $name (keys %calc_dist) {
    $dist{$name} = $calc_dist{$name}->($n);
}

for my $k (sort {$dist{$b} <=> $dist{$a}} keys %dist) {
    say "$k\t$dist{$k}";
}
