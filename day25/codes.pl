#!/usr/bin/env perl
use strict;
use warnings;
use 5.18.0;

my @grid;

$grid[1][1] = 20151125;
my $row = 2;
my $col = 1;
my $next_row = 3;
my $prev = $grid[1][1];
my $n = 0;

while (1) {
    $n++;
    if ($n % 1_000_000 == 0) {
        say "n = $n, row = $row, col = $col";
    }

    $grid[$row][$col] = ($prev * 252533) % 33554393;
    if ($row == 2981 && $col == 3075) {
        say "code = $grid[$row][$col] in $n iterations, next row = $next_row";
        last;
    }
    $prev = $grid[$row][$col];
    if (--$row == 0) {
        $row = $next_row;
        $next_row = $row+1;
        $col = 1;
    } else {
        $col++;
    }
}
