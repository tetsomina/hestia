#!/bin/sh

# Saver script for custom lock screen background with xsecurelock

# Lets do the cool, power hungry effect only when AC's plugged in
if [ "$(cat /sys/class/power_supply/AC/online)" -eq 1 ]; then
  #/usr/bin/alacritty -o window.dimensions.columns=232 \
  #  -o window.dimensions.lines=63 --embed $XSCREENSAVER_WINDOW -e fire -l100 -s25
  /usr/bin/urxvt -pe "" -geometry -1x-1 -b 0 -embed "$XSCREENSAVER_WINDOW" -e fire -l55 -s25
else
  /usr/bin/nsxiv -b -g 1920x1080+0+0 -e "$XSCREENSAVER_WINDOW" ~/Pictures/muspelheim_lockscreen.png
fi
