#!/usr/bin/env perl
use strict;
use warnings;
use JSON::XS;
use 5.22.0;

while (<>) {
    chomp;

    my $ref = decode_json($_);
    my $sum = addup($ref);
    say "total is $sum";
}

sub addup {
    my $ref = shift;

    if (ref($ref) eq "") {
        return value_of($ref);
    } elsif (ref($ref) eq "ARRAY") {
        return addup_ar($ref);
    } elsif (ref($ref) eq "HASH") {
        return addup_hr($ref);
    } else {
        die "WTF?";
    }
}

sub addup_ar {
    my $ref = shift;
    my $sum = 0;

    for my $val (@$ref) {
        $sum += addup($val);
    }

    return $sum;
}

sub addup_hr {
    my $ref = shift;
    my $sum = 0;

    if (grep /^red$/, values(%$ref)) {
        return 0;
    }

    while (my ($k, $v) = each %$ref) {
        $sum += value_of($k) + addup($v);
    }

    return $sum;
}

sub value_of {
    my $n = shift;

    if ($n =~ /\-?\d+/) {
        return $n;
    } else {
        return 0;
    }
}
