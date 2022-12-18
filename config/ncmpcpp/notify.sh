#!/bin/sh

status=$(playerctl status)

if [ "$status" = Playing ]; then
    info=$(playerctl metadata --format " Now Playing  {{ title }} {{ duration(mpris:length) }}  {{ artist }}  {{ album }}")
    notify-send -u low "Music" "$info"
elif [ "$status" = Paused ]; then
    formatted=$(playerctl metadata --format " Playback Paused Current Position: {{ duration(position) }}/{{ duration(mpris:length) }}")
    notify-send -u low "Music" "$formatted"
fi
