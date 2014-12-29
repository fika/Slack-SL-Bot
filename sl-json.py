#!/usr/bin/python
# -*- coding: utf-8 -*-

#Import!
import xml.etree.cElementTree as ElementTree
import urllib
import urllib2
import sys
import json

#Vars!
uppslag_data = {}
uppslag_data['key'] = '8c9bf84d3f3746eab8568891dafe74f8' #SL PLATSUPPSLAG API-NYCKEL
uppslag_data['maxresults'] = '1'
uppslag_data['searchstring'] = sys.argv[1]
uppslag_url_values = urllib.urlencode(uppslag_data)
uppslag_url = 'http://api.sl.se/api2/typeahead.xml'
uppslag_full_url = uppslag_url + '?' + uppslag_url_values
uppslag_data = urllib2.urlopen(uppslag_full_url)

uppslag_document = ElementTree.parse(uppslag_data)
uppslag_sites = uppslag_document.find('ResponseData/Site')
for Site in uppslag_sites:
        if Site.tag == 'SiteId':
                siteid = Site.text
#print siteid
#New vars!
realtid_data = {}
realtid_data['key'] = '9e99975c83864b6f8dab6ab4baddaba8'
realtid_data['siteid'] = siteid
realtid_data['timewindow'] = 15
realtid_url_values = urllib.urlencode(realtid_data)
realtid_url = 'http://api.sl.se/api2/realtimedepartures.json'
realtid_full_url = realtid_url + '?' + realtid_url_values
realtid_data = urllib2.urlopen(realtid_full_url)
realtid_string = realtid_data.read()
realtid_decoded = json.loads(realtid_string)
data = json.dumps(realtid_decoded, sort_keys=True, indent=4)
ourResult = realtid_decoded['ResponseData']['Buses']
ppourResult = json.dumps(ourResult, sort_keys=True, indent=4)

for rs in ourResult:
        looped = u'Buss ' + rs['LineNumber'] + u' från ' + rs['StopAreaName'] + ' mot ' + rs['Destination'] + u' avgår '
        if 'Nu' in rs['DisplayTime']:
                displaytime = 'nu'
        elif ':' in rs['DisplayTime']:
                displaytime = rs['DisplayTime']
        elif 'min' in rs['DisplayTime']:
                displaytime = 'om ' + rs['DisplayTime']
        output = looped + displaytime
        print output
