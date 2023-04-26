#!/usr/bin/sh

notif_log=/tmp/notif_log
count=/tmp/notif_count

query() {
    # Set to never time out, reverse order and attempts to dedup, doesnt work great
    notifs=$(tac $notif_log | cat -n | sort -uk2 | sort -nk1 | cut -f2-)

    # delete count file if older than 15 seconds
    find "$count" -not -newermt '-15 seconds' -delete

    [ ! -f "$count" ] && echo 1 >$count

    c=$(cat $count)
    pkill zscroll
    echo "$notifs" | awk "NR==$c" >"/tmp/old_notifs" &
    c=$((c + 1))
    echo "$c" >$count
}

cleanup() {
    [ -f $count ] && rm $count
    pkill zscroll
}

case "$1" in
-c | --cleanup)
    cleanup
    ;;
-q | --query | *)
    query
    ;;
esac
