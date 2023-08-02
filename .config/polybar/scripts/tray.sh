#!/bin/env bash

trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM EXIT

bltth() {
  rfkill event |
    while read -r line; do
      status=$(echo "$line" | grep "type 2" | awk '{print $10}')

      if [ "$status" -eq 0 ]; then
        status="%{F#87afaf}%{T1}%{T-}%{F-}"
      else
        status=""
      fi
      echo "BLUE ${status}"

    done
}

vpninfo() {
  vpnicon() {
    cvpn=""
    vpn="$(ip addr | grep 'muspelheim\|tun0' | awk '{print $2}' | grep -v -E '^[0-9]+' | tr -d ':')"
    for v in $vpn; do
      case "$v" in
      muspelheim)
        cvpn+="%{F#af5f5f}%{T1}%{T-}%{F-}"
        ;;
      tun0)
        cvpn+="%{F#dfaf87}%{T1}%{T-}%{F-}"
        ;;
      esac
    done

    echo "VPN ${cvpn}"
  }
  vpnicon
  ip monitor netconf |
    while read -r line; do
      echo "$line" | grep "muspelheim\|tun0" && vpnicon
    done
}

caffeine() {
  [ -e /tmp/caffeine.fifo ] && rm /tmp/caffeine.fifo
  mkfifo /tmp/caffeine.fifo
  tail -f /tmp/caffeine.fifo |
    while read -r event; do
      # Caffeine status
      if [ "$event" = "true" ]; then
        echo "CAFF %{F#af8787}%{T1}%{T-}%{F-}"
      else
        echo "CAFF "
      fi
    done
}

{
  bltth &
  vpninfo &
  caffeine &
} |
  while read -r line; do
    case "$line" in
    BLUE*)
      bluetooth="${line:4}"
      ;;
    VPN*)
      vpn="${line:4}"
      ;;
    CAFF*)
      caffeine="${line:4}"
      ;;
    esac

    if [ -n "$bluetooth" ] || [ -n "$vpn" ] || [ -n "$caffeine" ]; then
      echo "%{B#262626}$bluetooth$vpn$caffeine %{B-}"
    else
      echo ""
    fi

  done
wait
