use strict;
use warnings;
package Search::GIN::SelfIDs;
BEGIN {
  $Search::GIN::SelfIDs::AUTHORITY = 'cpan:NUFFIN';
}
# ABSTRACT:
$Search::GIN::SelfIDs::VERSION = '0.09';
use Moose::Role;
use namespace::clean -except => [qw(meta)];

sub ids_to_objects {
    my ( $self, @ids ) = @_;
    return @ids;
}

sub objects_to_ids {
    my ( $self, @objs ) = @_;
    return @objs;
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Search::GIN::SelfIDs - $Search::GIN::SelfIDs::VERSION = '0.09';

=head1 VERSION

version 0.09

=head1 SYNOPSIS

    use Search::GIN::SelfIDs;

=head1 DESCRIPTION

=head1 AUTHOR

יובל קוג'מן (Yuval Kogman) <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by יובל קוג'מן (Yuval Kogman), Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
