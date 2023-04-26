#!/bin/sh

#state=$(sv check ~/.local/service/wayland/swayidle/ | cut -d' ' -f2)
state=$(xset q | grep 'DPMS is' | awk '{print $3}')
case "$state" in
Enabled)
    xset -dpms
    xset s off
    xset s noblank
    xautolock -disable
    echo true >/tmp/caffeine.fifo
    ;;
Disabled)
    xset +dpms
    xset s
    xautolock -enable
    echo false >/tmp/caffeine.fifo
    ;;
*run*)
    sv down ~/.local/service/wayland/swayidle
    echo true >/tmp/caffeine.fifo
    ;;
*down*)
    sv up ~/.local/service/wayland/swayidle
    echo false >/tmp/caffeine.fifo
    ;;
esac
