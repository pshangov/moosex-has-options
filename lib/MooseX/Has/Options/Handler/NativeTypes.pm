package MooseX::Has::Options::Handler::NativeTypes;

# ABSTRACT: Option shortcuts for native types

use strict;
use warnings;

sub handles
{
    return (
        array   => { traits => ['Array']   },
        bool    => { traits => ['Bool']    },
        code    => { traits => ['Code']    },
        counter => { traits => ['Counter'] },
        hash    => { traits => ['Hash']    },
        number  => { traits => ['Number']  },
        string  => { traits => ['String']  },
    );
}

1;

=head1 DESCRIPTION

This module provides the following shortcut options for L<MooseX::Has::Options>:

=over

=item :array

Translates to C<< traits => ['Array'] >>

=item :bool

Translates to C<< traits => ['Bool'] >>

=item :code

Translates to C<< traits => ['Code'] >>

=item :counter

Translates to C<< traits => ['Counter'] >>

=item :hash

Translates to C<< traits => ['hash'] >>

=item :number

Translates to C<< traits => ['Number'] >>

=item :string

Translates to C<< traits => ['String'] >>

=back

=cut
