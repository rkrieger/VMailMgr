use strict;
use warnings;

use Test::Fatal;
use Test::More;

use VMailMgr::Util qw( string_is_empty );

$ENV{HARNESS_ACTIVE} = 0;

# Module usage
BEGIN
{
    use_ok('VMailMgr::Util');
}
require_ok('VMailMgr::Util');

# string_is_empty
is( string_is_empty(undef), 1, 'undef yields true' );
is( string_is_empty(q{}),   1, 'empty string yields true' );
is( string_is_empty( q{What?}, 0, 'non-empty string yields false' ) )
  ;

done_testing();
