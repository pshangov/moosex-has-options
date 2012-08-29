package MooseX::Has::Options::Handler::NativeTypes;

use strict;
use warnings;

sub handles
{
    my %expanded = (
        array   => { traits => ['ArrayRef'], default => sub { [] } },
        bool    => { traits => ['Bool'],     default => 0,         },
        code    => { traits => ['Code'],                           },
        counter => { traits => ['Counter'],  default => 0,         },
        hash    => { traits => ['HashRef'],  default => sub { {} } },
        number  => { traits => ['Number'],                         },
        string  => { traits => ['String'],   default => '',        },
    );

    return map { $_ => sub { %{ $expanded{$_[0]} } } } keys %expanded;
}

1;
