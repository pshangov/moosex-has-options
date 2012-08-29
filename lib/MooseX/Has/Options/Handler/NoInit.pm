package MooseX::Has::Options::Handler::NoInit;

use strict;
use warnings;

sub handles { no_init => sub { init_arg => undef } }

1;
