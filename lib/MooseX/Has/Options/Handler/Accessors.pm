package MooseX::Has::Options::Handler::Accessors;

use strict;
use warnings;

sub handles { map { $_ => sub { is => $_[0] } } qw(ro rw bare) }

1;
