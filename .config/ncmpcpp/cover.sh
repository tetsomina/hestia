#!/usr/bin/env bash

#----------------------------------#
# Cover script to run with ncmpcpp #
#----------------------------------#

clear
playerctl metadata --follow -f "{{ mpris:artUrl }}" |
	while read -r event; do
		## Album Art
		clear
		printf "%b" "\033[01;31mArtwork\033[0m\n"
		for i in $(seq 1 $(tput cols)); do
			printf "%b" "\033[30m─"
		done
		printf "%b" "\n"
		art=$(printf "%b\n" "$event" | cut -d'/' -f3-)
		chafa -c full "$art" 2>/dev/null
  done
