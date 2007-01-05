#!/usr/bin/perl -w

=head1 NAME

satellite-get-tle.pl - Application to retrive TLE data with Astro::SpaceTrack package

=cut

use strict;
use Astro::SpaceTrack;

=head1 SYNOPSIS

=head2 SYNTAX

./satellite-get-tle.pl login password [data_set_name]

=head2 EXAMPLES

  ./satellite-get-tle.pl login password navstar

  ./satellite-get-tle.pl login password inmarsat

  ./satellite-get-tle.pl login password artemis

  ./satellite-get-tle.pl login password galaxy

  ./satellite-get-tle.pl login password mtsat

=head2 ACCOUNT

Obtain and account at http://www.space-track.org/

=head2 ALTERNATIVE

http://celestrak.com/NORAD/elements/gps-ops.txt

=cut

sub usage {
  die("Syntax: $0 login password [data_set_name]\n");
}


my $account=shift() || usage();
my $passwd=shift() || usage();
my $name=shift()||'navstar';

my $st = Astro::SpaceTrack->new(username=>$account,
                                password=>$passwd,
                                with_name=>1) or die();
my $rslt = $st->search_name($name);
print $rslt->is_success ? $rslt->content : $rslt->status_line;
