#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);
use Spell;
use 5.18.0;

my @cost = (53, 73, 113, 173, 229);

my $games = 0;
my $best_cost = 1e100;
my $wins = 0;

#my $hp = 10;
my $hp = 50;
my $damage = 0;
my $armor = 0;
#my $mana = 250;
my $mana = 500;

#my $boss_hp = 13;
#my $boss_hp = 14;
#my $boss_damage = 8;
my $boss_hp = 71;
my $boss_damage = 10;

for my $spell (0..4) {
    play_round(1, 0, $spell, $hp, $mana, $boss_hp, 0, 0, 0);
}

say "won $wins, best cost = $best_cost";

sub play_round {
    my ($round, $cost, $spell, $hp, $mana, $boss_hp, $scnt, $pcnt, $rcnt) = @_;

    # player's turn
    return 0 if --$hp <= 0; # hard mode

    my $armor = 0;

    if ($scnt > 0) {
        $scnt--;
    }
    if ($pcnt > 0) {
        $boss_hp -= 3;
        return win($round, $cost) if $boss_hp <= 0;
        $pcnt--;
    }
    if ($rcnt > 0) {
        $mana += 101;
        $rcnt--;
    }

    # can the player play this spell?
    if ($spell == 2 && $scnt > 0) {
        return 0;
    } elsif ($spell == 3 && $pcnt > 0) {
        return 0;
    } elsif ($spell == 4 && $rcnt > 0) {
        return 0;
    }

    $mana -= $cost[$spell];
    $cost += $cost[$spell];
    return 0 if $mana < 0;

    # now play the spell
    if ($spell == 0) {
        $boss_hp -= 4;
        return win($round, $cost) if $boss_hp <= 0;
    } elsif ($spell == 1) {
        $hp += 2;
        $boss_hp -= 2;
        return win($round, $cost) if $boss_hp <= 0;
    } elsif ($spell == 2) {
        $scnt = 6;
    } elsif ($spell == 3) {
        $pcnt = 6;
    } elsif ($spell == 4) {
        $rcnt = 5;
    }

    # boss's turn
    if ($scnt > 0) {
        $armor = 7;
        $scnt--;
    }
    if ($pcnt > 0) {
        $boss_hp -= 3;
        return win($round, $cost) if $boss_hp <= 0;
        $pcnt--;
    }
    if ($rcnt > 0) {
        $mana += 101;
        $rcnt--;
    }

    $hp -= $boss_damage - $armor;
    return 0 if $hp <= 0;

    for my $new_spell (0..4) {
        play_round($round+1, $cost, $new_spell, $hp, $mana, $boss_hp, $scnt, $pcnt, $rcnt);
    }
}

sub win {
    my ($round, $cost) = @_;

    say "won in round $round with cost $cost";
    $wins++;

    if ($cost < $best_cost) {
        $best_cost = $cost;
    }
}
