use strict;
use warnings;
package Search::GIN::Extract::Attributes;
BEGIN {
  $Search::GIN::Extract::Attributes::AUTHORITY = 'cpan:NUFFIN';
}
# ABSTRACT:
$Search::GIN::Extract::Attributes::VERSION = '0.09';
use Moose;
use namespace::clean -except => 'meta';

with qw(
    Search::GIN::Extract
    Search::GIN::Keys::Deep
);

has attributes => (
    isa => "ArrayRef[Str]",
    is  => "rw",
    predicate => "has_attributes",
);

sub extract_values {
    my ( $self, $obj, @args ) = @_;

    my @meta_attrs = $self->get_meta_attrs($obj, @args);

    return $self->process_keys({ map {
                                    my $val = $_->get_value($obj);
                                    $_->name => (defined($val) ? $val : undef);
                                } @meta_attrs });
}

sub get_meta_attrs {
    my ( $self, $obj, @args ) = @_;

    my $class = ref $obj;
    my $meta = Class::MOP::get_metaclass_by_name($class);

    if ( $self->has_attributes ) {
        return grep { defined } map { $meta->find_attribute_by_name($_) } @{ $self->attributes };
    } else {
        return $meta->get_all_attributes;
    }
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Search::GIN::Extract::Attributes - $Search::GIN::Extract::Attributes::VERSION = '0.09';

=head1 VERSION

version 0.09

=head1 SYNOPSIS

    use Search::GIN::Extract::Attributes;

=head1 DESCRIPTION

=head1 AUTHOR

יובל קוג'מן (Yuval Kogman) <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by יובל קוג'מן (Yuval Kogman), Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
