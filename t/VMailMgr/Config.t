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

# Configuration creation
{
    my $config = VMailMgr::Config->new();

    is_deeply( $config->_raw_config(),
        {}, 'Config hash is empty by default' );
    is( $config->is_production, 0,
        'Configuration defaults is_production to zero value (false).' );
}

# Reading config files
{
    my $dir = tempdir( CLEANUP => 1 );
    my $file = "$dir/vmailmgr.ini";
    open my $fh, '>', $file;
    print {$fh} <<'EOF';
[vmailmgr]
vaddalias = /usr/local/bin/vaddalias
EOF
    close $fh;

    {
        local $ENV{VMAILMGR_CONFIG} = $file;

        my $config = VMailMgr::Config->new();

        is_deeply(
            $config->_raw_config(),
            {
                vmailmgr => { vaddalias => '/usr/local/bin/vaddalias' },
            },
            'config hash uses data from file in VMAILMGR_CONFIG'
        );
    }
}

# VMailMgr applications
{
    my $config_test = VMailMgr::Config->new();
    my $config_prod = VMailMgr::Config->new( is_production => 1 );

    my @utilities =
      qw{ vaddalias vadduser vchattr vchforwards vdeluser vpasswd };
    foreach my $item (@utilities)
    {
        local $ENV{PATH} = q{};    # Ensure we find nothing in path
        is( $config_test->$item, $item,
            "Substitute '$item' for $item utility if not found in development"
        );

        like(
            exception { $config_prod->$item; },
            qr/does not pass the type constraint because: Must not be empty/,
            "Production environment insists on finding $item utility in PATH"
          )
    } ## end foreach my $item (@utilities...)
}

done_testing();
