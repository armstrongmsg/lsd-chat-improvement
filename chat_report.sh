#!/bin/bash

conf_file="chat.cfg"
channels_report_file="channels_report.csv"
users_report_file="users_report.csv"
groups_report_file="groups_report.csv"

source $conf_file

rocket_chat_api () {
	curl -s -S http://$host:$port/api/v1/$1 ${@:2}
}

rocket_chat_login () {
	rocket_chat_api login "-d username=$1&password=$2"
}

echo -n "Password for user $username:"
read -s password
echo

echo "----------------------------------------------"
echo "Getting auth token"
login_tokens=`rocket_chat_login $username $password`
echo "----------------------------------------------"
auth_token=`echo $login_tokens | jq -r '.data.authToken'`
user_id=`echo $login_tokens | jq -r '.data.userId'`

timestamp=`date +%s`

while :
do
	echo "Generating channels report"
	bash channels_report.sh $auth_token $user_id $host $port >> $channels_report_file
	echo "Generating users report"
	bash users_report.sh $auth_token $user_id $host $port >> $users_report_file
	echo "Generating groups report"
	bash groups_report.sh $auth_token $user_id $host $port >> $groups_report_file

	echo "Waiting for collect time"
	sleep $collect_interval
	echo "---------------------------------------------"
done
