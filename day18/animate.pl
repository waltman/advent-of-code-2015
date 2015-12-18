#!/usr/bin/env perl
use strict;
use warnings;
use 5.22.0;

my $steps = shift;

# parse input
my $lights;
while (<>) {
    chomp;
    push @$lights, [split //];
}

# say "step 0";
# for my $l (@$lights) {
#     say @$l;
# }
# say "";

for my $step (1..$steps) {
    $lights = convolve($lights);

    # say "step $step";
    # for my $l (@$lights) {
    #     say @$l;
    # }
    # say "";
}

printf "%d lights are lit\n", num_lit($lights);

sub convolve {
    my $lights = shift;
    my $new;

    for my $row (0..$#$lights) {
        for my $col (0..$#$lights) {
            my $n = num_on($lights, $row, $col);
            my $c = $lights->[$row][$col];
            if ($c eq "#" && $n == 2) {
                $new->[$row][$col] = "#";
            } elsif ($n == 3) {
                $new->[$row][$col] = "#";
            } else {
                $new->[$row][$col] = ".";
            }
        }
    }
    return $new;
}

sub num_on {
    my ($lights, $row, $col) = @_;

    return val($lights, $row-1, $col-1) + val($lights, $row-1, $col) + val($lights, $row-1, $col+1)
         + val($lights, $row, $col-1) + val($lights, $row, $col+1)
         + val($lights, $row+1, $col-1) + val($lights, $row+1, $col) + val($lights, $row+1, $col+1);
}

sub val {
    my ($lights, $row, $col) = @_;

    if ($row < 0 || $row > $#$lights || $col < 0 || $col > $#$lights) {
        return 0;
    } elsif ($lights->[$row][$col] eq '#') {
        return 1;
    } else {
        return 0;
    }
}

sub num_lit {
    my $lights = shift;

    my $cnt = 0;
    for my $row (0..$#$lights) {
        for my $col (0..$#$lights) {
            $cnt++ if $lights->[$row][$col] eq '#';
        }
    }

    return $cnt;
}
