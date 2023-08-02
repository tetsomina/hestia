### Autologin
if [ -z "$DISPLAY" ] && [ "$(tty)" = "/dev/tty1" ]; then
    # Need to start gpg agent before lock screen for pam-gnupg
    gpg-connect-agent /bye >/dev/null 2>&1

    export XAUTHORITY="${HOME}/.local/share/xorg/xauthority"
    exec startx ${HOME}/.config/x11/xinitrc -- ${HOME}/.config/x11/xserverrc &>/dev/null
fi
