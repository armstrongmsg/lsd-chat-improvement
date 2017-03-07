#!/bin/bash

auth_token=$1
user_id=$2
host="$3"
port="$4"

timestamp=`date +%s`

groups_list=`curl -s -S http://$host:$port/api/v1/groups.list -H "X-Auth-Token: $auth_token" -H "X-User-Id: $user_id"`

number_of_groups=`echo $groups_list | jq -r '.count'`
messages=0

# format -> timestamp,group,messages

for i in `seq 0 $(( $number_of_groups - 1 ))`
do
        messages_in_group=`echo $groups_list | jq -r ".groups[$i].msgs"`
        group_name=`echo $groups_list | jq -r ".groups[$i].name"`
        echo "$timestamp,$group_name,$messages_in_group"
        messages=$(( $messages + $messages_in_group ))
done

echo "$timestamp,total,$messages"


