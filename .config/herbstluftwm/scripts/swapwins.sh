#!/usr/bin/env bash

# Direction to make swap
dir="$1"

# Hide any ugliness from flickering focus around
herbstclient lock

# Collect info from current window/frame
old_focused_win=$(herbstclient get_attr clients.focus.winid)
old_focused_frame=$(herbstclient get_attr tags.focus.tiling.focused_frame.index)

# Switch focus to collect more info
herbstclient focus "$dir"

# Collect info from next window/frame
new_focused_win=$(herbstclient get_attr clients.focus.winid)
new_focused_frame=$(herbstclient get_attr tags.focus.tiling.focused_frame.index)

# Gather client lists from each frames involved
winarrold=$(herbstclient list_clients --frame="$old_focused_frame")
winarrnew=$(herbstclient list_clients --frame="$new_focused_frame")

# Swap all windows in target frame to original frame
for j in $winarrnew; do
  herbstclient apply_tmp_rule "$j" index="$old_focused_frame"
done

# Swap all windows from current frame to target frame
for i in $winarrold; do
  herbstclient apply_tmp_rule "$i" index="$new_focused_frame"
done

# Finally, return focus to what was focused before this mess
herbstclient jumpto "$new_focused_win"
herbstclient jumpto "$old_focused_win"

# Back to normal
herbstclient unlock
