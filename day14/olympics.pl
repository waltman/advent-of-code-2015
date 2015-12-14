#!/usr/bin/env perl
use strict;
use warnings;
use 5.22.0;

my $n = shift;
my %name;
my %speed;
my %durr;
my %rest;

while (<>) {
    my @F = split;
    my ($name, $speed, $durr, $rest) = @F[0, 3, 6, -2];
    $name{$name} = $name;
    $speed{$name} = $speed;
    $durr{$name} = $durr;
    $rest{$name} = $rest;
}

my %dist;
for my $name (sort keys %name) {
    $dist{$name} = calc_dist($speed{$name}, $durr{$name}, $rest{$name}, $n);
}

for my $k (sort {$dist{$b} <=> $dist{$a}} keys %dist) {
    say "$k\t$dist{$k}";
}

sub calc_dist {
    my ($speed, $durr, $rest, $n) = @_;
    my $t = 0;
    my $dist = 0;

    while ($t < $n) {
        for (my $i = 0; $i < $durr && $t < $n; $i++, $t++) {
            $dist += $speed;
        }

        $t += $rest;
    }

    return $dist;
}
