use strict;
use warnings;
package Search::GIN::Driver::Hash;
BEGIN {
  $Search::GIN::Driver::Hash::AUTHORITY = 'cpan:NUFFIN';
}
# ABSTRACT:
$Search::GIN::Driver::Hash::VERSION = '0.09';
use Moose::Role;

use Set::Object;

use Data::Stream::Bulk::Util qw(bulk);
use Scalar::Util qw(refaddr);

use namespace::clean -except => [qw(meta)];

with qw(Search::GIN::Driver);

has values => (
    isa => "HashRef",
    is  => "ro",
    default => sub { {} },
);

has objects => (
    isa => "HashRef",
    is  => "ro",
    default => sub { {} },
);

sub clear {
    my $self = shift;

    %{ $self->values } = ();
    %{ $self->objects } = ();

    return;
}

sub fetch_entry {
    my ( $self, $key ) = @_;

    if ( my $set = $self->values->{$key} ) {
        return bulk($set->members);
    } else {
        return;
    }
}

sub remove_ids {
    my ( $self, @ids ) = @_;

    my $values  = $self->values;
    my $objects = $self->objects;

    my @key_sets = grep { defined } delete @{$objects}{map { ref() ? refaddr($_) : $_ } @ids};
    return unless @key_sets;
    my $keys = (shift @key_sets)->union(@key_sets);

    foreach my $key ( $keys->members ) {
        my $set = $values->{$key};
        $set->remove(@ids);
        delete $values->{$key} if $set->size == 0;
    }
}

sub insert_entry {
    my ( $self, $id, @keys ) = @_;

    my $values  = $self->values;
    my $objects = $self->objects;

    $self->remove_ids($id);

    my $set = $objects->{ref($id) ? refaddr($id) : $id} = Set::Object->new;

    $set->insert(@keys);

    foreach my $id_set (@{$values}{@keys}) {
        $id_set ||= Set::Object->new;
        $id_set->insert($id);
    }
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Search::GIN::Driver::Hash - $Search::GIN::Driver::Hash::VERSION = '0.09';

=head1 VERSION

version 0.09

=head1 AUTHOR

יובל קוג'מן (Yuval Kogman) <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by יובל קוג'מן (Yuval Kogman), Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
