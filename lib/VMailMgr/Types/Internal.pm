package VMailMgr::Types::Internal;

# $Id$

use strict;
use warnings;

# VERSION

use Email::Valid;
use List::AllUtils qw( all );
use MooseX::Types -declare => [
    qw(
        EmailAddress
        EmailLocalpart
        )
];
use MooseX::Types::Common 0.001003;
use MooseX::Types::Common::String qw( NonEmptyStr );
use MooseX::Types::Moose qw(  Defined Str );

subtype EmailAddress,
    as Str,
    where { _check_address($_); },
    message { 'Must be a valid (non-IP, existing domain) e-mail address.'};


# XXX   We should not rely on example.com as a test domain
subtype EmailLocalpart,
    as Str,
    where { _check_address($_ . q{@example.com}); },
    message { 'Must be a valid localpart for an e-mail address.' };


# Checks done via Email::Valid, using DNS
sub _check_address {
    my $address = shift;
    my $result = Email::Valid->address(
        -address  => $address,
        -allow_ip => 0,
        -mxcheck  => 1,
        -tldcheck => 1
    );

    return if ( !defined($result) );
    return $result;
} ## end sub _check_address

1;

# ABSTRACT: VMailMgr types library

__END__

=pod

=encoding UTF-8

=head1 NAME

VMailMgr::Types::Internal - VMailMgr-specific types

=head1 SYNOPSIS

This module is not intended to be loaded separately. Please use L<VMailMgr::Types>
instead and use any of the types defined there.

 use VMailMgr::Types qw( EmailAddress );

=head1 SEE ALSO

Please see the documentation for L<VMailMgr::Types>.

=cut
