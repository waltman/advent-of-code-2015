#!/usr/bin/env perl
use strict;
use warnings;
use 5.10.0;

my ($XMAX, $YMAX);

if (@ARGV >= 2) {
    $XMAX = shift @ARGV;
    $YMAX = shift @ARGV;
} else {
    $XMAX = $YMAX = 1000;
}

my @light;

# initialize
for my $x (0..$XMAX - 1) {
    for my $y (0..$YMAX - 1) {
        $light[$x][$y] = 0;
    }
}

# parse the instructions
while (<>) {
    chomp;
    m/(\d+),(\d+) through (\d+),(\d+)/;
    my ($x1, $y1, $x2, $y2) = ($1, $2, $3, $4);

    if (/^turn on/) {
        for my $x ($x1..$x2) {
            for my $y ($y1..$y2) {
                $light[$x][$y] = 1;
            }
        }
    }

    if (/^turn off/) {
        for my $x ($x1..$x2) {
            for my $y ($y1..$y2) {
                $light[$x][$y] = 0;
            }
        }
    }

    if (/^toggle/) {
        for my $x ($x1..$x2) {
            for my $y ($y1..$y2) {
                $light[$x][$y] = ($light[$x][$y] == 1) ? 0 : 1;
            }
        }
    }

    if (/^print/) {
        for my $x (0..$XMAX - 1) {
            for my $y (0..$YMAX - 1) {
                print "$light[$x][$y] ";
            }
            print "\n";
        }
    }
}

# how many lights are on?
my $num_on = 0;
for my $x (0..$XMAX - 1) {
    for my $y (0..$YMAX - 1) {
        $num_on++ if $light[$x][$y] == 1;
    }
}

say "$num_on lights on";

