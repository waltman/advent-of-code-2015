#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(permutations);
use 5.22.0;

my %names;
my %happiness;

# parse input
while (<>) {
    chomp;
    s/\.//;
    my @F = split / /;
    my ($n1, $gl, $val, $n2) = @F[0, 2, 3, -1];
    $names{$n1} = 1;
    $happiness{"$n1,$n2"} = ($gl eq "gain") ? $val : -$val;
}

# add myself
for my $k (keys %names) {
    $happiness{"$k,Self"} = $happiness{"Self,$k"} = 0;
}
$names{Self} = 1;

my @names = sort keys %names;
my $high_happ;
my $high_perm;
my $iter = permutations(\@names);
while (my $p = $iter->next) {
    my $total = 0;
    for my $i (0..$#$p) {
        my $j = ($i + 1) % @names;
        $total += $happiness{"$p->[$i],$p->[$j]"};
        $total += $happiness{"$p->[$j],$p->[$i]"};
    }

    my $perm = join " ", @$p;
    say "$perm = $total";

    if (!defined $high_happ || $total > $high_happ) {
        $high_happ = $total;
        $high_perm = $perm;
    }
}

print "\nhighest perm: $high_perm = $high_happ\n";
