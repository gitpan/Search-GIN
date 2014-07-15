use strict;
use warnings;
package Search::GIN::Driver::Pack::UUID;
BEGIN {
  $Search::GIN::Driver::Pack::UUID::AUTHORITY = 'cpan:NUFFIN';
}
# ABSTRACT: UUID key packing
$Search::GIN::Driver::Pack::UUID::VERSION = '0.09';
use Moose::Role;

use namespace::clean -except => [qw(meta)];

with qw(Search::GIN::Driver);

sub unpack_ids {
    my ( $self, $str ) = @_;
    unpack("(a16)*", $str);
}

sub pack_ids {
    my ( $self, @ids ) = @_;
    pack("(a16)*", @ids); # FIXME enforce size
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Search::GIN::Driver::Pack::UUID - UUID key packing

=head1 VERSION

version 0.09

=head1 SYNOPSIS

    use Search::GIN::Driver::PackUUID;

=head1 DESCRIPTION

=head1 AUTHOR

יובל קוג'מן (Yuval Kogman) <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by יובל קוג'מן (Yuval Kogman), Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
