#!/bin/sh

# Example notifier script -- lowers screen brightness, then waits to be killed
# and restores previous brightness on exit.

## CONFIGURATION ##############################################################

# Brightness will be lowered to this value.
min_brightness=10

# Time to change brightness (in microseconds).
fade_time=150000

###############################################################################

fade() {
  brillo -u "$fade_time" -S "$1"
}

# Commands to run before screen dim
old_brightness=$(brillo | cut -d'.' -f1)
echo pause >/tmp/signal_bar
fade $min_brightness

# Sunglasses time
xinput test-xi2 --root |
  while read -r event; do
    case "$event" in
    *EVENT*)
      break
      ;;
    esac
  done

# Commands to run after resuming
pgrep -x xsecurelock && pkill -x -USR2 xsecurelock
fade "$old_brightness"
echo resume >/tmp/signal_bar
