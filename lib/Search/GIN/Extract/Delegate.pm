use strict;
use warnings;
package Search::GIN::Extract::Delegate;
BEGIN {
  $Search::GIN::Extract::Delegate::AUTHORITY = 'cpan:NUFFIN';
}
# ABSTRACT:
$Search::GIN::Extract::Delegate::VERSION = '0.09';
use Moose::Role;
use namespace::clean -except => 'meta';

has extract => (
    does => "Search::GIN::Extract",
    is   => "ro",
    required => 1,
    # handles => "Search::GIN::Extract"
);

sub extract_values { shift->extract->extract_values(@_) }

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Search::GIN::Extract::Delegate - $Search::GIN::Extract::Delegate::VERSION = '0.09';

=head1 VERSION

version 0.09

=head1 AUTHOR

יובל קוג'מן (Yuval Kogman) <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by יובל קוג'מן (Yuval Kogman), Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
