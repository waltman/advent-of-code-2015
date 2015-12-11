#!/usr/bin/env perl
use strict;
use warnings;
use 5.22.0;

my $VALID_TRIPLES = make_valid_triples();

my $pw = $ARGV[0];;
my $n = 0;

while (1) {
    $n++;

    if ($pw =~ /i|l|o/) {
        $pw++;
        next;
    }

    unless ($pw =~ /$VALID_TRIPLES/) {
        $pw++;
        next;
    }

    my $double_pair = 0;
    while ($pw =~ /(.)\1.*?(.)\2/g) {
        if ($1 ne $2) {
            $double_pair = 1;
            last;
        }
    }
    unless ($double_pair) {
        $pw++;
        next;
    }

    last;
}

say "next password is $pw found after $n iterations";

sub make_valid_triples {
    my $valid = "abcdefghijklmnopqrstuvwxyz";
    my @valid_trip;
    for my $i (0..length($valid) - 3) {
        my $trip = substr($valid, $i, 3);
        push @valid_trip, $trip unless $trip =~ /i|l|o/;
    }
    my $valid_trip = join "|", @valid_trip;
    return  qr/$valid_trip/;
}

