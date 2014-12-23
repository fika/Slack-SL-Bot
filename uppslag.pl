#!/usr/bin/perl -w

# use module
use XML::Simple;
use Data::Dumper;
use LWP::Simple;
use URI;

#ASK QUESTIONS
$searchstring = $ARGV[0];
#2-50
$maxresults = "2";
$stations = "True";
@siteids = qw();

my $parser      = new XML::Simple;
my $url         = URI->new( 'http://api.sl.se/api2/typeahead.xml?' );
$url->query_form(
        'key'           => '8c9bf84d3f3746eab8568891dafe74f8',
        'searchstring'  => $searchstring,
        'stationsonly'  => $stations,
        'maxresults'    => $maxresults,
);
my $file        = "sl.xml";

#get response
my $response    = getstore($url, $file);
my $doc         = $parser->XMLin($file);

# read XML file
#/ResponseOfDepartures/ResponseData/Buses/Bus/"buss från"..StopAreaName.."Till"..Destination.."Avgår"..DisplayTime
foreach $e (@{$doc->{ResponseData}->{Site}})
{
#               print $e->{SiteId}, "\n";
                push (@siteids, $e->{SiteId});

}
                print $siteids[0], "\n";

