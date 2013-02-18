package MooseX::Has::Options::Handler::NoInit;

# ABSTRACT: Option shortcut for prohibiting init_arg

use strict;
use warnings;

sub handles
{
    return (
        no_init => { init_arg => undef }
    );
}

1;

=head1 DESCRIPTION

This module provides the following shortcut options for L<MooseX::Has::Options>:

=over

=item :no_init

Translates to C<< init_arg => undef >>

=back

=cut
