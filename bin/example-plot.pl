#!/usr/bin/perl -w

=head1 NAME

example-plot.pl - Plot GPS::SpaceTrack data with GD::Graph::Polar

=cut

use strict;
use lib qw{./lib ../lib};
use GPS::SpaceTrack;
use GD::Graph::Polar;
use Time::HiRes qw{time};

my $lat=shift()||39.870997;    #degrees
my $lon=shift()||-77.05596;    #degrees
my $hae=shift()||13;           #meters
my $time=time();               #seconds

my $filename="";
$filename="../doc/gps.tle" if -r "../doc/gps.tle";
$filename="./doc/gps.tle" if -r "./doc/gps.tle";

my $plot=GD::Graph::Polar->new(size=>480, radius=>90, ticks=>9);
my $obj=GPS::SpaceTrack->new(filename=>$filename) || die();

my $count=0;
foreach my $sec (0..80) {
  $sec*=400;
  $sec+=$time;
  foreach (grep {$_->elev > 0} $obj->getsatellitelist({lat=>$lat, lon=>$lon, alt=>$hae, time=>$sec})) {
    my $r=90-$_->elev;
    my $t=$_->azim;
    $plot->addGeoPoint($r=>$t);
    {
      local $|=1;
      print $count++, "\r";
    }
  }
} 
print "\nTime: ", time()-$time, " seconds\n";
open(IMG, ">example-plot.png");
print IMG $plot->draw;
close(IMG);
