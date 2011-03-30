package MooseX::Has::Options;

use strict;
use warnings;

use Package::Stash ();
use Carp           ();

sub import
{
	my ($class, @keywords) = @_;
	@keywords = 'has' unless @keywords;
	my $stash = Package::Stash->new(scalar caller());

	foreach my $keyword (@keywords)
	{
		if ($stash->has_symbol("&$keyword"))
		{
			my $orig = $stash->get_symbol("&$keyword");
			$stash->add_symbol("&$keyword", sub { $orig->(_expand_options($keyword, @_)) });
		}
		else
		{
            Carp::carp "Cannot add options for $keyword, no subroutine found in caller package";
		}
	}
}

sub _expand_options
{
	my $keyword = shift;
    my $name = shift;

	my %expanded;

	foreach my $option (@_)
	{
		if ( $keyword eq 'has' and $option =~ /^:(ro|rw|bare)$/ )
		{
			$expanded{is} = $1;
		}
		elsif ( $option =~ /^:(\w+)$/ )
		{
			$expanded{$1} = 1;
		}
		else
		{
			last;
		}
	}
	
	splice @_, 0, scalar keys %expanded;

	return $name, @_, %expanded;
}

1;
