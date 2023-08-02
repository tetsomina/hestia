#!/usr/bin/env sh

#-----------------------------------#
# Idle script to run with mpd-mpris #
#-----------------------------------#

exec playerctl metadata --follow -f "{{ title }}\t{{ artist }}\t{{ album }}\t{{ duration(mpris:length) }}\t{{ status }}" |
	while read -r event; do
		## Notifications
		# We do it this way instead of internally with ncmpcpp because it takes mpris a bit
		# longer to update than when ncmpcpp fires execute_on_song_change command
		title=$(printf "%b\n" "$event" | cut -f1)
		artist=$(printf "%b\n" "$event" | cut -f2)
		album=$(printf "%b\n" "$event" | cut -f3)
		length=$(printf "%b\n" "$event" | cut -f4)

		# To avoid blank notification on first startup
		[ -z "$title" ] || [ -z "$artist" ] || [ -z "$album" ] || [ -z "$length" ] && continue

		# Specific notification for paused state
		status=$(printf "%b\n" "$event" | cut -f5)
		if [ "$status" = Paused ]; then
			formatted=$(playerctl metadata -f " Playback Paused Current Position: {{ duration(position) }}/$length")
			notify-send -u low "Music" "$formatted"
			continue
		fi

		# Main notif
		notify-send -u low "Music" " Now Playing  $title ($length)  $artist  $album"
	done
