#!/bin/bash

# Warp mouse to center of focused window
winfo=$(xwininfo -id $(xdo id))
width=$(echo "$winfo" | awk 'NR==8 {print int($2/2)}')
height=$(echo "$winfo" | awk 'NR==9 {print int($2/2)}')
x=$(echo "$winfo" | awk 'NR==4 {print $4}')
y=$(echo "$winfo" | awk 'NR==5 {print $4}')
if [ "$width" -gt 0 ]; then
  xdo pointer_motion -x $((width + x)) -y $((height + y))
else
  #move pointer to center of screen if we're not focusing a window
  # TODO: Need to actually test this in mutli monitor setup
  mon_geom=$(xrandr --current | awk '/ connected primary/ {print $4}')
  x_width=${mon_geom%x*}
  y_height=${mon_geom#*x}
  y_height=${y_height%%+*}
  xdo pointer_motion -x $((x_width / 2)) -y $((y_height / 2))
fi
