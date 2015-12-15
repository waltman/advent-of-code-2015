#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum);
use 5.22.0;

my %ingred;

# parse the input
while (<>) {
    chomp;
    my @F = split /[:, ]+/;
    my ($name, $cap, $dur, $flav, $tex, $cal) = @F[0,2,4,6,8,10];
    # for (my $i = 0; $i < @F; $i++) {
    #     say "$i\t$F[$i]";
    # }
    # say "$name, $cap, $dur, $flav, $tex, $cal";
    $ingred{$name} = sub {
        my $n = shift;
        return ($cap*$n, $dur*$n, $flav*$n, $tex*$n, $cal*$n);
    }
}

my @names = sort keys %ingred;
# say "@names";

# hardwire loops
my $max_score = -1;
my $max_vals;
for my $i (0..100) {
    my @ingred1 = $ingred{$names[0]}->($i);
    for my $j (0..100 - $i) {
        my @ingred2 = $ingred{$names[1]}->($j);
        for my $k (0..100 - $i - $j) {
            my @ingred3 = $ingred{$names[2]}->($k);
            my $l = 100 - $i - $j - $k;
            my @ingred4 = $ingred{$names[3]}->($l);

            my $cap  = compute_total($ingred1[0], $ingred2[0], $ingred3[0], $ingred4[0]);
            my $dur  = compute_total($ingred1[1], $ingred2[1], $ingred3[1], $ingred4[1]);
            my $flav = compute_total($ingred1[2], $ingred2[2], $ingred3[2], $ingred4[2]);
            my $tex  = compute_total($ingred1[3], $ingred2[3], $ingred3[3], $ingred4[3]);

            my $score = $cap * $dur * $flav * $tex;

            printf "%3d %3d %3d %3d %8d\n", $i, $j, $k, $l, $score;
            # say "$cap $dur $flav $tex";

            if ($score > $max_score) {
                $max_score = $score;
                $max_vals = [$i, $j, $k, $l];
            }
        }
    }
}

say "Best score $max_score for @$max_vals";

sub compute_total {
    my $sum = sum @_;

    return $sum < 0 ? 0 : $sum;
}
