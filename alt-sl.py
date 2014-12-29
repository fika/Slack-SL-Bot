#!/usr/bin/python
# -*- coding: utf-8 -*-

#Import!
import xml.etree.cElementTree as ElementTree
import urllib
import urllib2
import sys

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
uppslag_sites = uppslag_document.find('ResponseData/Site') # http://api.sl.se/api2/typeahead.xml?key=8c9bf84d3f3746eab8568891dafe74f8&searchstring=slussen&stationsonly=True&maxresults=3
for Site in uppslag_sites:
        if Site.tag == 'SiteId':
                siteid = Site.text

#New vars!
realtid_data = {}
realtid_data['key'] = '9e99975c83864b6f8dab6ab4baddaba8'
realtid_data['siteid'] = siteid
realtid_data['timewindow'] = 15
realtid_url_values = urllib.urlencode(realtid_data)
realtid_url = 'http://api.sl.se/api2/realtimedepartures.xml'
realtid_full_url = realtid_url + '?' + realtid_url_values
realtid_data = urllib2.urlopen(realtid_full_url) #Ladda ner XML-dokumentet
realtid_document = ElementTree.parse(realtid_data) #Här stoppar vi in XML-dokumentet efter parse i realtid_document
realtid_buses = realtid_document.find('ResponseData/Buses/Bus') # DEN HÄR VARIABLEN BLIR "None", måste fixas!! # Vi letar igenom realtid_document efter ReponseData/Buses/Bus (se http://api.sl.se/api2/realtimedepartures.xml?timewindow=15&siteid=1142&key=9e99975c83864b6f8dab6ab4baddaba8 för att förstå bättre), och lägger i variabel.
for Bus in realtid_buses:
        if Bus.tag == 'LineNumber':
                linenumber = Bus.text
        elif Bus.tag == 'Destination':
                destination = Bus.text
        elif Bus.tag == 'StopAreaName':
                stopareaname = Bus.text
        elif Bus.tag == 'DisplayTime':
                if 'Nu' in Bus.text:
                        displaytime = 'nu'
                elif ':' in Bus.text:
                        displaytime = Bus.text
                elif 'min' in Bus.text:
                        displaytime = 'om ' + Bus.text

        print 'Buss ' + linenumber + ' från ' + stopareaname + ' mot ' + destination + ' avgår ' + displaytime
