#!/bin/bash

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

. "$HOME/.config/herbstluftwm/colorschemes/alduin.sh"
ORANGE="%{F$color11}"
CLR="%{B-}%{F-}"

# Signal fifo; not sure how to optimize this
[[ -e /tmp/signal_bar ]] && rm /tmp/signal_bar
mkfifo /tmp/signal_bar
tail -f /tmp/signal_bar |
    while read -r line; do
        [[ "$line" == "pause" ]] && touch /tmp/notif_pause
        [[ "$line" == "resume" ]] && rm /tmp/notif_pause 2>/dev/null
    done &

# Notif logic
while :; do
    # Check periodically as the fifo is created by the notification service
    [ -p /tmp/new_notifs ] && break
    sleep 1
done

[[ -e /tmp/old_notifs ]] && rm /tmp/old_notifs
mkfifo /tmp/old_notifs
{
    tail -F /tmp/new_notifs &
    tail -f /tmp/old_notifs &
} |
    while read -r line; do
        # We block the foreground until rofi is dead, if its running
        pid=$(pgrep -x rofi)
        if [ -n "$pid" ]; then
            tail --pid="$pid" -f /dev/null
        fi

        # Check if we're fullscreen; wait if we are
        if [[ "$(herbstclient attr tags.focus.focused_client.fullscreen)" == "true" ]]; then
            herbstclient --wait 'focus_changed|fullscreen' &>/dev/null
        fi

        # If pause signal was sent to script
        if [[ -f "/tmp/notif_pause" ]]; then
            # Block foreground until file gets deleted
            inotifywait -q -q /tmp/notif_pause
        fi

        # Duplicate any '%' to process them as literal '%' in lemonbar
        line=${line//%/%%}

        case "$line" in
        LOG*)
            line="${line#LOG }"
            pretext="${ORANGE} %{T5}NOTIF HISTORY:%{T-}${CLR} "
            ;;
        *)
            pretext="${ORANGE} %{T5}NOTIFICATION:%{T-}${CLR} "
            ;;
        esac
        body="$(echo -e "$line" | cut -f1 -)"
        summary="$(echo -e "$line" | cut -f2 -)"
        timeout="$(echo -e "$line" | cut -f3 -)"
        notif="$summary"

        # Determine actual timeout in secs
        if [ "$timeout" = "-1" ]; then
            time=10.0
        else
            time=$(echo "scale=1;$timeout/1000" | bc)
        fi

        # If summary is blank, display body instead
        [ -z "$notif" ] && notif="$body"

        # And finally, display the notification
        length=85
        wait_time=1 # Amount of time to display notif before starting scroll
        rem_time=$(echo "scale=1;$time - $wait_time" | bc -l)
        echo "$notif" | zscroll -l "$length" -t "$wait_time" -s "false" -b "$pretext" -a "..." &&
            echo "$notif" | zscroll -l "$length" -t "$rem_time" -d 0.2 -b "$pretext" -a "..." &
        wait $! 2>/dev/null # To suppress 'Terminated' message when signaling to skip
        
        echo "${CLR}"
    done
