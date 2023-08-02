#!/bin/bash

trap "kill 0" SIGINT SIGTERM EXIT

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
    [[ "$line" == "clear" ]] && echo "${CLR}"
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
    # Attempt to avoid duplicate notifications if they are spammed
    active="/tmp/active_notif"
    prev="/tmp/prev_notif"
    echo "$line" >$active
    # Delete previous notif record if older than 10 seconds.
    find "$prev" -not -newermt '-10 seconds' -delete
    [ -f $prev ] || touch "$prev"
    cmp -s "$active" "$prev" && continue
    mv $active $prev

    # We block the foreground until rofi is dead, if its running
    pid=$(pgrep -x rofi)
    [ -n "$pid" ] && tail --pid="$pid" -f /dev/null

    # Check if we're fullscreen; wait if we are before continuing
    if [ "$(xprop -id "$(xdo id)" _NET_WM_STATE | cut -d' ' -f3)" = "_NET_WM_STATE_FULLSCREEN" ]; then
      xprop -spy -root _NET_ACTIVE_WINDOW |
        while read -r event; do
          [ -n "$event" ] && break
        done
    fi

    # If pause signal was sent to script
    if [ -f "/tmp/notif_pause" ]; then
      # Block foreground until file gets deleted
      inotifywait -q -q /tmp/notif_pause
    fi

    # Duplicate any '%' to process them as literal '%' in polybar
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
    length=80
    wait_time=1 # Amount of time to display notif before starting scroll
    rem_time=$(echo "scale=1;$time - $wait_time" | bc -l)
    echo "$notif" | zscroll -l "$length" -t "$wait_time" -s "false" -b "$pretext" -a "..." &&
      echo "$notif" | zscroll -l "$length" -t "$rem_time" -d 0.2 -b "$pretext" -a "..."

    echo "${CLR}"
  done
