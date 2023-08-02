#!/bin/sh

timed_inotify() {
  timeout --foreground "$1" inotifywait -q -q -e create,modify,delete -r "$2"
}

dir_watch() {
  while :; do
    timed_inotify "$1" "$3"
    if [ $? -lt 124 ]; then
      while :; do
        timed_inotify "$2" "$3"
        [ $? -ge 124 ] && break
      done
    fi
    $4
  done
}

case "$1" in
pass)
  # Automatically push local changes when they're made; otherwise sync w/ remote
  dir_watch 30m 2s "$PASSWORD_STORE_DIR" "pass git pull; pass git push"
  ;;
vdir)
  # Automatically trigger vdirsyncer sync whenever the directory changes
  # If no changes in 15m period, do a sync anyway in case there are remote changes
  # There's a grace period of 2 seconds in case many changes are made quickly
  # This is my quick 'n dirty attempt at a shell script version of WhyNotHugo's autovdirsyncer
  dir_watch 15m 2s ~/.local/share/vdirsyncer/posteo/default "vdirsyncer sync"
  ;;
esac
