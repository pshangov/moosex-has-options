package MooseX::Role::OptionShortcuts;

use strict;
use warnings;

use MooseX::Role::Parameterized;

parameter handlers =>
(
    is       => 'bare',
    isa      => 'HashRef',
    required => 1,
    traits   => ['Hash'],
    handles  => { handler => 'get' },
);

parameter methods =>
(
    is       => 'ro',
    required => 1,
    default  => sub { ['new'] },
);

role
{
    my $args = shift;

    around $args->methods => sub
    {
        my $orig  = shift;
        my $class = shift;
        my $name  = shift;
       
        my ( @shortcuts, @expanded );

        while ( $_[0] =~ /^:(\w+)$/ ) 
        {
            # get the name of the shortcut, sans the column    
            push @shortcuts, $1;

            # make sure to remove that shortcut from @_
            shift;
        }

        foreach my $shortcut (@shortcuts)
        {
            # use expansion sub if available
            if ( my $handler = $args->handler($shortcut) )
            {
                push @expanded, $handler->($shortcut);
            }
            # otherwise just set to true
            else
            {
                push @expanded, $shortcut => 1;
            }
        }

        return $class->$orig($name, @expanded, @_);
    };

};

1;
