#!/bin/bash

auth_token=$1
user_id=$2
host="$3"

timestamp=`date +%s`

users_list=`curl -s -S https://$host/api/v1/users.list -H "X-Auth-Token: $auth_token" -H "X-User-Id: $user_id" `

number_of_users=`echo $users_list | jq -r '.count'`
number_of_online_users=0
number_of_offline_users=0
number_of_away_users=0
number_of_bots=0

for i in `seq 0 $(( $number_of_users - 1 ))`
do
        user_type=`echo $users_list | jq -r ".users[$i].type"`
        user_status=`echo $users_list | jq -r ".users[$i].status"`

        if [ $user_type = "user" ]
        then
                if [ $user_status = "online" ]
                then
                        number_of_online_users=$(( $number_of_online_users + 1 ))
                fi

                if [ $user_status = "offline" ]
                then
                        number_of_offline_users=$(( $number_of_offline_users + 1 ))
                fi

                if [ $user_status = "away" ]
                then
                        number_of_away_users=$(( $number_of_away_users + 1 ))
                fi
        fi

        if [ $user_type = "bot" ]
        then
                number_of_bots=$(( $number_of_bots + 1 ))
        fi
done

# format -> timestamp,status,count
echo "$timestamp,online,$number_of_online_users"
echo "$timestamp,offline,$number_of_offline_users"
echo "$timestamp,away,$number_of_away_users"
echo "$timestamp,bots,$number_of_bots"
echo "$timestamp,total,$number_of_users"
