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

#my $target = sum(@packages) / 3;
my $target = sum(@packages) / 4;
say "target = $target";

my $iter = partitions(\@packages, 2);
my $n = 0;
$| = 1;
my $smallest = @packages;
my $smallest_qe = 1e300;
while (my $p = $iter->next) {
    $n++;
    if ($n % 100_000 == 0) {
        printf "iteration %d, smallest = %d, smallest_qe = %d\n", $n, $smallest, $smallest_qe;
    }

    if (sum(@{$p->[0]}) == $target) {
        my $size = @{$p->[0]};
        if ($size < $smallest) {
            $smallest = $size;
            $smallest_qe = prod($p->[0]);
            say "(@{$p->[0]})\t$smallest\t$smallest_qe";
        } elsif ($size == $smallest) {
            my $qe = prod($p->[0]);
            if ($qe < $smallest_qe) {
                $smallest_qe = prod($p->[0]);
                say "(@{$p->[0]})\t$smallest\t$smallest_qe";
            }
        }
    }
}

sub prod {
    my $ar = shift;

    my $prod = 1;
    $prod *= $_ for @$ar;

    return $prod;
}
