use strict;
use warnings;
package Search::GIN::Driver::TXN;
BEGIN {
  $Search::GIN::Driver::TXN::AUTHORITY = 'cpan:NUFFIN';
}
# ABSTRACT:
$Search::GIN::Driver::TXN::VERSION = '0.09';
use Moose::Role;

use Scope::Guard;

use Carp qw(croak);

use namespace::clean -except => [qw(meta)];

with qw(Search::GIN::Driver);

requires qw(txn_begin txn_commit txn_rollback);

has current_transaction => (
    isa => "Any",
    is  => "rw",
    writer => "set_current_transaction",
    predicate => "has_current_transaction",
    clearer => "clear_current_transaction",
);

sub txn_do {
    my ( $self, $coderef ) = ( shift, shift );

    ref $coderef eq 'CODE' or croak '$coderef must be a CODE reference';

    my ( $txn, $scope_guard );

    if ( $self->has_current_transaction ) {
        my $prev = $self->current_transaction;
        $txn = $self->txn_begin($prev);
        $scope_guard = Scope::Guard->new(sub { $self->set_current_transaction($prev) });
    } else {
        $txn = $self->txn_begin;
        $scope_guard = Scope::Guard->new(sub { $self->clear_current_transaction() });
    }

    my @result;
    my $want_array = wantarray;

    my $err = do {
        local $@;
        eval {
            if ( $want_array ) {
                @result = $coderef->(@_);
            } elsif( defined $want_array ) {
                $result[0] = $coderef->(@_);
            } else {
                $coderef->(@_);
            }

            $self->txn_commit($txn);

            1;
        };

        $@
    };

    if ( !$err ) {
        return $want_array ? @result : $result[0];
    } else {
        my $rollback_exception = do {
            local $@;
            eval { $self->txn_rollback($txn) };
            $@;
        };

        if ($rollback_exception) {
            croak "Transaction aborted: $err, rollback failed: $rollback_exception";
        } else {
            die $err;
        }
    }
}

1;

__END__

=pod

=encoding UTF-8

=head1 NAME

Search::GIN::Driver::TXN - $Search::GIN::Driver::TXN::VERSION = '0.09';

=head1 VERSION

version 0.09

=head1 SYNOPSIS

    use Search::GIN::Driver::TXN;

=head1 DESCRIPTION

=head1 AUTHOR

יובל קוג'מן (Yuval Kogman) <nothingmuch@woobling.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2008 by יובל קוג'מן (Yuval Kogman), Infinity Interactive.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
