#!/usr/bin/perl -w

# use module
use XML::Simple;
use Data::Dumper;
use LWP::Simple;
use URI;

# create object
my $parser      = new XML::Simple;
my $url         = URI->new( 'http://api.sl.se/api2/realtimedepartures.xml?' );
$url->query_form(
        'key'           => '<API-KEY>',
        'siteid'        => $ARGV[0],
        'timewindow'    => '30',
);
my $file        = "sl3.xml";

#get response
my $response    = getstore($url, $file);
$edit = `sed -i 's/å/a/g' $file`;
$edit = `sed -i 's/ä/a/g' $file`;
$edit = `sed -i 's/ö/o/g' $file`;
$edit = `sed -i 's/Å/A/g' $file`;
$edit = `sed -i 's/Ä/A/g' $file`;
$edit = `sed -i 's/Ö/O/g' $file`;
my $doc         = $parser->XMLin($file, ForceArray=>['Train']);

# read XML file
foreach $e (@{$doc->{ResponseData}->{Trains}->{Train}})
{
                print "Pendeltåg ", $e->{LineNumber}, " från ", $e->{StopAreaName}, " mot ", $e->{Destination};

                print " avgår ";

                if ($e->{DisplayTime} eq 'Nu') {
                        print "nu.";
                }

                elsif ($e->{DisplayTime} =~ 'min') {
                        print "om ", $e->{DisplayTime}, ".";
                }

                elsif ($e->{DisplayTime} =~ ':') {
                        print $e->{DisplayTime}, ".";
                }



}
