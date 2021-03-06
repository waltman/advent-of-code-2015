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
say "target = $target";

my $iter = partitions(\@packages, 2);
my $n = 0;
$| = 1;
my $smallest = @packages;
my $smallest_qe = 1e300;
while (my $p = $iter->next) {
    $n++;
    if ($n % 100_000 == 0) {
        printf "iteration %d, found %d possibilites, smallest = %d, smallest_qe = %d\n", $n, scalar @possible, $smallest, $smallest_qe;
    }

    if (sum(@{$p->[0]}) == $target && !$seen{"@{$p->[0]}"}) {
        $seen{"@{$p->[0]}"} = 1;
#        say "checking @{$p->[0]}";
        my $iter2 = partitions($p->[1], 2);
        my $size1 = @{$p->[0]};
        my $qe1 = prod($p->[0]);
        while (my $p2 = $iter2->next) {
            if (sum(@{$p2->[0]}) == $target && !$seen{"@{$p2->[0]}"}) {
                $seen{"@{$p2->[0]}"} = 1;
                $seen{"@{$p2->[1]}"} = 1;
                my $size2 = @{$p2->[0]};
                my $size3 = @{$p2->[1]};
                my $qe2 = prod($p2->[0]);
                my $qe3 = prod($p2->[1]);
                my $small = min($size1, $size2, $size3);
                my $low_qe = min($qe1, $qe2, $qe3);
                next if $small > $smallest;
                if ($small < $smallest) {
                    @possible = ();
                    $smallest = $small;
                    $smallest_qe = $low_qe;
                } elsif ($low_qe <= $smallest_qe) {
                    @possible = ();
                    $smallest = $small;
                    $smallest_qe = $low_qe;
                } else {
                    next;
                }
                push @possible, [$p->[0], $p2->[0], $p2->[1]];
#                say "(@{$p->[0]}) (@{$p2->[0]}) (@{$p2->[1]})";
            }
        }
    }
}

# for my $p (sort smallest_group @possible) {
say "\nPossibilities";
for my $p (@possible) {
    say "(@{$p->[0]}) (@{$p->[1]}) (@{$p->[2]})"
}
say "low qe = $smallest_qe";

sub smallest_group {
    my ($x, $y) = @_;

    my $x1 = min(scalar @{$x->[0]}, scalar @{$x->[1]}, scalar @{$x->[2]});
    my $y1 = min(scalar @{$y->[0]}, scalar @{$y->[1]}, scalar @{$y->[2]});

    return $x1 <=> $y1;
}

sub prod {
    my $ar = shift;

    my $prod = 1;
    $prod *= $_ for @$ar;

    return $prod;
}
