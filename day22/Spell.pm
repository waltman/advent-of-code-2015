package Spell;

use strict;
use warnings;
use Carp;
use 5.22.0;
use List::Util qw(max);

sub new {
    my ($package, $name, $cost, $damage, $armor, $heal, $mana, $duration, $instant) = @_;
    my $self = {};
    bless $self, $package;

    $self->_init($name, $cost, $damage, $armor, $heal, $mana, $duration, $instant);

    return $self;
}

sub _init {
    my $self = shift;
    my ($name, $cost, $damage, $armor, $heal, $mana, $duration, $instant) = @_;

    $self->{name} = $name;
    $self->{cost} = $cost;
    $self->{damage} = $damage;
    $self->{armor} = $armor;
    $self->{heal} = $heal;
    $self->{mana} = $mana;
    $self->{duration} = $duration;
    $self->{timer} = 0;
    $self->{instant} = $instant;
}

sub active {
    my $self = shift;

    return $self->{timer} > 0;
}

sub inactive {
    my $self = shift;

    return $self->{timer} == 0;
}

sub activate {
    my $self = shift;

    $self->{timer} = $self->{duration};
}

sub deactivate {
    my $self = shift;

    $self->{timer} = 0;
}

sub take_turn {
    my $self = shift;

    $self->{timer} = max($self->{timer} - 1, 0);
}

sub name {
    my $self = shift;

    return $self->{name};
}

sub cost {
    my $self = shift;

    return $self->{cost};
}

sub damage {
    my $self = shift;

    return $self->{damage};
}

sub armor {
    my $self = shift;

    return $self->{armor};
}

sub heal {
    my $self = shift;

    return $self->{heal};
}

sub mana {
    my $self = shift;

    return $self->{mana};
}

sub instant {
    my $self = shift;

    return $self->{instant};
}

sub timer {
    my $self = shift;

    return $self->{timer};
}


1;
