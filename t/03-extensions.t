use strict;
use warnings;

use Test::Most;

do {
    package TestOptions;

    use Moose;
    use MooseX::Has::Options qw(NativeTypes NoInit);
    use namespace::autoclean;

    has 'no_init_attribute' => qw(:ro :lazy_build :no_init);

    has 'arrayref_attribute' => qw(:ro :required :array),
        handles => { 
            add_to_arrayref   => 'push',
            arrayref_elements => 'elements',
        };

    has 'attribute_with_overriden_type' => qw(:rw :hash),
        isa => 'HashRef[Int]';

    has 'attribute_with_overriden_default' => qw(:ro :string),
        default => 'foo';

    has 'attribute_with_overriden_builder' => qw(:ro :string),
        lazy_build => 1;

    sub _build_attribute_with_overriden_builder { 'bar' }
};

ok 1;

done_testing();
