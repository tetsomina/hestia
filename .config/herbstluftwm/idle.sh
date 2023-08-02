#!/usr/bin/env bash

# Stuff to do on focus changes

herbstclient --idle "focus_changed" | while read -r event; do
  case "$event" in
  *focus_changed*)
    # check if focused window is floating, if so, change active frame color (to reduce active window confusion)
    herbstclient or \
      . and , compare tags.focus.floating_focused = true \
      , set frame_border_active_color '#1c1c1c' \
      . set frame_border_active_color '#af875f' \
    ;;
  esac
done
