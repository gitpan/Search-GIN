use strict;
use warnings;
package Search::GIN::Driver;
BEGIN {
  $Search::GIN::Driver::AUTHORITY = 'cpan:NUFFIN';
}
# ABSTRACT:
$Search::GIN::Driver::VERSION = '0.09';
use Moose::Role;

use Data::Stream::Bulk::Util qw(bulk nil cat unique);

use namespace::clean -except => [qw(meta)];

requires qw(
    insert_entry
    remove_ids
    fetch_entry
);

sub fetch_entry_streams {
    my ( $self, %args ) = @_;
    map { $self->fetch_entry($_) } @{ $args{values} };
}

sub fetch_entries {
    my ( $self, %args ) = @_;

    my $method = "fetch_entries_" . ( $args{method} || "any" );

    $self->$method(%args);
}

sub fetch_entries_any {
    my ( $self, @args ) = @_;

    my @streams = $self->fetch_entry_streams(@args);

    return nil unless @streams;

    my $res = cat(splice @streams); # splice disposes of @streams ASAP, keeping memory utilization down

    if ( $res->loaded ) {
        # if all results are already ready, we can uniqify them to avoid
        # duplicate calls to ->consistent
        return unique($res);
    } else {
        return $res;
    }
}

sub fetch_entries_all {
    my ( $self, @args ) = @_;

    my @streams = $self->fetch_entry_streams(@args);

    return nil unless @streams;
    return $streams[0] if @streams == 1;

    foreach my $stream ( @streams ) {
        return cat(splice @streams) unless $stream->loaded;
    }

    # if we made it to here then we have a > 1 list of fully realized streams
    # we can compute the intersection of the IDs to avoid unnecessary calls to
    # ->consistent

    # If all streams are known to be sorted this method could be overridden to
    # use merge sorting

    my $last = shift @streams;
    my $n = scalar @streams;

    # compute intersection
    my %seen;
    foreach my $stream ( splice @streams ) {
        ++$seen{$_} for $stream->all;
    }

    no warnings 'uninitialized'; # == with undef
    return bulk( grep { $seen{$_} == $n } $last->all );
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Search::GIN::Driver - $Search::GIN::Driver::VERSION = '0.09';

=head1 VERSION

version 0.09

=head1 SYNOPSIS

    use Search::GIN::Driver;

=head1 DESCRIPTION

=head1 AUTHOR

יובל קוג'מן (Yuval Kogman) <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by יובל קוג'מן (Yuval Kogman), Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
