#!perl -T
use 5.008;
use strict;
use warnings FATAL => 'all';
use Test::More;

plan tests => 1;

BEGIN {
    use_ok( 'Qmail::VMailMgr' ) || print "Bail out!\n";
}

diag( "Testing Qmail::VMailMgr $Qmail::VMailMgr::VERSION, Perl $], $^X" );
