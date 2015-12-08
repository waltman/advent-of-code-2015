#!/usr/bin/env perl
use strict;
use warnings;
use 5.22.0;

my $total_diff = 0;

while (<>) {
    chomp;
    my $code_len = length;
    say;

    # escape quotes and backslashes
    s/(["\\])/\\$1/g;

    # add quotes around the whole thing
    $_ = "\"$_\"";

    say;

    my $encode_len = length;

    my $diff = $encode_len - $code_len;
    say "$code_len $encode_len $diff";
    say "";

    $total_diff += $diff;
}

say $total_diff;
