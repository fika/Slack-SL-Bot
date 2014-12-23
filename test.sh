#!/bin/bash
echo "" > /var/log/apache2/error.log
OLDCOUNT=0
dmy=$(date "+%a %b %d")
while :
do
        NEWS=$(grep -P '\[\K[^\]]+' /var/log/apache2/error.log | grep "$dmy" | grep info | grep TxoLNNB1IIM7i3R2N2IghTtr)
        COUNT=$(echo "$NEWS" | wc -l)
        DIFF=$((COUNT-OLDCOUNT))
        if [ $DIFF -gt 0 ]
        then
                traveltype=$(echo "$NEWS" | grep -oP '\&trigger_word=[^&]+' | grep -oP "\%21.*" | sed -e 's/%21//' | tail -n $DIFF)
                if [ "$traveltype" = "buss" ]
                then
                        siteid=$(/root/uppslag.pl $(echo "$NEWS" | grep -oP '\&text=[^&]+' | grep -oP "\+.*" | sed -e 's/+//' | tail -n $DIFF))
                        output=$(/root/buss.pl $siteid)
                        /root/post.sh $output
                else
                        siteid=$(/root/uppslag.pl $(echo "$NEWS" | grep -oP '\&text=[^&]+' | grep -oP "\+.*" | sed -e 's/+//' | tail -n $DIFF))
                        output=$(/root/tåg.pl $siteid)
                        /root/post.sh $output
                fi
        fi
        OLDCOUNT=$COUNT
done
