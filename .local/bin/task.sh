#!/usr/bin/env sh

ID=$(task export | jq -r 'sort_by( -.urgency )[] | [ (.id|tostring), .description ] | join("	")' | awk '!$1=="0"' |
    rofi -dmenu -i -p "Tasks" |
    cut -f 1)

[ -z "$ID" ] && exit

if echo "$ID" | grep -Eq '^[+-]?[0-9]+$'; then
    ACTION=$(printf "start\nstop\nedit\ndelete\ndone" | rofi -dmenu -i -p "Action")
    [ -z "$ACTION" ] && exit
else
    ACTION="add"
fi

task "$ID" "$ACTION"
