use strict;
use warnings;
package Search::GIN::Indexable;
BEGIN {
  $Search::GIN::Indexable::AUTHORITY = 'cpan:NUFFIN';
}
# ABSTRACT:
$Search::GIN::Indexable::VERSION = '0.09';
use Moose::Role;

requires 'gin_extract_values';

sub gin_id {
    my $self = shift;
    return $self;
}

sub gin_compare_values {
    my ( $self, $one, $two ) = @_;
    $one cmp $two;
}

sub gin_consistent {
    my ( $self, $index, $query, @args ) = @_;
    $query->gin_consistent($index, $self, @args);
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Search::GIN::Indexable - $Search::GIN::Indexable::VERSION = '0.09';

=head1 VERSION

version 0.09

=head1 SYNOPSIS

    use Search::GIN::Indexable;

=head1 DESCRIPTION

=head1 AUTHOR

יובל קוג'מן (Yuval Kogman) <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by יובל קוג'מן (Yuval Kogman), Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
