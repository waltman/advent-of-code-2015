#!/usr/bin/env perl
use strict;
use warnings;
use Wire;
use 5.10.0;

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

# for my $key (qw/d e f g h i x y/) {
for my $key (qw/a/) {
    my $val = $wires{$key}->value(\%wires);
    say "$key: $val";
}
