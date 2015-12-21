#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);
use 5.22.0;

my @weapons = (['Dagger',      8, 4, 0],
               ['Shortsword', 10, 5, 0],
               ['Warhammer',  25, 6, 0],
               ['Longsword',  40, 7, 0],
               ['Greataxe',   74, 8, 0]);

my @armor = (['No armor',      0, 0, 0],
             ['Leather',      13, 0, 1],
             ['Chainmail',    31, 0, 2],
             ['Splintmail',   53, 0, 3],
             ['Bandedmail',   75, 0, 4],
             ['Platemail',   102, 0, 5]);

my @rings = (['No ring 1',     0, 0, 0],
             ['No ring 2',     0, 0, 0],
             ['Damage +1',    25, 1, 0],
             ['Damage +2',    50, 2, 0],
             ['Damage +3',   100, 3, 0],
             ['Defense +1',   20, 0, 1],
             ['Defense +2',   40, 0, 2],
             ['Defense +3',   80, 0, 3]);

my $low_cost = 1e100;
my @low_picks;
my $high_cost = 0;
my @high_picks;

my $HP = 100;

for my $w (0..$#weapons) {
    for my $a (0..$#armor) {
        for my $r1 (0..$#rings-1) {
            next if $r1 == 1;
            for my $r2 ($r1+1..$#rings) {
                my $cost   = $weapons[$w]->[1] + $armor[$a]->[1] + $rings[$r1]->[1] + $rings[$r2]->[1];
                my $damage = $weapons[$w]->[2] + $armor[$a]->[2] + $rings[$r1]->[2] + $rings[$r2]->[2];
                my $armor  = $weapons[$w]->[3] + $armor[$a]->[3] + $rings[$r1]->[3] + $rings[$r2]->[3];

                my $win = win_battle($HP, $damage, $armor);
                if ($win && $cost < $low_cost) {
                    $low_cost = $cost;
                    @low_picks = ($w, $a, $r1, $r2);
                } elsif (!$win && $cost > $high_cost) {
                    $high_cost = $cost;
                    @high_picks = ($w, $a, $r1, $r2);
                }
            }
        }
    }
}

say "low cost = $low_cost";
say "$weapons[$low_picks[0]]->[0]";
say "$armor[$low_picks[1]]->[0]";
say "$rings[$low_picks[2]]->[0]";
say "$rings[$low_picks[3]]->[0]";

say "\nhigh cost = $high_cost";
say "$weapons[$high_picks[0]]->[0]";
say "$armor[$high_picks[1]]->[0]";
say "$rings[$high_picks[2]]->[0]";
say "$rings[$high_picks[3]]->[0]";

sub win_battle {
    my ($player_hp, $damage, $armor) = @_;
    my $boss_hp = 104;
    my $boss_damage = 8;
    my $boss_armor = 1;

    my $player_delta = max($boss_damage - $armor, 1);
    my $boss_delta = max($damage - $boss_armor, 1);

    while (1) {
        $boss_hp -= $boss_delta;
        return 1 if $boss_hp <= 0;

        $player_hp -= $player_delta;
        return 0 if $player_hp <= 0;
    }
}
