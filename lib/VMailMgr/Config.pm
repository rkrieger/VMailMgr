package VMailMgr::Config;
# $Id$

use strict;
use warnings;

use strict;
use warnings;
use namespace::autoclean;
use autodie qw( :all );

use File::Spec;
use File::Temp qw( tempdir );
use Path::Class;

use Moose;
use MooseX::Configuration;


=pod

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
{
    my $Instance;

    sub instance {
	return $Instance ||= shift->new(@_);
    }

    sub _clear_instance {
	undef $Instance;
    }
}
 

0;