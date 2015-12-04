#!/usr/bin/env perl
use strict;
use warnings;

use Digest::MD5 qw(md5_hex);
use 5.10.0;

my $key = $ARGV[0];
my $i = 1;
my $md5;

while (1) {
    $md5 = md5_hex("$key$i");
    if ($md5 =~ /^00000/) {
        last;
    } else {
        $i++;
    }
}

printf "starts with 5 0s: %10d %s\n", $i, $md5;

$i = 1;
while (1) {
    $md5 = md5_hex("$key$i");
    if ($md5 =~ /^000000/) {
        last;
    } else {
        $i++;
    }
}

printf "starts with 6 0s: %10d %s\n", $i, $md5;

