#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(partitions);
use List::Util qw(sum);
use 5.18.0;

#my @packages = (1..5, 7..11);
#say "@packages";

my @packages;
while (<>) {
    chomp;
    push @packages, $_;
}



say "@packages";
say scalar @packages;
say sum @packages;

# my $iter = partitions(\@packages, 5);
# while (my $p = $iter->next) {
#     say "(@{$p->[0]}) (@{$p->[1]}) (@{$p->[2]})";
# }
