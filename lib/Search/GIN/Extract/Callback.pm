use strict;
use warnings;
package Search::GIN::Extract::Callback;
BEGIN {
  $Search::GIN::Extract::Callback::AUTHORITY = 'cpan:NUFFIN';
}
# ABSTRACT:
$Search::GIN::Extract::Callback::VERSION = '0.09';
use Moose;
use namespace::clean -except => 'meta';

with qw(
    Search::GIN::Extract
    Search::GIN::Keys::Deep
);

has extract => (
    isa => "CodeRef|Str",
    is  => "ro",
    required => 1,
);

sub extract_values {
    my ( $self, $obj, @args ) = @_;

    my $extract = $self->extract;

    $self->process_keys( $obj->$extract($self, @args) );
}

__PACKAGE__->meta->make_immutable;

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Search::GIN::Extract::Callback - $Search::GIN::Extract::Callback::VERSION = '0.09';

=head1 VERSION

version 0.09

=head1 SYNOPSIS

    use Search::GIN::Extract::Callback;

=head1 DESCRIPTION

=head1 AUTHOR

יובל קוג'מן (Yuval Kogman) <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by יובל קוג'מן (Yuval Kogman), Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
