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

my %points = map {$_ => 0} keys %calc_dist;
for my $i (1..$n) {
    my $max_dist = -1;
    my @max_names;
    for my $name (keys %points) {
        my $dist = $calc_dist{$name}->($i);
        if ($dist > $max_dist) {
            $max_dist = $dist;
            @max_names = ($name);
        } elsif ($dist == $max_dist) {
            push @max_names, $name;
        }
    }
    $points{$_}++ for @max_names;
}

for my $k (sort {$points{$b} <=> $points{$a}} keys %points) {
    say "$k\t$points{$k}";
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
