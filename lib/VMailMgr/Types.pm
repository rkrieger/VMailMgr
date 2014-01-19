package VMailMgr::Types;

# $Id$

use strict;
use warnings;
use namespace::autoclean;

# VERSION

use Moose::Util::TypeConstraints;
use MooseX::Types::Moose qw( ArrayRef  );
use Sub::Install;

use base 'MooseX::Types::Combine';

__PACKAGE__->provide_types_from(
    qw(
      MooseX::Types::Common::Numeric
      MooseX::Types::Common::String
      MooseX::Types::Moose
      MooseX::Types::Path::Class
      VMailMgr::Types::Internal
      )
);

1;

# ABSTRACT: VMailMgr types library

__END__

=pod

=encoding UTF-8

=head1 NAME

VMailMgr::Types - Moose type library for VMailMgr

=head1 SYNOPSIS

 use VMailMgr::Types qw( EmailAddress );

=head1 SEE ALSO

For more information regarding Moose type definitions, please see the documentation
included with L<Moose::Util::TypeConstraints> and L<MooseX::Types::Common>.

=cut
