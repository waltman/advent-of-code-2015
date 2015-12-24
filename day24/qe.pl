#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(partitions);
use List::Util qw(sum min);
use 5.18.0;

my @packages;
while (<>) {
    chomp;
    push @packages, $_;
}

my $target = sum(@packages) / 3;
my %seen;
my @possible;

my $iter = partitions(\@packages, 2);
while (my $p = $iter->next) {
    if (sum(@{$p->[0]}) == $target && !$seen{"@{$p->[0]}"}) {
        $seen{"@{$p->[0]}"} = 1;
        my $iter2 = partitions($p->[1], 2);
        while (my $p2 = $iter2->next) {
            if (sum(@{$p2->[0]}) == $target && !$seen{"@{$p2->[0]}"}) {
                $seen{"@{$p2->[0]}"} = 1;
                $seen{"@{$p2->[1]}"} = 1;
                push @possible, [$p->[0], $p2->[0], $p2->[1]];
            }
        }
    }
}

# for my $p (sort smallest_group @possible) {
for my $p (@possible) {
    say "(@{$p->[0]}) (@{$p->[1]}) (@{$p->[2]})"
}

sub smallest_group {
    my ($x, $y) = @_;

    my $x1 = min(scalar @{$x->[0]}, scalar @{$x->[1]}, scalar @{$x->[2]});
    my $y1 = min(scalar @{$y->[0]}, scalar @{$y->[1]}, scalar @{$y->[2]});

    return $x1 <=> $y1;
}

