#!/usr/bin/sh

# Terminate already running bar instances
polybar-msg cmd quit

# Wait until the processes have been shut down
pid=$(pgrep -u "$(id -u)" -x polybar)
[ -n "$pid" ] && tail --pid="$pid" -f /dev/null

for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
  MONITOR=$m polybar -q bar &
done

sleep 2
for i in $(xdo id -n polybar); do
	herbstclient lower "$i"
done

wait
