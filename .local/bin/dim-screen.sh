#!/bin/sh

# Example notifier script -- lowers screen brightness, then waits to be killed
# and restores previous brightness on exit.

## CONFIGURATION ##############################################################

# Brightness will be lowered to this value.
min_brightness=10

# If your video driver works with xbacklight, set -time and -steps for fading
# to $min_brightness here. Setting steps to 1 disables fading.
fade_steps=30

# Time to sleep (in seconds) between increments when using sysfs. If unset or
# empty, fading is disabled.
fade_step_time=0.01

###############################################################################

get_brightness() {
    #light | cut -d'.' -f1
    
    brillo | cut -d'.' -f1
}

fade() {
	current="$1"
	target="$2"

    usecs=$(echo "$fade_steps*$fade_step_time*1000000" | bc -l | cut -d'.' -f1)
    brillo -u "$usecs" -S "$target"
	
 #    if [ "$current" -gt "$target" ]; then
 #        steps=$(echo "($current - $min_brightness)/$fade_steps" | bc -l)
	# 	while [ "$(get_brightness)" -gt "$target" ]; do
	# 		#light -U "$steps"
	# 		sleep $fade_step_time
	# 	done
	# elif [ "$target" -gt "$current" ]; then
	# 	steps=$(echo "($target - $current)/$fade_steps" | bc -l)
	# 	while [ "$target" -gt "$(get_brightness)" ]; do
	# 		#light -A "$steps"
	# 		sleep $fade_step_time
	# 	done
	# fi
}

# Commands to run before screen dim
old_brightness=$(get_brightness)
echo pause >/tmp/signal_bar
fade "$old_brightness" $min_brightness

# Sunglasses time
xinput test-xi2 --root |
    while read -r event; do
        echo "$event" | grep EVENT >/dev/null 2>&1 && break
    done

# Commands to run after resuming
pgrep -x xsecurelock && pkill -x -USR2 xsecurelock
fade "$(get_brightness)" "$old_brightness"
echo resume >/tmp/signal_bar
