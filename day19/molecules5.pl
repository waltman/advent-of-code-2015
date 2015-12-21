#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(shuffle);
use 5.22.0;

my %replacements;
my $orig;

# parse input
my $state = 1;
while (<>) {
    chomp;
    if (/^$/) {
        $state = 2;
    } elsif ($state == 1) {
        m/^(.+) => (.+)$/;
        $replacements{$2} = $1;
    } else {
        $orig = $_;
        $state = 3;
    }
}

my @reps = keys %replacements;

# try to generate the possibilities
my $target = "e";
my $n = 0;
my $num_steps;

OUTER: while (1) {
    my %seen = ($orig => 1);
    my @queue = ([$orig, 1]);
    @reps = shuffle @reps;
    $num_steps = 0;
    $n++;

    while (1) {
        my ($molecule, $steps) = @{shift @queue};
        if ($steps > $num_steps) {
            $num_steps = $steps;
        }

        my $new = $molecule;
        my $num_subs = 0;
        for my $rep (@reps) {
            my $cnt = $new =~ s/$rep/$replacements{$rep}/g;
            $num_subs += $cnt;
        }
        if ($num_subs == 0) {
            # try again with a different permutation...
            next OUTER;
        }
        if ($new eq $target) {
            last OUTER;
        } elsif (!exists $seen{$new}) {
            $seen{$new} = 1;
            push @queue, [$new, $steps + $num_subs];
        }
    }
}

say "generated it in $num_steps steps and $n iteration(s)";
