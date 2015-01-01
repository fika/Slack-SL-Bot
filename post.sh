#!/bin/bash

channel=general
text="$@"

if [[ $text == "" ]]
then
        exit 1
fi

escapedText=$(echo $text | sed 's/"/\"/g' | sed "s/'/\'/g" )
echo $escapedText > /root/text.txt
json="{\"channel\": \"#$channel\", \"username\": \"SL-Bot\", \"text\": \"$escapedText\"}"
echo ""
echo ""
echo $json >> /root/text.txt
curl -s -d "payload=$json" "<SLACK HOOK>"
