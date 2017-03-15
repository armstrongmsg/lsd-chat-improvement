#!/bin/bash

auth_token=$1
user_id=$2
host="$3"

channels_list=`curl -s -S https://$host/api/v1/channels.list -H "X-Auth-Token: $auth_token" -H "X-User-Id: $user_id" `
number_of_channels=`echo $channels_list | jq -r '.count'`
messages=0

timestamp=`date +%s`

# format -> timestamp,channel,messages

for i in `seq 0 $(( $number_of_channels - 1 ))`
do
        messages_in_channel=`echo $channels_list | jq -r ".channels[$i].msgs"`
        channel_name=`echo $channels_list | jq -r ".channels[$i].name"`
        echo "$timestamp,$channel_name,$messages_in_channel"
        messages=$(( $messages + $messages_in_channel ))
done

echo "$timestamp,total,$messages"
