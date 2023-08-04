### Environment vars

# Add local bin
export PATH="/home/tet/.local/bin:$PATH"

#Default editor
export EDITOR="nvim"

#Default browser
export BROWSER="linkhandler"

# Default terminal
export TERMINAL="urxvtc"

#Move urxvt socket
export RXVT_SOCKET="/tmp/urxvtd"

# allow mouse scrolling man pages in tmux
export LESS='-R --mouse --wheel-lines 1 --incsearch -P%lb/%L (?eEND):%pB\%)'

#Password asker
export SUDO_ASKPASS="${HOME}/.local/bin/sudopass"

# Sudo editor
export SUDO_EDITOR=${EDITOR}

#Uniform Qt and GTK appearance
export QT_QPA_PLATFORMTHEME=qt5ct

# For pam-gnupg support w/ ssh
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)

# colorscheme for fzf
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'  --color fg:7,bg:-1,hl:6,fg+:6,bg+:-1,hl+:6 --color info:2,prompt:1,spinner:5,pointer:5,marker:3,header:8'

#for bat theme
export BAT_THEME="base16"

### Non-standard folder/file locations (moving out of the home dir)
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export XDG_STATE_HOME="${HOME}/.local/state"

# Move bash history file
export HISTFILE="$XDG_STATE_HOME"/bash/history

# Move apsell configs
export ASPELL_CONF="per-conf $XDG_CONFIG_HOME/aspell/aspell.conf; personal $XDG_CONFIG_HOME/aspell/en.pws; repl $XDG_CONFIG_HOME/aspell/en.prepl"

# Change password store
export PASSWORD_STORE_DIR="${XDG_DATA_HOME}/pass"

# Move cargo dir
export CARGO_HOME="${XDG_DATA_HOME}/cargo"

# Move pylint dir
export PYLINTHOME="${XDG_CACHE_HOME}/pylint"

# Move python history file
export PYTHONSTARTUP="${HOME}/.local/bin/startup.py"

# Move mypy cache dir
export MYPY_CACHE_DIR="$XDG_CACHE_HOME/mypy"

# Move gtk2 config
export GTK2_RC_FILES="${XDG_CONFIG_HOME}/gtk-2.0/gtkrc"

# Disable less histfile
export LESSHISTFILE=-

# Move default wine bottle
export WINEPREFIX="${XDG_DATA_HOME}/wine"

# Move z data
export _Z_DATA="${XDG_DATA_HOME}/z"

# Move weechat home
export WEECHAT_HOME="${XDG_CONFIG_HOME}/weechat"

# Move go directory
export GOPATH="${XDG_DATA_HOME}/go"

# clipmenu settings
export CM_DIR="${HOME}/.cache/clipmenu"
export CM_LAUNCHER="rofi"

#Move java home
export _JAVA_OPTIONS=-"Djava.util.prefs.userRoot=${XDG_CONFIG_HOME}/java -Dsun.java2d.opengl=true"

# void changes default fzf dir
export FZF_BASE=/usr/share/doc/fzf

#Move gnupg home
export GNUPGHOME="${XDG_DATA_HOME}/gnupg"

### Deprecated (not needed but here for archival reasons)
# Sfeed settings
export SFEED_URL_FILE=~/.config/sfeed/read_sfeed
#export SFEED_PIPER="w3m -T text/html -cols $(tput cols)" #-dump | urlscan -d"
export SFEED_PLUMBER_INTERACTIVE=1
export SFEED_PLUMBER='feed_plumb.sh'
export SFEED_YANKER="xsel -ib"

#Move isync's mbsync config (I think mutt-wizard is the only one to recognize this)
export MBSYNCRC="${XDG_CONFIG_HOME}/isync/isyncrc"

# Move notmuch
export NOTMUCH_CONFIG="${XDG_CONFIG_HOME}/notmuch/notmuchrc"

# Enable trucolor in lf (needed for proper image previews w/ chafa)
export TCELL_TRUECOLOR=on

# Move vit dir
export VIT_DIR="${XDG_CONFIG_HOME}/vit"

# Move taskwarrior data and rc file
export TASKDATA="${XDG_DATA_HOME}/task"
export TASKRC="${XDG_CONFIG_HOME}/task/taskrc"

# Move taskopen config file
export TASKOPENRC="${XDG_CONFIG_HOME}/task/taskopenrc"

# Move readline config
export INPUTRC="$XDG_CONFIG_HOME"/readline/inputrc

# Move timewarrior dir
export TIMEWARRIORDB="${XDG_CONFIG_HOME}/timewarrior"

# Set notification fifo
export XNOTIFY_FIFO="/tmp/xnotify.fifo"
export XNOTIFY_HIST_FIFO="/tmp/xnotify_hist.fifo"

#Move vimrc
#export MYVIMRC="${XDG_CONFIG_HOME}/vim/vimrc"
#export VIMINIT="source ${MYVIMRC}"

# Move unison home
export UNISON="$XDG_DATA_HOME"/unison

# bemenu options
export BEMENU_OPTS="-i --fn 'monospace 16px' -H 24 --tf '#1c1c1c' --tb '#a87f5f' --nb '#1c1c1c' --nf '#dfdfaf' --hb '#a87f5f' --hf '#1c1c1c' --fb '#1c1c1c' --ff '#dfdfaf' --sb '#262626' --sf '#af875f' --ch 16 -B 6 --bdr '#1c1c1c' --hp 10 --cw 2 --ab '#262626' --af '#dfdfaf' --cf '#dfdfaf' --cb '#1c1c1c'"

# Force wayland usage for SDL
#export SDL_VIDEODRIVER="wayland"

# Qt wayland configuration
#export QT_QPA_PLATFORM="wayland"
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

#set task spooler settings
export TS_MAXFINISHED=5
export TS_ONFINISH="ts_alert.sh"
export TS_SAVELIST="${HOME}/.local/share/ts/ts_list.sh"

# Change zoom dir
export SSB_HOME="${XDG_DATA_HOME}/zoom"

