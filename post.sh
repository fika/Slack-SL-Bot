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
curl -s -d "payload=$json" "https://hooks.slack.com/services/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"
