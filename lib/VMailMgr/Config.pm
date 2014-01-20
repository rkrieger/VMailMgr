package VMailMgr::Config;

# $Id$

use strict;
use warnings;
use namespace::autoclean;
use autodie qw( :all );

# VERSION

use Carp;
use File::Spec;
use File::Temp qw( tempdir );
use File::Which qw( which );
use Path::Class;

use Moose;
use MooseX::Configuration;
use VMailMgr::Types qw( Bool Dir NonEmptyStr Str );
use VMailMgr::Util qw( string_is_empty );

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
            default       => sub { _vmailmgr_which( $_[0], $item ); },
            section       => 'vmailmgr',
            key           => $item,
            documentation => 'Path to the '
              . $item
              . '(1) utility of the vmailmgr(7) suite.'
        );
    } ## end foreach my $item (@utilities...)

    sub _vmailmgr_which {
        my $self = shift;
        my $name = shift;

        my $which = which($name);
        if ( !$self->is_production )
        {    # Allow missing executables outside production
            return defined($which)
              ? $which
              : $name;
        } ## end if ( !$self->is_production...)
        return $which;
    } ## end sub _vmailmgr_which

}

has _root_dir => (
    is      => 'rw',
    isa     => Dir,
    lazy    => 1,
    default => sub {
        dir(
            file( $INC{'VMailMgr/Config.pm'} )->dir()->parent()
              ->parent(),
            '.r2'
        )->absolute()->cleanup();
    },
    writer => '_set_root_dir',
);

## no critic 'ProhibitUnusedPrivateSubroutines'
sub _build_config_file {
    my $self = shift;

    if ( !string_is_empty( $ENV{VMAILMGR_CONFIG} ) )
    {
        croak
          "Nonexistent config file in VMAILMGR_CONFIG env var: $ENV{VMAILMGR_CONFIG}"
          unless -f $ENV{VMAILMGR_CONFIG};

        return file( $ENV{VMAILMGR_CONFIG} );
    } ## end if ( !string_is_empty(...))

    return if $ENV{VMAILMGR_CONFIG_TESTING};

    my @dirs = dir('/etc/vmailmgr');
    push @dirs, $self->_root_dir()->subdir('etc') if $>;

    for my $dir (@dirs)
    {
        my $file = $dir->file('vmailmgr.ini');

        return $file if -f $file;
    } ## end for my $dir (@dirs)

    return;
} ## end sub _build_config_file
## use critic

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

This module provides a number of methods for public consumption. Please note
that only these parts of the interface can be relied upon. Private methods
are subject to change without prior notice.

=head2 instance
X<instance>

Returns an instance of the configuration which can then be used to obtain
settings for consumption.

 use VMailMgr::Config;
 my $cfg = VMailMgr::Config->instance();
 
 my $dbname = $cfg->database_name;

=cut
