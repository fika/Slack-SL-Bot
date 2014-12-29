#!/usr/bin/python
#Import!
import xml.etree.cElementTree as ET

#Vars!
__author__ = 'CosbySweater'
filepath = 'test.xml'
context = ET.iterparse(file_path, events=("start", "end"))

#Do magic stuff!
context = iter(context)
on_buses_tag = False
for event, elem in context:
    tag = elem.tag
    value = elem.text
    if value :
        value = value.encode('utf-8').strip()

    if event == 'start' :
        if tag == "Buses" :
            on_buses_tag = True

        elif tag == 'LineNumber' :
            if on_buses_tag :
                print "Buss %s" % value
            elif on_metro_tag :
            	print "Tunnelbana %s" % value
            elif on_train_tag :
            	print "Pendeltåg %s" %value
        elif tag == 'Destination' :
        		print "mot %s" % value


    if event == 'end' and tag =='members' :
        on_buses_tag = False
    elem.clear()
