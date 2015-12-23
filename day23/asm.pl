#!/usr/bin/env perl
use strict;
use warnings;
use 5.22.0;

my @program;

while (<>) {
    chomp;
    my @F = split /[ ,]+/;
    if ($F[0] eq "hlf") {
        push @program, sub {
            my ($ip, $r) = @_;
            $r->{$F[1]} /= 2;
            return $ip + 1;
        }
    } elsif ($F[0] eq "tpl") {
        push @program, sub {
            my ($ip, $r) = @_;
            $r->{$F[1]} *= 3;
            return $ip + 1;
        }
    } elsif ($F[0] eq "inc") {
        push @program, sub {
            my ($ip, $r) = @_;
            $r->{$F[1]}++;
            return $ip + 1;
        }
    } elsif ($F[0] eq "jmp") {
        push @program, sub {
            my ($ip, $r) = @_;
            return $ip + $F[1];
        }
    } elsif ($F[0] eq "jie") {
        push @program, sub {
            my ($ip, $r) = @_;
            if ($r->{$F[1]} % 2 == 0) {
                return $ip + $F[2];
            } else {
                return $ip + 1;
            }
        }
    } elsif ($F[0] eq "jio") {
        push @program, sub {
            my ($ip, $r) = @_;
            if ($r->{$F[1]} == 1) {
                return $ip + $F[2];
            } else {
                return $ip + 1;
            }
        }
    } else {
        die "unexpected instruction: $F[0]";
    }
}

my $ip = 0;
#my %r = (a => 0, b => 0);
my %r = (a => 1, b => 0);
my $n = 0;
while ($ip >= 0 && $ip < @program) {
    say "$n\t$r{a}\t$r{b}";
    $ip = $program[$ip]->($ip, \%r);
    $n++;
}

say "register $_ = $r{$_}" for qw(a b);


