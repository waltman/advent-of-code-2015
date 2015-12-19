#!/usr/bin/env perl
use strict;
use warnings;
use 5.22.0;

my %replacements;
my $target;

# parse input
my $state = 1;
while (<>) {
    chomp;
    if (/^$/) {
        $state = 2;
    } elsif ($state == 1) {
        m/^(.+) => (.+)$/;
        push @{$replacements{$1}}, $2;
    } else {
        $target = $_;
        $state = 3;
    }
}

my $re = join "|", keys %replacements;
$re = qr($re);


# for my $k (sort keys %replacements) {
#     say "$k => @{$replacements{$k}}";
# }

# try to generate the possibilities
my %seen = (e => 1);
my @queue = (["e", 1]);
my $n = 0;
my $target_len = length $target;
my $num_steps = 0;
say "target length = $target_len";
my $longest = 0;

OUTER: while (1) {
    my ($molecule, $steps) = @{shift @queue};
    $n++;
    if ($steps > $num_steps) {
        $num_steps = $steps;
        printf "iterations = %d, steps = %d, in queue = %d, num seen = %d, longest = %d\n", $n, $num_steps, scalar @queue, scalar keys %seen, $longest;
    }

    while ($molecule =~ /$re/g) {
        my $from = $&;
        # say "molecule = $molecule, from = $from";
        for my $to (@{$replacements{$from}}) {
            my $new = $` . $to . $';
            if ($new eq $target) {
                last OUTER;
            } elsif (!exists $seen{$new} && length $new <= $target_len) {
                $seen{$new} = 1;
                push @queue, [$new, $steps + 1];
                $longest = length $new if length $new > $longest;
            }
        }
    }
}

say "generated it in $num_steps steps and $n iterations";
