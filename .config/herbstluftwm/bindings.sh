#!/usr/bin/env bash

hc() {
  herbstclient "$@"
}

scripts_dir="$HOME/.config/herbstluftwm/scripts"

### Key/mouse bindings separate in order to 'lazy load' them

## Key bindings
# remove all existing keybindings
hc keyunbind --all

# Basics
hc keybind Mod4-Return or ',' and '_' compare tags.focus.curframe_wcount = 0 '_' spawn urxvtc ',' chain '-' split auto '-' cycle_frame '-' spawn urxvtc #bsp-like spawning of terminal

hc keybind Mod4-Shift-Return spawn urxvtc                                    #Spawn terminal
hc keybind Mod4-e spawn "$scripts_dir"/launch                                #Launcher
hc keybind Mod4-Shift-e spawn power                                          #Power menu
hc keybind Mod4-d spawn "$scripts_dir"/hlscrthpd.sh                          #Dropdown terminal
hc keybind Mod4-space spawn todo.sh                                          #Todo list
hc keybind Mod4-a spawn "$scripts_dir"/key_help.sh                           #Keybinding help
hc keybind Mod4-Shift-a spawn urxvtc -e vim ~/.config/herbstluftwm/autostart #Edit hlwm config

# Window info/wm ctrls
hc keybind Mod4-w spawn rofi -show window                       #Switch windows
hc keybind Mod4-Control-w spawn "$scripts_dir"/toggle_titles.sh #Toggle window titles
hc keybind Mod4-Shift-r reload                                  #Reload hlwm

# Toggles
hc keybind Mod4-b spawn togglebar.sh                   #Toggle bar
hc keybind Mod4-Shift-p spawn togglepicom              #Toggle compositor
hc keybind XF86TouchpadToggle spawn toggle_touchpad.sh #Toggle touchpad
hc keybind XF86Display spawn caffeine.sh               #Toggle caffeine
#hc keybind XF86Tools spawn kb_variant.sh               #Toggles between qwerty and colemak
#hc keybind Mod4-Shift-n spawn toggledunst     #Toggle notifications
#hc keybind XF86Tools spawn toggle_redshift.sh #Toggle redshift

# Utilities
hc keybind Mod4-u spawn unmount.sh                      #Unmount drives
hc keybind XF86Favorites spawn prtscr -f                #Print Screen
hc keybind Mod4-XF86Favorites spawn prtscr -r           #Print region
hc keybind Mod4-x spawn clipmenu -i -p 'Clipboard' -l 0 #Clipboard manager
hc keybind Mod4-Shift-c spawn colorpicker.sh            #Colorpicker
hc keybind Mod4-Shift-z spawn mag.sh                    #Zoom
hc keybind Mod4-Shift-m spawn emote                     #emoji selector
hc keybind Mod4-z spawn mwarp.sh                        #Warp mouse
hc keybind Mod4-Shift-w spawn wttr                      #Current Weather Information

# Notification controls
hc keybind Control-grave spawn notif_hist.sh -q #Query last notification
hc keybind Control-space spawn notif_hist.sh -c #Close all notification history

# Volume/Brightness keys
hc keybind XF86MonBrightnessUp spawn bright up     #Increase brightness
hc keybind XF86MonBrightnessDown spawn bright down #Decrease brightness

hc keybind XF86AudioRaiseVolume spawn vol alsa up           #Increase Volume
hc keybind XF86AudioLowerVolume spawn vol alsa down         #Decrease volume
hc keybind XF86AudioMute spawn vol alsa mute                #Mute audio
hc keybind Mod4-XF86AudioRaiseVolume spawn vol alsamic up   #Increase mic volume
hc keybind Mod4-XF86AudioLowerVolume spawn vol alsamic down #Decrease mic volume
hc keybind XF86AudioMicMute spawn vol alsamic mute          #mute mic

# Player controls
hc keybind Mod4-Control-Mod1-Left spawn playerctl previous #Previous audio
hc keybind Mod4-Control-Mod1-Right spawn playerctl next    #Next audio
hc keybind Mod4-Control-Mod1-Up spawn playerctl play-pause #Toggle play/pause audio
hc keybind Mod4-Control-Mod1-Down spawn playerctl stop     #Stop audio
hc keybind Mod4-Control-Mod1-h spawn playerctl previous    #Previous audio
hc keybind Mod4-Control-Mod1-l spawn playerctl next        #Next audio
hc keybind Mod4-Control-Mod1-k spawn playerctl play-pause  #Toggle play/pause audio
hc keybind Mod4-Control-Mod1-j spawn playerctl stop        #Stop audio

# Window/frame controls
hc keybind Mod4-q close_and_remove                 #Close window and frame if last window
hc keybind Mod4-Shift-q close                      #Close window
hc keybind Mod4-m spawn "$scripts_dir"/maximize.sh #Alternate tiled and monocle layout
hc keybind Mod4-i jumpto urgent                    #Jump to urgent window
hc keybind Mod4-Tab cycle                          #Circulate focus on windows in frame
hc keybind Mod4-Shift-Tab cycle -1                 #Circulate focus on windows in frame in reverse
hc keybind Mod4-grave cycle_monitor                #Circulate monitor focus

# focusing clients
hc keybind Mod4-Left focus left   #Focus left
hc keybind Mod4-Down focus down   #Focus down
hc keybind Mod4-Up focus up       #focus up
hc keybind Mod4-Right focus right #Focus right
hc keybind Mod4-h focus left      #Focus left
hc keybind Mod4-j focus down      #Focus down
hc keybind Mod4-k focus up        #focus up
hc keybind Mod4-l focus right     #Focus right

