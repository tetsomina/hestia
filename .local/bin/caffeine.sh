#!/bin/sh

caffstart() {
  xset -dpms
  xset s off
  xset s noblank
  xautolock -disable
  echo true >/tmp/caffeine.fifo

}

caffend() {
  xset +dpms
  xset s
  xautolock -enable
  echo false >/tmp/caffeine.fifo
}

case "$1" in
-s | --start)
  caffstart
  ;;
-e | --end)
  caffend
  ;;
*)
  state=$(xset q | awk '/DPMS is/ {print $3}')
  case "$state" in
  Enabled)
    caffstart
    ;;
  Disabled)
    caffend
    ;;
  esac
  ;;
esac
