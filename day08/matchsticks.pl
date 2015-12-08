#!/usr/bin/env perl
use strict;
use warnings;
use 5.22.0;

my $total_diff = 0;
my $HEX = qr/[0-9a-f]{2}/;

while (<>) {
    chomp;
    my $code_len = length;
    say;

    # outer quotes
    s/^"(.*)"$/$1/;

    # escaped quotes
    s/\\"/"/g;

    # escaped backquotes
    s(\\\\)(\\)g;

    # hex
    s/\\x($HEX)/chr(hex "0x$1")/eg;
    say;

    my $mem_len = length;

    my $diff = $code_len - $mem_len;
    say "$code_len $mem_len $diff";
    say "";

    $total_diff += $diff;
}

say $total_diff;
