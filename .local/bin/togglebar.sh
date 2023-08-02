#!/bin/sh

map_state=$(xwininfo -id $(xdo id -N Polybar) | awk '/Map State/ {print $3}')

if [ "$map_state" = "IsViewable" ]; then
    polybar-msg cmd hide
    echo pause >/tmp/signal_bar
else
    polybar-msg cmd show
    echo resume >/tmp/signal_bar
fi
