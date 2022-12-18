#!/usr/bin/env sh

# show a menu of keybinds
grep bindsym ~/.config/sway/config | sed -r -e 's/    bindsym //' -e 's/--[a-zA-Z]+ //' -e 's/$mod/Super/' -e '/^ /d' | bemenu -p 'Keybinds' >/dev/null
