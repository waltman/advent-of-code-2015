#!/usr/bin/env perl
use strict;
use warnings;
use 5.22.0;

# parse input
my @sues;
while (<>) {
    chomp;
    my @F = split /[ :,]+/;
    my %h = (number => $F[1]);
    for (my $i = 2; $i < @F; $i += 2) {
        $h{$F[$i]} = $F[$i+1];
    }
    push @sues, \%h;
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
        next unless exists $sue->{$k};

        if ($k eq "cats" || $k eq "trees") {
            $bad = 1 unless $v < $sue->{$k};
        } elsif ($k eq "pomeranians" || $k eq "goldfish") {
            $bad = 1 unless $v > $sue->{$k};
        } else {
            $bad = 1 unless $v == $sue->{$k};
        }
    }
    next if $bad;
    say $sue->{number};
}
