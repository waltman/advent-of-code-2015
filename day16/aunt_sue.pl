#!/usr/bin/env perl
use strict;
use warnings;
use 5.22.0;

# parse input
my @sues;
while (<>) {
    chomp;
    push @sues, {split /[ :,]+/};
}

my %mfcam = (children => 3,
             cats => 7,
             samoyeds => 2,
             pomeranians => 3,
             akitas => 0,
             vizslas => 0,
             goldfish => 5,
             trees => 3,
             cars => 2,
             perfumes => 1);

# now find the best match
for my $sue (@sues) {
    my $bad = 0;
    while (my ($k, $v) = each %mfcam) {
        $bad = 1 if exists $sue->{$k} && $sue->{$k} != $v;
    }
    next if $bad;
    say $sue->{Sue};
}
