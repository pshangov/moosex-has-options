package MooseX::Has::Options::Handler::Accessors;

# ABSTRACT: Option shortcuts for ro/rw/bare

use strict;
use warnings;

sub handles
{
    return (
        ro   => { is => 'ro'   },
        rw   => { is => 'rw'   },
        bare => { is => 'bare' },
    );
}

1;

=head1 DESCRIPTION

This module provides the following shortcut options for L<MooseX::Has::Options>:

=over

=item :ro

Translates to C<< is => 'ro' >>

=item :rw

Translates to C<< is => 'rw' >>

=item :bare

Translates to C<< is => 'bare' >>

=back

=cut
