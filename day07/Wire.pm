package Wire;

use strict;
use warnings;
use Carp;
use 5.10.0;

sub new {
    my ($package, $from, $to) = @_;
    my $self = {};
    bless $self, $package;

    $self->_init($from, $to);

    return $self;
}

sub _init {
    my ($self, $from, $to) = @_;

    $self->{name} = $to;

    # parse the from side
    if ($from =~ /^\d+$/) {
        $self->{value} = $from;
    } else {
        my @f = split / /, $from;
        if (@f == 2) {
            $self->{op} = $f[0];
            $self->{arg1} = $f[1];
            $self->{arg2} = undef;
        } elsif (@f == 3) {
            $self->{arg1} = $f[0];
            $self->{op} = $f[1];
            $self->{arg2} = $f[2];
        } elsif (@f == 1) {
            $self->{op} = "EQUALS";
            $self->{arg1} = $f[0];
            $self->{arg2} = undef;
        } else {
            croak "Error parsing $from";
        }
    }
}

sub value {
    my ($self, $wires) = @_;

    unless (defined $self->{value}) {
        my $arg1 = $self->{arg1};
        my $arg2 = $self->{arg2};

        if ($self->{op} eq "NOT") {
            my $val = $wires->{$arg1}->value($wires) + 0;
            $self->{value} = ~$val & 0xffff;
        } elsif ($self->{op} eq "EQUALS") {
            my $val = $wires->{$arg1}->value($wires) + 0;
            $self->{value} = $val;
        } else {
            my $val1;
            if ($arg1 =~ /^\d+$/) {
                $val1 = $arg1 + 0;
            } else {
                $val1 = $wires->{$arg1}->value($wires) + 0;
            }
            my $val2;
            if ($arg2 =~ /^\d+$/) {
                $val2 = $arg2 + 0;
            } else {
                $val2 = $wires->{$arg2}->value($wires) + 0;
            }

            if ($self->{op} eq "AND") {
                $self->{value} = $val1 & $val2 & 0xffff;
            } elsif ($self->{op} eq "OR") {
                $self->{value} = $val1 | $val2 & 0xffff;
            } elsif ($self->{op} eq "LSHIFT") {
                $self->{value} = ($val1 << $val2) & 0xffff;
            } elsif ($self->{op} eq "RSHIFT") {
                $self->{value} = ($val1 >> $val2) & 0xffff;
            } else {
                croak "Unexpected op of $self->{op}";
            }
        }
    }

    return $self->{value};
}


1;
