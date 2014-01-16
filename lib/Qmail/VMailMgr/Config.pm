package Qmail::VMailMgr::Config;
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


{
    my $Instance;

    sub instance {
	return $Instance ||= shift->new(@_);
    }

    sub _clear_instance {
	undef $Instance;
    }
}
 

1;