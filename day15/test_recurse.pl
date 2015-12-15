#!/usr/bin/env perl
use strict;
use warnings;
use 5.22.0;

# recursively generate all the ways to make $SUM units of $N ingredients

my $N = 4;
my $SUM = 100;

my $recipes = gen_recipes($N, $SUM);
say "@$_" for @$recipes;

sub gen_recipes {
    my ($n, $sum) = @_;
    my @out;

    if ($n == 2) {
        for my $i (0..$sum) {
            push @out, [$i, $sum-$i];
        }
    } else {
        my %h;
        for my $i (0..$sum) {
            my $rest = gen_recipes($n-1, $sum-$i);
            for my $r (@$rest) {
                for my $j (0..$n-1) {
                    my @tmp = @$r;
                    splice @tmp, $j, 0, $i;
                    $h{"@tmp"} = 1;
                }
            }
        }
        for (keys %h) {
            push @out, [split / /];
        }
    }

    return \@out;
}
