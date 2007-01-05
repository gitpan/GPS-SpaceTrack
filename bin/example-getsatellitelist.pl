#!/usr/bin/perl -w

=head1 NAME

example-getsatellitelist.pl - GPS::SpaceTrack getsatellitelist method example

=cut

use strict;
use lib qw{./lib ../lib};
use GPS::SpaceTrack;

my $lat=shift()||38.870997;    #degrees
my $lon=shift()||-77.05596;    #degrees
my $hae=shift()||13;           #meters

my $filename="";
$filename="../doc/gps.tle" if -r "../doc/gps.tle";
$filename="./doc/gps.tle" if -r "./doc/gps.tle";

my $obj=GPS::SpaceTrack->new(filename=>$filename) || die();

my $i=0;
print join("\t", qw{Count PRN ELEV Azim SNR USED}), "\n";
foreach ($obj->getsatellitelist({lat=>$lat, lon=>$lon, alt=>$hae})) {
  print join "\t", ++$i,
                   $_->prn,
                   $_->elev,
                   $_->azim,
                   $_->snr,
                   $_->used;
  print "\n";
}
