#!/usr/bin/env perl
use strict;
use warnings;
use Algorithm::Combinatorics qw(permutations);
use 5.22.0;

unless (@ARGV == 2) {
    die "Usage: looksay.pl input iterations\n";
}

my ($input, $iterations) = @ARGV;

say "0\t$input";

for my $i (1..$iterations) {
    my $out;
    my $last = substr($input, 0, 1);
    my $cnt = 1;

    for my $j (1..length($input) - 1) {
        my $c = substr($input, $j, 1);
        if ($c eq $last) {
            $cnt++;
        } else {
            $out .= $cnt . $last;
            $cnt = 1;
            $last = $c;
        }
    }

    $out .= $cnt . $last;
    say "$i\t$out";
    $input = $out;
}

printf "\nfinal length = %d\n", length($input);
