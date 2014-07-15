use strict;
use warnings;
package Search::GIN::Query;
BEGIN {
  $Search::GIN::Query::AUTHORITY = 'cpan:NUFFIN';
}
# ABSTRACT:
$Search::GIN::Query::VERSION = '0.09';
use Moose::Role;
use namespace::clean -except => [qw(meta)];

requires qw(
    consistent
    extract_values
);

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Search::GIN::Query - $Search::GIN::Query::VERSION = '0.09';

=head1 VERSION

version 0.09

=head1 SYNOPSIS

    use Search::GIN::Query;

=head1 DESCRIPTION

=head1 AUTHOR

יובל קוג'מן (Yuval Kogman) <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by יובל קוג'מן (Yuval Kogman), Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
