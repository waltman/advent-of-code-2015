#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(sum);
use 5.22.0;

my $target = shift;
my @container;
my %num_containers;
while (<>) {
    chomp;
    push @container, $_;
}

my $n = @container;
my $cnt = 0;
for my $i (1..2**$n - 1) {
    my @subset = subset($i, $n);
    if (sum(@container[@subset]) == $target) {
        $cnt++;
        $num_containers{scalar @subset}++;
    }
}

say "total = $cnt";
for my $k (sort {$a<=>$b} keys %num_containers) {
    say "$k => $num_containers{$k}";
}
my @k = sort {$a<=>$b} keys %num_containers;
say "min size is $k[0], which can be done in $num_containers{$k[0]} ways";

sub subset {
    my ($i, $n) = @_;
    my @in_set;

    for my $exp (0..$n-1) {
        push @in_set, $exp if ($i & 1 << $exp);
    }

    return @in_set;
}
