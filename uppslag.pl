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
        'key'           => '<API-KEY>',
        'searchstring'  => $searchstring,
        'stationsonly'  => $stations,
        'maxresults'    => $maxresults,
);
my $file        = "sl.xml";

#get response
my $response    = getstore($url, $file);
my $doc         = $parser->XMLin($file);

# read XML file
foreach $e (@{$doc->{ResponseData}->{Site}})
{
                push (@siteids, $e->{SiteId});

}
                print $siteids[0], "\n";

