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

# for my $k (sort keys %replacements) {
#     say "$k => @{$replacements{$k}}";
# }

# try to generate the possibilities
my %molecules = (e => 1);
my $n = 0;
my $target_len = length $target;
say "target length = $target_len";

OUTER: while (1) {
    $n++;
    my $num_keys = scalar keys %molecules;
    say "step $n, $num_keys keys";
    my %new_molecules;
    my $longest = 0;

    for my $molecule (keys %molecules) {
        for my $from (keys %replacements) {
            while ($molecule =~ /^(.*?)$from(.*?)$/g) {
                for my $to (@{$replacements{$from}}) {
#                    my $new = $` . $to . $';
                    my $new = $1 . $to . $2;
                    if ($new eq $target) {
                        last OUTER;
                    } elsif (length $new <= $target_len) {
                        $new_molecules{$new} = 1;
                        $longest = length $new if length $new > $longest;
                    }
                }
            }
        }
    }
    say "longest is $longest";
    %molecules = %new_molecules;
}

# say "";
# say for sort keys %molecules;
# say "";
say "generated it in $n steps";
say scalar keys %molecules;
