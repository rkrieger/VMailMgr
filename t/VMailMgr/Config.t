use strict;
use warnings;

use Test::Fatal;
use Test::More;

use autodie;
use Cwd qw( abs_path );
use File::Basename qw( dirname );
use File::Slurp qw( read_file );
use File::Temp qw( tempdir );
use Path::Class qw( dir file );
use VMailMgr::Config;

my $dir = tempdir( CLEANUP => 1 );

$ENV{HARNESS_ACTIVE}          = 0;
$ENV{VMAILMGR_CONFIG_TESTING} = 1;

{
    my $config = VMailMgr::Config->new();

    is_deeply( $config->_raw_config(),
        {}, 'config hash is empty by default' );
}

done_testing();
