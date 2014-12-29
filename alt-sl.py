#!/usr/bin/python
# -*- coding: utf-8 -*-

#Import!
import xml.etree.cElementTree as ElementTree
import urllib
import urllib2
import sys

#Vars!
data = {}
data['key'] = '8c9bf84d3f3746eab8568891dafe74f8'
data['maxresults'] = '1'
data['searchstring'] = sys.argv[1]
url_values = urllib.urlencode(data)
url = 'http://api.sl.se/api2/typeahead.xml'
full_url = url + '?' + url_values
data = urllib2.urlopen(full_url)

#Output
print data.read()
