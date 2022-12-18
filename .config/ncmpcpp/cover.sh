#!/usr/bin/env sh

#-------------------------------#
# Display current cover         #
#-------------------------------#

clear
[ -e /tmp/cover.fifo ] && rm /tmp/cover.fifo
mkfifo /tmp/cover.fifo
tail -f /tmp/cover.fifo |
    while read -r event; do
        clear
        printf "%b" "\033[31mArtwork\n"
        for i in $(seq $(tput cols)); do
            printf "%b" "\033[30m─"
        done
        printf "%b" "\n"
        atmp="/tmp/temp.mp3"
        itmp="/tmp/temp.png"
        url=$(playerctl metadata xesam:url 2>/dev/null)
        nfs-cp "$url" "$atmp" >/dev/null 2>&1
        ffmpeg -nostdin -y -i "$atmp" "$itmp" >/dev/null 2>&1
        chafa -c full "${itmp}" 2>/dev/null && rm "$atmp" "$itmp" >/dev/null 2>&1
    done
