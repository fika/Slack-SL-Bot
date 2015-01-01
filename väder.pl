#!/usr/bin/perl -w

# use module
use XML::Simple;
use Data::Dumper;
use LWP::Simple;
use URI;

my $parser      = new XML::Simple;
my $url         = URI->new( 'http://api.wunderground.com/api/<KEY>/conditions/lang:SW/q/PWS:ISTOCKHO170.xml?' );
my $file        = "väder.xml";

#get response
my $response    = getstore($url, $file);
my $doc         = $parser->XMLin($file, ForceArray=>['current_observation']);

# read XML file
foreach $e (@{$doc->{current_observation}})
{
                print "God morgon. Vädret är ", $e->{weather}, ", ", "med en temperatur på ", $e->{temp_c}, "C vilket känns som ~", $e->{feelslike_c}, "C. ", "Mer info: http://$
}
