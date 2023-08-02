#!/usr/bin/env bash

#-----------------------------------#
# Launch script to run with ncmpcpp #
#-----------------------------------#

playerctl -F -p mpd metadata mpris:artUrl |
  while read -r event; do
    art=$(printf "%s\n" "$event" | sed 's|file://||')

    ## Attempt at calculating percentage offset needed to keep pic in the upper
    ## left position, without being under the title
    font_height=16
    cell_height=$(tput lines)
    pix_height=$((cell_height * font_height))
    y_offset=$(bc -l <<<"100 * ((4 * $font_height) / $pix_height)" | cut -d'.' -f1)

    ## Issue draw command depending on whether we're in a tmux session
    [ -n "$TMUX" ] &&
      printf "\ePtmux;\e\e]20;%s;24x100+0+%s:op=keep-aspect\a\e\\" "$art" "$y_offset" ||
      printf "\e]20;%s;24x100+0+%s:op=keep-aspect\a" "$art" "$y_offset"

    #  This is with my modified version of the background perl script, patched to accept the new expression syntax instead of old bollocks.
    #  I removed my version because it turns out it creates a gaping security hole. Still keeping the below in case there's a new method in
    #  the future that can use it.
    # [ -n "$TMUX" ] &&
    #   printf "\ePtmux;\e\e]20;pad keep { move 0, %s*2, keep { fit TW*0.245, TH - 4*%s, load_uc \"%s\" } }\a\e\\" "$font_height" "$font_height" "$art" ||
    #   printf "\e]20;pad keep { move 0, %s*2, keep { fit TW*0.245, TH - 4*%s, load_uc \"%s\" } }\a" "$font_height" "$font_height" "$art"

    # Cleanup
    #rm -f "$art"
  done &

# Finally, ncmpcpp
ncmpcpp

# Cleanup
kill 0
