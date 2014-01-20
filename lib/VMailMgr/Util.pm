package VMailMgr::Util;

# $Id$

use strict;
use warnings;

# VERSION

use Exporter qw( import );

our @EXPORT_OK
    = qw( string_is_empty );

## no critic 'RequireArgUnpacking'
sub string_is_empty {
    return 1 if !defined $_[0] || !length $_[0];
    return 0;
}
## use critic

1;

# ABSTRACT: Utility functions for VMailMgr

__END__

=pod

=encoding UTF-8

=head1 NAME

VMailMgr::Util - Utility functions for VMailMgr

=head1 SYNOPSIS

 use VMailMgr::Types qw( string_is_empty );

=head1 FUNCTIONS

This module exports several utility functions, mainly intended for use by other
VMailMgr modules, but you are welcome to use them elsewhere.

=head2 string_is_empty
X<string_is_empty>

Function that returns a true value for empty or undefined strings.

 my $undef = undef;
 my $empty = q{};
 
 print string_is_empty($empty) && string_is_empty($undef)
    ? 'Yes, empty string'
    : 'No, not empty';

=cut
