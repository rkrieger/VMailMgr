package Qmail::VMailMgr;
# $Id$

use 5.008;
use strict;
use warnings FATAL => 'all';

our $VERSION	= 0.11;

=pod

=head1 NAME

Qmail::VMailMgr - Utilify functions for C<vmailmg.plr> administration tool.

=head1 SYNOPSIS

 use Qmail::VMailMgr;

 my $cfg = Qmail::VMailMgr::Config;	# use ~/etc/vmailmgr.ini

 my (%user_for, %domain_for);
 my $vdomaindb = $cfg->{'vdomains'}->{'database'};
 my $ndomains  = getvdomains($vdomaindb, \%user_for, \%domain_for);
 my $sysuser   = $user_for{'example.com'}
 	if ($ndomains);

 my %qunit_for;
 my $qunitdb   = $cfg>{'quotaunits'}->{'database'};
 my $nqunits   = getqunits($qunitdb, \%qunit_for);
 my $unitquota = $qunit_for{'example.com'}
 	if ($nqunits);

 # Obtaining accounts through domain name
 my %accounts_for;
 my @domains   = qw{ example.com example.org };
 my $naccounts = getaccounts($vdomaindb, \@domains, \%accounts_for);
 my @aliases   = @{ $accounts_for{'example.com'}->{'users'}->
 			{'joeuser'}->{'aliases'} } # aliases for 'joeuser'
 	if ($naccounts); # assuming 'joeuser@example.com' mailbox exists

 # Obtaining accounts through system user
 my %acct;
 my $naccounts = getaccounts_user($sysuser, \%acct);
 my $pwhash    = $acct{'user'}->{'joeuser'}->{'password'}
 	if ($naccounts); # assuming 'joeuser' mailbox exists

 my $quota   = unitbytes('100M');	# 104857600 bytes
 
 # Update quota for 'joeuser' mailbox within 'example.com'
 my $result  = suexec($sysuser, "vchattr -Q $quota joeuser");
 die $res->{'message'} if (defined($res->{'message'}));

 # assume zero (shell) exitcode means success
 print $res->{'output'} unless ($res->{'exitcode'});

=cut


# version
# Returns the version number of this module. No side-effects.
sub version {
	return $VERSION;
}




=pod

=head1 AUTHOR

Rogier Krieger, C<< <rkrieger at cpan.org> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-vmailmgr at rt.cpan.org>, or
through the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=VmailMgr>.
I will be notified, and then you'll automatically be notified of progress on your
bug as I make changes.


=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Qmail::VmailMgr


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=VmailMgr>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/VmailMgr>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/VmailMgr>

=item * Search CPAN

L<http://search.cpan.org/dist/VmailMgr/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

See the C<LICENSE> file in the root of this distribution.

=cut

1; # End of Qmail::VMailMgr
