use 5.008;
use strict;
use warnings FATAL => 'all';
use Module::Build;

my $builder = Module::Build->new(
    module_name       => 'Qmail::VMailMgr',
    dist_name         => 'VMailMgr',
    license           => 'mit',
    dist_author       => q{Rogier Krieger <rkrieger@cpan.org>},
    dist_version_from => 'lib/Qmail/VMailMgr.pm',
    release_status    => 'stable',
    configure_requires => {
        'Module::Build' => 0,
    },
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'CDB_File'            => 0,
        'Config::INI::Reader' => 0,
        'File::HomeDir'       => 0,
        'Path::Class'         => 0,
        'IO::File'            => 0,
    },
    add_to_cleanup     => ['VMailMgr-*'],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
