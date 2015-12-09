#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(permutations);
use 5.22.0;

my %dist;
my %cities;

while (<>) {
    chomp;
    my ($cities, $dist) = split / = /;
    my ($c1, $c2) = split / to /, $cities;
    $dist{"$c1,$c2"} = $dist{"$c2,$c1"} = $dist;
    $cities{$c1} = $cities{$c2} = 1;
}

my @cities = sort keys %cities;
my $low_dist;
my $low_path;
my $high_dist;
my $high_path;
my $iter = permutations(\@cities);
while (my $p = $iter->next) {
    my $dist = 0;
    for my $i (0 .. $#$p - 1) {
        $dist += $dist{"$p->[$i],$p->[$i+1]"};
    }
    my $path = join " to ", @$p;
    say "$path = $dist";
    if (!defined $low_dist || $dist < $low_dist) {
        $low_dist = $dist;
        $low_path = $path;
    }
    if (!defined $high_dist || $dist > $high_dist) {
        $high_dist = $dist;
        $high_path = $path;
    }
}

print "\nshortest path: $low_path = $low_dist\n";
print "\nlongest path: $high_path = $high_dist\n";
