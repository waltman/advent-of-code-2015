#!/usr/bin/env perl
use strict;
use warnings;
use Wire;
use 5.22.0;

my %wires;
while (<>) {
    chomp;
    /^(.*) -> (.*)$/;
    my $from = $1;
    my $to = $2;
    my $wire = Wire->new($from, $to);
    $wires{$to} = $wire;
}

say "finished loading...";

for my $key (sort keys %wires) {
    my $val = $wires{$key}->value(\%wires);
    say "$key: $val";
}
