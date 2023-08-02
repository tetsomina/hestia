#!/usr/bin/bash

hex_prefix=0x
hex_num=$(printf '%x' $XSCREENSAVER_WINDOW)
window_id=$hex_prefix$hex_num

#/usr/bin/alacritty -o window.dimensions.columns=232 -o window.dimensions.lines=63 --embed $XSCREENSAVER_WINDOW -e fire -l100 -s25
/usr/bin/nsxiv -b -g 1920x1080+0+0 -e $window_id /home/barbaross/Pictures/muspelheim_lockscreen.png

#/usr/bin/mpv --no-audio --no-input-terminal --no-stop-screensaver --panscan=1.0 --image-display-duration=inf --no-config --wid="$XSCREENSAVER_WINDOW" /home/barbaross/Pictures/muspelheim_lockscreen.png
