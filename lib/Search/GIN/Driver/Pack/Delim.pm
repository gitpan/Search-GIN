use strict;
use warnings;
package Search::GIN::Driver::Pack::Delim;
BEGIN {
  $Search::GIN::Driver::Pack::Delim::AUTHORITY = 'cpan:NUFFIN';
}
# ABSTRACT:
$Search::GIN::Driver::Pack::Delim::VERSION = '0.09';
use Moose::Role;

use namespace::clean -except => [qw(meta)];

sub pack_delim {
    my ( $self, @strings ) = @_;
    join("\0", @strings );
}

sub unpack_delim {
    my ( $self, $string ) = @_;
    split("\0", $string );
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Search::GIN::Driver::Pack::Delim - $Search::GIN::Driver::Pack::Delim::VERSION = '0.09';

=head1 VERSION

version 0.09

=head1 AUTHOR

יובל קוג'מן (Yuval Kogman) <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by יובל קוג'מן (Yuval Kogman), Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
