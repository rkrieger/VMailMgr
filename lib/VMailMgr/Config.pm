package VMailMgr::Config;

# $Id$

use 5.008;
use strict;
use warnings;
use namespace::autoclean;
use autodie qw( :all );

# VERSION

use File::Spec;
use File::Temp qw( tempdir );
use Path::Class;

use Moose;
use MooseX::Configuration;
use VMailMgr::Types qw( Bool NonEmptyStr Str );

has is_production => (
    is      => 'rw',
    isa     => Bool,
    default => 0,
    key     => 'is_production',
    documentation =>
      'A flag indicating whether or not this is a production install. This should probably be true unless you are actively developing VMailMgr.',
    writer => '_set_is_production',
);

{
    my $Instance;

    ## no critic 'RequireArgUnpacking'
    sub instance {
        return $Instance ||= shift->new(@_);
    }
    ## use critic

    #    sub _clear_instance {
    #	undef $Instance;
    #    }
}

{
    my @utilities =
      qw{ vaddalias vadduser vchattr vchforwards vdeluser vpasswd };
    foreach my $item (@utilities)
    {
        has $item => (
            is            => 'ro',
            isa           => NonEmptyStr,
            default       => $item,
            section       => 'vmailmgr',
            key           => $item,
            documentation => 'Path to the '
              . $item
              . '(1) utility of the vmailmgr(7) suite.'
        );
    } ## end foreach my $item (@utilities...)

}

1;

# ABSTRACT: VMailMgr configuration utility

__END__

=pod

=encoding UTF-8

=head1 NAME

VMailMgr::Config - Configuration file handling for VMailMgr

=head1 SYNOPSIS

 use VMailMgr::Config;
 my $cfg = VMailMgr::Config->instance();
 
 my $dbname = $cfg->database_name;


=head1 METHODS

This module provides a number of methods.

=head2 instance
X<instance>

Returns an instance of the configuration which can then be used to obtain
settings for consumption.

 use VMailMgr::Config;
 my $cfg = VMailMgr::Config->instance();
 
 my $dbname = $cfg->database_name;

=cut
