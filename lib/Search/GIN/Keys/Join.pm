use strict;
use warnings;
package Search::GIN::Keys::Join;
BEGIN {
  $Search::GIN::Keys::Join::AUTHORITY = 'cpan:NUFFIN';
}
# ABSTRACT:
$Search::GIN::Keys::Join::VERSION = '0.09';
use Moose::Role;

sub join_keys {
    my ( $self, @keys ) = @_;
    map { $self->join_key($_) } @keys;
}

sub join_key {
    my ( $self, @key ) = @_;
    no warnings 'uninitialized';
    join ":", map { ref($_) ? @$_ : $_ } @key;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Search::GIN::Keys::Join - $Search::GIN::Keys::Join::VERSION = '0.09';

=head1 VERSION

version 0.09

=head1 AUTHOR

יובל קוג'מן (Yuval Kogman) <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by יובל קוג'מן (Yuval Kogman), Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
