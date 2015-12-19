#!/usr/bin/env perl
use strict;
use warnings;
use 5.22.0;

my @replacements;
my $starter;

# parse input
my $state = 1;
while (<>) {
    chomp;
    if (/^$/) {
        $state = 2;
    } elsif ($state == 1) {
        m/^(.+) => (.+)$/;
        push @replacements, [$1, $2];
    } else {
        $starter = $_;
        $state = 3;
    }
}

# try too the possibilities
my %molecules;

for (@replacements) {
    my ($from, $to) = @$_;
    # say "$from => $to";
    while ($starter =~ /$from/g) {
        # my $new = "$`$to$'";
        # say $new;
        $molecules{"$`$to$'"} = 1;
    }
}

# say "";
# say for sort keys %molecules;
# say "";
say scalar keys %molecules;
