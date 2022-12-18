#!/bin/sh

# Run these programs as user services
uid=$(id -u)
pgrep -U "$uid" runsv && pkill -U "$uid" runsv
pgrep -U "$uid" proton && pkill -U "$uid" proton # Doesn't get killed as expected on restarts
setsid -f runsvdir -P ~/.local/service/active

# Update dbus session address in cron
crontab -l | sed "s|DBUS_SESSION_BUS_ADDRESS=.*|DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS|" >/tmp/new_crontab
crontab /tmp/new_crontab && rm /tmp/new_crontab

# Things to launch on startup that require an internet connection
while :; do
    [ "$(cat /sys/class/net/wlp5s0/carrier)" -eq 1 ] && break
    sleep 1
done
network=$(iwctl station wlp5s0 show | grep 'Connected network' | xargs | cut -d' ' -f3-)
case "$network" in
Ollies*Network)
    sv start ~/.local/service/wayland/waynergy
    ;;
*)
    pid=$(pgrep -x swaylock)
    [ -n "$pid" ] && tail --pid="$pid" -f /dev/null
    sudo -A wg-quick up tetsominavpn
    ;;
esac

#On startup, Update stuff with server
vdirsyncer sync
task sync