# moving clients
## Function that detaches focused client to a dedicated frame if, in a multiple
## client frame near the monitor's edge the shift command is executed in
## direction of mentioned edge. Empty frames are closed in the process.
shift_or_detach() {
  split_dir="$2"
  # parsing movement to split options
  [[ "$2" == "up" ]] && split_dir="top"
  [[ "$2" == "down" ]] && split_dir="bottom"
  # If you're shifting right the empty frame to close is on the left (opposite dir)
  declare -A previous_frame # declaring associative arrays is mandatory
  previous_frame=([left]=right [down]=up [up]=down [right]=left)

  hc keybind "$1" silent or \
    , and \
    + compare tags.focus.curframe_wcount = 1 \
    + shift "$2" \
    + focus -e "${previous_frame[$2]}" \
    + close_and_remove \
    , shift "$2" \
    , and \
    + compare tags.focus.curframe_wcount gt 1 \
    + split "${split_dir}" 0.5 + shift "$2"
}
shift_or_detach Mod4+Shift+h left      #Move window left
shift_or_detach Mod4+Shift+j down      #Move window down
shift_or_detach Mod4+Shift+k up        #Move window up
shift_or_detach Mod4+Shift+l right     #Move window right
shift_or_detach Mod4+Shift+Left left   #Move window left
shift_or_detach Mod4+Shift+Down down   #Move window down
shift_or_detach Mod4+Shift+Up up       #Move window up
shift_or_detach Mod4+Shift+Right right #Move window right

# Cycle focus through tags
hc keybind Mod4-period spawn "$scripts_dir"/tag_switch.sh next #Switch to next non-empty tag
hc keybind Mod4-comma spawn "$scripts_dir"/tag_switch.sh prev  #Switch to prev non-empty tag

# Create frames
frac="0.5"
hc keybind Mod4-Control-Left split left $frac   #Create frame to left
hc keybind Mod4-Control-Right split right $frac #Create frame to right
hc keybind Mod4-Control-Up split top $frac      #Create frame up
hc keybind Mod4-Control-Down split bottom $frac #Create frame down
hc keybind Mod4-Control-h split left $frac      #Create frame to left
hc keybind Mod4-Control-j split right $frac     #Create frame to right
hc keybind Mod4-Control-k split top $frac       #Create frame up
hc keybind Mod4-Control-l split bottom $frac    #Create frame down
hc keybind Mod4-Control-space split explode     #Explode current frame

# resizing frames
resizestep=0.02
hc keybind Mod4-Mod1-Left resize left +$resizestep   #Resize frame leftwards
hc keybind Mod4-Mod1-Down resize down +$resizestep   #Resize frames downwards
hc keybind Mod4-Mod1-Up resize up +$resizestep       #Resize frame upwards
hc keybind Mod4-Mod1-Right resize right +$resizestep #Resize frame rightwards
hc keybind Mod4-Mod1-h resize left +$resizestep      #Resize frame leftwards
hc keybind Mod4-Mod1-j resize down +$resizestep      #Resize frames downwards
hc keybind Mod4-Mod1-k resize up +$resizestep        #Resize frame upwards
hc keybind Mod4-Mod1-l resize right +$resizestep     #Resize frame rightwards

# Misc. frame ctrls
hc keybind Mod4-f set always_show_frame toggle #Toggle frame visibility
hc keybind Mod4-Control-r rotate               #Rotate frame layout by 90 degrees

# Adjust gaps
hc keybind Mod4-minus spawn "$scripts_dir"/gap_adjust.sh -win       #Minus window gap
hc keybind Mod4-equal spawn "$scripts_dir"/gap_adjust.sh +win       #Plus window gap
hc keybind Mod4-Shift-minus spawn "$scripts_dir"/gap_adjust.sh -frm #Minus frame gap
hc keybind Mod4-Shift-equal spawn "$scripts_dir"/gap_adjust.sh +frm #Plus frame gap
hc keybind Mod4-BackSpace spawn "$scripts_dir"/gap_adjust.sh        #Reset gaps

# Swapping frames (actually just transferring windows between frames)
hc keybind Mod4-Shift-Ctrl-Right spawn "$scripts_dir"/swapwins.sh right #Swap frames to the right
hc keybind Mod4-Shift-Ctrl-Left spawn "$scripts_dir"/swapwins.sh left   #Swap frames to the left
hc keybind Mod4-Shift-Ctrl-Up spawn "$scripts_dir"/swapwins.sh up       #Swap frames to the top
hc keybind Mod4-Shift-Ctrl-Down spawn "$scripts_dir"/swapwins.sh down   #Swap frames tothe bottom

hc keybind Mod4-Shift-Ctrl-h spawn "$scripts_dir"/swapwins.sh right #Swap frames to the right
hc keybind Mod4-Shift-Ctrl-l spawn "$scripts_dir"/swapwins.sh left  #Swap frames to the left
hc keybind Mod4-Shift-Ctrl-k spawn "$scripts_dir"/swapwins.sh up    #Swap frames to the top
hc keybind Mod4-Shift-Ctrl-j spawn "$scripts_dir"/swapwins.sh down  #Swap frames tothe bottom

## Mouse bindings
# remove any existing mouse bindings
hc mouseunbind --all
hc mousebind Mod4-Button1 move
hc mousebind Mod4-Button2 zoom
hc mousebind Mod4-Button3 resize
