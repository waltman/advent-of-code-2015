#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw(max);
use Spell;
use 5.22.0;

my @spells;
push @spells, Spell->new("Magic Missile", 53, 4, 0, 0,   0, 1, 1);
push @spells, Spell->new("Drain",         73, 2, 0, 2,   0, 1, 1);
push @spells, Spell->new("Shield",       113, 0, 7, 0,   0, 6, 0);
push @spells, Spell->new("Poison",       173, 3, 0, 0,   0, 6, 0);
push @spells, Spell->new("Recharge",     229, 0, 0, 0, 101, 5, 0);

my $games = 0;
my $cost;
my $best_cost = 1e100;
my $wins = 0;

while ($games < 1_000_000) {

#my $hp = 10;
my $hp = 50;
my $damage = 0;
my $armor = 0;
#my $mana = 250;
my $mana = 500;

#my $boss_hp = 14;
#my $boss_damage = 8;
my $boss_hp = 71;
my $boss_damage = 10;
my $win = 0;
$cost = 0;
$games++;
#say "\nStarting game $games\n";
$_->deactivate for @spells;

while (1) {
#    say "-- Player turn --";
#    say "- Player has $hp hit points, $armor armor, $mana mana";
#    say "- Boss has $boss_hp hit points";

    # apply anything active
    for my $spell (@spells) {
        if ($spell->active) {
            if ($spell->name eq "Shield") {
#                printf "Shield's timer is now %d.\n", $spell->timer;
            } elsif ($spell->name eq "Poison") {
#                printf "Poison deals 3 damage; its timer is now %d.\n", $spell->timer;
                $boss_hp -= 3;
            } elsif ($spell->name eq "Recharge") {
#                printf "Recharge provides 101 mana; its timer is now %d.\n", $spell->timer;
                $mana += 101;
            }
        }
    }

    if ($boss_hp <= 0) {
#        say "This kills the boss, and the player wins.";
        $win = 1;
        last;
    }

    my $spell = pick_spell(\@spells, $mana);
    if (!defined $spell) {
#        say "Player can't afford to buy a spell. This kills the player.";
        last;
    }
    $spell->activate();
    $mana -= $spell->cost;
    $cost += $spell->cost;
#     last if $cost > $best_cost;
    if ($spell->name eq "Magic Missile") {
#        say "Player casts Magic Missile, dealing 4 damage.";
        $boss_hp -= 4;
        if ($boss_hp <= 0) {
#            say "This kills the boss, and the player wins.";
            $win = 1;
            last;
        }
    } elsif ($spell->name eq "Drain") {
#        say "Player casts Drain, dealing 2 damage, and healing 2 hit points.";
        $hp += 2;
        $boss_hp -= 2;
        if ($boss_hp <= 0) {
#            say "This kills the boss, and the player wins.";
            last;
        }
    } elsif ($spell->name eq "Shield") {
#        say "Player casts Shield, increasing armor by 7.";
    } else {
#        printf "Player casts %s.\n", $spell->name;
    }

#    say "Player has now spent $cost mana";

    $_->take_turn for @spells;

    # now take the boss's turn
#    say "";
#    say "-- Boss turn --";
#    say "- Player has $hp hit points, $armor armor, $mana mana";
#    say "- Boss has $boss_hp hit points";

    # apply anything active
    for my $spell (@spells) {
        if ($spell->active) {
            if ($spell->name eq "Shield") {
#                printf "Shield's timer is now %d.\n", $spell->timer;
            } elsif ($spell->name eq "Poison") {
#                printf "Poison deals 3 damage; its timer is now %d.\n", $spell->timer;
                $boss_hp -= 3;
            } elsif ($spell->name eq "Recharge") {
#                printf "Recharge provides 101 mana; its timer is now %d.\n", $spell->timer;
                $mana += 101;
            }
        }
    }

    if ($boss_hp <= 0) {
#        say "This kills the boss, and the player wins.";
        $win = 1;
        last;
    }

    if ($spells[2]->active) {
#        say "Boss attacks for 8 - 7 = 1 damage!";
        $hp--;
    } else {
#        say "Boss attacks for 8 damage!";
        $hp -= 8;
    }
    if ($hp <= 0) {
#        say "This kills the player, and the boss wins.";
        last;
    }

    $_->take_turn for @spells;
#    say "";

#    last;
}
if ($win) {
#    say "Player spent $cost mana";
    $best_cost = $cost if $cost < $best_cost;
    $wins++;
}
}

say "played $games games, won $wins, best cost = $best_cost";

sub pick_spell {
    my ($spells, $mana) = @_;
    my @possible;

    for my $spell (@$spells) {
        if ($spell->inactive && $spell->cost <= $mana) {
            push @possible, $spell;
        }
    }

    if (@possible == 0) {
        return;
    } else {
        return $possible[int(rand(@possible))];
    }
}
