use strict;
use warnings;
use autodie;

use Test::Fatal;
use Test::More;

use VMailMgr::Types ':all';

$ENV{HARNESS_ACTIVE}          = 0;


# Module usage
BEGIN
{
    use_ok('VMailMgr::Types');
}
require_ok('VMailMgr::Types');


# Address validation
{
# Don't bother sending e-mail to these addresses (or do so at your own peril)
    my $invalid = 'hostmaster@invalid';
    my $valid   = 'rattenvanger@bytepark.nl';
    my $dirty   = 'Ik wil aandacht < aandachttekort @bytepark.nl>';
    my $clean   = 'aandachttekort@bytepark.nl';

    ok( !is_EmailAddress($invalid), 'rejects invalid e-mail address' );
    ok( is_EmailAddress($valid),    'accepts valid e-mail address' );

    #    is( is_EmailAddress($dirty), $clean,
    #        'cleans up a valid e-mail address' );
}


# Localpart validation
{
    my $valid   = 'hostmaster';
    my $invalid = 'hostmaster@example.com'; # address, *not* a localpart
    my $dirty   = ' aandachttekort ';
    ( my $clean = $dirty ) =~ s{\s}{}g;

    ok( is_EmailLocalpart($valid),    'accepts valid localpart' );
    ok( !is_EmailLocalpart($invalid), 'rejects address as localpart' );

    #    is( is_EmailLocalpart($dirty),
    #        $clean, 'cleans up a valid localpart' );

}


# rejects invalid localpart
# rejects e-mail address as localpart
# cleans up valid localpart

# Type exportability
ok(
    EmailAddress->isa('Moose::Meta::TypeConstraint'),
    "EmailAddress type is available as an import"
);
ok(
    EmailLocalpart->isa('Moose::Meta::TypeConstraint'),
    "EmailLocalpart type is available as an import"
);

done_testing();

