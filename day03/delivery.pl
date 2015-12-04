#!/usr/bin/env perl
use strict;
use warnings;
use 5.10.0;

my %h;
my %sr;
my $x = 0;
my $y = 0;
my ($sx, $sy) = (0, 0);
my ($rx, $ry) = (0, 0);
$h{"$x,$y"}++;
$sr{"$sx,$sy"}++;
$sr{"$rx,$ry"}++;
my $turn = 0;

while (<>) {
    chomp;
    my @c = split //;
    for my $c (@c) {
        if ($c eq ">") {
            $x++;
            if ($turn % 2 == 0) {
                $sx++;
            } else {
                $rx++;
            }
        } elsif ($c eq "<") {
            $x--;
            if ($turn % 2 == 0) {
                $sx--;
            } else {
                $rx--;
            }
        } elsif ($c eq "^") {
            $y++;
            if ($turn % 2 == 0) {
                $sy++;
            } else {
                $ry++;
            }
        } elsif ($c eq "v") {
            $y--;
            if ($turn % 2 == 0) {
                $sy--;
            } else {
                $ry--;
            }
        } else {
            next;
        }

        $h{"$x,$y"}++;
        if ($turn % 2 == 0) {
            $sr{"$sx,$sy"}++;
        } else {
            $sr{"$rx,$ry"}++;
        }
        $turn++;
    }
}

say scalar keys %h;
say scalar keys %sr;
