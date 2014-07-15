use strict;
use warnings;
package Search::GIN::Extract::Class;
BEGIN {
  $Search::GIN::Extract::Class::AUTHORITY = 'cpan:NUFFIN';
}
# ABSTRACT:
$Search::GIN::Extract::Class::VERSION = '0.09';
use Moose;
use MRO::Compat;
use namespace::clean -except => 'meta';

with qw(
    Search::GIN::Extract
    Search::GIN::Keys::Deep
);

sub extract_values {
    my ( $self, $obj, @args ) = @_;

    my $class = ref $obj;

    my $isa = $class->mro::get_linear_isa();

    my $meta = Class::MOP::get_metaclass_by_name($class);
    my @roles = $meta && $meta->can("calculate_all_roles") ? ( map { $_->name } $meta->calculate_all_roles ) : ();

    return $self->process_keys({
        blessed => $class,
        class   => $isa,
        does    => \@roles,
    });
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Search::GIN::Extract::Class - $Search::GIN::Extract::Class::VERSION = '0.09';

=head1 VERSION

version 0.09

=head1 SYNOPSIS

    use Search::GIN::Extract::Class;

=head1 DESCRIPTION

=head1 AUTHOR

יובל קוג'מן (Yuval Kogman) <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by יובל קוג'מן (Yuval Kogman), Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
