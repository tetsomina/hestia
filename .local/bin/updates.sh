#!/bin/sh

# Check for updates
updates=$(xbps-install -nu | wc -l)

if [ "$updates" -gt 0 ]; then
    notify-send "xbps" " Updates: $updates"
fi
