package MooseX::Has::Options;

# ABSTRACT: Succinct options for Moose

use strict;
use warnings;

use Moose::Util;
use Class::Load;
use String::RewritePrefix;
use MooseX::Role::OptionShortcuts;

sub import
{
    my $class  = shift;
    my $caller = caller;

    $class->import_into($caller, @_);
}

sub import_into
{
    my $class = shift;
    my $into  = shift;

    # expand import arguments to full class names
    my @handler_classes = String::RewritePrefix->rewrite(
        { '' => 'MooseX::Has::Options::Handler::', '+' => '' }, 
        'Accessors', @_
    ); 

    # require each class and get its handlers
    my %handlers = map {
        Class::Load::load_class($_);
        $_->handles;
    } @handler_classes;

    # create a parameterized role
    my $metarole = MooseX::Role::OptionShortcuts->meta->generate_role(
        parameters => { handlers => \%handlers },
    );

    # apply that role it to the caller's attribute metaclass
    Moose::Util::MetaRole::apply_metaroles( for => $into, class_metaroles => {
        attribute => [$metarole->name],
    });
}

1;

=pod

=head1 SYNOPSIS

    use Moose;
    use MooseX::Has::Options;

    has 'some_attribute' => (
        qw(:ro :required),
        isa => 'Str',
        ...
    );

    has 'another_attribute' => (
        qw(:ro :lazy_build),
        isa => 'Str',
        ...
    );

=head1 DESCRIPTION

This module provides a succinct syntax for declaring options for L<Moose> attributes. It hijacks the C<has> function imported by L<Moose> and replaces it with one that understands the options syntax described above.

=head1 USAGE

=head2 Declaring options

MooseX::Has::Params works by checking the arguments to C<has> for strings that look like options, i.e. alphanumeric strings preceded by a colon, and replaces them with a hash whose keys are the names of the options (sans the colon) and the values are C<1>'s. Thus,

    has 'some_attribute', ':required';

becomes:

    has 'some_attribute', required => 1;

The options C<ro>, C<rw> and C<bare> are treated differently:

    has 'some_attribute', ':ro';

becomes:

    has 'some_attribute', is => 'ro';

Options must come in the beginning of the argument list. MooseX::Has::Options will stop searching for options after the first alphanumeric string that does not start with a colon.

=head2 Importing

MooseX::Has::Params hooks into a C<has> function that already exists in your module's namespace. Therefore it must be imported after L<Moose>. A side effect of this is that it will work with any module that provides a C<has> function, e.g. L<Mouse>.

If you specify arguments when importing MooseX::Has::Params, it will hook to these functions instead. Use this to change the behavior of functions that provide a syntax similar to L<Moose> attributes:

    use HTML::FormHandler::Moose;
    use MooseX::Has::Options qw(has_field);

    has_field 'name' => (
        qw(:required),
        type => 'Text',
    );

The special treatment of C<ro>, C<rw> and C<bare> will be disabled for such functions.

=head1 SEE ALSO

=for :list
* L<MooseX::Has::Sugar>

=cut
