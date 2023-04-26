#!/bin/sh

pad=$(herbstclient list_padding | cut -d' ' -f1)

if [ "$pad" -ne 0 ]; then
    #xdo hide -a yambar
    polybar-msg cmd hide
    echo pause >/tmp/signal_bar
    #herbstclient pad "" 0 0 0 0
else
    #xdo show -a yambar
    polybar-msg cmd show
    echo resume >/tmp/signal_bar
    #herbstclient pad "" 39 0 0 0
fi
